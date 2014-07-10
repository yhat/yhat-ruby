require 'rubygems'
require 'json'
require 'net/http'
require 'uri'

class Yhat
  # Class that can be used to access the Yhat API
  def initialize(username, apikey, env = 'cloud.yhathq.com')
    @username = username
    @apikey = apikey
    @base_uri = URI.encode(env.sub(/^http:\/\//, "").sub(/\/$/, ""))

    # set up a http request
    uri = URI("http://#{@base_uri}")
    http = Net::HTTP.new(uri.host, uri.port)

    endpoint = URI::encode("/verify?username=#{username}&apikey=#{apikey}")
    request = Net::HTTP::Post.new(endpoint)
    request.add_field('Content-Type', 'application/json')
    request.basic_auth(@username, @apikey)

    # send the request
    begin
      response = http.request(request)
    rescue
      raise "Could not connect to host: #{@base_uri}"
    end

    # try to parse the response
    begin
      data = JSON.parse(response.body)
    rescue
      raise "Bad response from host: #{@base_uri}"
    end

    # see if the response is valid
    if data["success"] != "true"
      raise "Incorrect username/apikey!" 
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
    # set up a http request
    uri = URI("http://#{@base_uri}")
    http = Net::HTTP.new(uri.host, uri.port)

    endpoint = URI::encode("/#{@username}/models/#{modelname}/")
    request = Net::HTTP::Post.new(endpoint)
    request.add_field('Content-Type', 'application/json')
    request.basic_auth(@username, @apikey)

    # convert data to JSON
    begin
      request.body = data.to_json
    rescue
      raise "Could not convert data to JSON"
    end

    # send the request
    begin
      response = http.request(request)
    rescue
      raise "Could not connect to host: #{@base_uri}"
    end

    # return a response
    begin
      return JSON.parse(response.body)
    rescue
      raise "Bad response from path: #{@base_uri}#{endpoint}"
    end
  end
end

