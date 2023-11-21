require 'rails_helper'
require 'capybara'

RSpec.describe 'User Show Page', type: :feature do
  let(:user1) { User.create(name: 'John deo', id: 2, post_counter: 0, bio: 'Bio text 1', photo: 'https://source.unsplash.com/featured/300x203') }

  let!(:post1) do
    Post.create(title: 'First post', text: 'test text', author_id: user1.id, comments_counter: 0, likes_counter: 0)
  end
  let!(:post2) do
    Post.create(title: 'Second post', text: 'test text', author_id: user1.id, comments_counter: 0, likes_counter: 0)
  end
  let!(:post3) do
    Post.create(title: 'Third post', text: 'test text', author_id: user1.id, comments_counter: 0, likes_counter: 0)
  end
  let!(:post4) do
    Post.create(title: 'Fourth post', text: 'test text', author_id: user1.id, comments_counter: 0, likes_counter: 0)
  end
  let!(:post5) do
    Post.create(title: 'Fifth post', text: 'test text', author_id: user1.id, comments_counter: 0, likes_counter: 0)
  end

  it 'displays the users profile picture' do
    visit user_path(user1)
    expect(page).to have_css("img[src*='#{user1.photo}']")
  end

  it 'displays the user username' do
    visit user_path(user1)
    expect(page).to have_content(user1.name)
  end

  it 'displays the user bio' do
    visit user_path(user1)
    expect(page).to have_content(user1.bio)
  end

  it 'displays the users first 3 posts' do
    visit user_path(user1)
    expect(page).to have_content('Fifth post')
    expect(page).to have_content('Fourth post')
    expect(page).to have_content('Third post')
  end

  it 'displays a button to view all of a users posts' do
    visit user_path(user1)
    expect(page).to have_button('See all posts')
  end

  it 'redirects to a users post show page when clicking on a users post' do
    visit user_path(user1)
    click_link 'Fifth post'
    expect(current_path).to eq(user_post_path(user1, post5))
  end

  it 'redirects to the users post index page when clicking to see all posts' do
    visit user_path(user1)
    click_link 'See all posts'
    expect(current_path).to eq(user_posts_path(user1))
  end

  it 'displays the number of posts the user has written' do
    visit user_path(user1)
    expect(page).to have_content("Number of posts: #{user1.post_counter}")
  end
end
