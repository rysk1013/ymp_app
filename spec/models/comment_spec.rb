require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  
  describe 'コメント機能' do
    context 'コメントできるとき' do
      it 'text,user,postが存在すればコメントできること' do
        expect(@comment).to be_valid
      end
    end

    context 'コメントできないとき' do
      it 'textが空ではコメントできないこと' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")
      end
    end
  end
end
