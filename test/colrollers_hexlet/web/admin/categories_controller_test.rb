# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  def sign_in(user); end

  setup do
    @user = users :admin
    sign_in @user

    @category = categories :transport
  end

  test 'should get index' do
    get admin_categories_url
    assert_response :success
  end

  test 'shoul get new' do
    get new_admin_category_url
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_category_url(@category)
    assert_response :success
  end

  test 'should update' do
    new_category_name = 'New Category Name'

    params = {
      category: {
        name: new_category_name
      }
    }

    log_params(params.to_json)

    patch admin_category_url(@category), params: params
    assert_response :redirect

    @category.reload

    assert_equal new_category_name, @category.name
  end

  test 'should create' do
    assert_difference 'Category.count', 1 do
      params = {
        category: {
          name: 'Name'
        }
      }

      log_params(params.to_json)

      post admin_categories_url, params: params
    end

    assert_response :redirect
  end
end
