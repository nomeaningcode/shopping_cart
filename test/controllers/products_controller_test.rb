require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { description: @product.description, title: @product.title } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test 'allows to create a new product' do
    post products_path, params: {
      product: {
        title: @product.title,
        description: @product.description,
        price: @product.price
      }
    }

    assert_redirected_to products_path
  end

  test 'does not allow to create a new product with empty fields' do
    post products_path, params: {
      product: {
        title: '',
        description: 'test',
        price: 2
      }
    }

    assert_response :unprocessable_entity
  end

  test 'testing flash message' do
     post products_path, params: {
      product: {
        title: @product.title,
        description: @product.description,
        price: @product.price
      }
    }
    
    assert_equal flash[:notice], 'Product was successfully created.'
  end

end
