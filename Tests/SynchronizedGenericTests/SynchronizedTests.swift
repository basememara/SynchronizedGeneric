import XCTest
import SynchronizedGeneric

final class SynchronizedTests: XCTestCase {
    private let iterations = 1_000_000
    private let writeMultipleOf = 1000
}

extension SynchronizedTests {
    
    func testSynchronizedSerialWritePerformance() {
        var temp = SynchronizedSerial<Int>(0)
     
        measure {
            temp.value { $0 = 0 } // Reset
     
            DispatchQueue.concurrentPerform(iterations: iterations) { _ in
                temp.value { $0 += 1 }
            }
            
            XCTAssertEqual(temp.value, iterations)
        }
    }
    
    func testSynchronizedSerialReadPerformance() {
        var temp = SynchronizedSerial<Int>(0)
     
        measure {
            temp.value { $0 = 0 } // Reset
     
            DispatchQueue.concurrentPerform(iterations: iterations) {
                XCTAssertGreaterThanOrEqual(temp.value, 0)
                
                if $0.isMultiple(of: writeMultipleOf) {
                    temp.value { $0 += 1 }
                }
            }
            
            XCTAssertGreaterThanOrEqual(temp.value, 0)
        }
    }
}

extension SynchronizedTests {
    
    func testSynchronizedBarrierWritePerformance() {
        var temp = SynchronizedBarrier<Int>(0)
     
        measure {
            temp.value { $0 = 0 } // Reset
     
            DispatchQueue.concurrentPerform(iterations: iterations) { _ in
                temp.value { $0 += 1 }
            }
            
            XCTAssertEqual(temp.value, iterations)
        }
    }
    
    func testSynchronizedBarrierReadPerformance() {
        var temp = SynchronizedBarrier<Int>(0)
     
        measure {
            temp.value { $0 = 0 } // Reset
     
            DispatchQueue.concurrentPerform(iterations: iterations) {
                XCTAssertGreaterThanOrEqual(temp.value, 0)
                
                if $0.isMultiple(of: writeMultipleOf) {
                    temp.value { $0 += 1 }
                }
            }
            
            XCTAssertGreaterThanOrEqual(temp.value, 0)
        }
    }
}

extension SynchronizedTests {
    
    func testSynchronizedSemaphoreWritePerformance() {
        var temp = SynchronizedSemaphore<Int>(0)
     
        measure {
            temp.value { $0 = 0 } // Reset
     
            DispatchQueue.concurrentPerform(iterations: iterations) { _ in
                temp.value { $0 += 1 }
            }
            
            XCTAssertEqual(temp.value, iterations)
        }
    }
    
    func testSynchronizedSemaphoreReadPerformance() {
        var temp = SynchronizedSemaphore<Int>(0)
     
        measure {
            temp.value { $0 = 0 } // Reset
     
            DispatchQueue.concurrentPerform(iterations: iterations) {
                XCTAssertGreaterThanOrEqual(temp.value, 0)
                
                if $0.isMultiple(of: writeMultipleOf) {
                    temp.value { $0 += 1 }
                }
            }
            
            XCTAssertGreaterThanOrEqual(temp.value, 0)
        }
    }
}

extension SynchronizedTests {
    
    func testSynchronizedNSLockWritePerformance() {
        var temp = SynchronizedNSLock<Int>(0)
     
        measure {
            temp.value { $0 = 0 } // Reset
     
            DispatchQueue.concurrentPerform(iterations: iterations) { _ in
                temp.value { $0 += 1 }
            }
            
            XCTAssertEqual(temp.value, iterations)
        }
    }
    
    func testSynchronizedNSLockReadPerformance() {
        var temp = SynchronizedNSLock<Int>(0)
     
        measure {
            temp.value { $0 = 0 } // Reset
     
            DispatchQueue.concurrentPerform(iterations: iterations) {
                XCTAssertGreaterThanOrEqual(temp.value, 0)
                
                if $0.isMultiple(of: writeMultipleOf) {
                    temp.value { $0 += 1 }
                }
            }
            
            XCTAssertGreaterThanOrEqual(temp.value, 0)
        }
    }
}

extension SynchronizedTests {
    
    func testSynchronizedOSLockWritePerformance() {
        let temp = SynchronizedOSLock<Int>(0)
     
        measure {
            temp.value { $0 = 0 } // Reset
     
            DispatchQueue.concurrentPerform(iterations: iterations) { _ in
                temp.value { $0 += 1 }
            }
            
            XCTAssertEqual(temp.value, iterations)
        }
    }
    
    func testSynchronizedOSLockReadPerformance() {
        let temp = SynchronizedOSLock<Int>(0)
     
        measure {
            temp.value { $0 = 0 } // Reset
     
            DispatchQueue.concurrentPerform(iterations: iterations) {
                XCTAssertGreaterThanOrEqual(temp.value, 0)
                
                if $0.isMultiple(of: writeMultipleOf) {
                    temp.value { $0 += 1 }
                }
            }
            
            XCTAssertGreaterThanOrEqual(temp.value, 0)
        }
    }
}
