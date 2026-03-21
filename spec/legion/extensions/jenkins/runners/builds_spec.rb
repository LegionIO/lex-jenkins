# frozen_string_literal: true

RSpec.describe Legion::Extensions::Jenkins::Runners::Builds do
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

  describe '#get_build' do
    it 'returns details for a specific build' do
      stubs.get('/job/my-pipeline/42/api/json') do
        [200, { 'Content-Type' => 'application/json' }, { 'number' => 42, 'result' => 'SUCCESS' }]
      end
      result = client.get_build(name: 'my-pipeline', build_number: 42)
      expect(result[:result]['number']).to eq(42)
      expect(result[:result]['result']).to eq('SUCCESS')
    end
  end

  describe '#get_last_build' do
    it 'returns the last build details' do
      stubs.get('/job/my-pipeline/lastBuild/api/json') do
        [200, { 'Content-Type' => 'application/json' }, { 'number' => 99, 'result' => 'FAILURE' }]
      end
      result = client.get_last_build(name: 'my-pipeline')
      expect(result[:result]['number']).to eq(99)
    end
  end

  describe '#trigger_build' do
    it 'triggers a build without parameters' do
      stubs.post('/job/my-pipeline/build') { [201, {}, ''] }
      result = client.trigger_build(name: 'my-pipeline')
      expect(result[:result]).to be true
    end

    it 'triggers a build with parameters' do
      stubs.post('/job/my-pipeline/buildWithParameters') { [201, {}, ''] }
      result = client.trigger_build(name: 'my-pipeline', parameters: { BRANCH: 'main' })
      expect(result[:result]).to be true
    end
  end

  describe '#get_build_log' do
    it 'returns the console output for a build' do
      stubs.get('/job/my-pipeline/42/consoleText') do
        [200, { 'Content-Type' => 'text/plain' }, 'Started by user admin\nFinished: SUCCESS']
      end
      result = client.get_build_log(name: 'my-pipeline', build_number: 42)
      expect(result[:result]).to include('SUCCESS')
    end
  end
end
