//
//  ClassifierViewModel.swift
//  CatBreeds
//
//  Created by Alexey Poletaev on 04.05.2022.
//

import Foundation
import CoreLocation
import Vision
import SwiftUI
import ServiceLocator
import NetworkReceive

final class ClassifierViewModel: ObservableObject {

    @Injected var networkReceive: NetworkReceive?

    @Published var selectedImage: UIImage?
    @Published var resultClassify: String?
    @Published var topResult: String? // ?
    @Published var barChartsData: [(String, Double)] = []
    @Published var opacityForDownloadingInProgress: Double = 100.0
    @Published var opacityForDownloadingEnd: Double = 0.0

    var titleBarCharts: String = "Top 3 results"
    var catBreedsArray: [CatBreedsResponse] = []
    var catBreedsDict: [CatBreedsResponse.ID: CatBreedsResponse] = [:]
    let modelName: CatBreedsModel = {
        do {
            let config = MLModelConfiguration()
            return try CatBreedsModel(configuration: config)
        } catch {
            print(error)
            fatalError("Couldn`t create MlModel")
        }
    }()

//    let modelName: MobileNetV2 = {
//        do {
//            let config = MLModelConfiguration()
//            return try MobileNetV2(configuration: config)
//        } catch {
//            print(error)
//            fatalError("Couldn`t create MlModel")
//        }
//    }()

    init() {
        if let api = Api.shared.catBreeds {
            getCatBreedsReceive(for: api)
        } else {
            print("Bad Api")
        }
    }

    func classifierImage() {
        self.opacityForDownloadingInProgress = 100.0
        self.opacityForDownloadingEnd = 0.0
        self.barChartsData = []

        guard let model = try? VNCoreMLModel(for: modelName.model) else { return }
        guard let image = selectedImage else { return }

        let request = VNCoreMLRequest(model: model) { request, error in
            if let observations = request.results as? [VNClassificationObservation] {
                let top3 = observations.prefix(through: 2)
                    .map { ($0.identifier, $0.confidence) }

                var totalResult = ""

                for ind in 0..<top3.count {
                    let text = top3[ind].0.capitalizingFirstLetter()
                    let percent = top3[ind].1 * 100
                    let percentText = String(format: "%.2f", percent)
                    let result = "\(text) - \(percentText)% \n"
                    totalResult += result

                    let percentDouble = Double(round(percent))
                    self.barChartsData.append((text, percentDouble))
                }
                print("\n Test")
                print("\(self.barChartsData) \n")

                print("\n \(top3) \n ")
                print(top3[0].0)
                self.resultClassify = totalResult
            } else {
                print(error as Any)
            }
        }
        request.imageCropAndScaleOption = .centerCrop
        let handler = VNImageRequestHandler(cgImage: image.cgImage!)
        try? handler.perform([request])

        self.opacityForDownloadingInProgress = 0.0
    }

    private func getCatBreedsReceive(for url: URL) {
        guard let networkReceive = networkReceive else {
            return
        }
        let catBreedsReceive = CatBreedsReceive.init(networkReceive: networkReceive)
        catBreedsReceive.getCatBreedsReceive(for: url) { results in
            self.catBreedsArray = results
            for result in results {
                self.catBreedsDict[result.id] = result
            }
            self.opacityForDownloadingInProgress = 0.0
            self.opacityForDownloadingEnd = 100.0
            print("\n Data Download End \n")
        }
    }
}
