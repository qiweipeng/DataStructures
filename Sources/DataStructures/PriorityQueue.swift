//
//  File.swift
//  
//
//  Created by Weipeng Qi on 2020/3/31.
//

import Foundation

/*
 优先队列
 
 优先队列的出队操作和入队操作复杂度均为 O(logn)。
 */
public struct PriorityQueue<T> {
    
    private var heap: Heap<T>
    
    /// 构造函数。
    /// - Parameter sort: 排序标准。
    public init(sort: @escaping (T, T) -> Bool) {
        heap = Heap(sort: sort)
    }
    
    /// 队列是否为空。
    /// - Complexity: O(1)
    public var isEmpty: Bool {
        return heap.isEmpty
    }
    
    /// 队列元素数量。
    /// - Complexity: O(1)
    public var count: Int {
        return heap.count
    }
    
    /// 入队。
    /// - Complexity: O(logn)
    /// - Parameter element: 入队的元素。
    public mutating func enqueue(_ element: T) {
        heap.insert(element)
    }
    
    /// 出队。
    /// - Complexity: O(logn)
    /// - Returns: 出队的元素。
    @discardableResult
    public mutating func dequeue() -> T? {
        return heap.remove()
    }
    
    /// 查看队首元素。
    /// - Complexity: O(1)
    public var front: T? {
        return heap.peek()
    }
}
