//
//  ChartAreaHView.swift
//  CatBreeds
//
//  Created by Alexey Poletaev on 10.05.2022.
//

import SwiftUI

struct ChartAreaHView: View {
    var data: [(String, Double)]
    var scaleFactor: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5.0)
                .fill(Color.white)
            
            VStack {
                VStack(spacing: 0) {
                    ForEach(data, id: \.0) { item in
                        BarHView(
                            name: item.0,
                            values: item.1,
                            scaleFactor: scaleFactor)
                    }
                }
            }
        }
    }
}
