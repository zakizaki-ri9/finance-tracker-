class Stock < ActiveRecord::Base
  
  # 株式情報を取得する処理
  # ticker_symbol - 名前(ex. "GOOG"など)
  def self.new_from_lookup(ticker_symbol)
    
    # 株式情報取得
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    
    # TODO: 検索失敗時の対応が必要
    # インスタンスを返す
    new(name: looked_up_stock.company_name,
        ticker: looked_up_stock.symbol,
        last_price: looked_up_stock.latest_price)
  end
  
end
