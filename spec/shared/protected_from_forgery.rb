shared_examples_for 'protected_from_forgery' do
  # USAGE:
  # def instance
  #   Object.new
  # end
  # def action
  #   'edit'
  # end
  def render_page
    render "/admin/#{class_symbol}/#{action}"
  end
  
  def class_symbol
    instance.class.name.underscore.to_sym
  end

  before(:each) do
    @object = instance
    assigns[class_symbol] = @object
  end
  
  describe 'authenticity token' do
    it 'should be used' do
      template.should_receive(:form_authenticity_token)

      render_page
    end 
    
    it 'should be included in a hidden input' do
      template.stub!(:form_authenticity_token).and_return('MY SUPER SECRET TOKEN')
      render_page 

      response.should have_tag("form") do
        with_tag("input[type='hidden'][name='authenticity_token'][value=?]", 'MY SUPER SECRET TOKEN')
      end
    end
  end
end