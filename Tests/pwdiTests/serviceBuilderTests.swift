//
//  serviceBuilderTests.swift
//  
//
//  Created by Shaun Hubbard on 4/8/20.
//


import Foundation
import XCTest
import pwdi

private protocol NotAService { }

final class  serviceBuilderTests: XCTestCase {
  func testCapturingAService() {
    let serv = ServiceA()
    let serviceCapture = service(ServiceA.self) { _ in serv }
    XCTAssertEqual(serviceCapture.types.count, 1)
    serviceCapture.types.forEach { type in
        XCTAssert(ObjectIdentifier(type) == ObjectIdentifier(ServiceA.self))
    }
  }

  func testImplicitlyCapturingAService() {
    let serv = ServiceA()
    let serviceCapture = service { _ in serv }
    XCTAssertEqual(serviceCapture.types.count, 1)
    serviceCapture.types.forEach { type in
        XCTAssert(ObjectIdentifier(type) == ObjectIdentifier(ServiceA.self))
    }
  }

  func testCapturingAServiceWithMultipleTypes() {
    let serv = ServiceA()
    let serviceCapture = service([MyCoolService.self, ServiceA.self]) { _ in serv }
    XCTAssertEqual(serviceCapture.types.count, 2)
    serviceCapture.types.first.map { type in
        XCTAssert(ObjectIdentifier(type) == ObjectIdentifier(MyCoolService.self))
    }
    serviceCapture.types.last.map { type in
        XCTAssert(ObjectIdentifier(type) == ObjectIdentifier(ServiceA.self))
    }
  }
  

  static var allTests = [
      ("testCapturingAService", testCapturingAService),
      ("testImplicitlyCapturingAService", testImplicitlyCapturingAService),
      ("testCapturingAServiceWithMultipleTypes", testCapturingAServiceWithMultipleTypes),
  ]
}
