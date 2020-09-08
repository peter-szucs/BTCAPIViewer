//
//  Data.swift
//  BTCAPIViewer
//
//  Created by Peter Szücs on 2020-09-07.
//  Copyright © 2020 Peter Szücs. All rights reserved.
//

import SwiftUI

struct CoinPrice: Codable {
//    var id: String
    var base_currency_id: String = ""
    var base_currency_name: String = ""
//    var base_price_last_updated: String
    var quote_currency_id: String = ""
    var quote_currency_name: String = ""
    var amount: Int = 0
    var price: Double = 0.0
}

struct CoinGecko: Codable {
    var eth: Double = 0.0
    var eth_24h_change: Double = 0.0
    var ltc: Double = 0.0
    var ltc_24h_change: Double = 0.0
    var sek: Double = 0.0
    var sek_24h_change: Double = 0.0
    var eur: Double = 0.0
    var eur_24h_change: Double = 0.0
    var usd: Double = 0.0
    var usd_24h_change: Double = 0.0
    
}

class Api {
    func getExchange(baseId: String, quoteId: String, completion: @escaping (CoinPrice) -> ()) {
        
        let concatenatedUrl = "https://api.coinpaprika.com/v1/price-converter?base_currency_id=\(baseId)&quote_currency_id=\(quoteId)&amount=1"
        guard let url = URL(string: concatenatedUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let exchanges = try! JSONDecoder().decode(CoinPrice.self, from: data!)
            
            DispatchQueue.main.async {
                completion(exchanges)
            }
        }
        .resume()
    }
    
    func getCoinGecko(completion: @escaping (CoinGecko) -> ()) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=eth%2Cltc%2Csek%2Ceur%2Cusd&include_market_cap=false&include_24hr_change=true") else {return}
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let exchanges = try! JSONDecoder().decode(CoinGecko.self, from: data!)
            DispatchQueue.main.async {
                completion(exchanges)
            }
        }
        .resume()
    }
    
}

struct Data_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}
