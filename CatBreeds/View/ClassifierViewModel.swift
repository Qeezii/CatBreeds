//
//  ClassifierViewModel.swift
//  CatBreeds
//
//  Created by Alexey Poletaev on 04.05.2022.
//

import Foundation
import CoreLocation
import Vision
import UIKit
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
    var catBreedsDict: [CatBreedsResponse.ID : CatBreedsResponse] = [:]
    let modelName = MobileNetV2()
//    let modelName = WhatIsCatBreedsModel()
    
    init() {
        if let api = Api.shared.catBreeds {
            getCatBreedsReceive(for: api)
        }
    }
    
    func classifierImage() {
        self.opacityForDownloadingInProgress = 100.0
        self.opacityForDownloadingEnd = 0.0
        
        self.barChartsData = [] // может можно лучше придумать
        
        guard let model = try? VNCoreMLModel(for: modelName.model) else { return }
        guard let image = selectedImage else { return }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            if let observations = request.results as? [VNClassificationObservation] {
                let top3 = observations.prefix(through: 2)
                    .map { ($0.identifier, $0.confidence) }
                
                var totalResult = ""

                for j in 0..<top3.count {
                    let text = top3[j].0.capitalizingFirstLetter()
                    let percent = top3[j].1 * 100
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
    
    func getCatBreedsReceive(for url: URL) {
        guard let networkReceive = networkReceive else {
            return
        }
        let catBreedsReceive = CatBreedsReceive.init(networkReceive: networkReceive)
        catBreedsReceive.getCatBreedsReceive(for: url) { result in
            self.catBreedsArray = result
            for i in result {
                self.catBreedsDict[i.id] = i
            }
            self.opacityForDownloadingInProgress = 0.0
            self.opacityForDownloadingEnd = 100.0
            print("\n DataDownloadEnd \n")
        }
    }
}
