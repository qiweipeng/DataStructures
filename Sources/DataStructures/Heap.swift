//
//  Heap.swift
//  
//
//  Created by Weipeng Qi on 2020/3/31.
//

import Foundation

/*
 堆
 */
public struct Heap<T> {
    
    private var nodes = [T]()
    
    // 排序标准。
    private var orderCriteria: (T, T) -> Bool
    
    /// 构造函数。
    /// - Parameter sort: 排序方式。
    public init(sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
    }
    
    /// Heapify 一个数组。
    /// - Parameters:
    ///   - array: 传入的数组。
    ///   - sort: 排序标准。
    /// - Complexity: O(n)
    public init(array: [T], sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
        configureHeap(from: array)
    }
    
    /// Heapify。
    /// - Parameter array: 需要 Heapify 的数组。
    /// - Complexity: O(n)
    private mutating func configureHeap(from array: [T]) {
        nodes = array
        for i in stride(from: (nodes.count / 2 - 1), through: 0, by: -1) {
            shiftDown(i)
        }
    }
    
    /// 堆是否为空。
    public var isEmpty: Bool {
        return nodes.isEmpty
    }
    
    /// 堆元素个数。
    public var count: Int {
        return nodes.count
    }
    
    // 父节点索引。
    private func parentIndex(ofIndex i: Int) -> Int {
        return (i - 1) / 2
    }
    
    // 左孩子索引。
    private func leftChildIndex(ofIndex i: Int) -> Int {
        return 2 * i + 1
    }
    
    // 右孩子索引。
    private func rightChildIndex(ofIndex i: Int) -> Int {
        return 2 * i + 2
    }
    
    /// 查看堆顶元素。
    /// - Complexity: O(1)
    /// - Returns: 堆顶元素。
    public func peek() -> T? {
        return nodes.first
    }
    
    
    /// 插入新元素。
    /// - Parameter value: 新元素。
    /// - Complexity: O(logn)
    public mutating func insert(_ value: T) {
        nodes.append(value)
        shiftUp(nodes.count - 1)
    }
    
    /// 替换堆顶元素。
    /// - Parameter value: 新元素。
    /// - Complexity: O(logn)
    /// - Returns: 原队首元素。
    public mutating func replace(value: T) -> T? {
        guard !isEmpty else { return nil }
        
        let ret = peek()
        nodes[0] = value
        shiftDown(0)
        
        return ret
    }
    
    /// 删除堆顶元素。
    /// - Complexity: O(logn)
    /// - Returns: 堆顶元素。
    @discardableResult
    public mutating func remove() -> T? {
        guard !nodes.isEmpty else { return nil }
        
        if nodes.count == 1 {
            return nodes.removeLast()
        } else {
            let value = nodes[0]
            nodes[0] = nodes.removeLast()
            shiftDown(0)
            return value
        }
    }
    
    private mutating func shiftUp(_ index: Int) {
        var childIndex = index
        let child = nodes[childIndex]
        var parentIndex = self.parentIndex(ofIndex: childIndex)
        
        while childIndex > 0 && orderCriteria(child, nodes[parentIndex]) {
            nodes[childIndex] = nodes[parentIndex]
            childIndex = parentIndex
            parentIndex = self.parentIndex(ofIndex: childIndex)
        }
        
        nodes[childIndex] = child
    }
    
    private mutating func shiftDown(from index: Int, until endIndex: Int) {
        let leftChildIndex = self.leftChildIndex(ofIndex: index)
        let rightChildIndex = leftChildIndex + 1
        
        var first = index
        if leftChildIndex < endIndex && orderCriteria(nodes[leftChildIndex], nodes[first]) {
            first = leftChildIndex
        }
        if rightChildIndex < endIndex && orderCriteria(nodes[rightChildIndex], nodes[first]) {
            first = rightChildIndex
        }
        if first == index { return }
        
        nodes.swapAt(index, first)
        shiftDown(from: first, until: endIndex)
    }
    
    private mutating func shiftDown(_ index: Int) {
        shiftDown(from: index, until: nodes.count)
    }
}
