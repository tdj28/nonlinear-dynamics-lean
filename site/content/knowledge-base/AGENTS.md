# Knowledge Base authoring scope

Read the repository-root `KB-AGENTS.md` completely before adding or changing a
page in this directory. Development Notebook rules remain separate and are not
mechanically applied to glossary pages.

Apply the guide with these path mappings:

- `blog-source/content/knowledge-base/**` maps to
  `site/content/knowledge-base/**`.
- `blog-source/content/knowledge-base/glossary/<term>/index.md` maps to
  `site/content/knowledge-base/glossary/<term>/index.md`.
- `blog-source/content/knowledge-base/deep-dives/**` maps to
  `site/content/knowledge-base/deep-dives/**`.
- Site-specific Praxagent names, links, examples, and branding are illustrative
  only. Do not copy them into this project.

Keep glossary entries and deep dives as leaf bundles. New pages start with
`draft: true` and `pro_reviewed: false`; publication still requires human
approval.
