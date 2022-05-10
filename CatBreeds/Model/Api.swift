//
//  Api.swift
//  CatBreeds
//
//  Created by Alexey Poletaev on 08.05.2022.
//

import Foundation

final class Api {
    static let shared = Api()
    let catBreeds: URL? = URL(string: "https://api.thecatapi.com/v1/breeds")
    let test: URL? = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=55&lon=37&exclude=minutely&appid=0a7d5a73e88d8d41d76d90bb356188d4&units=metric")
}

// cat api: 753f52d8-c5ca-4a02-891d-b5d774703fd2
