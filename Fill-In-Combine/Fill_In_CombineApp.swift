//
//  Fill_In_CombineApp.swift
//  Fill-In-Combine
//
//  Created by 윤범태 on 2023/08/21.
//

import SwiftUI

@main
struct Fill_In_CombineApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                // .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
