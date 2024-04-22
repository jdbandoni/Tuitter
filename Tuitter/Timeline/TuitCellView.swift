//
//  TuitCellView.swift
//  Tuitter
//
//  Created by Joni Bandoni on 19/04/2024.
//

import SwiftUI

struct TuitCellView: View {
    
    @ObservedObject var viewModel: TuitCellViewModel
    
    @State private var isLiked = false
    @Binding var isThreadButtonTapped: Bool
    @Binding var replyTo: Tuit?
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                UserImageView(iconURLString: viewModel.tuitData.profilePic).padding(5)
                VStack (alignment: .leading) {
                    Text(viewModel.tuitData.username)
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                    if let replyUsername = viewModel.tuitData.replyToUsername {
                        Text("in reply to \(replyUsername)")
                            .font(.subheadline)
                    }
                }
            }
            Text(viewModel.tuitData.text)
                .font(.footnote)
            Text("\(viewModel.creationDate,formatter: viewModel.dateFormatter)")
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundColor(Color.gray)
                .padding(2)
            Divider()
            (Text(viewModel.formattedLikes)
                .bold()
                .font(.footnote) +
             Text(" Me gusta")
                .foregroundColor(.gray)
                .font(.footnote)).padding(2)
            Divider()
            HStack {
                Spacer()
                Button {
                    isThreadButtonTapped = true
                    replyTo = viewModel.tuitData
                } label: {
                    Image(systemName: "message")
                }.buttonStyle(.plain)
                Spacer()
                Button {
                    isLiked.toggle()
                    Task {
                        await viewModel.like(isLiked)
                    }
                } label: {
                    if isLiked {
                        Image(systemName: "heart.fill").foregroundColor(.blue)
                    } else {
                        Image(systemName: "heart").foregroundColor(.black)
                    }
                }.buttonStyle(.borderless)
                Spacer()
            }.padding(2)
        }
        .padding(4)
    }
}

struct TuitCellView_Previews: PreviewProvider {
    static var previews: some View {
        TuitCellView(viewModel: TuitCellViewModel(), isThreadButtonTapped: .constant(false),replyTo: .constant(.empty))
            .previewLayout(.sizeThatFits)
    }
}
