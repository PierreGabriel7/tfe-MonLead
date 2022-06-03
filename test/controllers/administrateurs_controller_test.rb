require "test_helper"

class AdministrateursControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get administrateurs_index_url
    assert_response :success
  end
end
