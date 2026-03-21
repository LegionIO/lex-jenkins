# frozen_string_literal: true

require 'legion/extensions/jenkins/helpers/client'
require 'legion/extensions/jenkins/runners/jobs'
require 'legion/extensions/jenkins/runners/builds'
require 'legion/extensions/jenkins/runners/nodes'

module Legion
  module Extensions
    module Jenkins
      class Client
        include Helpers::Client
        include Runners::Jobs
        include Runners::Builds
        include Runners::Nodes

        attr_reader :opts

        def initialize(url: 'http://localhost:8080', username: nil, token: nil, **extra)
          @opts = { url: url, username: username, token: token, **extra }.compact
        end

        def connection(**override)
          super(**@opts.merge(override))
        end
      end
    end
  end
end
