# frozen_string_literal: true

require 'legion/extensions/jenkins/helpers/client'

module Legion
  module Extensions
    module Jenkins
      module Runners
        module Jobs
          include Legion::Extensions::Jenkins::Helpers::Client

          def list_jobs(**)
            response = connection(**).get('/api/json', tree: 'jobs[name,url,color]')
            { result: response.body }
          end

          def get_job(name:, **)
            response = connection(**).get("/job/#{name}/api/json")
            { result: response.body }
          end

          def create_job(name:, xml_config:, **)
            conn = connection(**)
            conn.headers['Content-Type'] = 'application/xml'
            response = conn.post("/createItem?name=#{name}", xml_config)
            { result: response.status == 200 }
          end

          def delete_job(name:, **)
            response = connection(**).post("/job/#{name}/doDelete")
            { result: [302, 200].include?(response.status) }
          end

          def enable_job(name:, **)
            response = connection(**).post("/job/#{name}/enable")
            { result: [302, 200].include?(response.status) }
          end

          def disable_job(name:, **)
            response = connection(**).post("/job/#{name}/disable")
            { result: [302, 200].include?(response.status) }
          end

          include Legion::Extensions::Helpers::Lex if Legion::Extensions.const_defined?(:Helpers) &&
                                                      Legion::Extensions::Helpers.const_defined?(:Lex)
        end
      end
    end
  end
end
