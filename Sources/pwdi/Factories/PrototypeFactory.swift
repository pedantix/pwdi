//
//  PrototypeFactory.swift
//  
//
//  Created by Shaun Hubbard on 4/8/20.
//

import Foundation

struct PrototypeFactory: ServiceFactory {
  var service: Service

  func get(container: Container) throws -> Injectable {
    return try service.serviceBlock(container)
  }
}
