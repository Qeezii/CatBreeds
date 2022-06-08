//
//  BarChartHView.swift
//  CatBreeds
//
//  Created by Alexey Poletaev on 10.05.2022.
//

import SwiftUI

struct BarChartHView: View {

    @ObservedObject var classifierViewModel: ClassifierViewModel

    var body: some View {

        GeometryReader { gReader in
            let axisWidth = gReader.size.width * 0.21
            let axisHeight = gReader.size.height * 0.5
            let fullChartHeight = gReader.size.height - axisHeight
            let fullChartWidth = gReader.size.width - axisWidth

            let maxValue = 100.0
            let tickMarks = AxisParameters.getTicks(top: Int(maxValue))
            let scaleFactor = (fullChartWidth * 0.95) / CGFloat(tickMarks[tickMarks.count-1])

            VStack(spacing: 0) {

                ChartHeaderView(title: classifierViewModel.titleBarCharts)
                    .padding(.bottom, 25)

                HStack(spacing: 0) {
                    YaxisHView(data: classifierViewModel.barChartsData)
                        .frame(width: axisWidth, height: fullChartHeight)

                    ChartAreaHView(data: classifierViewModel.barChartsData, scaleFactor: Double(scaleFactor))
                        .frame(height: fullChartHeight)
                }
                .padding(.leading, 5)
            }
        }
    }
}
