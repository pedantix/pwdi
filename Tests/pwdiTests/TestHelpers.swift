//
//  TestHelpers.swift
//  
//
//  Created by Shaun Hubbard on 4/8/20.
//

import Foundation
import XCTest
@testable import pwdi

protocol MyCoolService { }

struct ServiceA: Equatable, MyCoolService {
    var serviceId = 1
}

struct ServiceB: Equatable, MyCoolService {
    var serviceId = 2
}

struct ServiceC {
  let serviceA: ServiceA
  let serviceB: ServiceB
}

struct ServiceD {
  let serviceC: ServiceC
}

final class ClassBoundInjectable: MyCoolService, Equatable {
  let uuid = UUID()
  static func == (_ rhs: ClassBoundInjectable, _ lhs: ClassBoundInjectable) -> Bool {
    return rhs.uuid == lhs.uuid
  }
}

final class ClassBoundInjectable2: MyCoolService {

}

final class DummyContainer: Container {
  func make<S>(_ type: S.Type) throws -> S {
    fatalError("this is not implemented")
  }

  func make<S>(_ type: S.Type, qualifier: Qualifier) throws -> S {
    fatalError("this is not implemented")
  }

  init?(_ block: () -> [ServiceFactory]) {
    fatalError("nyi")
  }

  init() {  }

  func resetSession() {
    fatalError("nyi")
  }
}

class DummyServiceFactory: ServiceFactory {
  var service: Service {
    fatalError("nyi")
  }

  func get(container: Container) throws -> Any {
    fatalError("nyi")
  }
}

class GlobalContainerTestCase: XCTestCase {
  override func setUp() {
    super.setUp()
    GlobalContainer.resetGlobalContainer()
  }
}
