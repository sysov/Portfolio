//
//  FavoritesSwiftUIView.swift
//  NewsApp
//
//  Created by Valera Sysov on 12.03.22.
//

import SwiftUI

struct FavoritesSwiftUIView: View {
   
    var body: some View {
        VStack{
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).bold()
                .padding(40)
            Image(systemName: "star").font(.system(size: 60))
                .padding(40)
            Button("Tap") {
                print("Tap me")
            }.font(.system(size: 80))
                .background(.gray)
                
                .cornerRadius(20)
    }
    }
}

struct FavoritesSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesSwiftUIView()
    }
}
