class Admin::ProductController < Admin::AbstractModelController
  model_class Product  

  def index
    # Single supported conversion for the moment
    usd_to_aud = Radiant::Config['currency.usd-aud']
    @ccy_conversions = [{:source_ccy => 'USD', :target_ccy => 'AUD', :rate => usd_to_aud}]
    super
  end
  
  def update_ccy
    rate_key = "currency.#{params[:ccy]}"
    new_rate = params[:value].to_f
    result = ""
    
    # Only update keys that already exist
    if not Radiant::Config[rate_key].nil? and new_rate > 0.1
      Radiant::Config[rate_key] = new_rate
      result = new_rate
    else
      result = "'#{params[:value]}' is not valid"
    end
    render :text => result
  end
end
