//
//  ServiceHasher.swift
//  
//
//  Created by Shaun Hubbard on 4/24/20.
//

import Foundation

protocol ServiceHasher {
  func calculateServiceHash(qualifier: Qualifier, type: Any.Type) -> Int
}

extension ServiceHasher {
  func calculateServiceHash(qualifier: Qualifier, type: Any.Type) -> Int {
    return ServiceHashFactory(qualifier: qualifier, type: type).hashValue
  }
}

private struct ServiceHashFactory: Hashable {
  static func == (lhs: ServiceHashFactory, rhs: ServiceHashFactory) -> Bool {
    return lhs.type as AnyObject === rhs.type as AnyObject && lhs.qualifier == rhs.qualifier
  }

  let qualifier: Qualifier
  let type: Any.Type

  func hash(into hasher: inout Hasher) {
    hasher.combine(ObjectIdentifier(type))
    hasher.combine(qualifier)
  }
}
