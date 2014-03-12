require 'spec_helper'

feature 'User browsing the website' do
  context "on homepage" do
    it "sees a list of recent posts titles" do
      post = Post.create(title: "Text", content: "Testing")
      visit posts_url
      expect(page).to have_content "Text"
    end

    it "can click on titles of recent posts and should be on the post show page" do
      post = Post.create(title: "Text", content: "Testing")
      visit posts_url
      click_link "Text"
      expect(current_url).to eq(post_url(post))
    end
  end

  context "post show page" do
    it "sees title and body of the post" do
      post = Post.create(title: "Text", content: "Testing")
      visit posts_url
      click_link "Text"
      expect(current_url).to eq(post_url(post))
      page.should have_text("Text")
      page.should have_text("Testing")
    end
  end
end
