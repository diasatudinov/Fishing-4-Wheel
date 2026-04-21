//
//  FWTalk.swift
//  Fishing 4 Wheel
//
//

import Foundation

struct Talk: Identifiable, Hashable, Codable {
    let id: Int
    let title: String
    let description: String
    let imageName: String
}

struct TalkModel: Identifiable, Hashable, Codable {
    let id = UUID()
    let talk: Talk
    let description: String
    let didItWork: Bool
    let createdAt: Date = .now
}
