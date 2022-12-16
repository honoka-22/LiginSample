//
//  PostListViewModel.swift
//  LoginSample
//
//  Created by cmStudent on 2022/11/25.
//

import SwiftUI
import FirebaseFirestoreSwift

class PostListViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        // 絞り込み
//        COLLECTION_POSTS.whereField(絞り込みの条件).getDocuments(){}
        
        // 全て表示
        COLLECTION_POSTS.getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                print("エラーだよ")
            } else {
                self.posts = snapshot!.documents.compactMap({
                    try? $0.data(as: Post.self)
                })
            }
        }
    }
    
}
