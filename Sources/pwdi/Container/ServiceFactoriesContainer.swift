//
//  ServiceFactoriesContainer.swift
//  
//
//  Created by Shaun Hubbard on 4/27/20.
//

import Foundation

/// An ADT DataStructure that holds and stores services factories, and deals with search concerns
struct ServiceFactoriesContainer {
  let serviceFactories: ServiceFactories

  func search(serviceID: ServiceID) throws -> ServiceFactory {
    let matchingServiceFactories = serviceFactories.filter { $0.service.serviceIDs.contains(serviceID) }
    guard !matchingServiceFactories.isEmpty else {
      throw ServiceError.noServiceFound()
    }
    guard matchingServiceFactories.count == 1 else { throw ServiceError.duplicateServicesFound() }
    return matchingServiceFactories[0]
  }
}
