//
//  XCAInventoryTrackerApp.swift
//  XCAInventoryTracker
//
//  Created by Ayodimeji Adejuwon on 04/08/2023.
//

import SwiftUI

@main
struct XCAInventoryTrackerApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                InventoryListView()
            }
        }
    }
}
