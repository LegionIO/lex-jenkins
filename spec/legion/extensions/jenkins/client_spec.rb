# frozen_string_literal: true

RSpec.describe Legion::Extensions::Jenkins::Client do
  subject(:client) { described_class.new(url: 'http://jenkins.example.com', username: 'admin', token: 'secret') }

  describe '#initialize' do
    it 'stores url in opts' do
      expect(client.opts[:url]).to eq('http://jenkins.example.com')
    end

    it 'stores username in opts' do
      expect(client.opts[:username]).to eq('admin')
    end

    it 'stores token in opts' do
      expect(client.opts[:token]).to eq('secret')
    end

    it 'uses default url when not provided' do
      c = described_class.new
      expect(c.opts[:url]).to eq('http://localhost:8080')
    end

    it 'compacts nil values' do
      c = described_class.new(username: nil, token: nil)
      expect(c.opts).not_to have_key(:username)
      expect(c.opts).not_to have_key(:token)
    end
  end

  describe '#connection' do
    it 'returns a Faraday connection' do
      expect(client.connection).to be_a(Faraday::Connection)
    end
  end
end
