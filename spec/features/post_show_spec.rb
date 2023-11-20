require 'rails_helper'
RSpec.describe 'Post show page', type: :feature do
  let(:user) { User.create(name: 'John deo', id: 1, post_counter: 1, bio: 'Bio text 1', photo: 'https://source.unsplash.com/featured/300x203') }
  let!(:post) do
    Post.create(title: 'post 1', text: 'test text', author_id: user.id, comments_counter: 5, likes_counter: 0)
  end
  let!(:post2) do
    Post.create(title: 'Second post', text: 'test text', author_id: user.id, comments_counter: 0, likes_counter: 0)
  end
  let!(:comment1) { Comment.create(user_id: user.id, post_id: post.id, text: 'commment 1') }
  let!(:comment2) { Comment.create(user_id: user.id, post_id: post.id, text: 'commment 2') }
  let!(:comment3) { Comment.create(user_id: user.id, post_id: post.id, text: 'commment 3') }
  let!(:comment4) { Comment.create(user_id: user.id, post_id: post.id, text: 'commment 4') }
  let!(:comment5) { Comment.create(user_id: user.id, post_id: post.id, text: 'commment 5') }
  it 'Display who wrote the post' do
    visit user_post_path(user, post)
    expect(page).to have_content("by #{user.name}")
  end
  it 'Display posts title' do
    visit user_post_path(user, post)
    expect(page).to have_content(post.title)
  end
  it 'Display how many likes it has' do
    visit user_post_path(user, post)
    expect(page).to have_content("Likes: #{post.likes_counter}")
  end
  it 'Display how many comments it has' do
    visit user_post_path(user, post)
    expect(page).to have_content("Comments: #{post.comments_counter}")
  end
  it 'Display the post body' do
    visit user_post_path(user, post)
    expect(page).to have_content(post.text)
  end
end
