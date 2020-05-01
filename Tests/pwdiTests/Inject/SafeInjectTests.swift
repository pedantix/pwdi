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

  static var allTests = [
    ("testInjectingWhenObjectDoesNotExist", testInjectingWhenObjectDoesNotExist),
    ("testInjectingWhenObjectDoesExist", testInjectingWhenObjectDoesExist)
  ]
}
