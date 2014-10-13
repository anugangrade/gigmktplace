require 'test_helper'

class GigsControllerTest < ActionController::TestCase
  setup do
    @gig = gigs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gigs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gig" do
    assert_difference('Gig.count') do
      post :create, gig: { amount_per_gig: @gig.amount_per_gig, category_id: @gig.category_id, description: @gig.description, express_boolean: @gig.express_boolean, image_id: @gig.image_id, instructions_for_buyer: @gig.instructions_for_buyer, rating_per_order: @gig.rating_per_order, subcategory_id: @gig.subcategory_id, tags: @gig.tags, title: @gig.title, user_id: @gig.user_id, video_id: @gig.video_id }
    end

    assert_redirected_to gig_path(assigns(:gig))
  end

  test "should show gig" do
    get :show, id: @gig
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gig
    assert_response :success
  end

  test "should update gig" do
    patch :update, id: @gig, gig: { amount_per_gig: @gig.amount_per_gig, category_id: @gig.category_id, description: @gig.description, express_boolean: @gig.express_boolean, image_id: @gig.image_id, instructions_for_buyer: @gig.instructions_for_buyer, rating_per_order: @gig.rating_per_order, subcategory_id: @gig.subcategory_id, tags: @gig.tags, title: @gig.title, user_id: @gig.user_id, video_id: @gig.video_id }
    assert_redirected_to gig_path(assigns(:gig))
  end

  test "should destroy gig" do
    assert_difference('Gig.count', -1) do
      delete :destroy, id: @gig
    end

    assert_redirected_to gigs_path
  end
end
