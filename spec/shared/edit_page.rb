shared_examples_for 'edit_page' do
  # USAGE:
  # def instance
  #   Object.new
  # end
  # def self.fields
  #   {:name => 'john'}
  # end
  def action
    'edit'
  end
  
  it_should_behave_like 'protected_from_forgery'
  
  it 'should successfully render' do
    render_page

    response.should be_success
  end  
  
  it 'should only have one form' do
    # otherwise these tests would be invalid (you could give the form an ID to revalidate them)
    render_page 
    
    response.should have_tag('form', :count => 1)
  end
  
  it 'should ask for new record (for form builder)' do
    @object.should_receive(:new_record?).at_least(:once).and_return(false)
    
    render_page
  end
  
  describe 'form' do
    describe 'input fields' do
      fields.each do |field, value|
        it 'should include #{field}' do
          @object.send "#{field}=", value
          render_page
        
          response.should have_tag("form") do
            with_tag("input[type='text'][name='#{class_symbol}[#{field}]'][value=?]", value)
          end
        end
      end
    end
    
    describe 'for existing' do
      before(:each) do
        @object.stub!(:new_record?).and_return false
      end
      it 'should submit to itself' do
        # Posting to '' is kinda silly but is the RADIANT way. Should be using RESTful routing
        render_page
        response.should have_tag("form[action='']")
      end
      it 'should use post method' do
        render_page
        response.should have_tag("form[method=post]")
      end
      it 'should not "put"' do
        render_page

        response.should have_tag("form") do
          without_tag "input[name='_method'][type='hidden'][value='put']"
        end
      end
    end
    
    describe 'on new' do
      before(:each) do
        @object.stub!(:new_record?).and_return true
      end
      it 'should submit to itself' do
        # Posting to '' is kinda silly. Should be using RESTful routing
        render_page
        response.should have_tag("form[action='']")
      end
      it 'should use post method' do
        render_page
        response.should have_tag("form[method=post]")
      end
    end
  end
end