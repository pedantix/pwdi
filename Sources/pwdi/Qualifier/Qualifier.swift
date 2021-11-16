//
//  Qualifier.swift
//  
//
//  Created by Shaun Hubbard on 4/24/20.
//

import Foundation

public struct Qualifier {
    let name: String

    public init(name: String) {
        self.name = name
    }
}

extension Qualifier {
  public static let `default` = Qualifier(name: "default")
}

extension Qualifier: Equatable {
  public static func == (lhs: Qualifier, rhs: Qualifier) -> Bool {
    return lhs.name == rhs.name
  }
}

extension Qualifier: Hashable { }
