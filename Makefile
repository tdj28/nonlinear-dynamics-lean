.PHONY: setup lean site site-drafts site-serve check clean

setup:
	cd formalization && . "$$HOME/.elan/env" && lake update
	cd formalization && . "$$HOME/.elan/env" && lake exe cache get

lean:
	cd formalization && . "$$HOME/.elan/env" && lake build

site:
	hugo --source site --config hugo.yaml --cleanDestinationDir

site-drafts:
	hugo --source site --config hugo.yaml --buildDrafts --cleanDestinationDir

site-serve:
	hugo server --source site --config hugo.yaml --buildDrafts --disableFastRender

check: lean site

clean:
	cd formalization && . "$$HOME/.elan/env" && lake clean
	hugo --source site --config hugo.yaml --cleanDestinationDir
