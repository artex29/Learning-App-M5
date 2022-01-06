//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by ANGEL RAMIREZ on 1/5/22.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
