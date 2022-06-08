//
//  CatBreedsApp.swift
//  CatBreeds
//
//  Created by Alexey Poletaev on 04.05.2022.
//

import SwiftUI

@main
struct CatBreedsApp: App {

    @Environment(\.scenePhase) var scenePhase

    init() {
        print("📟 AppSUIApp application is starting up. App initialiser.")
        Configurator.shared.register()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { newScenePhase in
          switch newScenePhase {
          case .active:
            print("📟 App is active")
          case .inactive:
            print("📟 App is inactive")
          case .background:
            print("📟 App is in background")
          @unknown default:
            print("📟 Oh - interesting: I received an unexpected new value.")
          }
        }
    }
}
