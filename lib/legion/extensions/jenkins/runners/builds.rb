# frozen_string_literal: true

require 'legion/extensions/jenkins/helpers/client'

module Legion
  module Extensions
    module Jenkins
      module Runners
        module Builds
          include Legion::Extensions::Jenkins::Helpers::Client

          def get_build(name:, build_number:, **)
            response = connection(**).get("/job/#{name}/#{build_number}/api/json")
            { result: response.body }
          end

          def get_last_build(name:, **)
            response = connection(**).get("/job/#{name}/lastBuild/api/json")
            { result: response.body }
          end

          def trigger_build(name:, parameters: {}, **)
            response = if parameters.empty?
                         connection(**).post("/job/#{name}/build")
                       else
                         connection(**).post("/job/#{name}/buildWithParameters", parameters)
                       end
            { result: [201, 200].include?(response.status) }
          end

          def get_build_log(name:, build_number:, **)
            response = connection(**).get("/job/#{name}/#{build_number}/consoleText")
            { result: response.body }
          end

          include Legion::Extensions::Helpers::Lex if Legion::Extensions.const_defined?(:Helpers) &&
                                                      Legion::Extensions::Helpers.const_defined?(:Lex)
        end
      end
    end
  end
end
