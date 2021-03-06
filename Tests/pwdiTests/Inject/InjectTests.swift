//
//  InjectTests.swift
//
//
//  Created by Shaun Hubbard on 4/30/20.
//

import Foundation
import XCTest
import pwdi
#if canImport(Darwin)
import Nimble
#endif

private class DummyClass {
  @Inject var serviceA: ServiceA
  @Inject var classBoundInjectable: ClassBoundInjectable
}

final class InjectTests: GlobalContainerTestCase {
  func testInjectingWhenObjectDoesNotExist() {
     // TODO: Fix this once nimble 9 will load
    /*
    #if canImport(Darwin)
    expect { () -> Void in
        _ = DummyClass().serviceA
    }.to(throwAssertion())
    #endif*/
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
    ("testInjectingWhenObjectDoesExist", testInjectingWhenObjectDoesExist),
    ("testPrototypePersistAmongstInstaces", testPrototypePersistAmongstInstaces),
    ("testPrototypePersistAmongstInstaces", testPrototypePersistAmongstInstaces)
  ]
}
