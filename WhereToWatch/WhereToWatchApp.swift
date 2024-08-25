//
//  WhereToWatchApp.swift
//  WhereToWatch
//
//  Created by Sebastián Rubina on 2024-08-25.
//

import SwiftUI

@main
struct WhereToWatchApp: App {
    @AppStorage("needsOnboarding") var needsOnboarding = true
    @State var moviesViewModel = MoviesViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .environment(moviesViewModel)
                .fullScreenCover(isPresented: $needsOnboarding) {
                    needsOnboarding = false
                } content: {
                    OnboardingView()
                }
        }
    }
}
