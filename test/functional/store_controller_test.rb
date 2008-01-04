require File.dirname(__FILE__) + '/../test_helper'

# Re-raise errors caught by the controller.
StoreController.class_eval { def rescue_action(e) raise e end }

class StoreControllerTest < Test::Unit::TestCase
  def setup
    @controller = StoreController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_truth
    assert true
  end
end
