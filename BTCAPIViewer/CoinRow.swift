//
//  CoinRow.swift
//  BTCAPIViewer
//
//  Created by Peter Szücs on 2020-09-08.
//  Copyright © 2020 Peter Szücs. All rights reserved.
//

import SwiftUI

struct CoinRow: View {
    
    var image: String = "eth"
    var name: String = "ETH"
    var rate: Double = 26.6786
    var dayChange: Double = 1.234
    
    var body: some View {
        HStack() {
            Image(image)
                .resizable()
                .frame(width: 30, height: 30)
            Text(name)
            Spacer()
            Text("\(rate, specifier: "%.3f")")
                .multilineTextAlignment(.leading)
            Spacer()
            Text("\(dayChange, specifier: "%.3f")")
            .foregroundColor(colorChooser(number: dayChange))
        }
        .padding(.trailing, 11.0)
    }
    
    func colorChooser(number: Double) -> Color {
        var color: Color = .black
        if number < 0 {
            color = .red
        } else {
            color = .green
        }
        return color
    }
}

struct CoinRow_Previews: PreviewProvider {
    static var previews: some View {
        CoinRow()
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
