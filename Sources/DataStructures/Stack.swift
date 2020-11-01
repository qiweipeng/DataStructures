//
//  Stack.swift
//  
//
//  Created by Weipeng Qi on 2020/3/24.
//

import Foundation

/*
 栈

 使用数组实现。
*/
public struct Stack<T> {
    
    private var array = [T]()
    
    public init() {}
    
    /// 判断栈是否为空。
    /// - Complexity: O(1)
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    /// 栈中元素数量。
    /// - Complexity: O(1)
    public var count: Int {
        return array.count
    }
    
    /// 入栈。
    /// - Parameter element: 入栈的元素。
    /// - Complexity: O(1)
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
    /// 出栈。
    /// - Complexity: O(1)
    /// - Returns: 栈顶元素。
    @discardableResult
    public mutating func pop() -> T? {
        return array.popLast()
    }
    
    /// 查看栈顶元素。
    /// - Complexity: O(1)
    /// - Returns: 栈顶元素。
    public func top() -> T? {
        return array.last
    }
}

extension Stack: CustomStringConvertible {
    public var description: String {
        return "Stack: " + array.description + " top"
    }
}
