require 'test_helper'

class WeatherControllerTest < ActionController::TestCase
  test "should get current" do
    get :current
    assert_response :success
  end

  test "should get forcast" do
    get :forcast
    assert_response :success
  end

end
