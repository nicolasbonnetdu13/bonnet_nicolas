require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  
  fixtures :posts
  
  setup do
    @post = posts(:one)
    @update = {
      title: 'LoremIpsum',
      description: 'Lorem Ipsum Lorem Ipsum',
      post_type: 'standard'
    }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, post: { title: @post.title, description: @post.descriptionl, post_type: @post.post_type }
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    get :show, id: @post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post
    assert_response :success
  end

  test "should update post" do
    patch :update, id: @post, post: { title: @post.title, description: @post.description, post_type: @post.post_type }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
  end
end
