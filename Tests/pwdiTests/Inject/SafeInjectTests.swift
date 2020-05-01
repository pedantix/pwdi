//
//  SafeInjectTests.swift
//  
//
//  Created by Shaun Hubbard on 4/30/20.
//

import Foundation
import XCTest
import pwdi

private class DummyClass {
  @SafeInject var serviceA: ServiceA?
  @SafeInject var classBoundInjectable: ClassBoundInjectable?
}

final class SafeInjectTests: GlobalContainerTestCase {
  func testInjectingWhenObjectDoesNotExist() {
    XCTAssertNil(DummyClass().serviceA)
  }

  func testInjectingWhenObjectDoesExist() {
    GlobalContainer {
      Prototype {
        Service { _ in ServiceA() }
      }
    }

    XCTAssertNotNil(DummyClass().serviceA)
  }

  func testPrototypePersistAmongstInstaces() {
    GlobalContainer {
      Prototype {
        Service { _ in ClassBoundInjectable() }
      }
    }

    let dummyOne = DummyClass()
    XCTAssertEqual(dummyOne.classBoundInjectable, dummyOne.classBoundInjectable)

    let dummyTwo = DummyClass()
    XCTAssertNotEqual(dummyOne.classBoundInjectable, dummyTwo.classBoundInjectable)
  }

  static var allTests = [
    ("testInjectingWhenObjectDoesNotExist", testInjectingWhenObjectDoesNotExist),
    ("testInjectingWhenObjectDoesExist", testInjectingWhenObjectDoesExist)
  ]
}
