module S3ListBuckets

  class Config
    # Stronger builder pattern would be nice
    attr_accessor :client_options, :s3_client,
      :patterns,
      :show_location,
      :json_format

    def initialize
      @client_options = {}
      @patterns = nil
      @show_location = false
      @json_format = false
    end

    def validate
    end
  end

end
