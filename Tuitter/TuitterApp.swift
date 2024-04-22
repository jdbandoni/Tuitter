//
//  TuitterApp.swift
//  Tuitter
//
//  Created by Joni Bandoni on 19/04/2024.
//

import SwiftUI

@main
struct TuitterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Authorization.shared)
        }
    }
}
