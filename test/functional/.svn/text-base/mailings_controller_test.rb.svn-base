require File.dirname(__FILE__) + '/../test_helper'

class MailingsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:mailings)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_mailing
    assert_difference('Mailing.count') do
      post :create, :mailing => { }
    end

    assert_redirected_to mailing_path(assigns(:mailing))
  end

  def test_should_show_mailing
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_mailing
    put :update, :id => 1, :mailing => { }
    assert_redirected_to mailing_path(assigns(:mailing))
  end

  def test_should_destroy_mailing
    assert_difference('Mailing.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to mailings_path
  end
end
