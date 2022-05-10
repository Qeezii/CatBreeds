//
//  YaxisHView.swift
//  CatBreeds
//
//  Created by Alexey Poletaev on 10.05.2022.
//

import SwiftUI

struct YaxisHView: View {
//    var data: [DataItem]
    var data: [(String, Double)]
    
    var body: some View {
        GeometryReader { gr in
            let labelHeight = (gr.size.height * 0.9) / CGFloat(data.count)
            let padHeight = gr.size.height * 0.05 / CGFloat(data.count)
            
            ZStack {
                Rectangle()
                    .fill(Color.white)
                
                Rectangle()
                    .fill(Color.black)
                    .frame(width:1.5)
                    .offset(x: (gr.size.width/2.0) - 1, y: 1)
                
                VStack(spacing:0) {
                    ForEach(data, id: \.0) { item in
                        Text(item.0)
                            .font(.subheadline)
                            .frame(height: labelHeight)
                    }
                    .padding(.vertical, padHeight)
                }
            }
        }
    }
}
