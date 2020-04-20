//
//  GlobalContainer.swift
//  
//
//  Created by Shaun Hubbard on 4/7/20.
//

import Foundation

/// The cotainer that is globally referencable within an application
var globalContainer: Container = GlobalContainer(serviceFactories: [])

struct GlobalContainer: Container {
    let serviceFactories: [ServiceFactory]

    func make<S>(_ type: S.Type) throws -> S {
        throw ServiceError.noServiceFound()
    }

  static func make(_ block: () -> [ServiceFactory]) {
    let serviceFactories = block()
    globalContainer = GlobalContainer(serviceFactories: serviceFactories)
  }
}
