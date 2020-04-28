//
//  PrototypeFactory.swift
//  
//
//  Created by Shaun Hubbard on 4/8/20.
//

import Foundation

final class PrototypeFactory: ServiceFactory {
  internal init(service: Service) {
    self.service = service
  }

  var service: Service

  func get(container: Container) throws -> Any {
    return try service.serviceBlock(container)
  }
}
