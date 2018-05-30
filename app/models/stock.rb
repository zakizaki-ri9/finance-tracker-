class Stock < ActiveRecord::Base
  
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  
  # 登録済みのStockレコードを取得
  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
  
  # 株式情報を取得する処理
  # ticker_symbol - 名前(ex. "GOOG"など)
  def self.new_from_lookup(ticker_symbol)
    
    begin
      
      # 株式情報取得
      looked_up_stock = StockQuote::Stock.quote(ticker_symbol)

      # インスタンスを返す
      new(name: looked_up_stock.company_name,
          ticker: looked_up_stock.symbol,
          last_price: looked_up_stock.latest_price)
      
    rescue Exception => e
      return nil
    end
    
  end
  
end
