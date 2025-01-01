# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#  is_draft   :boolean          default(TRUE), not null
#
require "test_helper"

class PostTest < ActiveSupport::TestCase
  # Test that the post is valid with a title, body, and user
  test "should be valid with valid attributes" do
    post = posts(:draft_post)
    assert post.valid?
  end

  # Test that a post must have a title
  test "should not be valid without a title" do
    post = posts(:draft_post)
    post.title = nil
    assert_not post.valid?
  end

  # Test that a post must have a body
  test "should not be valid without a body" do
    post = posts(:draft_post)
    post.body = nil
    assert_not post.valid?
  end

  # Test that a post must belong to a user
  test "should not be valid without a user" do
    post = posts(:draft_post)
    post.user = nil
    assert_not post.valid?
  end

  # Test the draft scope
  test "should return only draft posts" do
    draft_post = posts(:draft_post)
    published_post = posts(:published_post)

    assert_includes Post.draft, draft_post
    assert_not_includes Post.draft, published_post
  end

  # Test the completed (published) scope
  test "should return only completed posts" do
    draft_post = posts(:draft_post)
    published_post = posts(:published_post)

    assert_includes Post.completed, published_post
    assert_not_includes Post.completed, draft_post
  end
end
