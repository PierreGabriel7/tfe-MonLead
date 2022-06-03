require "test_helper"

class LiaisonControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get liaison_index_url
    assert_response :success
  end

  test "should get new" do
    get liaison_new_url
    assert_response :success
  end
end
