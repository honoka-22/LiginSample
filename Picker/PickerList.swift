//
//  PickerList.swift
//  LoginSample
//
//  Created by cmStudent on 2022/12/06.
//

import SwiftUI

struct PickerList: View {
    var listItems: [String]
    @Binding var showList: Bool
    @Binding var selectItem: String
    var body: some View {
        ScrollView {
            LazyVStack {
                Divider()
                ForEach(listItems, id: \.self) { item in
                    HStack {
                        Text(item)
                            .padding(.leading)
                        Spacer()
                    }.onTapGesture {
                        selectItem = item
                        showList.toggle()
                    }
                    
                    Divider()
                }
            }
        }
       
        
        
    }
}

//struct PickerList_Previews: PreviewProvider {
//    static var previews: some View {
//        PickerList(listItems: ["A", "B", "C", "D", "E", "F", "G", "H"])
//    }
//}
