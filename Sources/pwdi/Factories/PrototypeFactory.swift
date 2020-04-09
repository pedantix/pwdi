//
//  PrototypeFactory.swift
//  
//
//  Created by Shaun Hubbard on 4/8/20.
//

import Foundation

struct PrototypeFactory: ServiceFactory {
    var block: ServiceClosure
    var types: [Any.Type]

    func get(container: Container) throws -> Service {
        return try block(container)
    }
}
