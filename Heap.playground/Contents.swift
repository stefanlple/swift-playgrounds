import Foundation

struct Heap {
    private(set) var heapArray: [Int]

    var count: Int {
        return heapArray.count
    }

    init(from inputArray: [Int]?) {
        guard let inputArray else {
            heapArray = [Int]()
            return
        }
        heapArray = inputArray
        heapify()
    }

    mutating func heapify() {
        guard let lastParent = getParent(forIndex: heapArray.count - 1) else {
            return
        }

        for index in stride(from: lastParent.index, through: 0, by: -1) {
            siftDown(at: index)
        }
    }

    mutating func pop() -> Int {
        heapArray.swapAt(0, heapArray.count - 1)
        let poppedElement = heapArray.removeLast()
        siftDown(at: 0)
        return poppedElement
    }

    func peak() -> Int {
        return heapArray[0]
    }

    mutating func insert(element: Int) {
        heapArray.append(element)
        siftUp(at: heapArray.count - 1)
    }

    mutating func remove(targetElement: Int) {
        for (index, element) in heapArray.enumerated() {
            if element == targetElement {
                heapArray.swapAt(index, heapArray.count - 1)
                heapArray.removeLast()
                siftDown(at: index)
                return
            }
        }
    }

    mutating func heapSort() -> [Int] {
        var res = [Int]()
        for index in 0..<heapArray.count {
            heapArray.swapAt(0, heapArray.count - 1 - index)
            siftDown(at: 0, to: heapArray.count - 1 - index)
        }
        return heapArray
    }

    private mutating func siftUp(at index: Int) {
        guard let parent = getParent(forIndex: index) else {
            return
        }

        if parent.element < heapArray[index] {
            heapArray.swapAt(parent.index, index)
            siftUp(at: parent.index)
        }
    }

    private mutating func siftDown(at index: Int, to endIndex: Int? = nil) {
        var end = endIndex ?? heapArray.count

        let (leftChild, rightChild) = getChildren(forIndex: index)

        guard let leftChild, leftChild.index < end else {
            return
        }
        var currentLargestIndex = index

        if leftChild.element > heapArray[currentLargestIndex],
            leftChild.index < end
        {
            currentLargestIndex = leftChild.index
        }

        if let rightChild,
            rightChild.element > heapArray[currentLargestIndex],
            rightChild.index < end
        {
            currentLargestIndex = rightChild.index
        }

        if currentLargestIndex != index {
            heapArray.swapAt(currentLargestIndex, index)
            siftDown(at: currentLargestIndex, to: endIndex)
        }
    }

    private func getParent(forIndex index: Int) -> ElementTuple? {
        let parentIndex = (index - 1) / 2
        return ElementTuple(index: parentIndex, heapArray: heapArray)
    }

    private func getChildren(forIndex index: Int) -> (ElementTuple?, ElementTuple?) {
        var leftChildrenIndex: Int {
            2 * index + 1
        }

        var rightChildrenIndex: Int {
            2 * index + 2
        }
        return (
            ElementTuple(index: leftChildrenIndex, heapArray: heapArray),
            ElementTuple(index: rightChildrenIndex, heapArray: heapArray)
        )
    }

    private struct ElementTuple {
        let index: Int
        private let heapArray: [Int]
        var element: Int {
            heapArray[index]
        }
        init?(index: Int, heapArray: [Int]) {
            guard heapArray.indices.contains(index) else {
                return nil
            }
            self.index = index
            self.heapArray = heapArray
        }
    }

}

var heap = Heap(from: [1, 2, 3, 4, 5, 6, 7, 8, 9])
//print(heap.getParent(forIndex: 4)?.element ?? "out of bound")
//print(heap.getParent(forIndex: 8)?.element ?? "out of bound")
//print(heap.insert(element: 10))
//print(heap.heapArray)
//heap.siftDown(at: 1)
print(heap.heapArray)
print("heapsort", heap.heapSort())
//print(heap.getChildren(forIndex: 3))
//print(heap.getChildren(4))
