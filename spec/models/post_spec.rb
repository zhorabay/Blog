require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, author: user) }

  describe 'validations' do
    subject { Post.new(title: 'Thanksgiving', comments_counter: 0, likes_counter: 0) }

    before { subject.save }

    it 'includes title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'should be less than 250 characters' do
      subject.title = 'a' * 251
      expect(subject).to_not be_valid
    end

    it 'should allow valid values for comments_counter' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'should allow valid values for likes_counter' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end
  end

  describe '#update_posts_counter' do
    it 'updates the posts_counter after saving a post' do
      post = create(:post, author: user)
      expect(user.reload.posts_counter).to eq(1)
    end
  end

  describe '#return_recent_comments' do
    it 'returns the most recent comments' do
      post = create(:post, author: user)
      older_comment = create(:comment, post: post, created_at: 2.days.ago)
      recent_comment1 = create(:comment, post: post, created_at: 1.day.ago)
      recent_comment2 = create(:comment, post: post, created_at: 1.hour.ago)

      recent_comments = post.return_recent_comments

      expect(recent_comments.sort_by(&:created_at)).to eq([older_comment, recent_comment1, recent_comment2])
    end

    it 'returns up to 5 recent comments' do
      post = create(:post, author: user)
      create_list(:comment, 7, post: post)

      recent_comments = post.return_recent_comments

      expect(recent_comments.count).to eq(5)
    end
  end
end
