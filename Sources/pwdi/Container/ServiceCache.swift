//
//  ServiceCache.swift
//  
//
//  Created by Shaun Hubbard on 4/27/20.
//

import Foundation

/// holds and stores a cache of resolved service factores
class ServiceCache {
  private var serviceCache = [ServiceID: Result<ServiceFactory, Error>]()

  func putSuccess(_ serviceID: ServiceID, factory: ServiceFactory) {
    serviceCache[serviceID] = .success(factory)
  }

  func putFailure(_ serviceID: ServiceID, error: Error) {
    serviceCache[serviceID] = .failure(error)
  }

  func check(for serviceID: ServiceID) -> Result<ServiceFactory, Error>? {
    return serviceCache[serviceID]
  }
}
