# lex-jenkins: Jenkins CI/CD Integration for LegionIO

**Repository Level 3 Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-other/CLAUDE.md`
- **Grandparent**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

Legion Extension that connects LegionIO to Jenkins CI/CD via the Jenkins REST API. Provides runners for job management, build triggering, and node inspection.

**GitHub**: https://github.com/LegionIO/lex-jenkins
**License**: MIT
**Version**: 0.1.2

## Architecture

```
Legion::Extensions::Jenkins
├── Runners/
│   ├── Jobs    # list_jobs, get_job, create_job, delete_job, enable_job, disable_job
│   ├── Builds  # get_build, get_last_build, trigger_build, get_build_log
│   └── Nodes   # list_nodes, get_node
├── Helpers/
│   └── Client  # Faraday connection (Jenkins REST API, Basic Auth with API token)
└── Client      # Standalone client class (includes all runners)
```

## Key Files

| Path | Purpose |
|------|---------|
| `lib/legion/extensions/jenkins.rb` | Entry point, extension registration |
| `lib/legion/extensions/jenkins/runners/jobs.rb` | Job management runners |
| `lib/legion/extensions/jenkins/runners/builds.rb` | Build query and trigger runners |
| `lib/legion/extensions/jenkins/runners/nodes.rb` | Node inspection runners |
| `lib/legion/extensions/jenkins/helpers/client.rb` | Faraday connection builder (Basic Auth: username + API token) |
| `lib/legion/extensions/jenkins/client.rb` | Standalone Client class |

## Authentication

Jenkins uses HTTP Basic Auth with `username` and `token` (API token, not password). Construct the client with `url:`, `username:`, and `token:`.

## Dependencies

| Gem | Purpose |
|-----|---------|
| `faraday` (~> 2.0) | HTTP client for Jenkins REST API |

## Development

19 specs total.

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

---

**Maintained By**: Matthew Iverson (@Esity)
