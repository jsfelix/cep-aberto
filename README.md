# cep-aberto
Ruby Connector for the CEP ABERTO API v3 (www.cepaberto.com)

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
First, you need an authorization token to use this gem. Go to [CEP Aberto](http://www.cepaberto.com/)
and sign up for free.

### Find address
Run:
```ruby
require "cep-aberto"
CepAberto::Cep::find("01001000", "1234567890abcdef01234567890abcde")
```

This method return a hash with the full address for the zipcode:
```ruby
=> {"altitude"=>760.0,
 "cep"=>"01001000",
 "latitude"=>"-23.5479099981",
 "longitude"=>"-46.636",
 "logradouro"=>"Pra\u00E7a da S\u00E9",
 "bairro"=>"S\u00E9",
 "cidade"=>{"ddd"=>11, "ibge"=>"3550308", "nome"=>"S\u00E3o Paulo"},
 "estado"=>{"sigla"=>"SP"}}
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
 "Aguaí",
 "Águas da Prata",
 "Águas de Lindóia",
 "Águas de Santa Bárbara",
 "Águas de São Pedro",
 ...
```
### List cities (including districts)
To list cities and districts from a state, do this:
```ruby
require "cep-aberto"
CepAberto::Cep::cities_with_districts("SP", "1234567890abcdef01234567890abcde")
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
 ...
```



## Thanks

Thanks to [CEP Aberto](http://cepaberto.com)
