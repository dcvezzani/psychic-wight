# while the SOAP server is running...
#
# Usage: ruby client.rb
#

require 'bundler'
Bundler.setup

require 'savon'

wsdl_location = "http://localhost:3652/soap/wsdl"

namespaces = {
  "xmlns" => "urn:WashOut"
}

@client = Savon.client({wsdl: wsdl_location, 
        pretty_print_xml: true, 
        log_level: :debug, 
        logger: Logger.new('savon.log'), 
        namespace: "urn:WashOut"
        #namespaces: namespaces
})

puts @client.operations

# formatted_xml = <<-EOL
#  <soapenv:Envelope xmlns="http://www.without-brains.net/echo_service" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:echo="http://www.without-brains.net/echo" >
#  <soapenv:Header/>
#  <soapenv:Body>
#    <echo:EchoRequest>
#      <echo:Message>Hello from Ruby</echo:Message>
#    </echo:EchoRequest>
#  </soapenv:Body>
# </soapenv:Envelope>
# EOL
# 
# xml = formatted_xml.gsub(/>\s+</, '><').gsub(/^\s+/, "").gsub(/\s+$/, "")

response = @client.call(:integer_to_string, message: { value: 101})
#response = @client.call(:echo, xml: xml)

#puts response.body[:echo_response][:message]
puts response.body[:integer_to_string_response][:value]

