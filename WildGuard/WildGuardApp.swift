//
//  WildGuardApp.swift
//  WildGuard
//
//  Created by Paul Hudson on 27/01/2024.
//

import SwiftUI

@main
struct WildGuardApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        WindowGroup(for: String.self) { $string in
            if let string {
                Image(string)
                    .resizable()
                    .scaledToFill()
            }
        }
        .defaultSize(width: 1000, height: 1000)

        WindowGroup(for: Animal.self) { $animal in
            if let animal {
                ZoomedView(animal: animal)
            }
        }
        .defaultSize(width: 1, height: 1, depth: 0.5, in: .meters)
        .windowStyle(.volumetric)
    }
}

