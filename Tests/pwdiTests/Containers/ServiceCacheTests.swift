//
//  ServiceCacheTests.swift
//  
//
//  Created by Shaun Hubbard on 4/28/20.
//

import Foundation
import XCTest
@testable import pwdi

final class ServiceCacheTests: XCTestCase {
  func testCheck_whenServiceIDisNotPartOfServiceCache() {
    let serviceCache = ServiceCache()
    let serviceID = ServiceID(qualifier: .default, type: ServiceA.self)
    XCTAssertNil(serviceCache.check(for: serviceID))
  }

  func testCheck_andPutSuccess() {
    let serviceFactory = DummyServiceFactory()
    let serviceCache = ServiceCache()
    let serviceID = ServiceID(qualifier: .default, type: ServiceA.self)

    serviceCache.putSuccess(serviceID, factory: serviceFactory)

    guard let result = serviceCache.check(for: serviceID) else {
      return XCTFail("Service ID should return a value")
    }

    switch result {
    case let.success(factory):
      XCTAssertEqual(ObjectIdentifier(serviceFactory), ObjectIdentifier(factory))
    case .failure:
      XCTFail("There should be no failure")
    }
  }

  func testCheck_andPutFailure() {
    let serviceError = ServiceError.noServiceFound()
    let serviceCache = ServiceCache()
    let serviceID = ServiceID(qualifier: .default, type: ServiceA.self)

    serviceCache.putFailure(serviceID, error: serviceError)

    guard let result = serviceCache.check(for: serviceID) else {
      return XCTFail("Service ID should return a value")
    }

    switch result {
    case let.failure(error):
      guard let serviceError = error as? ServiceError else { return XCTFail("Should be a service error") }
      XCTAssertEqual(ObjectIdentifier(serviceError), ObjectIdentifier(serviceError))
    case .success:
      XCTFail("There should be no failure")
    }
  }

  static let allTests = [
    ("testCheck_whenServiceIDisNotPartOfServiceCache", testCheck_whenServiceIDisNotPartOfServiceCache),
    ("testCheck_andPutSuccess", testCheck_andPutSuccess),
    ("testCheck_andPutFailure", testCheck_andPutFailure)
  ]
}
