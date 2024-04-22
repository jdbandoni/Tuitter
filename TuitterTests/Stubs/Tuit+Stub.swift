//
//  Tuit+Stub.swift
//  TuitterTests
//
//  Created by Joni Bandoni on 21/04/2024.
//

import Foundation
@testable import Tuitter

extension Tuit {
    static let testSample: Tuit = .init(ts: 1687357676717,
                                   text: "probando de nuevo!",
                                   username: "@emascv",
                                   profileName: "Emascv",
                                   profilePic: "https://robohash.org/emascv.png",
                                   template: .init(dark: .init(backgroundColor: "#000000", textColor: "#ffffff"), light: .init(template: "#000000", backgroundColor: "#ffffff", textColor: "#ffffff")), likes: 10, replyTo: 0, replyToUsername: "@quienteconoce")
}
