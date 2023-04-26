//
//  final_projectApp.swift
//  final project
//
//  Created by User03 on 2023/4/19.
//

import SwiftUI
import Firebase

@main
struct final_projectApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
