require 'sitepoint/sitepoint.rb'

require 'soap/rpc/driver'

class CrmHubSoap < ::SOAP::RPC::Driver
  DefaultEndpointUrl = "http://crmhub.austhink.com/EcommerceTest/Crmhub.asmx"
  MappingRegistry = ::SOAP::Mapping::Registry.new

  Methods = [
    [ "http://tempuri.org/ActivateNew",
      "activateNew",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "ActivateNew"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "ActivateNewResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "http://tempuri.org/Ping",
      "ping",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "Ping"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "PingResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "http://tempuri.org/CreateCustomer",
      "createCustomer",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "CreateCustomer"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "CreateCustomerResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "http://tempuri.org/UpdateCustomer",
      "updateCustomer",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "UpdateCustomer"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "UpdateCustomerResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "http://tempuri.org/GetCustomerDetails",
      "getCustomerDetails",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "GetCustomerDetails"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "GetCustomerDetailsResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "http://tempuri.org/FindCustomerByEmail",
      "findCustomerByEmail",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "FindCustomerByEmail"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "FindCustomerByEmailResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "http://tempuri.org/DeleteTestData",
      "deleteTestData",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "DeleteTestData"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "DeleteTestDataResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "http://tempuri.org/NotifyOfOrder",
      "notifyOfOrder",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "NotifyOfOrder"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "NotifyOfOrderResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "http://tempuri.org/GetOrder",
      "getOrder",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "GetOrder"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "GetOrderResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "http://tempuri.org/NotifyOfFailedOrder",
      "notifyOfFailedOrder",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "NotifyOfFailedOrder"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "NotifyOfFailedOrderResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "http://tempuri.org/GetSubscriptions",
      "getSubscriptions",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "GetSubscriptions"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "GetSubscriptionsResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "http://tempuri.org/MelbUniPersonAlreadyRegistered",
      "melbUniPersonAlreadyRegistered",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "MelbUniPersonAlreadyRegistered"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "MelbUniPersonAlreadyRegisteredResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "http://tempuri.org/IssueMelbourneUniLicense",
      "issueMelbourneUniLicense",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "IssueMelbourneUniLicense"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "IssueMelbourneUniLicenseResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "http://tempuri.org/Database",
      "database",
      [ ["in", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "Database"], true],
        ["out", "parameters", ["::SOAP::SOAPElement", "http://tempuri.org/", "DatabaseResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ]
  ]

  def initialize(endpoint_url = nil)
    endpoint_url ||= DefaultEndpointUrl
    super(endpoint_url, nil)
    self.mapping_registry = MappingRegistry
    init_methods
  end

private

  def init_methods
    Methods.each do |definitions|
      opt = definitions.last
      if opt[:request_style] == :document
        add_document_operation(*definitions)
      else
        add_rpc_operation(*definitions)
        qname = definitions[0]
        name = definitions[2]
        if qname.name != name and qname.name.capitalize == name.capitalize
          ::SOAP::Mapping.define_singleton_method(self, qname.name) do |*arg|
            __send__(name, *arg)
          end
        end
      end
    end
  end
end

