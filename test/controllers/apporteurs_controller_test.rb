require "test_helper"

class ApporteursControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get apporteurs_index_url
    assert_response :success
  end
end
