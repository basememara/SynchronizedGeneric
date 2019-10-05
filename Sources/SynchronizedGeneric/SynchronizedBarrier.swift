//
//  SynchronizedBarrier.swift
//  
//
//  Created by Basem Emara on 2019-10-05.
//

import Foundation

public struct SynchronizedBarrier<Value> {
    private let mutex = DispatchQueue(label: "io.zamzam.SynchronizedBarrier", attributes: .concurrent)
    private var _value: Value
 
    public init(_ value: Value) {
        self._value = value
    }
 
    public var value: Value { mutex.sync { _value } }
 
    public mutating func value<T>(execute task: (inout Value) throws -> T) rethrows -> T {
        try mutex.sync(flags: .barrier) { try task(&_value) }
    }
}
