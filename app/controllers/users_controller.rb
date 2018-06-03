class UsersController < ApplicationController
  
  def my_portfolio
    @user = current_user
    @user_stocks = current_user.stocks
  end
  
  def my_friends
    @friendships = current_user.friends
  end
  
  def search
    if params[:search_param].blank?
      
      # 検索条件が空欄だった場合のメッセージ設定
      flash.now[:danger] = "You have entered on empty search string"
      
    else
      
      # ユーザー検索
      @users = User.search(params[:search_param])
      
      # 取得失敗した場合のメッセージ設定
      flash.now[:danger] = "No users match" if @users.blank?
    end
    
    # 部分ビューのみ更新
    render partial: 'friends/result'
  end
end
