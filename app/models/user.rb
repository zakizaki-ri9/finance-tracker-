class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  
  # tickerの２重登録チェック
  def stock_already_added?(ticker_symbol)
    stock = Stock.find_by_ticker(ticker_symbol)
    
    # Stockが取得できなかった場合は終了
    return false unless stock 
    
    user_stocks.where(stock_id: stock.id).exists?
  end
  
  # 登録上限チェック
  def under_stock_limit?
    (user_stocks.count < 10)
  end
  
  # 上記に定義した関数を元に登録チェックを行う
  def can_add_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_added?(ticker_symbol)
  end
  
end
