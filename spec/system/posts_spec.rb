require 'rails_helper'

RSpec.describe "Posts", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post_title = Faker::Lorem.sentence
    @post_overview = Faker::Lorem.sentence
    @post_programming_languages = Faker::Lorem.sentence
    @post_techs = Faker::Lorem.sentence
    @post_portfolio_url = Faker::Lorem.sentence
    @post_github_url = Faker::Lorem.sentence
  end

  context '投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿')
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      image_path = Rails.root.join('public/test2.png')
      attach_file('post[image]', image_path)
      fill_in 'タイトル', with: @post_title
      fill_in '概要', with: @post_overview
      fill_in 'プログラミング言語', with: @post_programming_languages
      fill_in '技術', with: @post_techs
      fill_in 'ポートフォリオのURL', with: @post_portfolio_url
      fill_in 'GitHubのURL', with: @post_github_url
      # 送信するとPostモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Post.count }.by(1)
      # トップページに遷移する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿した画像が存在することを確認する（画像）
      expect(page).to have_selector("img")
      # トップページには先ほどの投稿が存在することを確認する（テキスト）
      expect(page).to have_content(@post_overview)
    end
  end

  context '投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 投稿ページへのリンクがない
      expect(page).to have_no_content('投稿')
    end
  end  
end


RSpec.describe '投稿編集', type: :system do
  before do
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end
  context '投稿編集ができるとき' do
    it 'ログインしたユーザーは自分の投稿を編集できる' do
      # post1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @post1.user.email
      fill_in 'パスワード', with: @post1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 編集ページへ遷移する
      visit edit_post_path(@post1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#post_title').value
      ).to eq(@post1.title)

      expect(
        find('#post_overview').value
      ).to eq(@post1.overview)

      expect(
        find('#post_programming_languages').value
      ).to eq(@post1.programming_languages)

      expect(
        find('#post_techs').value
      ).to eq(@post1.techs)

      expect(
        find('#post_portfolio_url').value
      ).to eq(@post1.portfolio_url)

      expect(
        find('#post_github_url').value
      ).to eq(@post1.github_url)
      # 投稿内容を編集する
      image_path = Rails.root.join('public/test2.png')
      attach_file('post[image]', image_path)
      fill_in 'post_title', with: "#{@post1.title}+編集したテキスト"
      # 編集してもPostモデルのカウントは変わらないことを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Post.count }.by(0)
      # 編集完了画面に遷移したことを確認する
      expect(current_path).to eq(post_path(@post1))
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容の投稿が存在することを確認する（画像）
      expect(page).to have_selector("img")
      # トップページには先ほど変更した内容の投稿が存在することを確認する（テキスト）
      expect(page).to have_content("#{@post1.title}+編集したテキスト")
    end
  end

  context '投稿が編集ができないとき' do
    it 'ログインしたユーザーは自分以外の投稿編集画面には遷移できない' do
      # post1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @post1.user.email
      fill_in 'パスワード', with: @post1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # post2の詳細ページに遷移する
      visit post_path(@post2)
      # post2に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '編集'
    end
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # post1の詳細ページに遷移する
      visit post_path(@post1)
      # post1に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '編集'
      # post2の詳細ページに遷移する
      visit post_path(@post2)
      # post2に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '編集'
    end
  end
end

RSpec.describe 'ツイート削除', type: :system do
  before do
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end
  context '投稿が削除ができるとき' do
    it 'ログインしたユーザーは自らの投稿を削除ができる' do
      # post1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @post1.user.email
      fill_in 'パスワード', with: @post1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # post1の詳細ページに遷移する
      visit post_path(@post1)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect {
        click_link '削除'
      }.to change { Post.count }.by(-1)
      # トップページに遷移する
      visit root_path
      # トップページにはpost1の内容が存在しないことを確認する（画像）
      # トップページにはpost1の内容が存在しないことを確認する（テキスト）
    end
  end
  context '投稿が削除ができないとき' do
    it 'ログインしたユーザーは自分以外の投稿を削除できない' do
      # post1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @post1.user.email
      fill_in 'パスワード', with: @post1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # post2の詳細ページに遷移する
      visit post_path(@post2)
      # post2に「削除」ボタンがないことを確認する
      expect(page).to have_no_link '編集'
    end
    it 'ログインしていないと投稿詳細の削除ボタンがない' do
      # トップページにいる
      visit root_path
      # post1の詳細ページに遷移する
      visit post_path(@post1)
      # post1に「削除」ボタンがないことを確認する
      expect(page).to have_no_link '編集'
      # post2の詳細ページに遷移する
      visit post_path(@post2)
      # post2に「削除」ボタンがないことを確認する
      expect(page).to have_no_link '編集'
    end
  end
end
