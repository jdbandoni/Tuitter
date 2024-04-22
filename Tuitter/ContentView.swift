//
//  ContentView.swift
//  Tuitter
//
//  Created by Joni Bandoni on 19/04/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authorization: Authorization
    
    var body: some View {
        if authorization.isLoggedIn {
            TimelineView()
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Authorization.shared)
    }
}
