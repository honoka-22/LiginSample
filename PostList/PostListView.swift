//
//  PostListView.swift
//  LoginSample
//
//  Created by cmStudent on 2022/11/25.
//

import SwiftUI

struct PostListView: View {
    @ObservedObject var viewModel = PostListViewModel()
    
    var body: some View {
        VStack {
            
            ButtonStyleView(text: "List") {
                viewModel.fetchPosts()
            }
            
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}
