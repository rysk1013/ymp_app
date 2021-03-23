require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  describe '新規投稿機能' do
    context '新規投稿できるとき' do
      it 'image,title,overview,programming_languages,techs,portfolio_url,github_urlが存在すれば投稿できること' do
        expect(@post).to be_valid
      end
    end

    context '新規投稿できないとき' do
      it 'titleが空では投稿できないこと' do
        @post.title = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("Title can't be blank")
      end

      it 'overviewが空では投稿できないこと' do
        @post.overview = ''
        @post.valid?
        expect(@post.errors.full_messages). to include("Overview can't be blank")
      end

      it 'programming_languagesが空では投稿できなこと' do
        @post.programming_languages = ''
        @post.valid?
        expect(@post.errors.full_messages). to include("Programming languages can't be blank")
      end

      it 'techsが空では投稿できないこと' do
        @post.techs = ''
        @post.valid?
        expect(@post.errors.full_messages). to include("Techs can't be blank")
      end

      it 'portfolio_urlが空では投稿できないこと' do
        @post.portfolio_url = ''
        @post.valid?
        expect(@post.errors.full_messages). to include("Portfolio url can't be blank")
      end

      it 'github_urlが空では投稿できないこと' do
        @post.github_url = ''
        @post.valid?
        expect(@post.errors.full_messages). to include("Github url can't be blank")
      end
    end
  end
end
