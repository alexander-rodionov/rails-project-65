# frozen_string_literal: true

require "test_helper"

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @published_bulletin = bulletins(:published)
    @draft_bulletin = bulletins(:draft)
    # FIXME
    @uploaded_file = Rack::Test::UploadedFile.new("test/fixtures/files/test.png", "image/png")
  end

  test "should get index" do
    get bulletins_path
    assert_response :success
  end

  test "should get show" do
    get bulletin_path(@published_bulletin)
    assert_response :success
  end

  test "should get new" do
    sign_in @user

    get new_bulletin_path
    assert_response :success
  end

  test "should get edit" do
    sign_in @user

    get edit_bulletin_path(@draft_bulletin)
    assert_response :success
  end

  test "should update" do
    sign_in @user

    new_title = "New Title"

    params = {
      bulletin: {
        title: new_title,
        image: @uploaded_file
      }
    }

    # log_params(params.to_json)
    patch bulletin_url(@draft_bulletin), params: params

    assert_response :redirect

    @draft_bulletin.reload

    assert_equal new_title, @draft_bulletin.title
  end

  test "should create" do
    sign_in @user

    # FIXME: we do not use assert_difference
    assert_difference "Bulletin.count", 1 do
      params = {
        bulletin: {
          title: "Test",
          description: "description",
          category_id: @published_bulletin.category.id,
          image: @uploaded_file
        }
      }

      log_params(params.to_json)

      post bulletins_url, params: params
    end

    assert_response :redirect
  end

  test "should archive" do
    sign_in @user

    patch archive_bulletin_url(@published_bulletin)
    assert_response :redirect

    @published_bulletin.reload

    assert @published_bulletin.archived?
  end
end
