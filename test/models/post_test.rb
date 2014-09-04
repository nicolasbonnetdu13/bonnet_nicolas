require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  fixtures :posts
  # test "the truth" do
  #   assert true
  # end
  
  test "product attributes must not be empty" do
    post = Post.new
    assert post.invalid?
    assert post.errors[:title].any?
    assert post.errors[:description].any?
    assert post.errors[:post_type].any?
  end
  
  def new_post_with_image_url(image_url)
    Post.new(
    title: "a title",
    description: "a description Lorem Ipsum",
    post_type: "standard",
    image_url: image_url
    )
  end
  
  def new_post_with_post_type(post_type)
    Post.new(
    title: "a title",
    description: "a description",
    post_type: post_type,
    image_url: ""
    )
  end
  
  test "image url" do
    
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG toto.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    
    ok.each do |name|
      assert new_post_with_image_url(name).valid?, "#{name} should be an image valid"
    end
    
    bad.each do |name|
      assert new_post_with_image_url(name).invalid?, "#{name} should be an image invalid"
    end
    
  end
  
  test "post type" do
    
    ok = %w{ standard video link }
    bad = %w{ Standard toto videos tete VIdeo }
    
    ok.each do |name|
      assert new_post_with_post_type(name).valid?, "#{name} should be a post type valid"
    end
    
    bad.each do |name|
      assert new_post_with_post_type(name).invalid?, "#{name} should be a post type invalid"
    end
    
  end

end
