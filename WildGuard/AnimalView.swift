//
//  AnimalView.swift
//  WildGuard
//
//  Created by Paul Hudson on 27/01/2024.
//

import SwiftUI

struct AnimalView: View {    
    var animal: Animal
    @State private var selectedImage: String?

    @Environment(\.openURL) var openURL
    @Environment(\.openWindow) var openWindow
    @AppStorage("AnimalIsFavorite") var animalIsFavorite = false

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("**Rating:** \(animal.endangeredRating)")
                            .padding()
                            .background(.regularMaterial)
                            .background(.red.tertiary)
                            .foregroundStyle(.white)
                            .clipShape(.rect(cornerRadius: 10))

                        Text("**Estimated population:** \(animal.estimatedPopulation)")
                            .padding()
                            .background(.regularMaterial)
                            .background(.red.tertiary)
                            .foregroundStyle(.white)
                            .clipShape(.rect(cornerRadius: 10))
                    }

                    Text(animal.scientificName)
                        .italic()
                        .padding(.vertical, 20)

                    Text(animal.description)
                        .padding(.bottom, 20)

                    Spacer()

                    HStack {
                        Button {
                            #if os(visionOS)
                            openWindow(value: animal.englishName)
                            #else
                            selectedImage = animal.englishName
                            #endif
                        } label: {
                            Image(animal.englishName)
                                .resizable()
                                .scaledToFit()
                                .containerRelativeFrame(.horizontal) { size, axis in
                                    size * 0.3
                                }
                                .clipShape(.rect(cornerRadius: 15))
                        }
                        .buttonStyle(.plain)
                        .buttonBorderShape(.roundedRectangle(radius: 15))

                        Button {
                            #if os(visionOS)
                            openWindow(value: animal)
                            #else
                            selectedImage = animal.mapImage
                            #endif
                        } label: {
                            Image(animal.mapImage)
                                .resizable()
                                .scaledToFit()
                                .containerRelativeFrame(.horizontal) { size, axis in
                                    size * 0.3
                                }
                                .clipShape(.rect(cornerRadius: 15))
                        }
                        .buttonStyle(.plain)
                        .buttonBorderShape(.roundedRectangle(radius: 15))
                    }
                }
            }
            .scrollBounceBehavior(.basedOnSize)

            if let selectedImage {
                Image(selectedImage)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .black, radius: 20)
                    .onTapGesture {
                        self.selectedImage = nil
                    }
            }
        }
        .navigationTitle(animal.englishName)
        .padding([.horizontal, .bottom], 20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .toolbar {
            ToolbarItemGroup(placement: .bottomOrnament) {
                Toggle("Toggle Favorite", systemImage: "star", isOn: $animalIsFavorite)

                Button("Learn more", systemImage: "safari") {
                    openURL(animal.url)
                }

                ShareLink(item: animal.url)
            }
        }
    }

    init(animal: Animal) {
        self.animal = animal
        _animalIsFavorite = AppStorage(wrappedValue: false, animal.favoritesKey)
    }
}

#Preview {
    AnimalView(animal: .example)
}
