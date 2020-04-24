//
//  PrototypeFactoryTests.swift
//  
//
//  Created by Shaun Hubbard on 4/24/20.
//

import Foundation
import XCTest
@testable import pwdi

private let testService = Service { _ in
  ClassBoundInjectable()
}

final class PrototypeFactoryTests: XCTestCase {
  func testGet_createsInjectible() throws {
    let factory = PrototypeFactory(service: testService)
    let injectable = try factory.get(container: DummyContainer())
    XCTAssertTrue(injectable is ClassBoundInjectable)
  }

  func testGet_createsAUniqueInjectibleEachTime() throws {
    let factory = PrototypeFactory(service: testService)
    let container = DummyContainer()
    let injectable = try factory.get(container: container) as AnyObject
    let injectable2 = try factory.get(container: container) as AnyObject
    XCTAssertFalse(injectable === injectable2)
  }

  static var allTests = [
    ("testGet_createsInjectible", testGet_createsInjectible),
    ("testGet_createsAUniqueInjectibleEachTime", testGet_createsAUniqueInjectibleEachTime)
  ]
}
