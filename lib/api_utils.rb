module ApiUtils

# TEST BROADSOFT API CALL
def self.licenses()
  begin
    $bsoft_api_endpoint['/license'].send(:get) do |response, request, result, &block|
      last_response = response
      response = response.return!(request, result, &block)
    end
  rescue => e
    p e.message
    {}
  end
end

end