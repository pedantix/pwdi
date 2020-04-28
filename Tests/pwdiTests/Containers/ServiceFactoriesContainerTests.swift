//
//  ServiceFactoriesContainerTests.swift
//  
//
//  Created by Shaun Hubbard on 4/27/20.
//

import Foundation
import XCTest

@testable import pwdi

private extension Qualifier {
  static let myQualifier = Qualifier(name: "my_qual")
}

final class ServiceFactoriesContainerTests: XCTestCase {
  func testSearch_throwsWhenContainerIsEmpty() {
    let container = ServiceFactoriesContainer(serviceFactories: [])

    let requestedServiceID = ServiceID(qualifier: .default, type: Any.Type.self)
    try XCTAssertThrowsError({ try container.search(serviceID: requestedServiceID) }())
  }

  func testSearch_findsCorrectService_qualifierDistinguished() throws {
    let serviceA = ClassBoundInjectable()
    let serviceB = ClassBoundInjectable()

    let serviceFactory = PrototypeFactory(service: Service({ _ in serviceA }))
    let serviceFactory2 = PrototypeFactory(service: Service({ _ in serviceB }).qualifier(.myQualifier))

    let container = ServiceFactoriesContainer(serviceFactories: [serviceFactory, serviceFactory2].shuffled())

    let retrievedServiceFactory = try container.search(
      serviceID: .init(qualifier: .default, type: ClassBoundInjectable.self)
    )
    let retrievedServiceFactory2 = try container.search(
      serviceID: .init(qualifier: .myQualifier, type: ClassBoundInjectable.self)
    )

    XCTAssertEqual(ObjectIdentifier(retrievedServiceFactory), ObjectIdentifier(serviceFactory))
    XCTAssertEqual(ObjectIdentifier(retrievedServiceFactory2), ObjectIdentifier(serviceFactory2))
  }

  func testSearch_findsCorrectService_interfaceDistinguished() throws {
    let serviceA = ClassBoundInjectable()
    let serviceB = ClassBoundInjectable2()

    let serviceFactory = PrototypeFactory(service: Service({ _ in serviceA }))
    let serviceFactory2 = PrototypeFactory(service: Service({ _ in serviceB }))

    let container = ServiceFactoriesContainer(serviceFactories: [serviceFactory, serviceFactory2].shuffled())

    let retrievedServiceFactory = try container.search(
      serviceID: .init(qualifier: .default, type: ClassBoundInjectable.self)
    )
    let retrievedServiceFactory2 = try container.search(
      serviceID: .init(qualifier: .default, type: ClassBoundInjectable2.self)
    )

    XCTAssertEqual(ObjectIdentifier(retrievedServiceFactory), ObjectIdentifier(serviceFactory))
    XCTAssertEqual(ObjectIdentifier(retrievedServiceFactory2), ObjectIdentifier(serviceFactory2))
  }

  func testSearch_handlesDuplicates_byThrowing() throws {
    let serviceA = ClassBoundInjectable()
    let serviceB = ClassBoundInjectable()

    let serviceFactory = PrototypeFactory(service: Service({ _ in serviceA }))
    let serviceFactory2 = PrototypeFactory(service: Service({ _ in serviceB }))

    let container = ServiceFactoriesContainer(serviceFactories: [serviceFactory, serviceFactory2].shuffled())

    try XCTAssertThrowsError({
      try container.search(serviceID: .init(qualifier: .default, type: ClassBoundInjectable.self))
    }())
  }

  func testSearch_handlesNotFound_byThrowing() throws {
    let serviceA = ClassBoundInjectable()
    let serviceB = ServiceA()

    let serviceFactory = PrototypeFactory(service: Service({ _ in serviceA }))
    let serviceFactory2 = PrototypeFactory(service: Service({ _ in serviceB }))

    let container = ServiceFactoriesContainer(serviceFactories: [serviceFactory, serviceFactory2].shuffled())

    try XCTAssertThrowsError({
      try container.search(serviceID: .init(qualifier: .default, type: ClassBoundInjectable2.self))
    }())
  }

  static let allTests = [
    ("testSearch_throwsWhenContainerIsEmpty", testSearch_throwsWhenContainerIsEmpty),
    ("testSearch_findsCorrectService_qualifierDistinguished", testSearch_findsCorrectService_qualifierDistinguished),
    ("testSearch_findsCorrectService_interfaceDistinguished", testSearch_findsCorrectService_interfaceDistinguished),
    ("testSearch_handlesDuplicates_byThrowing", testSearch_handlesDuplicates_byThrowing),
    ("testSearch_handlesNotFound_byThrowing", testSearch_handlesNotFound_byThrowing)
  ]
}
