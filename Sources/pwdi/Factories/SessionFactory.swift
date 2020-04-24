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

  func get(container: Container) throws -> Injectable {
    return try threadSafeExecute {
      try service.serviceBlock(container)
    }
  }
}
