//
//  SingletonFactory.swift
//  
//
//  Created by Shaun Hubbard on 4/23/20.
//

import Foundation

final class SingletonFactory: ServiceFactory {
  internal init(service: Service) {
    self.service = service
  }

  var service: Service

  private var resolvedInjectable: Injectable?

  func get(container: Container) throws -> Injectable {
    if let injectable = resolvedInjectable {
      return injectable
    }

    let injectable = try threadSafeExecute {
      try service.serviceBlock(container)
    }

    resolvedInjectable = injectable

    return injectable
  }
}
