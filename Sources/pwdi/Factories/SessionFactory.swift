//
//  SessionFactory.swift
//  
//
//  Created by Shaun Hubbard on 4/23/20.
//

import Foundation

final class SessionFactory: ServiceFactory {
  internal init(service: Service) {
    self.service = service
  }

  var service: Service

  private var resolvedObject: Any?

  func get(container: Container) throws -> Any {
    if let injectable = resolvedObject {
      return injectable
    }

    let object = try service.serviceBlock(container)

    resolvedObject = object

    return object
  }

  internal func sessionChanged() {
    resolvedObject = nil
  }
}
