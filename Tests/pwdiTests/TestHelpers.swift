//
//  TestHelpers.swift
//  
//
//  Created by Shaun Hubbard on 4/8/20.
//

import Foundation
import XCTest
@testable import pwdi

protocol MyCoolService: Injectable { }

struct ServiceA: Equatable, Injectable, MyCoolService {
    var serviceId = 1
}

struct ServiceB: Equatable, Injectable, MyCoolService {
    var serviceId = 2
}

struct ServiceC: Injectable {
  let serviceA: ServiceA
  let serviceB: ServiceB
}

struct ServiceD: Injectable {
  let serviceC: ServiceC
}

final class ClassBoundInjectable: MyCoolService, Injectable {

}

final class ClassBoundInjectable2: MyCoolService, Injectable {

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
}

class DummyServiceFactory: ServiceFactory {
  var service: Service {
    fatalError("nyi")
  }

  func get(container: Container) throws -> Injectable {
    fatalError("nyi")
  }
}

class GlobalContainerTestCase: XCTestCase {
  override func setUp() {
    super.setUp()
    GlobalContainer.resetGlobalContainer()
  }
}
