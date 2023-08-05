//
//  XCInventoryTrackerVisionApp.swift
//  XCInventoryTrackerVision
//
//  Created by Ayodimeji Adejuwon on 04/08/2023.
//

import SwiftUI

@main
struct XCInventoryTrackerVisionApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var navVM = NavigationViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                InventoryListView()
                    .environmentObject(navVM)
            }
        }
        
        WindowGroup(id: "item") {
            InventoryItemView().environmentObject(navVM)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 1, height: 1, depth: 1, in: .meters)
    }
}
