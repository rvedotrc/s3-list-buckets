lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 's3-list-buckets/version'

Gem::Specification.new do |s|
  s.name        = 's3-list-buckets'
  s.version     = S3ListBuckets::VERSION
  s.licenses    = [ 'Apache-2.0' ]
  s.date        = '2017-07-10'
  s.summary     = 'List S3 bucket names and their location constraints'
  s.description = '
    s3-list-buckets shows the names and (optionally) location constraints of
    your S3 buckets.

    Options are available to control display of location constraint and json
    output.

    Respects $https_proxy.
  '
  s.homepage    = 'https://github.com/rvedotrc/s3-list-buckets'
  s.authors     = ['Rachel Evans']
  s.email       = 's3-list-buckets-git@rve.org.uk'

  s.executables = %w[
s3-list-buckets
  ]

  s.files       = %w[
lib/s3-list-buckets.rb
lib/s3-list-buckets/client.rb
lib/s3-list-buckets/config.rb
lib/s3-list-buckets/runner.rb
lib/s3-list-buckets/version.rb
  ] + s.executables.map {|s| "bin/"+s}

  s.require_paths = ["lib"]

  s.add_dependency 'aws-sdk', "~> 2.0"
  s.add_dependency 'rosarium', "~> 0.1"
end
