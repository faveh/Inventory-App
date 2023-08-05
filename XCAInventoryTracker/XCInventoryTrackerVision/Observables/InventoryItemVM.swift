//
//  InventoryItemViewModel.swift
//  XCAInventoryTracker
//
//  Created by Ayodimeji Adejuwon on 04/08/2023.
//

import FirebaseFirestore
import FirebaseStorage
import Foundation
import SwiftUI
import RealityKit

class InventoryItemViewModel: ObservableObject {
    
    @Published var item: InventoryItem?
    @Published var usdzFileURL: URL?
    @Published var entity: ModelEntity?
    
    var onItemDeleted: (() -> Void)? = nil
    
    func listenToItem(_ item: InventoryItem) {
        self.item = item
        Firestore.firestore().collection("items")
            .document(item.id)
            .addSnapshotListener { snapshot, error in
                guard let snapshot else {
                    print("Error fetching snapshot: \(error?.localizedDescription ?? "Error")")
                    return
                }
                
                if !snapshot.exists {
                    self.onItemDeleted?()
                    return
                }
                
                self.item = try? snapshot.data(as: InventoryItem.self)
                if let usdzURL = item.usdzURL {
                    Task {
                        await self.fetchFileURL(usdzURL: usdzURL)
                    }
                } else {
                    self.entity = nil
                    self.usdzFileURL = nil
                }
            }
    }
    
    @MainActor
    func fetchFileURL(usdzURL: URL) async {
        guard let url = usdzURL.usdzFileCacheURL else { return }
        
        if let usdzFileURL, usdzFileURL.lastPathComponent == url.lastPathComponent {
            return
        }
        
        do {
            if !FileManager.default.fileExists(atPath: url.absoluteString) {
                _ = try await Storage.storage().reference(forURL: usdzURL.absoluteString)
                    .writeAsync(toFile: url)
            }
            let entity = try await ModelEntity(contentsOf: url)
            entity.name = item?.usdzURL?.absoluteString ?? ""
            entity.generateCollisionShapes(recursive: true)
            entity.components.set(InputTargetComponent())
            self.usdzFileURL = url
            self.entity = entity
        } catch {
            self.usdzFileURL = nil
            self.entity = nil
        }
    }
}
