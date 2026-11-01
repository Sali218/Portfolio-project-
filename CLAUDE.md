# CLAUDE.md

This repo ships project skills in `.claude/skills/` (Everything Claude Code).
Use them as part of normal work: before starting a task, check the table below and invoke
the matching skill with the Skill tool. If several apply, use all of them, in the order listed.

## Default workflow for any code change

1. `search-first` — look for existing code, libraries or patterns before writing new code.
2. `tdd-workflow` — write the failing test first, then the implementation.
3. Language skill for the files touched (see below).
4. `security-review` — when the change touches auth, user input, secrets, APIs or payments.
5. `verification-loop` — build, lint and test before saying the work is done or committing.

## Skill by task

| Task | Skills |
|------|--------|
| Python code | `python-patterns`, `python-testing` |
| Django | `django-patterns`, `django-tdd`, `django-security`, `django-verification` |
| TypeScript / JavaScript / React / Next.js | `coding-standards`, `frontend-patterns`, `backend-patterns` |
| Go | `golang-patterns`, `golang-testing` |
| Java / Spring Boot | `java-coding-standards`, `springboot-patterns`, `springboot-tdd`, `springboot-security`, `jpa-patterns` |
| C++ | `cpp-coding-standards`, `cpp-testing` |
| Swift / iOS | `swiftui-patterns`, `swift-concurrency-6-2`, `swift-protocol-di-testing`, `swift-actor-persistence` |
| REST API design | `api-design` |
| Database schema or queries | `postgres-patterns`, `database-migrations`, `clickhouse-io` |
| Docker / deploy / CI | `docker-patterns`, `deployment-patterns` |
| Browser end-to-end tests | `e2e-testing` |
| LLM / agent features | `cost-aware-llm-pipeline`, `agent-harness-construction`, `regex-vs-llm-structured-text` |
| Long sessions | `strategic-compact` |
| Presentations | `frontend-slides` |
| Articles, posts, social content | `article-writing`, `content-engine` |
| Market or competitor research | `market-research` |
| Fundraising | `investor-materials`, `investor-outreach` |

## Overlap with other plugins

If the superpowers plugin is also loaded, its process skills (brainstorming, systematic-debugging,
writing-plans) still come first; then use the project skills above for the implementation itself.
