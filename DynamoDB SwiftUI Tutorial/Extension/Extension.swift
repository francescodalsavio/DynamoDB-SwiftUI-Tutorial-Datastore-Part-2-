//
//  Extension.swift
//  DynamoDB SwiftUI Tutorial
//
//  Created by Francesco Dal Savio on 24/10/2020.
//

import Foundation

extension Contact: Identifiable {}

extension Contact: Equatable {
    public static func ==(lhs: Contact, rhs: Contact) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.surname == rhs.surname && lhs.image == rhs.image
    }
}

extension Contact: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
