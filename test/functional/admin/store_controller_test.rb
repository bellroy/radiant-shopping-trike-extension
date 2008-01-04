require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/store_controller'

# Re-raise errors caught by the controller.
Admin::StoreController.class_eval { def rescue_action(e) raise e end }

class Admin::StoreControllerTest < Test::Unit::TestCase
  def setup
    @controller = Admin::StoreController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_truth
    assert true
  end
end
