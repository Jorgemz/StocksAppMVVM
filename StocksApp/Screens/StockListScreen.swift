//
//  StockListView.swift
//  StocksApp
//
//  Created by Mohammad Azam on 1/25/21.
//

import SwiftUI

struct StockListScreen: View {
    
    @State private var isPresented = false
    @State private var selectedStock: StockViewModel?
  
  @StateObject var stockListVM = StockListViewModel()
    
    let stocks = ["SEARS", "GMSP", "APLE", "BLBUS", "ENRON"]
    
    var body: some View {
        
        VStack {
          
          Text("\(stockListVM.portfolioBalance.formatAsCurrency())")
            
          List(stockListVM.stocks, id: \.id) { stock in
                
                NavigationLink(
                    destination: Text("Show stock news"),
                    label: {
                        HStack {
                            VStack(alignment: .leading) {
                              Text(stock.symbol)
                                    .fontWeight(.bold)
                              Text(stock.title)
                            }
                            
                            Spacer()
                          Text(stock.marketValue.formatAsCurrency())
                        }
                    })
                
                
                
            }.listStyle(PlainListStyle())
            
            /* COVERED LATER IN THE SESSION
            if let selectedStock = selectedStock {
                NavigationLink(
                    destination: StockArticleListScreen(stock: selectedStock),
                    isActive: .constant(true),
                    label: {
                        EmptyView()
                    })
            } */
            
        }
        .onAppear(perform: {
            selectedStock = nil
        })
        .navigationTitle("Portfolio")
        .navigationBarItems(trailing: Button("Add Stock") {
            isPresented = true
        })
        .embedInNavigationView()
        
        .sheet(isPresented: $isPresented, onDismiss: {
            // get all stocks
          stockListVM.getAllStocks()
          
        }, content: {
            AddStockScreen()
        })
        .onAppear(perform: {
            // get all stocks
          stockListVM.getAllStocks()
        })
        
    }
}

struct StockListScreen_Previews: PreviewProvider {
    static var previews: some View {
        StockListScreen()
    }
}



struct StockSummaryView: View {
    
    let portfolioBalance: Double
    
    var body: some View {
        HStack {
            Spacer()
            Text("Total: \(portfolioBalance.formatAsCurrency())")
                .fontWeight(.bold)
            Spacer()
        }
    }
    
}
