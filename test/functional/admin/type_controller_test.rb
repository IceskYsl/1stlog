require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/type_controller'

# Re-raise errors caught by the controller.
class Admin::TypeController; def rescue_action(e) raise e end; end

class Admin::TypeControllerTest < Test::Unit::TestCase
  fixtures :types

  def setup
    @controller = Admin::TypeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = types(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:types)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:type)
    assert assigns(:type).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:type)
  end

  def test_create
    num_types = Type.count

    post :create, :type => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_types + 1, Type.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:type)
    assert assigns(:type).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Type.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Type.find(@first_id)
    }
  end
end
