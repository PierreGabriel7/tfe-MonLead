require "test_helper"

class GestionnairesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get gestionnaires_index_url
    assert_response :success
  end

  test "should get new" do
    get gestionnaires_new_url
    assert_response :success
  end

  test "should get create" do
    get gestionnaires_create_url
    assert_response :success
  end

  test "should get edit" do
    get gestionnaires_edit_url
    assert_response :success
  end

  test "should get update" do
    get gestionnaires_update_url
    assert_response :success
  end
end
