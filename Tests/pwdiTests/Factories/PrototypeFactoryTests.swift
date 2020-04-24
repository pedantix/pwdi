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
    let prototypeFactory = PrototypeFactory(service: testService)
    let injectable = try prototypeFactory.get(container: DummyContainer())
    XCTAssertTrue(injectable is ClassBoundInjectable)
  }

  func testGet_createsAUniqueInjectibleEachTime() throws {
    let prototypeFactory = PrototypeFactory(service: testService)
    let container = DummyContainer()
    let injectable = try prototypeFactory.get(container: container) as AnyObject
    let injectable2 = try prototypeFactory.get(container: container) as AnyObject
    XCTAssertFalse(injectable === injectable2)
  }

  static var allTests = [
    ("testGet_createsInjectible", testGet_createsInjectible),
    ("testGet_createsAUniqueInjectibleEachTime", testGet_createsAUniqueInjectibleEachTime)
  ]
}
