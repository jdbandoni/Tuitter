//
//  PostingTuitView.swift
//  Tuitter
//
//  Created by Joni Bandoni on 20/04/2024.
//

import SwiftUI

struct PostingTuitView: View {
    @ObservedObject var viewModel = PostingTuitViewModel()
    
    var body: some View {
        NavigationView {
            HStack (alignment: .top) {
                UserImageView(iconURLString: viewModel.authorization.profilePic).padding(8)
                VStack (alignment: .leading) {
                    TextField("What are you thinking...", text: $viewModel.text)
                        .frame(minHeight: 60)
                        .lineLimit(0)
                        .padding(8)
                    Divider()
                        .padding(.trailing)
                    HStack {
                        Spacer()
                        Button(action: {
                            Task {
                                await viewModel.postTuit()
                            }
                        }, label: {
                            Text("Tuit")
                                .frame(width: 50, height: 30)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .font(.caption)
                                .bold()
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        })
                        .padding(.trailing)
                    }
                    Spacer()
                }
            }.navigationTitle(viewModel.title)
        }
    }
}

struct PostingTuitView_Previews: PreviewProvider {
    static var previews: some View {
        PostingTuitView()
            
    }
}
