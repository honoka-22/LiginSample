//
//  LoginView.swift
//  LoginSample
//
//  Created by cmStudent on 2022/11/09.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var mail:String = ""
    @State var password:String = ""
    @State var isShow = false
    var body: some View {
        VStack {
            Text("Login")
            
            Spacer()
            
            TextField("mail", text: $mail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            
            SecureField("password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Text(viewModel.errorMessage)
            
            ButtonStyleView(text: "Login") {
                // パスワード・メールアドレスの入力チェック
                viewModel.login(withEmail: mail, password: password)
            }
            

            Button {
                
            } label: {
                Text("パスワードをお忘れのお方")
            }
            
            ButtonStyleView(text: "SignUp") {
                isShow.toggle()
            }
            .fullScreenCover(isPresented: $isShow) {
                SignUpView(isShow: $isShow)
            }
            
            Spacer()
            
        }.padding()
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
