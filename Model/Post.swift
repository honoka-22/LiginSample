//
//  Post.swift
//  LoginSample
//
//  Created by cmStudent on 2022/11/25.
//

import FirebaseFirestoreSwift


// 登録する情報
struct Post:Identifiable, Decodable {
    // id 自動生成
    @DocumentID var id: String?
    
    var title: String
    var price: Int
}
