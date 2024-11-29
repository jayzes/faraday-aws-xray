# frozen_string_literal: true

RSpec.describe Faraday::Aws::XRay::Middleware do
  let(:app) { ->(env) { Faraday::Response.new(env) } }
  let(:env) do
    Faraday::Env.from(
      url: Faraday::Utils.URI('https://example.com/test'),
      status: 200,
      method: :get,
      body: 'response',
      request_headers: Faraday::Utils::Headers.new({ 'User-Agent' => 'TestAgent' }),
      response_headers: Faraday::Utils::Headers.new({ 'Content-Length' => '100' })
    )
  end
  let(:options) { { name: 'test_request' } }
  let(:middleware) { described_class.new(app, options) }
  let(:segment) { instance_double(XRay::Segment) }
  let(:subsegment) { instance_double(XRay::Subsegment) }

  before do
    allow(::XRay.recorder).to receive(:capture).and_yield(segment)
    allow(::XRay.recorder).to receive(:capture).and_yield(subsegment)
    allow(subsegment).to receive(:merge_http_request)
    allow(subsegment).to receive(:merge_http_response)
  end

  describe '#call' do
    it 'creates an X-Ray segment and subsegment' do
      middleware.call(env)
      expect(::XRay.recorder).to have_received(:capture).with('test_request')
      expect(::XRay.recorder).to have_received(:capture).with('https://example.com/test')
    end

    it 'adds request data to the subsegment' do
      middleware.call(env)
      expect(subsegment).to have_received(:merge_http_request).with(
        request: {
          method: 'GET',
          url: 'https://example.com/test',
          user_agent: 'TestAgent'
        }
      )
    end

    it 'adds response data to the subsegment' do
      allow(::XRay.recorder).to receive(:capture).and_yield(subsegment)
      middleware.call(env)
      expect(subsegment).to have_received(:merge_http_response).with(
        response: {
          status: 200,
          content_length: '100'
        }
      )
    end

    context 'when an exception occurs' do
      let(:app) { ->(_env) { raise StandardError, 'Test error' } }

      it 're-raises the exception' do
        expect { middleware.call(env) }.to raise_error(StandardError, 'Test error')
      end
    end
  end
end
