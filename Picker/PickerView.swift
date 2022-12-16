//
//  PickerView.swift
//  LoginSample
//
//  Created by cmStudent on 2022/12/06.
//

import SwiftUI

struct PickerView: View {
    let items: [String]
    @Binding var selectItem: Int
    var action: () -> () = {}
    
    var body: some View {
        VStack(spacing: 0) {
            
            Menu {
                ForEach(items, id: \.self) { item in
                    //
                    Button {
                        selectItem = items.firstIndex(of: item) ?? 0
                        action()
                    } label: {
                        Text(item)
                    }
                }
            } label: {
                HStack {
                    Text(items[selectItem])
                        .padding(.leading)
                    Spacer()
                    Text("▼")
                        .padding(.trailing)
                }
                .frame(width: 200, height: 40)
                .foregroundColor(.black)
                .background(.white)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.brown, lineWidth: 1))
            }
        }
    }
}
//
//struct PickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PickerView()
//    }
//}
