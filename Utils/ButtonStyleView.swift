//
//  ButtonStyleView.swift
//  LoginSample
//
//  Created by cmStudent on 2022/11/11.
//

import SwiftUI

struct ButtonStyleView: View {
    var text: String =  "sample"
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .foregroundColor(.white)
                .frame(width: 360, height: 50)
                .background(.blue)
                .clipShape(Capsule())
        }

    }
}

struct ButtonStyleView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyleView(text: "sample"){}
    }
}
