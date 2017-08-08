# Main module CepAberto
# Author:: Jefferson Felix
module CepAberto
  # This class holds the methods to find zipcodes and address using the CEP 
  # Aberto API.
  class Cep
    
    require "net/http"
    require "uri"
    require "json"
    
    @domain = "http://www.cepaberto.com/api/v2/ceps.json"

    # Find an address from a zipcode using the CEP Aberto API
    # Params:
    # +zipcode+:: the zipcode to be searched by CEP Aberto API
    # +token+:: the user authorization token
    # Return: Hash with the full address
    def Cep::find(cep, token)
      validate_cep(cep)
      uri = URI(@domain)
      params = {'cep' => cep}
      headers = { "Authorization" => "Token token=#{token}" }
      
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.path)
      request.set_form_data(params)
      request = Net::HTTP::Get.new(uri.path + '?' + request.body, headers)
      response = http.request(request).body
      address = JSON.parse(response)
      if(address["logradouro"].is_a?String)
        address["logradouro"] = address["logradouro"].split(",")[0]
      end
      return address
    end

    private
    
    def Cep::validate_cep(str)
      raise ArgumentError, 'Argument is not string with 8 characters' unless str.is_a? String and str.length == 8
    end
  end
end




