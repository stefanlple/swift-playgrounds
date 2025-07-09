import Foundation

var inputArray = [3, 7, 5, 6, 1, 4, 8, 2]

func bubbleSort(_ arr: [Int]) -> [Int] {
    var array = arr
    for i in 0..<array.count {
        for j in 0..<array.count - i - 1 {
            if array[j] > array[j + 1] {
                array.swapAt(j, j + 1)
            }
        }
    }
    return array
}

func selectionSort(_ arr: [Int]) -> [Int] {
    var array = arr
    for i in 0..<array.count {
        var maxValueIndex = 0
        for j in 0..<array.count - i {
            if array[j] > array[maxValueIndex] {
                maxValueIndex = j
            }
        }
        array.swapAt(maxValueIndex, array.count - i - 1)
    }
    return array
}

func insertionSort(_ arr: [Int]) -> [Int] {
    var array = arr
    for i in 0..<array.count {
        var currentIndex = i
        while currentIndex > 0 && array[currentIndex] < array[currentIndex - 1] {
            array.swapAt(currentIndex, currentIndex - 1)
            currentIndex -= 1
        }
    }
    return array
}

func mergeSort(_ arr: [Int]) -> [Int] {
    if arr.count <= 1 {
        return arr
    }
    let middleIndex = arr.count / 2

    let leftArray = Array(arr[0..<middleIndex])
    let rightArray = Array(arr[middleIndex..<arr.count])

    var result = merge(mergeSort(leftArray), mergeSort(rightArray))
    return result
}

func merge(_ leftArray: [Int], _ rightArray: [Int]) -> [Int] {
    var leftArr = leftArray
    var rightArr = rightArray
    var resultArray = [Int]()
    while (leftArr.count != 0) && (rightArr.count != 0) {
        if leftArr[0] < rightArr[0] {
            resultArray.append(leftArr.removeFirst())
            continue
        }
        resultArray.append(rightArr.removeFirst())
    }
    let result = resultArray + leftArr + rightArr
    return result
}

func quickSort(_ arr: inout [Int], leftPointer: Int? = nil, rightPointer: Int? = nil) -> [Int] {
    var leftPointer = leftPointer ?? 0
    var rightPointer = rightPointer ?? arr.count - 1
    var pivotIndex = partition(&arr, leftPointer: leftPointer, rightPointer: rightPointer)
    guard let pivotIndex else {
        return arr
    }

    quickSort(&arr, leftPointer: leftPointer, rightPointer: pivotIndex - 1)
    quickSort(&arr, leftPointer: pivotIndex + 1, rightPointer: rightPointer)

    return arr
}

func partition(_ arr: inout [Int], leftPointer: Int, rightPointer: Int) -> Int? {
    if leftPointer > rightPointer {
        return nil
    }
    var leftPointer = leftPointer
    var rightPointer = rightPointer
    var middleIndex = (leftPointer + rightPointer) / 2
    arr.swapAt(leftPointer, middleIndex)
    middleIndex = leftPointer
    leftPointer += 1

    while leftPointer < rightPointer {
        while arr[leftPointer] < arr[middleIndex] && leftPointer < arr.count - 1 {
            leftPointer += 1
        }

        while arr[rightPointer] > arr[middleIndex] && rightPointer > 0 {
            rightPointer -= 1
        }

        if leftPointer <= rightPointer {
            arr.swapAt(leftPointer, rightPointer)
            leftPointer += 1
            rightPointer -= 1
        }
    }
    arr.swapAt(rightPointer, middleIndex)
    return rightPointer
}

print("oldarray".padding(toLength: 20, withPad: " ", startingAt: 0), inputArray)
print("bubbleSort".padding(toLength: 20, withPad: " ", startingAt: 0), bubbleSort(inputArray))
print("selectionSort".padding(toLength: 20, withPad: " ", startingAt: 0), selectionSort(inputArray))
print("insertionSort".padding(toLength: 20, withPad: " ", startingAt: 0), insertionSort(inputArray))
print("mergeSort".padding(toLength: 20, withPad: " ", startingAt: 0), mergeSort(inputArray))
print("quickSort".padding(toLength: 20, withPad: " ", startingAt: 0), quickSort(&inputArray))
