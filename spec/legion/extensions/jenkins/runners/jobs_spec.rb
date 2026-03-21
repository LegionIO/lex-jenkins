# frozen_string_literal: true

RSpec.describe Legion::Extensions::Jenkins::Runners::Jobs do
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

  describe '#list_jobs' do
    it 'returns jobs from the Jenkins API' do
      stubs.get('/api/json') do
        [200, { 'Content-Type' => 'application/json' }, { 'jobs' => [{ 'name' => 'my-pipeline', 'color' => 'blue' }] }]
      end
      result = client.list_jobs
      expect(result[:result]).to be_a(Hash)
      expect(result[:result]['jobs'].first['name']).to eq('my-pipeline')
    end
  end

  describe '#get_job' do
    it 'returns details for a specific job' do
      stubs.get('/job/my-pipeline/api/json') do
        [200, { 'Content-Type' => 'application/json' }, { 'name' => 'my-pipeline', 'buildable' => true }]
      end
      result = client.get_job(name: 'my-pipeline')
      expect(result[:result]['name']).to eq('my-pipeline')
    end
  end

  describe '#delete_job' do
    it 'returns true on successful deletion' do
      stubs.post('/job/my-pipeline/doDelete') { [302, {}, ''] }
      result = client.delete_job(name: 'my-pipeline')
      expect(result[:result]).to be true
    end
  end

  describe '#enable_job' do
    it 'returns true when job is enabled' do
      stubs.post('/job/my-pipeline/enable') { [200, {}, ''] }
      result = client.enable_job(name: 'my-pipeline')
      expect(result[:result]).to be true
    end
  end

  describe '#disable_job' do
    it 'returns true when job is disabled' do
      stubs.post('/job/my-pipeline/disable') { [200, {}, ''] }
      result = client.disable_job(name: 'my-pipeline')
      expect(result[:result]).to be true
    end
  end

  describe '#create_job' do
    it 'returns true when job is created' do
      stubs.post('/createItem?name=new-job') { [200, {}, ''] }
      result = client.create_job(name: 'new-job', xml_config: '<project/>')
      expect(result[:result]).to be true
    end
  end
end
