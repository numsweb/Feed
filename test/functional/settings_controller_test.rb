require File.dirname(__FILE__) + '/../test_helper'

class SettingsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:settings)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_setting
    assert_difference('Setting.count') do
      post :create, :setting => { }
    end

    assert_redirected_to setting_path(assigns(:setting))
  end

  def test_should_show_setting
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_setting
    put :update, :id => 1, :setting => { }
    assert_redirected_to setting_path(assigns(:setting))
  end

  def test_should_destroy_setting
    assert_difference('Setting.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to settings_path
  end
end
