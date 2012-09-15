require 'test_helper'

class BbcodesControllerTest < ActionController::TestCase
  setup do
    @bbcode = bbcodes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bbcodes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bbcode" do
    assert_difference('Bbcode.count') do
      post :create, bbcode: @bbcode.attributes
    end

    assert_redirected_to bbcode_path(assigns(:bbcode))
  end

  test "should show bbcode" do
    get :show, id: @bbcode
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bbcode
    assert_response :success
  end

  test "should update bbcode" do
    put :update, id: @bbcode, bbcode: @bbcode.attributes
    assert_redirected_to bbcode_path(assigns(:bbcode))
  end

  test "should destroy bbcode" do
    assert_difference('Bbcode.count', -1) do
      delete :destroy, id: @bbcode
    end

    assert_redirected_to bbcodes_path
  end
end
