require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/link_controller'

# Re-raise errors caught by the controller.
class Admin::LinkController; def rescue_action(e) raise e end; end

class Admin::LinkControllerTest < Test::Unit::TestCase
  fixtures :links

  def setup
    @controller = Admin::LinkController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = links(:first).id
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

    assert_not_nil assigns(:links)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:link)
    assert assigns(:link).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:link)
  end

  def test_create
    num_links = Link.count

    post :create, :link => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_links + 1, Link.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:link)
    assert assigns(:link).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Link.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Link.find(@first_id)
    }
  end
end
