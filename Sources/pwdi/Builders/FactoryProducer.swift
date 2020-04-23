//
//  FactoryProducer.swift
//  
//
//  Created by Shaun Hubbard on 4/23/20.
//

import Foundation

typealias FactoryProducers = [FactoryProducer]

protocol FactoryProducer {
    var factories: ServiceFactories { get }
}
