func majorityElement(_ nums: [Int]) -> Int {
    var dict: Dictionary<Int, Int> = [:]
    var arr: Array<Int> = []
    var max = 0
    var secondKey = 0
    
    if arr.count == 1 {
        return nums[0]
    }
    
    nums.forEach { value in
        if let count = dict[value] {
            dict[value]! += 1
        } else {
            dict[value] = 0
        }
    }
    
    dict.forEach { (key, value) in
        if value > max {
            secondKey = key
        }
    }
    
    return secondKey
}

print(majorityElement([1]))
