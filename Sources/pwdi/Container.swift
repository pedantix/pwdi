//
//  Container.swift
//  
//
//  Created by Shaun Hubbard on 4/7/20.
//

public protocol Container {
    /// Make a service based on an interface.
    func make<S: Injectable>(_ type: S.Type) throws -> S
}
