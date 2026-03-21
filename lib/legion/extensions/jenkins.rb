# frozen_string_literal: true

require 'legion/extensions/jenkins/version'
require 'legion/extensions/jenkins/helpers/client'
require 'legion/extensions/jenkins/runners/jobs'
require 'legion/extensions/jenkins/runners/builds'
require 'legion/extensions/jenkins/runners/nodes'
require 'legion/extensions/jenkins/client'

module Legion
  module Extensions
    module Jenkins
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
