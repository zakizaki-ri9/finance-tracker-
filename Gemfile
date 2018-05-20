source 'https://rubygems.org'


gem 'rails', '4.2.5'

# 認証機能(ログイン、ログアウト)を簡単に実装できるライブラリ
gem 'devise'

# Bootstrapの導入
gem 'twitter-bootstrap-rails'

# deviseで作成された画面に対してBootstrapを適応させる
gem 'devise-bootstrap-views'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

group :development, :test do
  gem 'byebug'
  
  # SQLiteはデプロイ先(heroku)では使えないため、開発環境にのみ適用
  gem 'sqlite3'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :production do
  # デプロイ先(heroku)ではpostgres sqlをインストールする
  gem 'pg', '~> 0.11'
  gem 'rails_12factor'
end

