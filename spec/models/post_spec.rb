require 'spec_helper'

describe Post do
    let(:post) { Post.new(title: "new post", content: "Lorem Ipsum!") }
  it "title should be automatically titleized before save" do
    post.save
    expect(post.title).to eq("New Post")
  end

  it "post should be unpublished by default" do
    expect(post.is_published).to be_false
  end

  # a slug is an automaticaly generated url-friendly
  # version of the title
  it "slug should be automatically generated" do
    post = Post.new(title: "New post!", content: "A great story")

    expect(post.slug).to be_nil
    post.save

    expect(post.slug).to eq "new-post"
  end
end
