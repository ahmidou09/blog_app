require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
  before do
    User.create(
      name: 'Mehdi Ahmidou',
      id: 1,
      post_counter: 2,
      photo: 'https://source.unsplash.com/featured/300x203'
    )

    User.create(
      name: 'John deo',
      id: 2,
      post_counter: 5,
      photo: 'https://source.unsplash.com/featured/300x203'
    )
  end

  it 'displays usernames of all other users' do
    visit users_path
    expect(page).to have_content('Mehdi Ahmidou')
    expect(page).to have_content('John deo')
  end

  it 'displays profile picture for each user' do
    visit users_path
    expect(page).to have_css("img[src*='https://source.unsplash.com/featured/300x203']", count: 2)
  end

  it 'redirects to user show page when clicking on a user' do
    visit users_path
    click_link('John deo')
    expect(current_path).to eq(user_path(User.last))
  end
end
