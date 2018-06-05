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
      
      # 検索結果から自分のオブジェクトを除く
      @users = current_user.except_current_user(@users)
      
      # 取得失敗した場合のメッセージ設定
      flash.now[:danger] = "No users match" if @users.blank?
    end
    
    # 部分ビューのみ更新
    render partial: 'friends/result'
  end
  
  def add_friend
    @friend = User.find(params[:friend])
    
    # モデルオブジェクトの生成（Createと異なりsaveはされない）
    current_user.friendships.build(friend_id: @friend.id)
    
    if current_user.save
      flash[:success] = "Friend was successfully added"
    else
      flash[:danger] = "There was something wrong with the friend request"
    end
    
    redirect_to my_friends_path
  end
  
end
