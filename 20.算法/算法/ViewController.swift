//
//  ViewController.swift
//  算法
//
//  Created by Allison on 2017/11/19.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

//        let a =  [6,2,7,3,8,9]
//        let newArr =  bubble_sort(a: a)
//        print(newArr)

//        let a = [6,2,7,3,8,9]
//        let newArr = quickSort(oArr: a)
//        print(newArr)

        let a = [6,2,7,3,8,9]
        let newArr3 = insertionSort(oArr: a)
        print(newArr3)

//        let a = [6,2,7,3,8,9]
//        let newArr4 = selectSort(oArr: a)
//        print(newArr4)


    }
}

extension ViewController {

    // MARK: - 冒泡排序
    func bubble_sort<T: Comparable> (a : [T]) -> [T] {
        var arr = a
        for i in 0 ..< arr.count - 1  {
            for j in 0  ..< arr.count - 1 - i {
                if arr[j] > arr[j+1] {
                   let temp = arr[j]
                    arr[j] = arr[j+1]
                    arr[j+1] = temp
                }
            }
        }
        return arr
    }

    // MARK: - 快速排序
    func quickSort<T: Comparable> (oArr: [T]) -> [T] {
        let arr = oArr
        if let (k, rest) = arr.decompose {
            let lesser  = rest.filter { $0 < k }
            let greater = rest.filter { $0 >= k }
            let les = quickSort(oArr: lesser)
            let gre = quickSort(oArr: greater)
            return les + [k] + gre
        } else {
            return []
        }
    }

    // MARK: - 插入排序 O(N2/4)
    func insertionSort<T: Comparable>(oArr: [T]) -> [T] {
        var arr = oArr
        for i in 1..<arr.count {
            let temp = arr[i]
            var j = i
            // 与已排序的数逐一比较,大于temp时,改数后移
            while j > 0 && arr[j - 1] >= temp {
                print(arr[j - 1])
                arr[j] = arr[j - 1]
                j      -= 1
            }
            arr[j] = temp
            print(arr[j])
        }
        print(arr)
        return arr
    }


    //选择排序 O(N)
    func selectSort<T: Comparable>(oArr: [T]) -> [T] {
        var arr = oArr
        var minIndex = 0 //记录每次遍历的最小值
        for outerIndex in 0..<arr.count {
            minIndex = outerIndex
            for innerIndex in (outerIndex + 1)..<arr.count {
                if arr[minIndex] > arr[innerIndex] {
                    minIndex = innerIndex //判断最小值，记住下标
                }
                if minIndex != outerIndex { //一个轮回结束交换
                    let temp        = arr[outerIndex]
                    arr[outerIndex] = arr[minIndex]
                    arr[minIndex]   = temp
                }
            }
        }
        print(arr)

        return arr
    }

}

extension Array {
    var decompose : (head: Element, tail: [Element])? {
        return (count > 0) ? (self[0], Array(self[1..<count])) : nil
    }
}

