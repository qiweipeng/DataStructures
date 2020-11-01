//
//  Queue.swift
//  
//
//  Created by Weipeng Qi on 2020/3/25.
//

import Foundation

/*
 队列
 
 使用数组实现，其中出队时数组的元素不会总是移动，出队的复杂度为 O(1)。
 */
public struct Queue<T> {
    
    private var array = [T?]()
    private var head = 0
    
    public init() {}
    
    /// 判断队列是否为空。
    /// - Complexity: O(1)
    public var isEmpty: Bool {
        return count == 0
    }
    
    /// 队列中元素数量。
    /// - Complexity: O(1)
    public var count: Int {
        return array.count - head
    }
    
    /// 入队。
    /// - Parameter element: 入队的元素。
    /// - Complexity: O(1)
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    /// 出队。
    /// - Complexity: O(1)
    /// - Returns: 队首元素。
    @discardableResult
    public mutating func dequeue() -> T? {
        guard head < array.count, let element = array[head] else { return nil }
        
        array[head] = nil
        head += 1
        
        let percentage = Double(head)/Double(array.count)
        if array.count > 50 && percentage > 0.25 {
            array.removeFirst(head)
            head = 0
        }
        
        return element
    }
    
    /// 查看队首元素。
    /// - Complexity: O(1)
    /// - Returns: 队首元素。
    public var front: T? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }
}

extension Queue: CustomStringConvertible {
    public var description: String {
        return "Queue: front " + Array(array.suffix(count)).map { $0! }.description + " tail"
    }
}
