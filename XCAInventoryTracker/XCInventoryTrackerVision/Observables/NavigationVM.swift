//
//  NavigationViewModel.swift
//  XCAInventoryTracker
//
//  Created by Ayodimeji Adejuwon on 04/08/2023.
//

import FirebaseFirestore
import FirebaseStorage
import Foundation
import SwiftUI
import QuickLookThumbnailing

class NavigationViewModel: ObservableObject {
    @Published var selectedItem: InventoryItem?
    
    init(selectedItem: InventoryItem? = nil) {
        self.selectedItem = selectedItem
    }
}
