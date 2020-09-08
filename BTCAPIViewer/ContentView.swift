//
//  ContentView.swift
//  BTCAPIViewer
//
//  Created by Peter Szücs on 2020-09-07.
//  Copyright © 2020 Peter Szücs. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    
    @State var price: CoinPrice
    @State var prices: CoinGecko
    @State var isDragging = false
    
    var drag: some Gesture {
        DragGesture()
            .onChanged {_ in self.isDragging = true }
            .onEnded {_ in self.isDragging = false }
    }
    
    var body: some View {
        VStack {
            HStack() {
                
                VStack() {
                    Image("btc")
                        .resizable()
                        .frame(width: 50.0, height: 50.0)
                        .offset(y: 50)
                        .padding(.bottom, 30)
                    
                    Text(price.base_currency_name)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .padding()
                        
                    Text("1")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    
                }
                Spacer()
                VStack() {
                    Image("dollar")
                        .resizable()
                        .frame(width: 50.0, height: 50.0)
                        .offset(y: 50)
                        .padding(.bottom, 30)
                    Text(price.quote_currency_name)
                        .font(.headline)
                        .multilineTextAlignment(.trailing)
                        .padding()
                    Text("\(price.price, specifier: "%.2f")")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                }
//                Spacer()
                
                
            }
//            Text("\(prices.eth)")
            
                Spacer()
                    

            Button(action: {self.updateApi()}) {
                    Text("Uppdatera")
                    }
                    .padding(.bottom, 20.0)
            .onAppear {
                self.updateApi()
//            Api().getCoinGecko { (prices) in
//                self.prices = prices
//                }
            }
            
        }
    }
    
    func updateApi() {
        Api().getExchange(baseId: "btc-bitcoin", quoteId: "usd-us-dollars") { (price) in
        self.price = price
        }
    }
    
    func fetchCoinGecko() -> () {
        Api().getCoinGecko { (prices) in
            self.prices = prices
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello")
    }
}
