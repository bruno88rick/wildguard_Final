//
//  HomeView.swift
//  WildGuard
//
//  Created by Paul Hudson on 27/01/2024.
//

import SwiftUI

struct HomeView: View {
    @Environment(DataController.self) var dataController

    var body: some View {
        @Bindable var dataController = dataController

        VStack(spacing: 20) {
            Text("WildGuard")
                .font(.largeTitle)

            Text("Welcome to WildGuard, the app that immerses you in the fascinating world of endangered animals, educating and inspiring you to protect our planet's most vulnerable species.")
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .font(.title2)
                .padding(.bottom, 20)

            HStack {
                ForEach(AnimalType.allCases, id: \.self) { type in
                    Button {
                        dataController.selectedTab = type.rawValue
                    } label: {
                        CategoryStack(type: type)
                    }
                    .buttonStyle(.plain)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                }
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .fontDesign(.rounded)
        .padding()
    }
}

#Preview {
    HomeView()
}
