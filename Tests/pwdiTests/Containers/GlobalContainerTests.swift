//
//  GlobalContainerTests.swift
//  
//
//  Created by Shaun Hubbard on 4/24/20.
//

import Foundation
import XCTest

@testable import pwdi

final class GlobalContainerTests: GlobalContainerTestCase {
  // test look up, default
  func testLookupInjectibleFromGlobalContainer() {
    let serviceA = ServiceA()
    GlobalContainer {
      Prototype {
        Service(types: [MyCoolService.self, ServiceA.self]) { _ in
          serviceA
        }
      }
    }

    try XCTAssertNotNil(globalContainer.make(MyCoolService.self, qualifier: .default))
    try XCTAssertNotNil(globalContainer.make(ServiceA.self))
  }

  func testContainerLookup() {
    try XCTAssertEqual(ObjectIdentifier(globalContainer.make(GlobalContainer.self)),
                       ObjectIdentifier(globalContainer as AnyObject))
    try XCTAssertEqual(ObjectIdentifier(globalContainer.make(Container.self)),
                       ObjectIdentifier(globalContainer as AnyObject))
  }

  func testMakingAComplexObject() {
    let exp1 = expectation(description: "1")
    let exp2 = expectation(description: "2")
    let exp3 = expectation(description: "3")
    let exp4 = expectation(description: "4")
    exp4.expectedFulfillmentCount = 1

    GlobalContainer {
      Prototype {
        Service(type: ServiceA.self) { _ in
          exp1.fulfill()
          return ServiceA()
        }

        Service(type: ServiceB.self) { _ in
          exp2.fulfill()
          return ServiceB()
        }
        Service(type: ServiceC.self) { container in
          exp3.fulfill()
          return try ServiceC(
            serviceA: container.make(ServiceA.self),
            serviceB: container.make(ServiceB.self)
          )
        }
      }

      Singleton {
        Service(type: ServiceD.self) { container in
          exp4.fulfill()
          return try ServiceD(serviceC: container.make(ServiceC.self))
        }
      }
    }

    try XCTAssertNotNil(globalContainer.make(ServiceD.self))

    try XCTAssertNotNil(globalContainer.make(ServiceD.self))

    waitForExpectations(timeout: 3, handler: nil)
  }

  func testMake_throwsErrorsOnNotFound() throws {
    try XCTAssertThrowsError({try globalContainer.make(ServiceA.self) }())
    try XCTAssertThrowsError({try globalContainer.make(ServiceA.self) }())
  }

  func testResetSession() throws {
    GlobalContainer {
      Session {
        Service { _ in ClassBoundInjectable() }
      }
    }
    let original = try globalContainer.make(ClassBoundInjectable.self)

    try XCTAssertEqual(ObjectIdentifier(original), ObjectIdentifier(globalContainer.make(ClassBoundInjectable.self)))

    globalContainer.resetSession()

    try XCTAssertNotEqual(ObjectIdentifier(original), ObjectIdentifier(globalContainer.make(ClassBoundInjectable.self)))
  }

  static let allTests = [
    ("testLookupInjectibleFromGlobalContainer", testLookupInjectibleFromGlobalContainer),
    ("testContainerLookup", testContainerLookup),
    ("testMakingAComplexObject", testMakingAComplexObject),
    ("testMake_throwsErrorsOnNotFound", testMake_throwsErrorsOnNotFound)
  ]
}
