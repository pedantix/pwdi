//
//  TestHelpers.swift
//  
//
//  Created by Shaun Hubbard on 4/8/20.
//

import Foundation
import pwdi

protocol MyCoolService: Injectable { }

struct ServiceA: Equatable, Injectable, MyCoolService {
    var serviceId = 1
}

struct ServiceB: Equatable, Injectable, MyCoolService {
    var serviceId = 2
}

final class ClassBoundInjectable: Injectable {

}

final class DummyContainer: Container {
  func make<S>(_ type: S.Type) throws -> S where S: Injectable {
    fatalError("this is not implemented")
  }
}
