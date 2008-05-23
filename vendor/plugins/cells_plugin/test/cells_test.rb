require File.dirname(__FILE__) + '/../../../../test/test_helper'

#require "cell_registry"

class MyTPLHandler
  def initialize(view)
    @view = view
  end

  def render(template, local_assigns={})
    template
  end
end

ActionView::Base.register_template_handler("mytpl", MyTPLHandler)

class CellTestController < ApplicationController
  def rescue_action(e) raise e end

  def render_cell_state
    cell  = params[:cell]
    state = params[:state]

    render :text => render_cell_to_string(cell, state)
  end

  def call_render_cell_with_strings
    static = render_cell_to_string("test", "direct_output")
    render :text => static
  end

  def call_render_cell_with_syms
    static = render_cell_to_string(:test, :direct_output)
    render :text => static
  end

  def call_render_cell_with_state_view
    render :text => render_cell_to_string(:test, :rendering_state)
    return
  end

  def render_view_with_render_cell_invocation
    render :template => "../../vendor/plugins/cells/test/views/view_with_render_cell_invocation"
    return
  end


  def render_just_one_view_cell
    static = render_cell_to_string("just_one_view", "some_state")
    render :text => static
  end

  def render_reset_bug
    static = render_cell_to_string("test", "setting_state")
    static += render_cell_to_string("test", "reset_state")
    render :text => static
  end


  def cells_render_invocation
    render :template => "../../vendor/plugins/cells/test/views/view_with_cells_render_invocation"
    return
  end

  def render_state_with_link_to
    static = render_cell_to_string("test", "state_with_link_to")
    render :text => static
  end

end


class TestCell < Cell::Base

  def view_for_state(state)
    RAILS_ROOT+"/vendor/plugins/cells/test/views/#{state}.rhtml"
  end

  def direct_output
    "<h9>this state method doesn't render a template but returns a string, which is great!</h9>"
  end

  def rendering_state
    @instance_variable_one = "yeah"

    return
  end

  def another_rendering_state
    @instance_variable_one = "go"

    return
  end

  def setting_state
    @reset_me = '<p id="ho">ho</p>'
    return
  end
  def reset_state
    return
  end


  def state_with_link_to
    return
  end


  def state_with_not_included_helper_method
  end

  def broken_partial
  end

  def view_with_cells_render_invocation
  end

end

module Some
  class Cell < Cell::Base
  end
end

class JustOneViewCell < Cell::Base
  def some_state
    return
  end

  def view_for_state(state)
    CellsTest.path_to_test_views + "just_one_view.rhtml"
  end
end


module CellsTestHelper

  def a_mysterious_helper_method
    "mysterious"
  end

end

class HelperUsingCell < Cell::Base

  #helper :cells_test
  helper CellsTestHelper

  def state_with_helper_invocation
  end

  def state_with_automatic_helper_invocation
  end

  def state_with_helper_method_invocation
  end

  def view_for_state(state)
    CellsTest.path_to_test_views + "#{state}.rhtml"
  end
protected
  def my_helper_method
    "helped by a method"
  end
  helper_method :my_helper_method
end

class HelperUsingSubCell < HelperUsingCell
  def another_state_with_helper_invocation
  end

  def view_for_state(state)
    CellsTest.path_to_test_views + "state_with_helper_invocation.rhtml"
  end
end


class CellsTest < Test::Unit::TestCase

  def self.path_to_test_views
    RAILS_ROOT + "/vendor/plugins/cells/test/views/"
  end


  def assert_selekt(content, *args)
    assert_select(HTML::Document.new(content).root, *args)
  end


  def setup
    @controller = CellTestController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new


    # Because the load paths are added after this plugin is instantiated,
    # it will not be able to load things from itself.  To prevent tests
    # from failing on this, we'll override this manually for now.
    # This adds knowledge about Engines to the test, so if Engines changes,
    # this may break too.
    Rails.plugins[:cells].code_paths |= Rails.plugins[:cells].default_code_paths
    Rails.plugins[:cells].inject_into_load_path

  end


  def test_factory
    cell = Cell::Factory.create(@controller, :test)

    assert cell.kind_of?(Cell::Base)

    #assert_equal cell.path, @my_path

    #assert_equal Cell::Factory.create(@controller, :some_more).path, @my_path

    ### FIXME: this gives an error due to some unprepared controller:
    #assert_equal cell.render_state("rendering_state").class, String
    assert_equal cell.render_state("direct_output").class, String
  end


  def test_controller_render_methods
    get :call_render_cell_with_strings  # render_cell("test", "state")
    assert_response :success
    assert_tag :tag => "h9"


    get :call_render_cell_with_syms
    assert_response :success
    assert_tag :tag => "h9"


    get :call_render_cell_with_state_view
    #assert_response :success
    #assert_tag :tag => "h9", :child => /^begin of view/

#    assert_tag :tag => "span", :child => /^yeah$/
    assert_select "div#RenderingView>span", /^yeah$/

    #get :render_view_with_render_cell_invocation
    #assert_response :success
    #assert_tag :tag => "h9"                       # render_cell(:test, :direct_output)
    #assert_tag :tag => "span", :child => /^yeah$/ # render_cell(:test, :rendering_state)

  end


  def DONT_test_assert_template
    get :call_render_cell_with_state_view
    assert_template "rendering_state.rhtml"
  end

  def test_init
    cell = TestCell.new(@controller, @my_path)

    assert cell.kind_of?(Cell::Base)
  end


  def test_render
    ###@ cell = Cell::Registry[:test].new(@controller, @path)
    cell = TestCell.new(@controller, @path)

    assert_equal cell.render_state("direct_output").class, String
    #assert_equal cell.render_state("rendering_state").class, String
    assert_raises (NoMethodError) { cell.render_state("non_existing_state") }

  end

  def test_view_for_state_overwriting
    #cell = Cell::Registry[:just_one_view].new(@controller, @path)
    #cell = Cell::Factory.create(@controller, :just_one_view)

    get :render_just_one_view_cell
    assert_response :success
    assert_tag :tag => "p", :content => "Great!"
  end


  def test_reset_bug
    get :render_reset_bug

    assert_response :success
    assert_select "p#ho", 1
  end


  def test_bug_no_1
    get :render_view_with_render_cell_invocation

    ### FIXME: if this line is uncommented, we have bug #1 again:
    assert_select "span", /^yeah$/, :count => 1
    assert_select "div#AnotherRenderingView>span", "go", :count => 1

  end

  def test_cells_render_partial
    #get :cells_render_invocation
    #assert_response :success

    content = TestCell.new(@controller).render_state(:view_with_cells_render_invocation)


    # test cells_render :partial ------------------------------------------------

    assert_selekt content, "ul#TestList>li", 3
    assert_selekt content, "ul#TestList>li", "one"
    assert_selekt content, "ul#TestList>li", "two"
    assert_selekt content, "ul#TestList>li", "three"

    # test cells_render :template -----------------------------------------------
    #assert_select "div#ACellTemplate"

    #assert_select "div#ACellTemplateFile"
  end

  def test_cells_render_with_broken_partial
    assert_raises ActionView::TemplateError do
      get :render_cell_state, :cell => 'test', :state => 'broken_partial'
    end

    #assert_response :success
    #assert_select "div#BrokenPartialDiv>p#BrokenPartialP"
  end


  # cell_one explicitly returns a view file in #view_for_state
  # for the state :instance_view. so we test if view finding in instance
  # context still works:
  #
  def test_state_view_set_statically_in_VIEW_FOR_FILE_in_instance
    cell_one = CellsTestOneCell.new(@controller, nil)
    view_one = cell_one.render_state(:instance_view)

    assert_selekt view_one, "p#instanceView", "InstanceViewInCellsTestOneCell"
  end


  def test_state_view_existing_in_my_view_directory
    cell_one = CellsTestOneCell.new(@controller, nil)
    view_one = cell_one.render_state(:super_state)

    assert_selekt view_one, "p#superStateView", "CellsTestOneCell"
  end


  def test_state_view_existing_in_super_cell_view_directory
    cell_two = CellsTestTwoCell.new(@controller, nil)
    view_two = cell_two.render_state(:super_state)

    assert_selekt view_two, "p#superStateView", "CellsTestTwoCell"
  end


  def test_state_view_not_existing
    cell_one = CellsTestOneCell.new(@controller, nil)
    view_one = cell_one.render_state(:state_with_no_view)

    assert_match /ATTENTION/, view_one
  end

  def test_templating_systems
    simple_cell = SimpleCell.new(@controller, nil)
    simple_view = simple_cell.render_state(:two_templates_state)

    assert_match /Written using my own spiffy templating system/, simple_view
  end

  #require RAILS_ROOT + "/vendor/plugins/cells/app/cells/cells_test_one_cell.rb"

  ### API test (unit) -----------------------------------------------------------
  def test_cell_name
    cell_one = CellsTestOneCell.new(@controller, nil)

    assert_equal cell_one.cell_name, "cells_test_one"
    assert_equal CellsTestOneCell.cell_name, "cells_test_one"
  end


  def test_cell_name_set_in_constructor
    cell_one = CellsTestOneCell.new(@controller, "sophisticated_extra_name")

    assert_equal cell_one.cell_name, "sophisticated_extra_name"
    assert_equal CellsTestOneCell.cell_name, "cells_test_one"
  end


  def test_cell_name_suffix
    assert_equal Cell::Base.name_suffix, "_cell"
  end


  def test_class_from_cell_name
    assert_equal Cell::Base.class_from_cell_name("cells_test_one"), CellsTestOneCell
  end


  def test_class_autoloading
    Dependencies.log_activity = true

    assert UnknownCell.new(@controller, nil)


    assert_kind_of Module, ReallyModule
    assert_kind_of Class, ReallyModule::NestedCell
    #Really::NestedCell.new(@controller, nil)
  end

  def test_new_directory_hierarchy
    cell = ReallyModule::NestedCell.new(@controller)
    view = cell.render_state(:happy_state)
    @response.body = view

    assert_select "#happyStateView"
  end


  def test_helper
    cell = HelperUsingCell.new(@controller)

    content = cell.render_state(:state_with_helper_invocation)
    assert_selekt content, "p#stateWithHelperInvocation", "mysterious"
  end

  def test_auto_helper
    cell = HelperUsingCell.new(@controller)

    content = cell.render_state(:state_with_automatic_helper_invocation)
    assert_selekt content, "p#stateWithAutomaticHelperInvocation", "automatic"
  end

  def test_helper_method
    cell = HelperUsingCell.new(@controller)

    content = cell.render_state(:state_with_helper_method_invocation)
    assert_selekt content, "p#stateWithHelperMethodInvocation", "helped by a method"
  end

  def test_helper_with_subclassing
    subclassedcell = HelperUsingSubCell.new(@controller)
    content = subclassedcell.render_state(:state_with_helper_invocation)
    assert_selekt content, "p#stateWithHelperInvocation", "mysterious"

    content = subclassedcell.render_state(:another_state_with_helper_invocation)
    assert_selekt content, "p#stateWithHelperInvocation", "mysterious"
  end

  def test_helper_including_and_cleanup
    # this cell includes a helper, and uses it:
    cell = HelperUsingCell.new(@controller)

    content = cell.render_state(:state_with_helper_invocation)
    assert_selekt content, "p#stateWithHelperInvocation", "mysterious"

    # this cell doesn't include the helper, but uses it anyway, which should
    # produce an error:

    cell = TestCell.new(@controller)

#    assert_raises (NameError) do
     assert_raises (ActionView::TemplateError) do
      cell.render_state(:state_with_not_included_helper_method)
    end
  end

  ### functional tests: ---------------------------------------------------------


  def test_link_to_in_view
    get :render_state_with_link_to

    assert_response :success
    assert_select "a", "bla"
  end


  def ERROR_test_link_to_in_view
    @controller.params = {}
    @controller.send :initialize_current_url

    cell = TestCell.new(@controller, nil)
    content = cell.render_state(:state_with_link_to)
    assert_select HTML::Document.new(content).root, "div#linkTo"
  end


  def test_view_and_partial_in_plugin
    content = CellContainedInPlugin.new(@controller).render_state(:some_view)
    assert_selekt content, "p#someView", 1  # state view.
    assert_selekt content, "p#partialContainedInPlugin", 1
  end

end

class CellContainedInPlugin < Cell::Base
  def some_view
  end
end
