//
//  ServiceFactory.swift
//  
//
//  Created by Shaun Hubbard on 4/8/20.
//

import Foundation

public protocol ServiceFactory {
    var service: Service { get }
    func get(container: Container) throws -> Injectable
}
