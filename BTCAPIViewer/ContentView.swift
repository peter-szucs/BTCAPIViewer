//
//  ContentView.swift
//  BTCAPIViewer
//
//  Created by Peter Szücs on 2020-09-07.
//  Copyright © 2020 Peter Szücs. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    
    @State var price: CoinPrice?
    @State var prices: CoinGecko?
    @State var isDragging = false
    
    var drag: some Gesture {
        DragGesture()
            .onChanged {_ in self.isDragging = true }
            .onEnded {_ in self.isDragging = false }
    }
    
    var body: some View {
        VStack() {
            HStack(alignment: .top) {
                Spacer()
                Image("btc")
                    .resizable()
                    .frame(width: 100, height: 100)
                Spacer()
            }
            .padding(.top, 10.0)
            
            
//            Spacer()
            
            HStack() {
                Text("Bitcoin Rates")
                    .font(.title)
                    .padding(.bottom, 30.0)
            }
            HStack {
                Text("Currency")
                    .font(.headline)
                    .padding(.leading, 15.0)
                Spacer()
                Text("Rate")
                    .font(.headline)
                Spacer()
                Text("24h")
                    .font(.headline)
                    
            }
            .padding(.trailing, 30.0)
            if(unwrap()) {
                List {
                    CoinRow(image: "eth", name: "ETH", rate: prices!.eth, dayChange: prices!.eth_24h_change)
                    
                    CoinRow(image: "ltc", name: "LTC", rate: prices!.ltc, dayChange: prices!.ltc_24h_change)
                    CoinRow(image: "swe", name: "SEK", rate: prices!.sek, dayChange: prices!.sek_24h_change)
                    CoinRow(image: "eur", name: "EUR", rate: prices!.eur, dayChange: prices!.eur_24h_change)
                    CoinRow(image: "usa", name: "USD", rate: prices!.usd, dayChange: prices!.usd_24h_change)
                }
                
            }
        }
        
        
        
        
        .onAppear {
        self.updateApi()
        
        
//        VStack {
//            HStack() {
//
//                VStack() {
//                    Image("btc")
//                        .resizable()
//                        .frame(width: 50.0, height: 50.0)
//                        .offset(y: 50)
//                        .padding(.bottom, 30)
//                    if price?.base_currency_name != nil {
//                    Text(price!.base_currency_name)
//                        .font(.headline)
//                        .multilineTextAlignment(.leading)
//                        .padding()
//                    } else {
//                        Text("")
//                    }
//
//                    Text("1")
//                        .font(.largeTitle)
//                        .multilineTextAlignment(.center)
//                        .padding()
//
//
//                }
//                Spacer()
//                VStack() {
//                    Image("dollar")
//                        .resizable()
//                        .frame(width: 50.0, height: 50.0)
//                        .offset(y: 50)
//                        .padding(.bottom, 30)
//                    if price?.quote_currency_name != nil {
//                        Text(price!.quote_currency_name)
//                            .font(.headline)
//                            .multilineTextAlignment(.trailing)
//                            .padding()
//                    } else {
//                        Text("")
//                    }
//                    if price?.price != nil {
//                    Text("\(price!.price, specifier: "%.2f")")
//                        .font(.title)
//                        .multilineTextAlignment(.center)
//                        .padding()
//                    } else {
//                        Text("")
//                    }
//                }
////                Spacer()
//
//
//            }
//            if prices?.eth != nil {
//                Text("\(prices!.eth)")
//            } else {
//                Text("")
//            }
//
//            Spacer()
//
//
//            Button(action: {self.updateApi()}) {
//                Text("Uppdatera")
//            }
//                    .padding(.bottom, 20.0)
//            .onAppear {
//                self.updateApi()
//            Api().getCoinGecko { (prices) in
//                self.prices = prices
//                }
//            }
            
        }
    }
    
    func updateApi() {
        Api().getExchange(baseId: "btc-bitcoin", quoteId: "usd-us-dollars") { (price) in
            self.price = price
        }
        Api().getCoinGecko { (prices) in
            self.prices = prices
        }
    }
    
    func unwrap() -> Bool {
        if prices?.eth != nil && prices?.eth_24h_change != nil && prices?.ltc != nil && prices?.ltc_24h_change != nil && prices?.sek != nil && prices?.sek_24h_change != nil && prices?.eur != nil && prices?.eur_24h_change != nil && prices?.usd != nil && prices?.usd_24h_change != nil {
            return true
        } else {
            return false
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
