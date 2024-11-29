# frozen_string_literal: true

require_relative 'lib/faraday/aws/xray/version'

Gem::Specification.new do |spec|
  spec.name = 'faraday-aws-xray'
  spec.version = Faraday::Aws::XRay::VERSION
  spec.authors = ['Jay Zeschin']
  spec.email = ['jay@zeschin.org']

  spec.summary = 'Faraday middleware to instrument spans for AWS X-Ray'
  spec.description = <<~DESC
    Faraday middleware to instrument spans for AWS X-Ray.
  DESC
  spec.license = 'MIT'

  github_uri = "https://github.com/ajayzes/faraday-aws-xray/#{spec.name}"

  spec.homepage = github_uri

  spec.metadata = {
    'bug_tracker_uri' => "#{github_uri}/issues",
    'changelog_uri' => "#{github_uri}/blob/v#{spec.version}/CHANGELOG.md",
    'documentation_uri' => "http://www.rubydoc.info/gems/#{spec.name}/#{spec.version}",
    'homepage_uri' => spec.homepage,
    'rubygems_mfa_required' => 'true',
    'source_code_uri' => github_uri,
    'wiki_uri' => "#{github_uri}/wiki"
  }

  spec.files = Dir['lib/**/*', 'README.md', 'LICENSE.md', 'CHANGELOG.md']

  spec.required_ruby_version = '>= 3.0', '< 4'

  spec.add_dependency 'faraday', '>= 2.9', '< 3'
  spec.add_dependency 'aws-xray-sdk'
end
