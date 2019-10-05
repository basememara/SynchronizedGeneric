//
//  SynchronizedSemaphore.swift
//
//
//  Created by Basem Emara on 2019-10-05.
//

import Foundation

public struct SynchronizedSemaphore<Value> {
    private let mutex = DispatchSemaphore(value: 1)
    private var _value: Value
 
    public init(_ value: Value) {
        self._value = value
    }
 
    public var value: Value {
        mutex.lock { _value }
    }
 
    public mutating func value(execute task: (inout Value) -> Void) {
        mutex.lock { task(&_value) }
    }
}
 
private extension DispatchSemaphore {
    
    func lock<T>(execute task: () throws -> T) rethrows -> T {
        wait()
        defer { signal() }
        return try task()
    }
}
