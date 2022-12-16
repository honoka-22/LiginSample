//
//  LoginSampleApp.swift
//  LoginSample
//
//  Created by cmStudent on 2022/10/21.
//

import SwiftUI
import Firebase

@main
struct LoginSampleApp: App {
    // Firebaseを使うとき必ず必要
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }
}
