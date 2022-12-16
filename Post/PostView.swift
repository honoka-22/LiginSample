//
//  PostView.swift
//  LoginSample
//
//  Created by cmStudent on 2022/11/18.
//

import SwiftUI

struct PostView: View {
    @State var title: String
    @State var price: Int
    @ObservedObject var viewModel = PostViewModel()
    @State var message: String = ""
    
    var body: some View {
        VStack {
            Text(message)
                .padding()
            
            
            TextField("post", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("price", value: $price,
                      formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            ButtonStyleView(text: "Post") {
                // 入力チェック
                if title != "" {
                    print("データを登録します")
                    viewModel.uploadPost(title: title, price: price)
                    title = ""
                    price = 0
                    message = ""
                    
                } else {
                    message = "文字を入力してください。"
                }
            }
            
            PickerView(items: viewModel.sortItems,
                       selectItem: $viewModel.item) {
                // 項目が変更されたら再読み込み
                viewModel.fetchPosts()
            }
            
            ZStack {
                Color.gray
                
                PostListView(viewModel: viewModel)
                    .padding()
                
            }

        }.padding()
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(title: "title", price: 0)
    }
}
