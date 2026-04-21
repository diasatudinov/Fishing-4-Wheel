//
//  Entertainment.swift
//  Fishing 4 Wheel
//
//

import SwiftUI

struct Entertainment: Identifiable, Hashable, Codable {
    let id: Int
    let title: String
    let imageName: String
}

struct Company: Identifiable, Hashable, Codable {
    let id: Int
    let title: String
    let imageName: String
}

struct Duration: Identifiable, Hashable, Codable {
    let id: Int
    let title: String
    let imageName: String
}

struct SpinCombo: Identifiable, Hashable, Codable {
    let id: UUID
    let entertainment: Entertainment
    let company: Company
    let duration: Duration
    let createdAt: Date
    
    init(
        id: UUID = UUID(),
        entertainment: Entertainment,
        company: Company,
        duration: Duration,
        createdAt: Date = .now
    ) {
        self.id = id
        self.entertainment = entertainment
        self.company = company
        self.duration = duration
        self.createdAt = createdAt
    }
}
