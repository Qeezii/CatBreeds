//
//  BarHView.swift
//  CatBreeds
//
//  Created by Alexey Poletaev on 10.05.2022.
//

import SwiftUI

struct BarHView: View {

    var name: String
    var values: Double
    var scaleFactor: Double

    var body: some View {

        GeometryReader { gReader in

            let padHeight = gReader.size.height * 0.15
            VStack(spacing: 0) {

                Spacer()
                    .frame(height: padHeight)

                let barSize = values * scaleFactor

                HStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(.blue)
                        .frame(width: CGFloat(barSize), alignment: .trailing)
                        .overlay(
                            Text("\(values, specifier: "%.0F")%")
                                .font(.footnote)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .offset(x: -1, y: 0)
                            ,
                            alignment: .trailing
                        )
                    Spacer()
                }

                Spacer()
                    .frame(height: padHeight)
            }
        }
    }
}
