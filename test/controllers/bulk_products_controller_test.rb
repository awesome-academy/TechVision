require 'test_helper'

class BulkProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get bulk_products_destroy_url
    assert_response :success
  end

end
