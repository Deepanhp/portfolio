require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "should get about" do
    get home_about_url
    assert_response :success
  end

  test "should get projects" do
    get home_projects_url
    assert_response :success
  end

  test "should get contact" do
    get home_contact_url
    assert_response :success
  end
end
