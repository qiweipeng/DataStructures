//
//  SegmentTree.swift
//  
//
//  Created by Weipeng Qi on 2020/3/31.
//

import Foundation

/*
 线段树
 
 创建线段树复杂度为 O(n)，查询操作 O(logn)，更新操作 O(logn)
 */
public class SegmentTree<T> {

    private var value: T
    private var function: (T, T) -> T
    private var leftBound: Int
    private var rightBound: Int
    private var leftChild: SegmentTree<T>?
    private var rightChild: SegmentTree<T>?

    private init(array: [T], leftBound: Int, rightBound: Int, function: @escaping (T, T) -> T) {
        self.leftBound = leftBound
        self.rightBound = rightBound
        self.function = function

        if leftBound == rightBound {
            value = array[leftBound]
        } else {
            let middle = (leftBound + rightBound) / 2
            leftChild = SegmentTree<T>(array: array, leftBound: leftBound, rightBound: middle, function: function)
            rightChild = SegmentTree<T>(array: array, leftBound: middle+1, rightBound: rightBound, function: function)
            value = function(leftChild!.value, rightChild!.value)
        }
    }
    
    /// 构造函数。
    /// - Parameters:
    ///   - array: 传入的数组。
    ///   - function: 融合器。
    public convenience init(array: [T], function: @escaping (T, T) -> T) {
        self.init(array: array, leftBound: 0, rightBound: array.count-1, function: function)
    }
    
    /// 区间查询。
    /// - Parameters:
    ///   - leftBound: 左边界。
    ///   - rightBound: 右边界。
    /// - Returns: 这个区间计算的值。
    public func query(leftBound: Int, rightBound: Int) -> T {
        if self.leftBound == leftBound && self.rightBound == rightBound {
            return self.value
        }

        guard let leftChild = leftChild else { fatalError("leftChild should not be nil") }
        guard let rightChild = rightChild else { fatalError("rightChild should not be nil") }

        if leftChild.rightBound < leftBound {
            return rightChild.query(leftBound: leftBound, rightBound: rightBound)
        } else if rightChild.leftBound > rightBound {
            return leftChild.query(leftBound: leftBound, rightBound: rightBound)
        } else {
            let leftResult = leftChild.query(leftBound: leftBound, rightBound: leftChild.rightBound)
            let rightResult = rightChild.query(leftBound:rightChild.leftBound, rightBound: rightBound)
            return function(leftResult, rightResult)
        }
    }
    
    /// 单点替换某个区间中某个元素，更新线段树。
    /// - Parameters:
    ///   - index: 元素的索引。
    ///   - item: 新值。
    public func replaceItem(at index: Int, withItem item: T) {
        if leftBound == rightBound {
            value = item
        } else if let leftChild = leftChild, let rightChild = rightChild {
            if leftChild.rightBound >= index {
                leftChild.replaceItem(at: index, withItem: item)
            } else {
                rightChild.replaceItem(at: index, withItem: item)
            }
            value = function(leftChild.value, rightChild.value)
        }
    }
}
