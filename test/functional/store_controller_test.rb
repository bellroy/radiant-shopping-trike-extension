require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/../../app/controllers/store_controller'

# Re-raise errors caught by the controller.
StoreController.class_eval { def rescue_action(e) raise e end }

class StoreControllerTest < Test::Unit::TestCase
  def setup
    @controller = StoreController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # scaffold only (so far)
  def test_truth
    assert true
  end
end
