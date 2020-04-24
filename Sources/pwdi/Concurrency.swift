//
//  Concurrency.swift
//  
//
//  Created by Shaun Hubbard on 4/24/20.
//

import Foundation

private let queueLabel = "com.pwdi.DispatchQueue"

private let queue: DispatchQueue = {
  let queue = DispatchQueue(label: queueLabel)
  queue.setSpecific(key: queueSpecific, value: UUID())
  return queue
}()

private let queueSpecific: DispatchSpecificKey<UUID> = .init()

private var isExecutingOnQueue: Bool {
  return  DispatchQueue.getSpecific(key: queueSpecific) == nil
}

// NOTE: - The following function is "slow and expensive" and its usage should be minimized/
/// An internal function to handle thread/queue safe creation of service objects
internal func threadSafeExecute<T>(_ block: ()  throws -> T) throws -> T {
  guard isExecutingOnQueue else { return try block() }
  var result: Result<T, Error> = .failure(ServiceError.noServiceFound())
  queue.sync {
    do {
      result = .success(try block())
    } catch {
      result = .failure(error)
    }
  }
  switch result {
  case let.success(thing):
    return thing
  case let.failure(error):
    throw error
  }
}
