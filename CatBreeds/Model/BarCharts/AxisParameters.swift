//
//  AxisParameters.swift
//  CatBreeds
//
//  Created by Alexey Poletaev on 10.05.2022.
//
// swiftlint: disable cyclomatic_complexity

import Foundation

struct AxisParameters {

    static func getTicks(top: Int) -> [Int] {

        var step = 0
        var high = top

        switch top {
        case 0...8:
            step = 1
        case 9...17:
            step = 2
        case 18...50:
            step = 5
        case 51...170:
            step = 10
        case 171...500:
            step = 50
        case 501...1700:
            step = 200
        case 1701...5000:
            step = 500
        case 5001...17000:
            step = 1000
        case 17001...50000:
            step = 5000
        case 50001...170000:
            step = 10000
        case 170001...1000000:
            step = 10000
        default:
            step = 10000
        }

        high = ((top/step) * step) + step + step
        var ticks: [Int] = []
        for ind in stride(from: 0, to: high, by: step) {
            ticks.append(ind)
        }
        return ticks
    }
}
