require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/topic_controller'

# Re-raise errors caught by the controller.
class Admin::TopicController; def rescue_action(e) raise e end; end

class Admin::TopicControllerTest < Test::Unit::TestCase
  fixtures :topics

  def setup
    @controller = Admin::TopicController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = topics(:first).id
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

    assert_not_nil assigns(:topics)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:topic)
    assert assigns(:topic).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:topic)
  end

  def test_create
    num_topics = Topic.count

    post :create, :topic => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_topics + 1, Topic.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:topic)
    assert assigns(:topic).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Topic.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Topic.find(@first_id)
    }
  end
end
