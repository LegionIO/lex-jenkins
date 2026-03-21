# lex-jenkins

LegionIO extension that connects to Jenkins CI/CD via the Jenkins REST API.

## Installation

Add to your Gemfile:

```ruby
gem 'lex-jenkins'
```

## Usage

### Standalone

```ruby
require 'legion/extensions/jenkins'

client = Legion::Extensions::Jenkins::Client.new(
  url:      'http://jenkins.example.com',
  username: 'admin',
  token:    'your-api-token'
)

# List all jobs
client.list_jobs

# Trigger a build with parameters
client.trigger_build(name: 'my-pipeline', parameters: { BRANCH: 'main' })

# Get last build result
client.get_last_build(name: 'my-pipeline')
```

## Runners

### Jobs
- `list_jobs` - List all jobs
- `get_job(name:)` - Get job details
- `create_job(name:, xml_config:)` - Create a job from XML config
- `delete_job(name:)` - Delete a job
- `enable_job(name:)` - Enable a job
- `disable_job(name:)` - Disable a job

### Builds
- `get_build(name:, build_number:)` - Get a specific build
- `get_last_build(name:)` - Get the last build
- `trigger_build(name:, parameters: {})` - Trigger a build
- `get_build_log(name:, build_number:)` - Get console output

### Nodes
- `list_nodes` - List all nodes
- `get_node(name:)` - Get node details

## License

MIT
