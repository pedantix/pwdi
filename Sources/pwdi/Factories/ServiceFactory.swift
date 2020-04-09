//
//  ServiceFactory.swift
//  
//
//  Created by Shaun Hubbard on 4/8/20.
//

import Foundation

public protocol ServiceFactory {
    var types: [Any.Type] { get }
    func get(container: Container) throws -> Service
}
