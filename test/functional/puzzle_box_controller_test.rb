require 'test_helper'

class PuzzleBoxControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

end
