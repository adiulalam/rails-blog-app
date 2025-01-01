require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Create and sign in a user
    @user = users(:one)  # Assuming the user fixture is named 'one'
    sign_in @user

    # Set up posts
    @post = posts(:one)
  end

  # Test index action
  test "should get index" do
    get posts_url
    assert_response :success
  end

  # Test new post form
  test "should get new" do
    get new_post_url
    assert_response :success
  end

  # Test post creation
  test "should create post" do
    assert_difference("Post.count") do
      post posts_url, params: { post: { title: "New Post", body: "This is a new post." } }
    end
    assert_redirected_to post_url(Post.last)
  end

  # Test show action
  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  # Test edit post form
  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  # Test post update
  test "should update post" do
    patch post_url(@post), params: { post: { title: "Updated Post", body: "This is an updated post." } }
    assert_redirected_to post_url(@post)
  end

  # Test post deletion
  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post)
    end
    assert_redirected_to posts_url
  end

  # Test that user can only edit or destroy their own post
  test "should not allow unauthorized user to edit post" do
    other_user = users(:two)  # Assuming another user fixture named 'two'
    sign_in other_user

    patch post_url(@post), params: { post: { title: "Unauthorized Edit", body: "Trying to edit another user's post" } }
    assert_redirected_to posts_url
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end

  # Test my_posts action with drafts only
  test "should filter posts by drafts_only param" do
    get my_posts_posts_url(drafts_only: "true")
    assert_response :success
    assert_includes assigns(:posts), posts(:one)  # Assuming the first post is a draft
    assert_not_includes assigns(:posts), posts(:two)  # Assuming the second post is not a draft
  end
end
