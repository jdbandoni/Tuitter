//
//  LoginView.swift
//  Tuitter
//
//  Created by Joni Bandoni on 19/04/2024.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            ZStack (alignment: .leading) {
                Text("username")
                    .foregroundColor(viewModel.username.isEmpty ? Color(.placeholderText) : .gray)
                    .offset(y: viewModel.username.isEmpty ? -6 : -20)
                    .scaleEffect(viewModel.username.isEmpty ? 1 : 0.8, anchor: .leading)
                    .font(viewModel.username.isEmpty ? .body : .caption)
                    .padding(.leading, 4)
                TextField("", text: $viewModel.username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .frame(width: 200, height: 40)
                    .offset(y: viewModel.username.isEmpty ? -6 : 0)
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.gray,lineWidth: 1).offset(y: -6))
                
            }
            .animation(.default, value: UUID())
            
            ZStack (alignment: .leading) {
                Text("password")
                    .foregroundColor(viewModel.password.isEmpty ? Color(.placeholderText) : .gray)
                    .offset(y: viewModel.password.isEmpty ? -6 : -20)
                    .scaleEffect(viewModel.password.isEmpty ? 1 : 0.8, anchor: .leading)
                    .font(viewModel.password.isEmpty ? .body : .caption)
                    .padding(.leading, 4)
                SecureField("", text: $viewModel.password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .textContentType(.password)
                    .frame(width: 200, height: 40)
                    .offset(y: viewModel.password.isEmpty ? -6 : 0)
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.gray,lineWidth: 1).offset(y: -6))
                
            }
            .animation(.default, value: UUID())
            
            if (viewModel.isLoading) {
                ProgressView()
            } else {
                Button(action: {
                    Task {
                        await viewModel.login()
                    }
                }, label: {
                    Text("Login")
                        .frame(width: 200, height: 30)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .font(.caption)
                        .bold()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                })
            }
            Spacer()
        }.padding(4)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
