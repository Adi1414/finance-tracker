require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get my_portfolio" do
    get user_my_portfolio_url
    assert_response :success
  end

end
