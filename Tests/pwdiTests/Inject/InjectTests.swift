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
  @Inject var serviceA: MyCoolService
  @Inject(qualifier: .cooler) var serviceB: MyCoolService
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
      Singleton {
        Service(types: [MyCoolService.self, ServiceA.self]) { _ in ServiceA() }
        Service(types: [MyCoolService.self, ServiceB.self]) { _ in ServiceB() }.qualifier(.cooler)
      }
    }

      XCTAssertNotNil(DummyClass().serviceA)
      XCTAssertTrue(DummyClass().serviceA is ServiceA)
      XCTAssertTrue(DummyClass().serviceB is ServiceB)
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

extension Qualifier {
    static let cooler = Qualifier(name: "cooler")
}
