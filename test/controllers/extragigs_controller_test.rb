require 'test_helper'

class ExtragigsControllerTest < ActionController::TestCase
  setup do
    @extragig = extragigs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:extragigs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create extragig" do
    assert_difference('Extragig.count') do
      post :create, extragig: { amount_per_extragig: @extragig.amount_per_extragig, express_boolean: @extragig.express_boolean, title: @extragig.title }
    end

    assert_redirected_to extragig_path(assigns(:extragig))
  end

  test "should show extragig" do
    get :show, id: @extragig
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @extragig
    assert_response :success
  end

  test "should update extragig" do
    patch :update, id: @extragig, extragig: { amount_per_extragig: @extragig.amount_per_extragig, express_boolean: @extragig.express_boolean, title: @extragig.title }
    assert_redirected_to extragig_path(assigns(:extragig))
  end

  test "should destroy extragig" do
    assert_difference('Extragig.count', -1) do
      delete :destroy, id: @extragig
    end

    assert_redirected_to extragigs_path
  end
end
