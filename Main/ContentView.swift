//
//  ContentView.swift
//  LoginSample
//
//  Created by cmStudent on 2022/10/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        // アカウントの所持・未所持で遷移先を分ける
        Group {
            
            if viewModel.userSession == nil {
                LoginView()
            } else {
                MainView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
