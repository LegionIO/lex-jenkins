# frozen_string_literal: true

RSpec.describe Legion::Extensions::Jenkins::Runners::Nodes do
  let(:client) { Legion::Extensions::Jenkins::Client.new(url: 'http://jenkins.example.com', username: 'admin', token: 'secret') }
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:test_connection) do
    Faraday.new(url: 'http://jenkins.example.com') do |conn|
      conn.request :json
      conn.response :json, content_type: /\bjson$/
      conn.adapter :test, stubs
    end
  end

  before { allow(client).to receive(:connection).and_return(test_connection) }

  describe '#list_nodes' do
    it 'returns the list of nodes' do
      stubs.get('/computer/api/json') do
        [200, { 'Content-Type' => 'application/json' },
         { 'computer' => [{ 'displayName' => 'master', 'offline' => false, 'numExecutors' => 2 }] }]
      end
      result = client.list_nodes
      expect(result[:result]).to be_a(Hash)
      expect(result[:result]['computer'].first['displayName']).to eq('master')
    end
  end

  describe '#get_node' do
    it 'returns details for a specific node' do
      stubs.get('/computer/agent-1/api/json') do
        [200, { 'Content-Type' => 'application/json' },
         { 'displayName' => 'agent-1', 'offline' => false, 'numExecutors' => 4 }]
      end
      result = client.get_node(name: 'agent-1')
      expect(result[:result]['displayName']).to eq('agent-1')
      expect(result[:result]['numExecutors']).to eq(4)
    end
  end
end
