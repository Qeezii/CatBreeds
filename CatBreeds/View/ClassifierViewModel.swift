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

final class ClassifierViewModel: ObservableObject {

    @Published var selectedImage: UIImage?
    @Published var resultClassify: String?
    let modelName = MobileNetV2()
    
    func classifierImage() {
        guard let model = try? VNCoreMLModel(for: modelName.model) else { return }
        guard let image = selectedImage else { return }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            if let observations = request.results as? [VNClassificationObservation] {
                let top3 = observations.prefix(through: 2)
                    .map { ($0.identifier, $0.confidence) }
                
                var totalResult = ""

                for j in 0..<top3.count {
                    let text = top3[j].0.capitalizingFirstLetter()
                    let percent = String(format: "%.2f", top3[j].1 * 100)
                    let result = "\(text) - \(percent)% \n"
                    totalResult += result
                }
                self.resultClassify = totalResult
            } else {
                print(error as Any)
            }
        }
        request.imageCropAndScaleOption = .centerCrop
        let handler = VNImageRequestHandler(cgImage: image.cgImage!)
        try? handler.perform([request])
    }
}
