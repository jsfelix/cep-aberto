# Main module CepAberto.
# Author:: Jefferson Felix
module CepAberto
  # This class holds the methods to find zipcodes and addresses using the CEP
  # Aberto API.
  class Cep

    require "net/http"
    require "uri"
    require "json"

    # CEP Aberto API (v2)
    @domain = "http://www.cepaberto.com/api/v2/"

    # Find an address from a zipcode using the CEP Aberto API. <br />
    # Params:
    # +zipcode+:: the zipcode to be searched by CEP Aberto API
    # +token+:: the user authorization token
    # Returns a hash with the full address
    def Cep::find(cep, token)
      validate_cep(cep)
      uri = URI("#{@domain}ceps.json")
      params = {'cep' => cep}
      address = request_cep(uri, params, token)
      if(address["logradouro"].is_a?String)
        address["logradouro"] = address["logradouro"].split(",")[0]
      end
      return address
    end

    # Returns a list of cities from a given state, including their districts. <br />
    # Params:
    # +state+:: State acronym (e.g. SP)
    # +token+:: the user authorization token
    # Returns an array with all cities from the state
    def Cep::cities_with_districts(state, token)
      uri = URI("#{@domain}cities.json")
      params = {'estado' => state}
      all_cities = request_cep(uri, params, token)
      cities_arr = Array.new
      all_cities.each do |c|
        cities_arr.push(c["nome"])
      end
      return cities_arr
    end

    # Returns a list of cities from a given state. This method excludes districts. <br />
    # Params:
    # +state+:: State acronym (e.g. SP)
    # +token+:: the user authorization token
    # Returns an array with all cities from the state
    def Cep::cities(state, token)
      all_cities = cities_with_districts(state, token)
      cities_arr = Array.new
      all_cities.each do |c|
        cities_arr.push(c) unless c.end_with?(')')
      end
      return cities_arr
    end

    private

    # Validate cep entry
    # * Must be a string
    # * Must be 8 characters
    def Cep::validate_cep(str)
      raise ArgumentError, 'Argument is not string with 8 characters' unless str.is_a? String and str.length == 8
    end

    # Request API
    def Cep::request_cep(uri, params, token)
      headers = { "Authorization" => "Token token=#{token}" }
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.path)
      request.set_form_data(params)
      request = Net::HTTP::Get.new(uri.path + '?' + request.body, headers)
      response = http.request(request).body
      JSON.parse(response)
    end

  end
end
