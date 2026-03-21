# Changelog

## [0.1.0] - 2026-03-21

### Added
- Initial release
- `Helpers::Client` with Faraday Basic auth connection builder
- `Runners::Jobs`: list_jobs, get_job, create_job, delete_job, enable_job, disable_job
- `Runners::Builds`: get_build, get_last_build, trigger_build, get_build_log
- `Runners::Nodes`: list_nodes, get_node
- Standalone `Client` class with all runner modules included
