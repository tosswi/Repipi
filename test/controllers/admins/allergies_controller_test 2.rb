require 'test_helper'

class Admins::AllergiesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get admins_allergies_create_url
    assert_response :success
  end

  test "should get index" do
    get admins_allergies_index_url
    assert_response :success
  end

  test "should get create" do
    get admins_allergies_create_url
    assert_response :success
  end

  test "should get edit" do
    get admins_allergies_edit_url
    assert_response :success
  end

  test "should get update" do
    get admins_allergies_update_url
    assert_response :success
  end

end
