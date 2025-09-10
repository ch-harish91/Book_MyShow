require "test_helper"

class SeatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get seats_index_url
    assert_response :success
  end

  test "should get update" do
    get seats_update_url
    assert_response :success
  end
end
