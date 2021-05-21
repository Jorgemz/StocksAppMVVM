//
//  StockListViewModel.swift
//  StocksApp
//
//  Created by Mohammad Azam on 1/25/21.
//

import Foundation

// represents the entire screen
class StockListViewModel: ObservableObject {
  
  @Published var stocks: [StockViewModel] = []
  
  var portfolioBalance: Double {
    return stocks.reduce(0.0, {$0 + $1.marketValue} )
  }
  
  var hasBalance: Bool {
    return portfolioBalance > 0
  }
  
    // get all stocks
    func getAllStocks() {
      Webservice().getAllStocks(url: Constants.Urls.getAllStocks) { (result) in
        switch result {
        case .success(let stocks):
          if let stocks = stocks {
            DispatchQueue.main.async {
               self.stocks = stocks.map(StockViewModel.init)
            }
          }
        case .failure(let error):
          print(error)
        }
      }
    }
}

// represents individual stock displayed on the screen

struct StockViewModel {
    
    let stock: Stock
    let id: UUID = UUID() 
    
    var symbol: String {
        stock.symbol
    }
    
    var title: String {
        stock.title
    }
    
    var price: Double {
        stock.price
    }
    
    var quantity: Int {
        stock.quantity
    }
    
    var marketValue: Double {
        return Double(quantity) * price
    }
    
}
