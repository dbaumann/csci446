require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Game.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Game.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to games_url
  end

  def test_edit
    get :edit, :id => Game.first
    assert_template 'edit'
  end

  def test_update_invalid
    Game.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Game.first
    assert_template 'edit'
  end

  def test_update_valid
    Game.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Game.first
    assert_redirected_to games_url
  end
end
