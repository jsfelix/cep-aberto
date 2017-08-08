module CepAberto
  class Cep
    
    require "net/http"
    require "uri"
    require "json"
    
    @domain = "http://www.cepaberto.com/api/v2/ceps.json"

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

    def Cep::validate_cep(str)
      raise ArgumentError, 'Argument is not string with 8 characters' unless str.is_a? String and str.length == 8
    end
  end
end




