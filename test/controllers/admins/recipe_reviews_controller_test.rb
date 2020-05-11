require 'test_helper'

class Admins::RecipeReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get admins_recipe_reviews_destroy_url
    assert_response :success
  end

end
