require 'rails_helper'
RSpec.feature 'Post Index Page' do
  let!(:user1) { User.create(name: 'Assem', bio: 'The best web developer', photo: 'https://avatars.githubusercontent.com/u/127784077?s=400&u=18861529a022fa246f6fc1a684f9831b59131d23&v=4', posts_counter: 0, email: 'assem@example.com', password: 'password') }
  let!(:post1) { Post.create(author_id: user1.id, title: 'My first Post', text: 'I am doing integration specs', comments_counter: 0, likes_counter: 0) }
  let!(:post2) { Post.create(author_id: user1.id, title: 'My second Post', text: 'I am failing integration specs', comments_counter: 0, likes_counter: 0) }
  let!(:post3) { Post.create(author_id: user1.id, title: 'My third Post', text: 'I am finishing integration specs', comments_counter: 0, likes_counter: 0) }
  let!(:post4) { Post.create(author_id: user1.id, title: 'My forth Post', text: 'I finished integration specs', comments_counter: 0, likes_counter: 0) }
  let!(:comment1) { Comment.create(user: user1, post: post3, text: 'Perfect!') }
  let!(:comment2) { Comment.create(user: user1, post: post1, text: 'Good luck!') }
  let!(:comment3) { Comment.create(user: user1, post: post2, text: 'Never give up!') }
  let!(:comment4) { Comment.create(user: user1, post: post4, text: 'Good job!') }
  scenario 'Displays profile picture' do
    visit user_posts_path(user1)
    expect(page).to have_css(".user-photo[src*='#{user1.photo}']")
  end
  scenario 'Displays username' do
    visit user_posts_path(user1)
    expect(page).to have_content(user1.name)
  end
  scenario 'Displays posts count' do
    visit user_posts_path(user1)
    expect(page).to have_content("Number of posts: #{user1.posts.count}")
  end
  scenario 'Displays post title' do
    visit user_posts_path(user1)
    expect(page).to have_content(post1.title)
  end
  scenario 'Displays some part of post body' do
    visit user_posts_path(user1)
    expect(page).to have_content(post1.text)
  end
  scenario 'Displays post title' do
    visit user_posts_path(user1)
    expect(page).to have_content(post1.title)
  end
  scenario 'Displays the 1st comment' do
    visit user_posts_path(user1)
    expect(page).to have_content(comment1.text)
  end
  scenario 'Displays comments count' do
    visit user_posts_path(user1)
    expect(page).to have_content("Comments: #{post1.comments.count}")
  end
  scenario 'Displays likes count' do
    visit user_posts_path(user1)
    expect(page).to have_content("Likes: #{post1.likes.count}")
  end
  scenario 'Displays the pagination if more than 3 posts' do
    visit user_posts_path(user1)
    expect(page).to have_content('Next')
  end
  scenario 'Redirects to post show page when clicked' do
    visit user_posts_path(user1)
    click_link post1.title
    sleep(5)
    expect(current_path).to eq(user_post_path(user1, post1))
  end
end
