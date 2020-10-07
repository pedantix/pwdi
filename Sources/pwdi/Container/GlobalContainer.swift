//
//  GlobalContainer.swift
//  
//
//  Created by Shaun Hubbard on 4/7/20.
//

import Foundation

/// The cotainer that is globally referencable within an application
internal var globalContainer: Container = GlobalContainer(serviceFactories: [])
private let defaultContainerServiceID = ServiceID(qualifier: .default, type: Container.self)
private let globalContainerServiceID = ServiceID(qualifier: .default, type: GlobalContainer.self)

public final class GlobalContainer: Container {
  internal init(serviceFactories: ServiceFactories) {
    let globalContainerFactory = SingletonFactory(
      // swiftlint:disable:next force_cast
      service: Service(types: [Container.self, GlobalContainer.self], { _ in globalContainer as! GlobalContainer })
    )

    self.serviceFactories = ServiceFactoriesContainer(serviceFactories: serviceFactories + [globalContainerFactory])
  }

  private let serviceFactories: ServiceFactoriesContainer
  private let serviceCache = ServiceCache()

  public func make<S>(_ type: S.Type) throws -> S {
    return try make(type, qualifier: .default)
  }

  public func make<S>(_ type: S.Type, qualifier: Qualifier) throws -> S {
    let serviceID = ServiceID(qualifier: qualifier, type: type)
    if let cacheResult = serviceCache.check(for: serviceID) {
      return try make(from: cacheResult)
    }

    return try threadSafeExecute {
      do {
        let serviceFactory = try serviceFactories.search(serviceID: serviceID)

        guard let service = try serviceFactory.get(container: self) as? S
          else { throw ServiceError.registrationError(type: S.self) }
        serviceCache.putSuccess(serviceID, factory: serviceFactory)
        return service
      } catch {
        serviceCache.putFailure(serviceID, error: error)
        throw error
      }
    }
  }

  public func resetSession() {
    serviceFactories.serviceFactories.compactMap { $0 as? SessionFactory }.forEach { $0.sessionChanged() }
  }

  @discardableResult
  public init?(@FactoryBuilder builder: @escaping () -> ServiceFactories) {
    globalContainer = GlobalContainer(serviceFactories: builder())
    return nil
  }

  @discardableResult
  public init?(@FactoryBuilder builder: @escaping () -> FactoryProducer) {
    globalContainer = GlobalContainer(serviceFactories: builder().factories)
    return nil
  }

  public static func resetGlobalContainer() {
    globalContainer = GlobalContainer(serviceFactories: [])
  }
}

extension GlobalContainer {
  func make<S>(from cacheResult: Result<ServiceFactory, Error>) throws -> S {

    switch cacheResult {
    case let.success(factory):
      // swiftlint:disable:next force_cast
      return try factory.get(container: self) as! S
    case let.failure(error):
      throw error
    }
  }
}
