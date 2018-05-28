class StocksController < ApplicationController
  
  def search
    if params[:stock].blank?
      
      # 検索条件が空欄だった場合のメッセージ設定
      flash.now[:danger] = "You have entered on empty search string"
      
    else
      
      # 株式情報取得
      @stock = Stock.new_from_lookup(params[:stock])
      
      # 取得失敗した場合のメッセージ設定
      flash.now[:danger] = "You have entered on incorrect symbol" unless @stock
    end
    
    # 部分ビューのみ更新
    render partial: 'users/result'
  end
  
end