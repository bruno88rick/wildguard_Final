//
//  ContentView.swift
//  WildGuard
//
//  Created by Paul Hudson on 27/01/2024.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    @State private var dataController = DataController()

    var body: some View {
        TabView(selection: $dataController.selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag("home")

            ForEach(AnimalType.allCases, id: \.self) { type in
                CategoryView(type: type)
                    .tabItem {
                        Label(type.rawValue.capitalized, systemImage: type.icon)
                    }
                    .tag(type.rawValue)
            }
        }
        .environment(dataController)
    }
}

#Preview {
    ContentView()
}
