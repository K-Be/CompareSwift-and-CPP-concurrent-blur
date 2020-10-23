//
//  SwiftBlur.swift
//  SwiftBlur
//
//  Created by Andrew Romanov on 23.10.2020.
//

import Foundation

@objc public class SwiftBlur: NSObject {

    let source: [Double]
    let blurRadius: UInt

    @objc public init(withSource source: [Double], blurRadius: UInt = 10) {
        self.source = source
        self.blurRadius = blurRadius
    }

    @objc public func blur() -> [Double] {
        var result = source
        let indexSet = NSIndexSet(indexesIn: NSMakeRange(0, source.count))
        let from = -Int(self.blurRadius)
        let to = Int(self.blurRadius)
        let lastIndex = self.source.count - 1
        indexSet.enumerate(options: .concurrent) { (index:Int, _) in
            let sum = ((from + index)...(to + index)).reduce(0.0) { (partial:Double, nonClamped:Int) -> Double in
                let index = self.clamp(nonClamped, min: 0, max: lastIndex)
                let result = partial + self.source[index]
                return result
            }
            let avg = sum / Double(2 * self.blurRadius + 1);
            result[index] = avg
        }

        return result
    }

    private func clamp<T:Comparable>(_ val: T, min minVal: T, max maxVal:T) -> T {
        let result =  min(max(val, minVal), maxVal)
        return result
    }
}
