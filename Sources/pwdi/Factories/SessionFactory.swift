//
//  SessionFactory.swift
//  
//
//  Created by Shaun Hubbard on 4/23/20.
//

import Foundation

struct SessionFactory: ServiceFactory {
  var service: Service

  func get(container: Container) throws -> Injectable {
    return try service.serviceBlock(container)
  }
}
