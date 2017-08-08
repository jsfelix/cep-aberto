# cep-aberto
Ruby Connector for the CEP ABERTO API (www.cepaberto.com)

## Installation
Include cep-aberto in Gemfile:
```ruby
gem 'cep-aberto'
```
And bundle with:
```bash
bundle 
```
Or execute manually:
```bash
gem install cep-aberto
```

## Usage
First, you need a Token Authorization to use this gem. Go to [CEP Aberto site](http://www.cepaberto.com/) and sign up for free.

### Find address
Run:
```ruby
require "cep-aberto"
CepAberto::Cep::find("01001000", "1234567890abcdef01234567890abcde")
```

This method return a hash with the full address for the zipcode:
```ruby
=> {"altitude"=>760.0,
 "bairro"=>"Sé",
 "cep"=>"01001000",
 "latitude"=>"-23.5479099981",
 "longitude"=>"-46.636",
 "logradouro"=>"Praça da Sé",
 "cidade"=>"São Paulo",
 "ddd"=>11,
 "ibge"=>"3550308",
 "estado"=>"SP"}
```

### List cities 
To list cities from a given state, do this:
```ruby
require "cep-aberto"
CepAberto::Cep::cities("SP", "1234567890abcdef01234567890abcde")
```
And the result is:
```ruby
=> ["Adamantina",
 "Adolfo",
 "Agisse (Rancharia)",
 "Aguaí",
 "Águas da Prata",
 "Águas de Lindóia",
 "Águas de Santa Bárbara",
 "Águas de São Pedro",
 "Água Vermelha (São Carlos)",
 ...
```

## Thanks

Thanks to [CEP Aberto](http://www.cepaberto.com)
