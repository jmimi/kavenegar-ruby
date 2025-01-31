module KaveRestApi
  class Lookup < KaveRestApi::RequestBase
    include Validatable
    attr_accessor :receptor, :type, :template, :token, :token2, :token3
    attr_reader   :response,:message_size
    validates_presence_of :token
    validates_presence_of :receptor    

    def initialize(args = {})
      super
      @ACTION_NAME    = [:lookup,@FORMAT].join('.').freeze
      @receptor    = args.fetch(:receptor)
      @receptor    = @receptor.ctsd
      @valid_receptor = @receptor.is_phone?
      @token       = args.fetch(:token)
      @token2      = args.fetch(:token2,nil)
      @token3      = args.fetch(:token3,nil)
      @template    = args.fetch(:template)
      @type        = args.fetch(:type,'sms')
      @response    = ResponseLookup.new
    end

    def valid_message?
      @valid_message ||= true
    end

    def valid_receptor?
      @valid_receptor
    end

    def call
        connection = Faraday.new(url: "#{@API_URL}/verify/") do |faraday|
          faraday.adapter Faraday.default_adapter
          faraday.response @FORMAT.to_sym
        end
         response = connection.get(@ACTION_NAME, receptor: @receptor , token: @token , template: @template , type: @type , token2: @token2 , token3: @token3)
         @response.validate(response.body)
    end

  end

end
