//
//  Authorization.swift
//  Tuitter
//
//  Created by Joni Bandoni on 20/04/2024.
//

import Foundation
import SwiftUI

final class Authorization: ObservableObject {
    
    //TODO: move out this
    var profilePic: String = ""
    
    var accessToken: String = "" {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isLoggedIn = !self.accessToken.isEmpty
            }
        }
    }
    var tokenType: String = ""
    
    //This could leave in the AppDelegate to avoid using a singleton
    static let shared = Authorization()
    
    @Published var isLoggedIn: Bool = false
    
}
