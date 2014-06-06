require 'rest-client'
require 'json'


bsoft_api_endpoint       = YAML.load_file(Rails.root.join('config', 'api_endpoints.yml'))[Rails.env]['bsoft_api_url']

#Ip address_verification_url.inspect

$bsoft_api_endpoint       = RestClient::Resource.new(bsoft_api_endpoint      , :open_timeout=>15, :timeout=>90, :headers=>{:accept=>:xml, :content_type => :xml})
