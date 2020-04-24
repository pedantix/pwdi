//
//  Service.swift
//  
//
//  Created by Shaun Hubbard on 4/19/20.
//

import Foundation

public struct Service: ServiceHasher {
  internal let types: [Any.Type]
  internal let serviceBlock: ServiceClosure
  internal private(set) var qualifier: Qualifier = .default

  public init<T: Injectable>(_ block: @escaping (Container) -> T) {
    serviceBlock = block
    types = [T.self]
  }

  public init(type: Any.Type, _ block: @escaping ServiceClosure) {
    serviceBlock = block
    types = [type]
  }

  public init(types: [Any.Type], _ block: @escaping ServiceClosure) {
    self.types = types
    serviceBlock = block
  }

  public mutating func qualifier(_ qual: Qualifier) -> Service {
    self.qualifier = qual
    return self
  }

  internal var servicesHashes: [Int] {
    return  self.types.map { calculateServiceHash(qualifier: self.qualifier, type: $0) }
  }
}
