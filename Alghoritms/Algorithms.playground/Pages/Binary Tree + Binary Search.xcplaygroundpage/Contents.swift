import Foundation

/**
Реализованы
 1) функция поиска по массиву с помощью алгоритма бинарного поиска, возвращающая индекс найденного элемента или nil
 2) функция поиска по массиву с помощью алгоритма бинарного поиска, возвращающая Bool (найден ли элемент)
 3) структура данных Бинарное дерево, с возможностью поиска элемента

 Далее определяется, что быстрее 1) или 2) для поиска элементов
 */




/// Производит поиск индекса элемента в массиве с использованием алгоритма "Бинарный поиск"
/// - Parameters:
///   - searchElement: искомый элемент
///   - array: массив, в котором производистя поиск. Элементы массива должны быть сопоставимы (подписаны на Comparable)
///   - minLimit: минимальный элемент в массиве (используется при рекурсии)
///   - maxLimit: максимальный элемент в массиве (используется при рекурсии)
/// - Returns: Индекс найденного элемент или nil
func binarySearchElementIndex<T: Comparable>(byValue element: T, in array: [T], min minLimit: Int? = nil, max maxLimit: Int? = nil) -> Int? {

    let min = minLimit ?? 0
    let max = maxLimit ?? array.count-1

    // есть ли искомый элемент в переданном массиве
    if min > max ||
    array[min] > element ||
    array[max] < element {
        return nil
    }

    // проверяем, что в массиве остался не единственный элемент
    if min == max && array[min] == element {
        return min
    } else if min == max && array[min] != element {
        return nil
    }
    
    // определяем индекс центрального элемента
    let midElement = Int(Float(min + max) / 2)
       
    if array[midElement] > element {
        return binarySearchElementIndex(byValue: element, in: array, min: min, max: midElement - 1)
    } else if array[midElement] < element {
        return binarySearchElementIndex(byValue: element, in: array, min: midElement + 1, max: max)
    } else if array[midElement] == element  {
        return midElement
    } else {
        return nil
    }
}

// Пример использования функции бинарного поиска по массиву [Int]
binarySearchElementIndex(byValue: 9, in: [1,5,9,10])

/// Производит проверку наличия элемента в массиве с использованием алгоритма "Бинарный поиск"
/// - Parameters:
///   - searchElement: искомый элемент
///   - array: массив, в котором производистя поиск. Элементы массива должны быть сопоставимы (подписаны на Comparable)
///   - minLimit: минимальный элемент в массиве (используется при рекурсии)
///   - maxLimit: максимальный элемент в массиве (используется при рекурсии)
/// - Returns: Есть ли элемент в массиве
func binarySearchElement<T: Comparable>(byValue element: T, in array: [T], min minLimit: Int? = nil, max maxLimit: Int? = nil) -> Bool {

    let min = minLimit ?? 0
    let max = maxLimit ?? array.count-1

    // есть ли искомый элемент в переданном массиве
    if min > max ||
    array[min] > element ||
    array[max] < element {
        return false
    }

    // проверяем, что в массиве остался не единственный элемент
    if min == max && array[min] == element {
        return true
    } else if min == max && array[min] != element {
        return false
    }
    
    // определяем индекс центрального элемента
    let midElement = Int(Float(min + max) / 2)
       
    if array[midElement] > element {
        return binarySearchElement(byValue: element, in: array, min: min, max: midElement - 1)
    } else if array[midElement] < element {
        return binarySearchElement(byValue: element, in: array, min: midElement + 1, max: max)
    } else if array[midElement] == element  {
        return true
    } else {
        return false
    }
}

// Пример использования функции бинарного поиска по массиву [Int]
binarySearchElement(byValue: 8, in: [1,5,9,10])


// MARK: - Бинарное дерево

// Структуру "Бинарное дерево"
class BinaryTree<T: Comparable> {
    var value: T
    var leftBranch: BinaryTree<T>? = nil
    var rightBranch: BinaryTree<T>? = nil
    init(value: T) {
        self.value = value
    }
    
    func search(_ element: T) -> Bool {
        if self.value == element {
            return true
        } else if self.value > element, let leftBranch = leftBranch {
            return leftBranch.search(element)
        } else if self.value > element, let rightBranch = rightBranch {
            return rightBranch.search(element)
        }
        return false
    }
}



/// Конвертирует массив в бинарное дерево
/// - Parameter array: массив, который необходимо сконвертировать
/// - Returns: бинарное дерево
func convert<T: Comparable>(arrayToBinaryTree array: [T]) -> BinaryTree<T> {
    let max = array.count-1
    let midElement = Int(Float(max) / 2)

    let resultBinaryTree = BinaryTree<T>(value: array[midElement])

    if midElement > 0 {
        resultBinaryTree.leftBranch = convert(arrayToBinaryTree: Array(array[0...midElement-1]))
    }

    if midElement == 0 && max > 0 {
        resultBinaryTree.rightBranch = convert(arrayToBinaryTree: Array(array[midElement+1...max]))
    } else if midElement > 0 {
        resultBinaryTree.rightBranch = convert(arrayToBinaryTree: Array(array[midElement+1...max]))
    }

    return resultBinaryTree
}

// Пример получения бинарного дерева из массива
let tree = convert(arrayToBinaryTree: [1,2,3,4,5,6,7,8,9,10])

/// Вывести состав бинарного дерева (значение типа BinaryTree)
/// - Parameter tree: бинарное дерево, состав которого необходимо вывести
func printTree<T:Comparable>(_ tree: BinaryTree<T>) {
    print(tree.value,  terminator: ": ")
    print(tree.leftBranch?.value ?? "-", "_", tree.rightBranch?.value ?? "-")
    if tree.leftBranch != nil {
        printTree(tree.leftBranch!)
    }
    if tree.rightBranch != nil {
        printTree(tree.rightBranch!)
    }
}

var timeExecutionBinarySearchInArray: Double = 0
var timeExecutionSearchInBinaryTree: Double = 0

//let start = CFAbsoluteTimeGetCurrent()
//// run your work
//let diff = CFAbsoluteTimeGetCurrent() - start
//print("Took \(diff) seconds")


// Измеряем время выполнения поиска

// массив, в котормо будем искать
let searchInArray = Array(1...100000)
// бинарное дерево, в котором будем искать
let binaryTree = convert(arrayToBinaryTree: searchInArray)

// 10000 операций поиска с замером времени
for _ in 1...10000 {
    // элемент, который ищем
    let searchingElement = searchInArray.randomElement()!
    
    // производим поиск бинарным поиском
    let start1 = CFAbsoluteTimeGetCurrent()
    binarySearchElement(byValue: searchingElement, in: searchInArray)
    timeExecutionBinarySearchInArray += CFAbsoluteTimeGetCurrent() - start1
    
    // производим поиск поиском по бинарному дереву
    let start2 = CFAbsoluteTimeGetCurrent()
    binaryTree.search(searchingElement)
    timeExecutionSearchInBinaryTree += CFAbsoluteTimeGetCurrent() - start2
}

print( timeExecutionBinarySearchInArray)
print( timeExecutionSearchInBinaryTree)









