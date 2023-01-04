//
//  SLApp.swift
//  SL
//
//  Created by Anand Upadhyay on 30/07/22.
//

import SwiftUI

@main
struct SLApp: App {
    @Environment(\.scenePhase) var scenePhase
    init(){
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//            .onOpenURL { url in
//                    print("Received URL: \(url)")
//            }
        }
//        .onChange(of: scenePhase) { newScenePhase in
//            switch newScenePhase {
//            case .active:
//              print("App is active")
//            case .inactive:
//              print("App is inactive")
//            case .background:
//              print("App is in background")
//            @unknown default:
//              print("Oh - interesting: I received an unexpected new value.")
//            }
//          }
    }
}
/*
 Resources
 Method swizzling
 https://stackoverflow.com/questions/39562887/how-to-implement-method-swizzling-swift-3-0
 https://abhimuralidharan.medium.com/method-swizzling-in-ios-swift-1f38edaf984f
 
 */
