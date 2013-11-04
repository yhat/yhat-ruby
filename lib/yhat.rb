require 'rubygems'
require 'json'
require 'net/http'
require 'uri'

class Yhat
  # Class that can be used to access the Yhat API
 
  def initialize(username, apikey, uri = 'api.yhathq.com')
    @username = username
    @apikey = apikey
    @base_uri = uri

    if @base_uri == 'api.yhathq.com'
      @is_enterprise = false
    else
      @is_enterprise = true
    end

  end

  # Make a prediction by calling Yhat via HTTP. You should pass both
  # the name of the model you want to use to make a prediction as well
  # as a JSON object (or a Hash) that contains the data requried to 
  # make a prediction.
  #
  # @param modelname [String]
  # @param data [Hash]
  # @return [Hash]
  def predict(modelname, data)
    uri = URI::parse(@base_uri)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new("/models/" + modelname + "/")
    request.add_field('Content-Type', 'application/json')
    request.body = data
    response = http.request(request)
    data = response.body
    JSON.parse(data)
  end
end

