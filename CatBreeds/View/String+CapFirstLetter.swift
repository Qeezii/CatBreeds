//
//  String+CapFirstLetter.swift
//  CatBreeds
//
//  Created by Alexey Poletaev on 04.05.2022.
//

import Foundation

extension String {

    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
