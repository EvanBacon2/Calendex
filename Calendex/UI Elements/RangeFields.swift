//
//  RangeFields.swift
//  Calendex
//
//  Created by Evan Bacon on 3/31/21.
//

import SwiftUI

struct RangeFields: View {
    private let low: FieldValue
    private let mid: FieldValue
    private let high: FieldValue
    
    private struct FieldValue: Comparable {
        var range: Range
        var value: Int
        var lessThanOne: Bool
        var size: FieldSize
        
        init(range: Range, value: Int, lessThanOne: Bool) {
            self.range = range
            self.value = value
            self.lessThanOne = lessThanOne
            self.size = .small
        }
        
        static func < (lhs: RangeFields.FieldValue, rhs: RangeFields.FieldValue) -> Bool {
            return lhs.value < rhs.value ||
                  (lhs.value == 1 &&
                   rhs.value == 1 &&
                   lhs.lessThanOne == true &&
                   rhs.lessThanOne == false)
        }
    }
    
    init(low: Int, lowLessThanOne: Bool,
         mid: Int, midLessThanOne: Bool,
         high: Int, highLessThanOne: Bool) {
        let lowField = FieldValue(range: .low, value: low, lessThanOne: lowLessThanOne)
        let midField = FieldValue(range: .mid, value: mid, lessThanOne: midLessThanOne)
        let highField = FieldValue(range: .high, value: high, lessThanOne: highLessThanOne)
        
        var fields = [lowField, midField, highField]
        fields.sort()
        
        fields[0].size = fields[0] < fields[1] ? .small : .medium
        fields[1].size = .medium
        fields[2].size = fields[2] > fields[1] ? .large : .medium
        
        self.low = fields.filter { $0.range == .low }[0]
        self.mid = fields.filter { $0.range == .mid }[0]
        self.high = fields.filter { $0.range == .high }[0]
    }
    
    var body: some View {
        HStack() {
            RangeField(range: .low, value: self.low.value, size: self.low.size,
                       lessThanOne: self.low.lessThanOne)
            Spacer().frame(width: UIScreen.screenWidth * 0.06)
            RangeField(range: .mid, value: self.mid.value, size: self.mid.size,
                       lessThanOne: self.mid.lessThanOne)
            Spacer().frame(width: UIScreen.screenWidth * 0.06)
            RangeField(range: .high, value: self.high.value, size: self.high.size,
                       lessThanOne: self.high.lessThanOne)
        }
    }
}

struct RangeFields_Previews: PreviewProvider {
    static var previews: some View {
        VStack() {
            RangeFields(low: 20, lowLessThanOne: false,
                        mid: 30, midLessThanOne: false,
                        high: 50, highLessThanOne: false)
            RangeFields(low: 20, lowLessThanOne: false,
                        mid: 40, midLessThanOne: false,
                        high: 40, highLessThanOne: false)
            RangeFields(low: 20, lowLessThanOne: false,
                        mid: 20, midLessThanOne: false,
                        high: 60, highLessThanOne: false)
            RangeFields(low: 1, lowLessThanOne: true,
                        mid: 1, midLessThanOne: false,
                        high: 98, highLessThanOne: false)
            RangeFields(low: 1, lowLessThanOne: true,
                        mid: 1, midLessThanOne: true,
                        high: 98, highLessThanOne: false)
        }.environmentObject(Colors())
    }
}
