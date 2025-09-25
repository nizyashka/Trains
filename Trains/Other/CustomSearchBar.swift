//
//  CustomSearchBar.swift
//  Trains
//
//  Created by Алексей Непряхин on 25.09.2025.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Поиск", text: $text)
                .textFieldStyle(PlainTextFieldStyle())
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct CustomSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomSearchBar(text: .constant(""))
    }
}
