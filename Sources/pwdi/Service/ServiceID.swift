//
//  ServiceID.swift
//  
//
//  Created by Shaun Hubbard on 4/24/20.
//

import Foundation

internal struct ServiceID: Hashable {
  static func == (lhs: ServiceID, rhs: ServiceID) -> Bool {
    return lhs.type == rhs.type && lhs.qualifier == rhs.qualifier
  }

  let qualifier: Qualifier
  let type: Any.Type

  func hash(into hasher: inout Hasher) {
    hasher.combine(ObjectIdentifier(type))
    hasher.combine(qualifier)
  }
}
