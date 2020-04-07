//
//  Container.swift
//  
//
//  Created by Shaun Hubbard on 4/7/20.
//

protocol Container {
    func make<S>(_ type: S.Type) -> S
}
