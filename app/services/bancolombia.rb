require 'uri'
require 'openssl'
require 'net/http'

class Bancolombia

  def initialize(args = {})
    @client_id = args[:client_id]
    @client_secret = args[:client_secret]
    @token = generate_token
  end

  def call(amount)
    url = URI("https://sbapi.bancolombia.com/v1/operations/cross-product/payments/payment-orders/actions/start")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    request = Net::HTTP::Post.new(url)
    request["authorization"] = "Bearer #{@token}"
    request["content-type"] = 'application/vnd.bancolombia.v1+json'
    request["accept"] = 'application/vnd.bancolombia.v1+json'
    request.body = "{\"data\":[{\"button_commerce_code\":\"123\",\"button_commerce_bill\":\"0000123455\",\"button_commerce_value\":\"#{amount}\",\"button_commerce_reference\":\"1 mes de suscripción a Poncho\"}]}"

    response = http.request(request)
    response.read_body
  end

  private

  def generate_token
    url = URI("https://sbapi.bancolombia.com/v2/security/oauth-otp/oauth2/token")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/x-www-form-urlencoded'
    request["accept"] = 'application/json'
    request.body = "grant_type=client_credentials&client_id=#{@client_id}&client_secret=#{@client_secret}&scope=Payments-order:write:app"
    response = http.request(request)
    response_json = JSON.parse(response.read_body)
    response_json["access_token"]
  end
end
