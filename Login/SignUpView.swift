//
//  SignUpView.swift
//  LoginSample
//
//  Created by cmStudent on 2022/11/09.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State var mail:String = ""
    @State var password:String = ""
    @State var rePassword:String = ""
    @Binding var isShow: Bool
    
    @State var message: String = ""
    
    var body: some View {
        VStack {
            Text("Login")
            
            Spacer()
            
            Text(message).padding()
            
            TextField("メールアドレスを入力してください", text: $mail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            
            SecureField("パスワードを入力してください", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("パスワードをもう一度入力してください", text: $rePassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Text(viewModel.errorMessage)
            
            
            ButtonStyleView(text: "Sign up") {
                if mail == "" || password == "" || rePassword == "" {
                    message = "未入力の項目があります"
                    return
                }
                if password != rePassword {
                    message = "パスワードが違います"
                    return
                }
                
                // パスワード・メールアドレスの入力チェック
                viewModel.register(withEmail: mail,
                                   password: password)
            }
            
            /// ログイン画面に遷移する
            ButtonStyleView(text: "Login") {
                isShow.toggle()
            }
            
            Spacer()
            
        }.padding()
    }
}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
