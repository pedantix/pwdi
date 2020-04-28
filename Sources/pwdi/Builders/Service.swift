//
//  Service.swift
//  
//
//  Created by Shaun Hubbard on 4/19/20.
//

import Foundation

public struct Service {
  internal let types: [Any.Type]
  internal let serviceBlock: ServiceClosure
  internal private(set) var qualifier: Qualifier = .default

  public init<T: Injectable>(_ block: @escaping (Container) throws -> T) {
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

  public func qualifier(_ qual: Qualifier) -> Service {
    var dup = self
    dup.qualifier = qual
    return dup
  }

  internal var serviceIDs: [ServiceID] {
    return  self.types.map { ServiceID(qualifier: self.qualifier, type: $0) }
  }
}
