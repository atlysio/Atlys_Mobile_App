require 'test_helper'

module AtlysMobileApp
  class AndroidsControllerTest < ActionController::TestCase
    setup do
      @android = atlys_mobile_app_androids(:one)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:androids)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create android" do
      assert_difference('Android.count') do
        post :create, android: {  }
      end

      assert_redirected_to android_path(assigns(:android))
    end

    test "should show android" do
      get :show, id: @android
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @android
      assert_response :success
    end

    test "should update android" do
      patch :update, id: @android, android: {  }
      assert_redirected_to android_path(assigns(:android))
    end

    test "should destroy android" do
      assert_difference('Android.count', -1) do
        delete :destroy, id: @android
      end

      assert_redirected_to androids_path
    end
  end
end
