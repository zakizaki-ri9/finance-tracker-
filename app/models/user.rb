class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable  
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  
  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    "Anonymous"
  end
  
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
  
  def self.search(param)
    param.strip!
    param.downcase!
    to_send_back = 
      (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    return nil unless to_send_back
    to_send_back
  end
  
  # 各カラムに対して前方 or 後方一致する検索を行う
  def self.matches(field_name, param)
    User.where("#{field_name} like ?", "%#{param}%")
  end
  
  # self.matchesを使用した検索処理
  def self.first_name_matches(param)
    matches('first_name', param)
  end
  def self.last_name_matches(param)
    matches('last_name', param)
  end
  def self.email_matches(param)
    matches('email', param)
  end
  
  # 引数「users」から自分のオブジェクトを除く
  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end
  
  # 友達として追加済みかチェックする
  def not_friends_with?(friend_id)
    friendships.where(friend_id: friend_id).count < 1
  end
end
