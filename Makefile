HUGO ?= hugo
PYTHON ?= python3
TAILSCALE ?= tailscale
CLOUD_LEAN_BUILD ?= 0
LEAN_FILE ?=
export CLOUD_LEAN_BUILD LEAN_FILE
override CLOUD_LEAN_RUNNER := scripts/run_cloud_lean_target.sh

# Hugo preview port. Override with, for example, BLOG_PORT=1444.
BLOG_PORT ?= 1333

.DEFAULT_GOAL := help

.PHONY: help setup lean lean-file lean-clean checkpoint checkpoint-check content-coverage content-coverage-test content-hygiene-test content-hygiene site site-drafts site-check blog-serve site-serve blog-serve-tailscale site-serve-tailscale workstation-check check clean

help: ## Show available commands
	@awk 'BEGIN {FS = ":.*## "; printf "Usage: make <target>\n\nTargets:\n"} /^[a-zA-Z0-9_-]+:.*## / {printf "  %-24s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

setup: ## Cloud/Linux only: download pinned dependencies and compiled cache
	@$(CLOUD_LEAN_RUNNER) setup

lean: ## Cloud/Linux only: build the Lean formalization
	@$(CLOUD_LEAN_RUNNER) build

lean-file: ## Cloud/Linux only: warning-fatal compile of LEAN_FILE
	@$(CLOUD_LEAN_RUNNER) file

lean-clean: ## Cloud/Linux only: remove generated Lean build output
	@$(CLOUD_LEAN_RUNNER) clean

checkpoint: ## Show the current verified state and next formalization milestone
	@cat checkpoint.md

checkpoint-check: ## Validate the checkpoint and project research skill
	$(PYTHON) scripts/check_checkpoint.py

content-coverage: ## Check that every substantive Lean module has a comprehensive notebook page
	$(PYTHON) scripts/check_lean_notebook_coverage.py

content-coverage-test: ## Run regression tests for the Lean snapshot coverage contract
	$(PYTHON) -m unittest discover -s scripts -p 'test_check_lean_notebook_coverage.py'

content-hygiene-test: ## Run regression tests for the context-aware source gate
	$(PYTHON) -m unittest discover -s scripts -p 'test_check_teaching_source_hygiene.py'

content-hygiene: ## Check rendered teaching prose for Markdown and TeX source hazards
	$(PYTHON) scripts/check_teaching_source_hygiene.py

site: ## Build the publication-ready Hugo site into public/
	$(HUGO) --source site --config hugo.yaml --cleanDestinationDir

site-drafts: ## Build Hugo output including draft notebook and knowledge pages
	$(HUGO) --source site --config hugo.yaml --buildDrafts --cleanDestinationDir

site-check: ## Validate all Hugo content, including drafts, without writing public/
	$(HUGO) --source site --config hugo.yaml --buildDrafts --panicOnWarning --noBuildLock --renderToMemory

blog-serve: ## Serve drafts locally at http://127.0.0.1:1333/
	@echo "Serving the blog locally: http://127.0.0.1:$(BLOG_PORT)/"
	$(HUGO) server \
		--source site \
		--config "$(abspath site/hugo.yaml)" \
		--bind 127.0.0.1 \
		--port "$(BLOG_PORT)" \
		--baseURL "http://127.0.0.1:$(BLOG_PORT)/" \
		--buildDrafts \
		--disableFastRender \
		--noHTTPCache \
		--navigateToChanged \
		--noBuildLock \
		--renderToMemory

site-serve: blog-serve ## Alias for blog-serve

blog-serve-tailscale: ## Serve drafts privately on Tailscale port 1333
	@ts_ip="$$($(TAILSCALE) ip -4 2>/dev/null | sed -n '1p')"; \
	ts_host="$$($(TAILSCALE) status --peers=false --json 2>/dev/null | \
		$(PYTHON) -c 'import json,sys; d=json.load(sys.stdin); s=d.get("Self") or {}; t=d.get("CurrentTailnet") or {}; print(s.get("DNSName","").rstrip(".") if t.get("MagicDNSEnabled") else "")' 2>/dev/null)"; \
	test -n "$$ts_ip" || { echo "Tailscale IPv4 unavailable; is Tailscale running?"; exit 1; }; \
	url_host="$${ts_host:-$$ts_ip}"; \
	url="http://$$url_host:$(BLOG_PORT)/"; \
	echo "Serving the blog on your tailnet: $$url"; \
	exec $(HUGO) server \
		--source site \
		--config "$(abspath site/hugo.yaml)" \
		--bind "$$ts_ip" \
		--port "$(BLOG_PORT)" \
		--baseURL "$$url" \
		--buildDrafts \
		--disableFastRender \
		--noHTTPCache \
		--navigateToChanged \
		--noBuildLock \
		--renderToMemory

site-serve-tailscale: blog-serve-tailscale ## Alias for blog-serve-tailscale

workstation-check: checkpoint-check content-coverage content-coverage-test content-hygiene-test content-hygiene site-check ## Validate all non-Lean repository gates

check: lean checkpoint-check content-coverage content-coverage-test content-hygiene-test content-hygiene site-check ## Cloud/Linux only: run the complete repository gate

clean: ## Remove generated Hugo output without invoking Lean or Lake
	rm -rf public site/resources/_gen
