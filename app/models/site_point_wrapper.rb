class SitePointWrapper
  require "sitepoint/sitepointDriver.rb"
  
  attr_reader :customer
  
  def initialize
    @driver = CrmHubSoap.new
    
    # uncomment the following line to have all SOAP request and responses logged
    @driver.wiredump_dev = STDERR
  end
  
  def customer_id_for_email( email )
    customer_by_email_request = FindCustomerByEmail.new( Dealer, email )
    customer_by_email_response = @driver.findCustomerByEmail( customer_by_email_request )
    customer_id = customer_by_email_response.FindCustomerByEmailResult.id
    
    if customer_id > 0
      return customer_id
    else
      return nil
    end
  end
  
  def customer_details( id, password )   
      get_customer_details_request = GetCustomerDetails.new( Dealer, id, password )
      get_customer_details_response = driver.getCustomerDetails( get_customer_request )
    
      # load customer details
      result = get_customer_details_response.GetCustomerDetailsResult
      if ( result.ErrorCode == 1 )
        customer_details_to_hash( result )
      else
        nil
      end
  end
 
  private
    def customer_details_to_hash( customer_details )
      {
        :first_name => customer_details.firstname,
        :last_name => customer_details.lastname
      }
    end
end