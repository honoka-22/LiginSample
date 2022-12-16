//
//  PostViewModel.swift
//  LoginSample
//
//  Created by cmStudent on 2022/11/18.
//

import Foundation

import SwiftUI
import Firebase

class PostViewModel: ObservableObject {
    @Published var posts = [Post]()
    @Published var togle = true
    
    @Published var sortItems = ["価格が高い順", "価格が低い順", "名前順"]
    @Published var item = 0
    
    init() {
        fetchPosts()
    }
    
    // データ読み込み
    func fetchPosts() {
        // 絞り込み
//        COLLECTION_POSTS.where(絞り込みの条件).orderBy(並び替えの条件).limit(表示数).getDocuments(){}

        let order = item == 0 || item == 1 ? "price" : "title"
        let descending = item == 0 ? true : false
        
        // .order(by: order, descending: descending)
        //  → 並び順を指定 byが列, descendingはfalseが昇順trueが降順
        // .getDocuments → 値を取得
        COLLECTION_POSTS.order(by: order, descending: descending).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                print("エラーだよ")
                
            } else {
                // 取得した値をpostsに詰める
                // そのために、値の形式がPostと同じかを確認
                self.posts = snapshot!.documents.compactMap({
                    try? $0.data(as: Post.self)
                })
                
                // デバッグ用
                print("postsの中身を表示します")
                for post in 0 ..< self.posts.count {
                    print(self.posts[post].title + ", \(self.posts[post].price)")
                }
                print("以上です")
            }
            
            
        }

    }
    

    // データ登録
    func uploadPost(title: String, price: Int) {
        
        let data = ["title": title,
                    "price": price] as [String: Any]

        COLLECTION_POSTS.addDocument(data: data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("登録完了")
            self.fetchPosts()
        }
        
        
    }
}

