//
//  ServiceTests.swift
//  
//
//  Created by Shaun Hubbard on 4/19/20.
//

import Foundation
import XCTest

@testable import pwdi

final class ServiceTests: XCTestCase {
  func testCapturingAService() {
    let service = Service { container in
      ServiceA()
    }

    XCTAssertEqual(service.types.count, 1)
    XCTAssertEqual(ObjectIdentifier(service.types.first ?? Any.self),  ObjectIdentifier(ServiceA.self))
  }

  func testImplicitlyCapturingAService() {
    let service = Service(type: MyCoolService.self) { container in
      ServiceA()
    }

    XCTAssertEqual(service.types.count, 1)
    XCTAssertEqual(ObjectIdentifier(service.types.first ?? Any.self),  ObjectIdentifier(MyCoolService.self))
  }

  func testCapturingAServiceWithMultipleTypes() {
    let service = Service(types: [MyCoolService.self, ServiceB.self]) { container in
      ServiceB()
    }

    XCTAssertEqual(service.types.count, 2)
    XCTAssertEqual(ObjectIdentifier(service.types.first ?? Any.self),  ObjectIdentifier(MyCoolService.self))
    XCTAssertEqual(ObjectIdentifier(service.types.last ?? Any.self),  ObjectIdentifier(ServiceB.self))
  }

  static var allTests = [
      ("testCapturingAService", testCapturingAService),
      ("testImplicitlyCapturingAService", testImplicitlyCapturingAService),
      ("testCapturingAServiceWithMultipleTypes", testCapturingAServiceWithMultipleTypes)
  ]
}
