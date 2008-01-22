class SitePointController < ApplicationController

  def login
    sitepoint = SitePointWrapper.new
    customer_id = sitepoint.customer_id_for_email( params[:email] )
    
    if customer_id
      session[:customer] = sitepoint.customer_details( customer_id, params[:password] )
    else
      session[:customer] = nil
    end
    
    redirect_to :back
  end

  def self.customer_login_form
    %Q( <form action="/shopping_trike/sitepoint/login" method="post">
          Email address: <input name="email" size="50" type="text" /><br />
          Password: <input type="password" size="50" name="password" /><br />
          <input name="commit" type="submit" value="login" />
        </form> )
  end
end
