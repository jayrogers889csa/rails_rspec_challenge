require 'spec_helper'

feature 'Admin panel' do
  context "on admin homepage" do
    it "can see a list of recent posts" do
      page.driver.browser.basic_authorize("geek", "jock")
      Post.create(title: "Hello World", content: "Lorem Ipsum")
      visit admin_posts_url
      expect(page).to have_content "Hello World"
    end

    it "can edit a post by clicking the edit link next to a post" do
      page.driver.browser.basic_authorize("geek", "jock")
      post = Post.create(title: "Sample", content: "Another sample")
      visit admin_posts_url
      click_link "Edit"
      expect(current_url).to eq(edit_admin_post_url(post))
      fill_in 'post_title', with: "Hello World!"
      click_button "Save"
      expect(post.reload.title).to eq("Hello World!")
    end

    it "can delete a post by clicking the delete link next to a post" do
      page.driver.browser.basic_authorize("geek", "jock")
      post = Post.create(title: "Fun", content: "testing")
      visit admin_posts_url
      click_link "Delete"
      page.should_not have_text("Fun")
    end

    it "can create a new post and view it" do
       page.driver.browser.basic_authorize("geek", "jock")
       visit new_admin_post_url

       expect {
         fill_in 'post_title',   with: "Hello world!"
         fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
         page.check('post_is_published')
         click_button "Save"
       }.to change(Post, :count).by(1)

       expect(page).to have_content "Published: true"
       expect(page).to have_content "Post was successfully saved."
     end
  end

  context "editing post" do
    it "can mark an existing post as unpublished" do
      page.driver.browser.basic_authorize("geek", "jock")
      post = Post.create(title: "Hello", content: "World")
      visit admin_posts_url
      click_link "Edit"
      expect(current_url).to eq(edit_admin_post_url(post))
      page.uncheck('post_is_published')
      click_button "Save"
      expect(page).to have_content "Published: false"
    end
  end

  context "on post show page" do
    it "can visit a post show page by clicking the title" do
      page.driver.browser.basic_authorize("geek", "jock")
      post = Post.create(title: "Test", content: "Testing")
      visit admin_posts_url
      click_link "Test"
      expect(current_url).to eq(post_url(post))
    end

    it "can see an edit link that takes you to the edit post path" do
      page.driver.browser.basic_authorize("geek", "jock")
      post = Post.create(title: "Test", content: "Testing")
      visit admin_posts_url
      expect(page).to have_content "Edit"
    end

    it "can go to the admin homepage by clicking the Admin welcome page link" do
      page.driver.browser.basic_authorize("geek", "jock")
      post = Post.create(title: "Test", content: "Testing")
      visit admin_post_url(post)
      click_link "Admin welcome page"
      expect(current_url).to eq(admin_posts_url)
      expect(page).to have_content("Welcome to the admin panel!")
    end
  end
end


#save_and_open_page
