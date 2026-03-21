# frozen_string_literal: true

require 'legion/extensions/jenkins/helpers/client'

module Legion
  module Extensions
    module Jenkins
      module Runners
        module Nodes
          include Legion::Extensions::Jenkins::Helpers::Client

          def list_nodes(**)
            response = connection(**).get('/computer/api/json', tree: 'computer[displayName,offline,numExecutors]')
            { result: response.body }
          end

          def get_node(name:, **)
            response = connection(**).get("/computer/#{name}/api/json")
            { result: response.body }
          end

          include Legion::Extensions::Helpers::Lex if Legion::Extensions.const_defined?(:Helpers) &&
                                                      Legion::Extensions::Helpers.const_defined?(:Lex)
        end
      end
    end
  end
end
