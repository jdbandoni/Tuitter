//
//  UserImageView.swift
//  Tuitter
//
//  Created by Joni Bandoni on 19/04/2024.
//

import SwiftUI

struct UserImageView: View {
    let iconURLString: String?
    
    var body: some View {
        AsyncImage(url: URL(string: iconURLString ?? "")) { image in
            image.resizable()
                .scaledToFit()
                .padding(2)
                .frame(width: 50, height: 50)
                .background(Color.gray)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black,lineWidth: 1))
        } placeholder: {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .padding(11)
                .frame(width: 50, height: 50)
                .background(Color.gray)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black,lineWidth: 1))
        }
    }
}

struct UserImageView_Previews: PreviewProvider {
    static var previews: some View {
        UserImageView(iconURLString: "nil")
            .previewLayout(.sizeThatFits)
    }
}
