require 'rails_helper'
RSpec.describe 'Post Index Page', type: :feature do
  let(:user) { User.create(name: 'Mehdi Ahmidou', id: 1, post_counter: 1, bio: 'Bio text 1', photo: 'https://source.unsplash.com/featured/300x203') }
  let!(:post) { Post.create(title: 'post 1', text: 'test text', author_id: user.id, comments_counter: 0) }
  let!(:post2) do
    Post.create(title: 'post 2', text: 'test text', author_id: user.id, comments_counter: 0, likes_counter: 0)
  end
  let!(:comment1) { Comment.create(user_id: user.id, post_id: post.id, text: 'commment 1') }
  let!(:like) { Like.create(user_id: user.id, post_id: post.id) }
  it 'Displays the username of the user' do
    visit user_posts_path(user)
    expect(page).to have_content(user.name)
  end
  it 'displays the profile picture of user' do
    visit user_posts_path(user)
    expect(page).to have_css("img[src*='#{user.photo}']")
  end
  it 'displays the number of posts the user has written' do
    visit user_posts_path(user)
    expect(page).to have_content(user.post_counter)
  end
  it 'displays a posts title' do
    visit user_posts_path(user)
    expect(page).to have_content(post.title)
  end
  it 'displays some of the posts body' do
    visit user_posts_path(user)
    expect(page).to have_content(post.text)
  end
  it 'displays the first comments on a post' do
    visit user_posts_path(user)
    expect(page).to have_content('post 1')
  end
  it 'displays how many comments a post has' do
    visit user_posts_path(user)
    expect(page).to have_content("Comments: #{post.comments_counter}")
  end
  it 'displays how many likes a post has' do
    visit user_posts_path(user)
    expect(page).to have_content("Likes: #{post.likes_counter}")
  end
  it 'redirects to a posts show page when clicking on a post' do
    visit user_posts_path(user)
    click_link 'post 1'
    expect(current_path).to eq(user_post_path(user, post))
  end
  it 'displays a button for pagination' do
    visit user_posts_path(user)
    expect(page).to have_button('Pagination')
  end
end