require 'xsd/qname'

ResponseCodes = Hash.new { |h,k|
  case k
  when 1
    "Success"
  when -1
    "General Failure"
  when -2
    "Unrecognised customer id and/or password"
  when -3
    "Another customer already has the specified email"
  when -4
    "Invalid dealer"
  when -6
    "Empty order"
  else
    "Unknown error code: " + k.to_s
  end
}

Dealer = 'SitepointEcommerce | moon chair triffid'

# {http://tempuri.org/}ActivateNew
class ActivateNew
  @@schema_type = "ActivateNew"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["licenseId", "SOAP::SOAPString"], ["userName", "SOAP::SOAPString"], ["assemblyName", "SOAP::SOAPString"], ["version", "SOAP::SOAPString"], ["machineHash", "SOAP::SOAPString"]]

  attr_accessor :licenseId
  attr_accessor :userName
  attr_accessor :assemblyName
  attr_accessor :version
  attr_accessor :machineHash

  def initialize(licenseId = nil, userName = nil, assemblyName = nil, version = nil, machineHash = nil)
    @licenseId = licenseId
    @userName = userName
    @assemblyName = assemblyName
    @version = version
    @machineHash = machineHash
  end
end

# {http://tempuri.org/}ActivateNewResponse
class ActivateNewResponse
  @@schema_type = "ActivateNewResponse"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["activateNewResult", ["ActivationStatus", XSD::QName.new("http://tempuri.org/", "ActivateNewResult")]]]

  def ActivateNewResult
    @activateNewResult
  end

  def ActivateNewResult=(value)
    @activateNewResult = value
  end

  def initialize(activateNewResult = nil)
    @activateNewResult = activateNewResult
  end
end

# {http://tempuri.org/}Ping
class Ping
  @@schema_type = "Ping"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = []

  def initialize
  end
end

# {http://tempuri.org/}PingResponse
class PingResponse
  @@schema_type = "PingResponse"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["pingResult", ["SOAP::SOAPBoolean", XSD::QName.new("http://tempuri.org/", "PingResult")]]]

  def PingResult
    @pingResult
  end

  def PingResult=(value)
    @pingResult = value
  end

  def initialize(pingResult = nil)
    @pingResult = pingResult
  end
end

# {http://tempuri.org/}CreateCustomer
class CreateCustomer
  @@schema_type = "CreateCustomer"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["dealer", "SOAP::SOAPString"], ["c", "CustomerDetails"]]

  attr_accessor :dealer
  attr_accessor :c

  def initialize(dealer = nil, c = nil)
    @dealer = dealer
    @c = c
  end
end

# {http://tempuri.org/}CreateCustomerResponse
class CreateCustomerResponse
  @@schema_type = "CreateCustomerResponse"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["createCustomerResult", ["CustomerLogin", XSD::QName.new("http://tempuri.org/", "CreateCustomerResult")]]]

  def CreateCustomerResult
    @createCustomerResult
  end

  def CreateCustomerResult=(value)
    @createCustomerResult = value
  end

  def initialize(createCustomerResult = nil)
    @createCustomerResult = createCustomerResult
  end
end

# {http://tempuri.org/}UpdateCustomer
class UpdateCustomer
  @@schema_type = "UpdateCustomer"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["dealer", "SOAP::SOAPString"], ["id", "SOAP::SOAPInt"], ["password", "SOAP::SOAPString"], ["c", "CustomerDetails"]]

  attr_accessor :dealer
  attr_accessor :id
  attr_accessor :password
  attr_accessor :c

  def initialize(dealer = nil, id = nil, password = nil, c = nil)
    @dealer = dealer
    @id = id
    @password = password
    @c = c
  end
end

# {http://tempuri.org/}UpdateCustomerResponse
class UpdateCustomerResponse
  @@schema_type = "UpdateCustomerResponse"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["updateCustomerResult", ["SOAP::SOAPInt", XSD::QName.new("http://tempuri.org/", "UpdateCustomerResult")]]]

  def UpdateCustomerResult
    @updateCustomerResult
  end

  def UpdateCustomerResult=(value)
    @updateCustomerResult = value
  end

  def initialize(updateCustomerResult = nil)
    @updateCustomerResult = updateCustomerResult
  end
end

# {http://tempuri.org/}GetCustomerDetails
class GetCustomerDetails
  @@schema_type = "GetCustomerDetails"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["dealer", "SOAP::SOAPString"], ["id", "SOAP::SOAPInt"], ["password", "SOAP::SOAPString"]]

  attr_accessor :dealer
  attr_accessor :id
  attr_accessor :password

  def initialize(dealer = nil, id = nil, password = nil)
    @dealer = dealer
    @id = id
    @password = password
  end
end

# {http://tempuri.org/}GetCustomerDetailsResponse
class GetCustomerDetailsResponse
  @@schema_type = "GetCustomerDetailsResponse"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["getCustomerDetailsResult", ["CustomerDetails", XSD::QName.new("http://tempuri.org/", "GetCustomerDetailsResult")]]]

  def GetCustomerDetailsResult
    @getCustomerDetailsResult
  end

  def GetCustomerDetailsResult=(value)
    @getCustomerDetailsResult = value
  end

  def initialize(getCustomerDetailsResult = nil)
    @getCustomerDetailsResult = getCustomerDetailsResult
  end
end

# {http://tempuri.org/}FindCustomerByEmail
class FindCustomerByEmail
  @@schema_type = "FindCustomerByEmail"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["dealer", "SOAP::SOAPString"], ["email", "SOAP::SOAPString"]]

  attr_accessor :dealer
  attr_accessor :email

  def initialize(dealer = nil, email = nil)
    @dealer = dealer
    @email = email
  end
end

# {http://tempuri.org/}FindCustomerByEmailResponse
class FindCustomerByEmailResponse
  @@schema_type = "FindCustomerByEmailResponse"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["findCustomerByEmailResult", ["CustomerLogin", XSD::QName.new("http://tempuri.org/", "FindCustomerByEmailResult")]]]

  def FindCustomerByEmailResult
    @findCustomerByEmailResult
  end

  def FindCustomerByEmailResult=(value)
    @findCustomerByEmailResult = value
  end

  def initialize(findCustomerByEmailResult = nil)
    @findCustomerByEmailResult = findCustomerByEmailResult
  end
end

# {http://tempuri.org/}DeleteTestData
class DeleteTestData
  @@schema_type = "DeleteTestData"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = []

  def initialize
  end
end

# {http://tempuri.org/}DeleteTestDataResponse
class DeleteTestDataResponse
  @@schema_type = "DeleteTestDataResponse"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = []

  def initialize
  end
end

# {http://tempuri.org/}NotifyOfOrder
class NotifyOfOrder
  @@schema_type = "NotifyOfOrder"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["dealer", "SOAP::SOAPString"], ["id", "SOAP::SOAPInt"], ["password", "SOAP::SOAPString"], ["order", "OrderDetails"]]

  attr_accessor :dealer
  attr_accessor :id
  attr_accessor :password
  attr_accessor :order

  def initialize(dealer = nil, id = nil, password = nil, order = nil)
    @dealer = dealer
    @id = id
    @password = password
    @order = order
  end
end

# {http://tempuri.org/}NotifyOfOrderResponse
class NotifyOfOrderResponse
  @@schema_type = "NotifyOfOrderResponse"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["notifyOfOrderResult", ["SOAP::SOAPInt", XSD::QName.new("http://tempuri.org/", "NotifyOfOrderResult")]]]

  def NotifyOfOrderResult
    @notifyOfOrderResult
  end

  def NotifyOfOrderResult=(value)
    @notifyOfOrderResult = value
  end

  def initialize(notifyOfOrderResult = nil)
    @notifyOfOrderResult = notifyOfOrderResult
  end
end

# {http://tempuri.org/}GetOrder
class GetOrder
  @@schema_type = "GetOrder"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["dealer", "SOAP::SOAPString"], ["id", "SOAP::SOAPInt"], ["password", "SOAP::SOAPString"], ["confirmation", "SOAP::SOAPString"]]

  attr_accessor :dealer
  attr_accessor :id
  attr_accessor :password
  attr_accessor :confirmation

  def initialize(dealer = nil, id = nil, password = nil, confirmation = nil)
    @dealer = dealer
    @id = id
    @password = password
    @confirmation = confirmation
  end
end

# {http://tempuri.org/}GetOrderResponse
class GetOrderResponse
  @@schema_type = "GetOrderResponse"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["getOrderResult", ["OrderDetails", XSD::QName.new("http://tempuri.org/", "GetOrderResult")]]]

  def GetOrderResult
    @getOrderResult
  end

  def GetOrderResult=(value)
    @getOrderResult = value
  end

  def initialize(getOrderResult = nil)
    @getOrderResult = getOrderResult
  end
end

# {http://tempuri.org/}NotifyOfFailedOrder
class NotifyOfFailedOrder
  @@schema_type = "NotifyOfFailedOrder"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["dealer", "SOAP::SOAPString"], ["description", "SOAP::SOAPString"]]

  attr_accessor :dealer
  attr_accessor :description

  def initialize(dealer = nil, description = nil)
    @dealer = dealer
    @description = description
  end
end

# {http://tempuri.org/}NotifyOfFailedOrderResponse
class NotifyOfFailedOrderResponse
  @@schema_type = "NotifyOfFailedOrderResponse"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = []

  def initialize
  end
end

# {http://tempuri.org/}GetSubscriptions
class GetSubscriptions
  @@schema_type = "GetSubscriptions"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["dealer", "SOAP::SOAPString"], ["id", "SOAP::SOAPInt"], ["password", "SOAP::SOAPString"]]

  attr_accessor :dealer
  attr_accessor :id
  attr_accessor :password

  def initialize(dealer = nil, id = nil, password = nil)
    @dealer = dealer
    @id = id
    @password = password
  end
end

# {http://tempuri.org/}GetSubscriptionsResponse
class GetSubscriptionsResponse
  @@schema_type = "GetSubscriptionsResponse"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["getSubscriptionsResult", ["ArrayOfSubscriptionDetails", XSD::QName.new("http://tempuri.org/", "GetSubscriptionsResult")]]]

  def GetSubscriptionsResult
    @getSubscriptionsResult
  end

  def GetSubscriptionsResult=(value)
    @getSubscriptionsResult = value
  end

  def initialize(getSubscriptionsResult = nil)
    @getSubscriptionsResult = getSubscriptionsResult
  end
end

# {http://tempuri.org/}MelbUniPersonAlreadyRegistered
class MelbUniPersonAlreadyRegistered
  @@schema_type = "MelbUniPersonAlreadyRegistered"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["email", "SOAP::SOAPString"]]

  attr_accessor :email

  def initialize(email = nil)
    @email = email
  end
end

# {http://tempuri.org/}MelbUniPersonAlreadyRegisteredResponse
class MelbUniPersonAlreadyRegisteredResponse
  @@schema_type = "MelbUniPersonAlreadyRegisteredResponse"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["melbUniPersonAlreadyRegisteredResult", ["SOAP::SOAPBoolean", XSD::QName.new("http://tempuri.org/", "MelbUniPersonAlreadyRegisteredResult")]]]

  def MelbUniPersonAlreadyRegisteredResult
    @melbUniPersonAlreadyRegisteredResult
  end

  def MelbUniPersonAlreadyRegisteredResult=(value)
    @melbUniPersonAlreadyRegisteredResult = value
  end

  def initialize(melbUniPersonAlreadyRegisteredResult = nil)
    @melbUniPersonAlreadyRegisteredResult = melbUniPersonAlreadyRegisteredResult
  end
end

# {http://tempuri.org/}IssueMelbourneUniLicense
class IssueMelbourneUniLicense
  @@schema_type = "IssueMelbourneUniLicense"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["p", "MelbUniPerson"]]

  attr_accessor :p

  def initialize(p = nil)
    @p = p
  end
end

# {http://tempuri.org/}IssueMelbourneUniLicenseResponse
class IssueMelbourneUniLicenseResponse
  @@schema_type = "IssueMelbourneUniLicenseResponse"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["issueMelbourneUniLicenseResult", ["SOAP::SOAPBoolean", XSD::QName.new("http://tempuri.org/", "IssueMelbourneUniLicenseResult")]]]

  def IssueMelbourneUniLicenseResult
    @issueMelbourneUniLicenseResult
  end

  def IssueMelbourneUniLicenseResult=(value)
    @issueMelbourneUniLicenseResult = value
  end

  def initialize(issueMelbourneUniLicenseResult = nil)
    @issueMelbourneUniLicenseResult = issueMelbourneUniLicenseResult
  end
end

# {http://tempuri.org/}Database
class Database
  @@schema_type = "Database"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = []

  def initialize
  end
end

# {http://tempuri.org/}DatabaseResponse
class DatabaseResponse
  @@schema_type = "DatabaseResponse"
  @@schema_ns = "http://tempuri.org/"
  @@schema_qualified = "true"
  @@schema_element = [["databaseResult", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "DatabaseResult")]]]

  def DatabaseResult
    @databaseResult
  end

  def DatabaseResult=(value)
    @databaseResult = value
  end

  def initialize(databaseResult = nil)
    @databaseResult = databaseResult
  end
end

# {http://tempuri.org/}ActivationStatus
class ActivationStatus
  @@schema_type = "ActivationStatus"
  @@schema_ns = "http://tempuri.org/"
  @@schema_element = [["isActivated", ["SOAP::SOAPBoolean", XSD::QName.new("http://tempuri.org/", "IsActivated")]], ["message", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "Message")]], ["licenceString", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "LicenceString")]]]

  def IsActivated
    @isActivated
  end

  def IsActivated=(value)
    @isActivated = value
  end

  def Message
    @message
  end

  def Message=(value)
    @message = value
  end

  def LicenceString
    @licenceString
  end

  def LicenceString=(value)
    @licenceString = value
  end

  def initialize(isActivated = nil, message = nil, licenceString = nil)
    @isActivated = isActivated
    @message = message
    @licenceString = licenceString
  end
end

# {http://tempuri.org/}CustomerDetails
class CustomerDetails
  @@schema_type = "CustomerDetails"
  @@schema_ns = "http://tempuri.org/"
  @@schema_element = [["errorCode", ["SOAP::SOAPInt", XSD::QName.new("http://tempuri.org/", "ErrorCode")]], ["firstname", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "Firstname")]], ["lastname", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "Lastname")]], ["organization", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "Organization")]], ["email", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "Email")]], ["phone", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "Phone")]], ["fax", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "Fax")]], ["academicInstitution", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "AcademicInstitution")]], ["academicInstitutionType", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "AcademicInstitutionType")]], ["academicDepartment", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "AcademicDepartment")]], ["academicStatus", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "AcademicStatus")]], ["billAddress1", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "BillAddress1")]], ["billAddress2", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "BillAddress2")]], ["billCity", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "BillCity")]], ["billState", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "BillState")]], ["billPostCode", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "BillPostCode")]], ["billCountry", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "BillCountry")]], ["academicStudentOrStaffNumber", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "AcademicStudentOrStaffNumber")]]]

  def ErrorCode
    @errorCode
  end

  def ErrorCode=(value)
    @errorCode = value
  end

  def Firstname
    @firstname
  end

  def Firstname=(value)
    @firstname = value
  end

  def Lastname
    @lastname
  end

  def Lastname=(value)
    @lastname = value
  end

  def Organization
    @organization
  end

  def Organization=(value)
    @organization = value
  end

  def Email
    @email
  end

  def Email=(value)
    @email = value
  end

  def Phone
    @phone
  end

  def Phone=(value)
    @phone = value
  end

  def Fax
    @fax
  end

  def Fax=(value)
    @fax = value
  end

  def AcademicInstitution
    @academicInstitution
  end

  def AcademicInstitution=(value)
    @academicInstitution = value
  end

  def AcademicInstitutionType
    @academicInstitutionType
  end

  def AcademicInstitutionType=(value)
    @academicInstitutionType = value
  end

  def AcademicDepartment
    @academicDepartment
  end

  def AcademicDepartment=(value)
    @academicDepartment = value
  end

  def AcademicStatus
    @academicStatus
  end

  def AcademicStatus=(value)
    @academicStatus = value
  end

  def BillAddress1
    @billAddress1
  end

  def BillAddress1=(value)
    @billAddress1 = value
  end

  def BillAddress2
    @billAddress2
  end

  def BillAddress2=(value)
    @billAddress2 = value
  end

  def BillCity
    @billCity
  end

  def BillCity=(value)
    @billCity = value
  end

  def BillState
    @billState
  end

  def BillState=(value)
    @billState = value
  end

  def BillPostCode
    @billPostCode
  end

  def BillPostCode=(value)
    @billPostCode = value
  end

  def BillCountry
    @billCountry
  end

  def BillCountry=(value)
    @billCountry = value
  end

  def AcademicStudentOrStaffNumber
    @academicStudentOrStaffNumber
  end

  def AcademicStudentOrStaffNumber=(value)
    @academicStudentOrStaffNumber = value
  end

  def initialize(errorCode = nil, firstname = nil, lastname = nil, organization = nil, email = nil, phone = nil, fax = nil, academicInstitution = nil, academicInstitutionType = nil, academicDepartment = nil, academicStatus = nil, billAddress1 = nil, billAddress2 = nil, billCity = nil, billState = nil, billPostCode = nil, billCountry = nil, academicStudentOrStaffNumber = nil)
    @errorCode = errorCode
    @firstname = firstname
    @lastname = lastname
    @organization = organization
    @email = email
    @phone = phone
    @fax = fax
    @academicInstitution = academicInstitution
    @academicInstitutionType = academicInstitutionType
    @academicDepartment = academicDepartment
    @academicStatus = academicStatus
    @billAddress1 = billAddress1
    @billAddress2 = billAddress2
    @billCity = billCity
    @billState = billState
    @billPostCode = billPostCode
    @billCountry = billCountry
    @academicStudentOrStaffNumber = academicStudentOrStaffNumber
  end
end

# {http://tempuri.org/}CustomerLogin
class CustomerLogin
  @@schema_type = "CustomerLogin"
  @@schema_ns = "http://tempuri.org/"
  @@schema_element = [["id", ["SOAP::SOAPInt", XSD::QName.new("http://tempuri.org/", "Id")]], ["password", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "Password")]]]

  def Id
    @id
  end

  def Id=(value)
    @id = value
  end

  def Password
    @password
  end

  def Password=(value)
    @password = value
  end

  def initialize(id = nil, password = nil)
    @id = id
    @password = password
  end
end

# {http://tempuri.org/}OrderDetails
class OrderDetails
  @@schema_type = "OrderDetails"
  @@schema_ns = "http://tempuri.org/"
  @@schema_element = [["date", ["SOAP::SOAPDateTime", XSD::QName.new("http://tempuri.org/", "Date")]], ["amountPaid", ["SOAP::SOAPFloat", XSD::QName.new("http://tempuri.org/", "AmountPaid")]], ["orderConfirmationNumber", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "OrderConfirmationNumber")]], ["affiliate", ["Affiliate", XSD::QName.new("http://tempuri.org/", "Affiliate")]], ["items", ["ArrayOfOrderItemDetails", XSD::QName.new("http://tempuri.org/", "Items")]], ["errorCode", ["SOAP::SOAPInt", XSD::QName.new("http://tempuri.org/", "ErrorCode")]]]

  def Date
    @date
  end

  def Date=(value)
    @date = value
  end

  def AmountPaid
    @amountPaid
  end

  def AmountPaid=(value)
    @amountPaid = value
  end

  def OrderConfirmationNumber
    @orderConfirmationNumber
  end

  def OrderConfirmationNumber=(value)
    @orderConfirmationNumber = value
  end

  def Affiliate
    @affiliate
  end

  def Affiliate=(value)
    @affiliate = value
  end

  def Items
    @items
  end

  def Items=(value)
    @items = value
  end

  def ErrorCode
    @errorCode
  end

  def ErrorCode=(value)
    @errorCode = value
  end

  def initialize(date = nil, amountPaid = nil, orderConfirmationNumber = nil, affiliate = nil, items = nil, errorCode = nil)
    @date = date
    @amountPaid = amountPaid
    @orderConfirmationNumber = orderConfirmationNumber
    @affiliate = affiliate
    @items = items
    @errorCode = errorCode
  end
end

# {http://tempuri.org/}Affiliate
class Affiliate
  @@schema_type = "Affiliate"
  @@schema_ns = "http://tempuri.org/"
  @@schema_element = [["id", ["SOAP::SOAPInt", XSD::QName.new("http://tempuri.org/", "Id")]], ["code", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "Code")]]]

  def Id
    @id
  end

  def Id=(value)
    @id = value
  end

  def Code
    @code
  end

  def Code=(value)
    @code = value
  end

  def initialize(id = nil, code = nil)
    @id = id
    @code = code
  end
end

# {http://tempuri.org/}ArrayOfOrderItemDetails
class ArrayOfOrderItemDetails < ::Array
  @@schema_type = "OrderItemDetails"
  @@schema_ns = "http://tempuri.org/"
  @@schema_element = [["OrderItemDetails", ["OrderItemDetails[]", XSD::QName.new("http://tempuri.org/", "OrderItemDetails")]]]
end

# {http://tempuri.org/}OrderItemDetails
class OrderItemDetails
  @@schema_type = "OrderItemDetails"
  @@schema_ns = "http://tempuri.org/"
  @@schema_element = [["productCode", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "ProductCode")]], ["price", ["SOAP::SOAPFloat", XSD::QName.new("http://tempuri.org/", "Price")]], ["packSize", ["SOAP::SOAPInt", XSD::QName.new("http://tempuri.org/", "PackSize")]], ["originalSubscriptionId", ["SOAP::SOAPInt", XSD::QName.new("http://tempuri.org/", "OriginalSubscriptionId")]], ["couponCode", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "CouponCode")]], ["couponDescription", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "CouponDescription")]], ["couponValue", ["SOAP::SOAPFloat", XSD::QName.new("http://tempuri.org/", "CouponValue")]]]

  def ProductCode
    @productCode
  end

  def ProductCode=(value)
    @productCode = value
  end

  def Price
    @price
  end

  def Price=(value)
    @price = value
  end

  def PackSize
    @packSize
  end

  def PackSize=(value)
    @packSize = value
  end

  def OriginalSubscriptionId
    @originalSubscriptionId
  end

  def OriginalSubscriptionId=(value)
    @originalSubscriptionId = value
  end

  def CouponCode
    @couponCode
  end

  def CouponCode=(value)
    @couponCode = value
  end

  def CouponDescription
    @couponDescription
  end

  def CouponDescription=(value)
    @couponDescription = value
  end

  def CouponValue
    @couponValue
  end

  def CouponValue=(value)
    @couponValue = value
  end

  def initialize(productCode = nil, price = nil, packSize = nil, originalSubscriptionId = nil, couponCode = nil, couponDescription = nil, couponValue = nil)
    @productCode = productCode
    @price = price
    @packSize = packSize
    @originalSubscriptionId = originalSubscriptionId
    @couponCode = couponCode
    @couponDescription = couponDescription
    @couponValue = couponValue
  end
end

# {http://tempuri.org/}ArrayOfSubscriptionDetails
class ArrayOfSubscriptionDetails < ::Array
  @@schema_type = "SubscriptionDetails"
  @@schema_ns = "http://tempuri.org/"
  @@schema_element = [["SubscriptionDetails", ["SubscriptionDetails[]", XSD::QName.new("http://tempuri.org/", "SubscriptionDetails")]]]
end

# {http://tempuri.org/}SubscriptionDetails
class SubscriptionDetails
  @@schema_type = "SubscriptionDetails"
  @@schema_ns = "http://tempuri.org/"
  @@schema_element = [["originalProductCode", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "OriginalProductCode")]], ["description", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "Description")]], ["originalSubscriptionID", ["SOAP::SOAPInt", XSD::QName.new("http://tempuri.org/", "OriginalSubscriptionID")]], ["packSize", ["SOAP::SOAPInt", XSD::QName.new("http://tempuri.org/", "PackSize")]], ["previousRenewals", ["SOAP::SOAPInt", XSD::QName.new("http://tempuri.org/", "PreviousRenewals")]], ["nextStart", ["SOAP::SOAPDateTime", XSD::QName.new("http://tempuri.org/", "NextStart")]], ["nextDuration", ["SOAP::SOAPInt", XSD::QName.new("http://tempuri.org/", "NextDuration")]], ["expires", ["SOAP::SOAPDateTime", XSD::QName.new("http://tempuri.org/", "Expires")]], ["renewUntil", ["SOAP::SOAPDateTime", XSD::QName.new("http://tempuri.org/", "RenewUntil")]]]

  def OriginalProductCode
    @originalProductCode
  end

  def OriginalProductCode=(value)
    @originalProductCode = value
  end

  def Description
    @description
  end

  def Description=(value)
    @description = value
  end

  def OriginalSubscriptionID
    @originalSubscriptionID
  end

  def OriginalSubscriptionID=(value)
    @originalSubscriptionID = value
  end

  def PackSize
    @packSize
  end

  def PackSize=(value)
    @packSize = value
  end

  def PreviousRenewals
    @previousRenewals
  end

  def PreviousRenewals=(value)
    @previousRenewals = value
  end

  def NextStart
    @nextStart
  end

  def NextStart=(value)
    @nextStart = value
  end

  def NextDuration
    @nextDuration
  end

  def NextDuration=(value)
    @nextDuration = value
  end

  def Expires
    @expires
  end

  def Expires=(value)
    @expires = value
  end

  def RenewUntil
    @renewUntil
  end

  def RenewUntil=(value)
    @renewUntil = value
  end

  def initialize(originalProductCode = nil, description = nil, originalSubscriptionID = nil, packSize = nil, previousRenewals = nil, nextStart = nil, nextDuration = nil, expires = nil, renewUntil = nil)
    @originalProductCode = originalProductCode
    @description = description
    @originalSubscriptionID = originalSubscriptionID
    @packSize = packSize
    @previousRenewals = previousRenewals
    @nextStart = nextStart
    @nextDuration = nextDuration
    @expires = expires
    @renewUntil = renewUntil
  end
end

# {http://tempuri.org/}MelbUniPerson
class MelbUniPerson
  @@schema_type = "MelbUniPerson"
  @@schema_ns = "http://tempuri.org/"
  @@schema_element = [["isStudent", ["SOAP::SOAPBoolean", XSD::QName.new("http://tempuri.org/", "IsStudent")]], ["name", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "Name")]], ["department", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "Department")]], ["subjectCode", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "SubjectCode")]], ["email", ["SOAP::SOAPString", XSD::QName.new("http://tempuri.org/", "Email")]]]

  def IsStudent
    @isStudent
  end

  def IsStudent=(value)
    @isStudent = value
  end

  def Name
    @name
  end

  def Name=(value)
    @name = value
  end

  def Department
    @department
  end

  def Department=(value)
    @department = value
  end

  def SubjectCode
    @subjectCode
  end

  def SubjectCode=(value)
    @subjectCode = value
  end

  def Email
    @email
  end

  def Email=(value)
    @email = value
  end

  def initialize(isStudent = nil, name = nil, department = nil, subjectCode = nil, email = nil)
    @isStudent = isStudent
    @name = name
    @department = department
    @subjectCode = subjectCode
    @email = email
  end
end

# {http://tempuri.org/}DatabaseToConnectTo
module DatabaseToConnectTo
  BackupLive = "BackupLive"
  Live = "Live"
  Temp = "Temp"
  TestEcommerce = "TestEcommerce"
  TestLocal = "TestLocal"
  TestRemote = "TestRemote"
end
