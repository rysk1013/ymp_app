require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post)
    @like = FactoryBot.build(:like)
    @like.user_id = user.id
    @like.post_id = post.id
  end

  describe 'いいね機能' do
    context 'いいねできるとき' do
      it 'user,postが存在すればいいねできること' do
        expect(@like).to be_valid
      end
    end

    context 'いいねできないとき' do
      it 'user_idが存在しなければいいねできないこと' do
        @like.user_id = ''
        @like.valid?
        expect(@like.errors.full_messages).to include("User can't be blank")
      end

      it 'post_idが存在しなければいいねできないこと' do
        @like.post_id = ''
        @like.valid?
        expect(@like.errors.full_messages).to include("Post can't be blank")
      end
    end
  end
end
