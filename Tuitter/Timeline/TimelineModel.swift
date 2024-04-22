//
//  TimelineModel.swift
//  Tuitter
//
//  Created by Joni Bandoni on 19/04/2024.
//

import Foundation

// MARK: - TimelineModel
struct TimelineModel: Codable {
    let tuits: [Tuit]
    
    static let empty: TimelineModel = .init(tuits: [])
}

// MARK: - Tuit
struct Tuit: Codable {
    let ts: Int
    let text: String
    let username: String
    let profileName: String
    let profilePic: String
    let template: Template
    let likes: Int
    let replyTo: Int?
    let replyToUsername: String?
    
    static let empty: Tuit = .init(ts: 1687357676717,
                                   text: "probando de nuevo!",
                                   username: "@emascv",
                                   profileName: "Emascv",
                                   profilePic: "https://robohash.org/emascv.png",
                                   template: .init(dark: .init(backgroundColor: "#000000", textColor: "#ffffff"), light: .init(template: "#000000", backgroundColor: "#ffffff", textColor: "#ffffff")), likes: 10, replyTo: 0, replyToUsername: "@quienteconoce")
}

// MARK: - Template
struct Template: Codable {
    let dark: Dark?
    let light: Light?

}

// MARK: - Dark
struct Dark: Codable {
    let backgroundColor, textColor: String
}

// MARK: - Light
struct Light: Codable {
    let template: String?
    let backgroundColor: String?
    let textColor: String
}

