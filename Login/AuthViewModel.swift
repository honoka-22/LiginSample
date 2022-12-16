//
//  AuthViewModel.swift
//  LoginSample
//
//  Created by cmStudent on 2022/11/11.
//

import SwiftUI
import Firebase

class  AuthViewModel: ObservableObject {
    @Published var userSession: Firebase.User?
    @Published var currentUser: User?
    @Published var errorMessage:String = ""
    
    static let shared = AuthViewModel()
    
    init() {
        // メールの言語設定
        Auth.auth().languageCode = "ja_JP"
        // 現在ログインしているユーザーを取得する
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    /// ログインする
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                // TODO: 登録失敗時の画面処理を追加する
                self.errorMessage = "失敗"
            }
            
            guard let user = result?.user else { return }
            
            if user.isEmailVerified {
                print("メールアドレス確認済み")
                self.userSession = user
                self.fetchUser()
            } else {
                print("メールアドレス未確認")
                self.errorMessage = "メールアドレスが未確認です"
            }
            
            
        }
    }
    
    /// SignUp時に呼び出し、パスワード ベースのアカウントを作成する
    func register(withEmail email: String, password: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            
            if let error = error {
                print(error.localizedDescription)
                // TODO: 登録失敗時の画面処理を追加する
                self.errorMessage = "失敗"
                return
            }
            
            guard let user = result?.user else { return }
            
            // メールアドレス認証
            user.sendEmailVerification(completion: { error in
                
                if let error = error {
                    print(error.localizedDescription)
                    self.errorMessage = "送信に失敗しました"
                    return
                }
                self.errorMessage = "送信に成功しました"
            })
            
            
            let data = ["email": email, "uid": user.uid]
            
            COLLECTION_USERS.document(user.uid).setData(data) { _ in
                self.userSession = user
                self.fetchUser()
            }
            
        }
        
    }
    
    /// ログアウト
    func signout() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    
    /// パスワードをリセットする
    func resetPassword() {
        
    }
    
    /// ユーザーを取得する
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            self.currentUser = user
            self.errorMessage = "成功"
        }
    }
}


//public enum AuthError: Error {
//    // ネットワークエラー
//    case networkError
//    // パスワードが条件より脆弱であることを示します。
//    case weakPassword
//    // ユーザーが間違ったパスワードでログインしようとしたことを示します。
//    case wrongPassword
//    // ユーザーのアカウントが無効になっていることを示します。
//    case userNotFound
//    // メールアドレスの形式が正しくないことを示します。
//    case invalidEmail
//    // 既に登録されているメールアドレス
//    case emailAlreadyInUse
//    // 不明なエラー
//    case unknown
//
//    //エラーによって表示する文字を定義
//    var title: String {
//        switch self {
//        case .networkError:
//            return "通信エラーです。"
//        case .weakPassword:
//            return "パスワードが脆弱です。"
//        case .wrongPassword:
//            return "メールアドレス、もしくはパスワードが違います。"
//        case .userNotFound:
//            return "アカウントがありません。"
//        case .invalidEmail:
//            return "正しくないメールアドレスの形式です。"
//        case .emailAlreadyInUse:
//            return "既に登録されているメールアドレスです。"
//        case .unknown:
//            return "エラーが起きました。"
//        }
//    }
//}
