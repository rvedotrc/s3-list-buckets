require 'aws-sdk'
require 'json'
require 'rosarium'

module S3ListBuckets

  class Runner

    def initialize(config)
      @config = config

      @config.s3_client ||= begin
                              effective_options = S3ListBuckets::Client.core_v2_options.merge(config.client_options)
                              Aws::S3::Client.new(effective_options)
                            end
    end

    def promise
      Rosarium::Promise.execute do
        @config.s3_client.list_buckets
      end.then do |response|
        # list_buckets doesn't paginate so this is relatively simple
        Rosarium::Promise.all(
          response.buckets.map {|bucket| promise_bucket bucket}.reject &:nil?
        )
      end
    end

    def promise_bucket(bucket)
      return nil unless name_matches_patterns?(bucket.name)

      Rosarium::Promise.execute do
        r = {
          name: bucket.name,
          creation_date: bucket.creation_date,
        }

        if @config.show_location
          r[:location_constraint] = @config.s3_client.get_bucket_location(bucket: bucket.name).location_constraint
        end

        r
      end
    end

    def name_matches_patterns?(bucket_name)
      return true if @config.patterns.nil?

      @config.patterns.any? do |pattern|
        bucket_name.match("^" + pattern)
      end
    end

    def display_json(buckets)
      buckets.each do |bucket|
        bucket[:creation_date] = bucket[:creation_date].utc.strftime '%Y-%m-%dT%H:%M:%SZ'
        puts JSON.generate(bucket)
      end
    end

    def display_location_text(buckets)
      unless buckets.empty?
        width = buckets.map {|d| (d[:location_constraint] || "-").length }.max
        format = "%-#{width}.#{width}s %s"
        buckets.each do |d|
          puts format % [ d[:location_constraint] || "-", d[:name] ]
        end
      end
    end

    def run
      promise.then do |buckets|
        if @config.json_format
          display_json(buckets)
        elsif @config.show_location
          display_location_text(buckets)
        else
          buckets.each {|bucket| puts bucket[:name]}
        end
      end.value!

      0
    end

  end

end
