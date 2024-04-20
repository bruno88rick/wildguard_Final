//
//  ZoomedView.swift
//  WildGuard
//
//  Created by Paul Hudson on 27/01/2024.
//

import RealityKit
import SwiftUI

struct ZoomedView: View {
    @Environment(\.scenePhase) var scenePhase
    var animal: Animal

    @State private var spinX = 0.0
    @State private var spinY = 0.0

    var body: some View {
        RealityView { content, attachments in
            guard let texture = try? await TextureResource(named: "Earth") else { return }

            let shape = MeshResource.generateSphere(radius: 0.25)
            var material = UnlitMaterial()
            material.color = .init(texture: .init(texture))
            let model = ModelEntity(mesh: shape, materials: [material])
            model.components.set(GroundingShadowComponent(castsShadow: true))
            model.components.set(InputTargetComponent())
            model.collision = CollisionComponent(shapes: [.generateSphere(radius: 0.25)])
            model.name = "Earth"
            content.add(model)

            let pitch = Transform(pitch: Float(animal.mapRotationX * -1)).matrix
            let yaw = Transform(yaw: Float(animal.mapRotationY)).matrix
            model.transform.matrix = pitch * yaw

            if let attachment = attachments.entity(for: "name") {
                attachment.position = [0, -0.3, 0]
                content.add(attachment)
            }
        } update: { content, attachments in
            guard let entity = content.entities.first else { return }

            let pitch = Transform(pitch: Float((animal.mapRotationX + spinX) * -1)).matrix
            let yaw = Transform(yaw: Float(animal.mapRotationY + spinY)).matrix
            entity.transform.matrix = pitch * yaw
        } attachments: {
            Attachment(id: "name") {
                Text("Location of \(animal.englishName)")
                    .font(.extraLargeTitle)
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .targetedToAnyEntity()
                .onChanged { value in
                    let startLocation = value.convert(value.startLocation3D, from: .local, to: .scene)
                    let currentLocation = value.convert(value.location3D, from: .local, to: .scene)
                    let delta = currentLocation - startLocation
                    spinX = Double(delta.y) * 5
                    spinY = Double(delta.x) * 5
                }
        )
        .onChange(of: scenePhase) {
            print(scenePhase)
        }
    }
}

#Preview {
    ZoomedView(animal: .example)
}
