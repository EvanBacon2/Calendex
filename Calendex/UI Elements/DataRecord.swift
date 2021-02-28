//
//  DataRecord.swift
//  Calendex
//
//  Created by Evan Bacon on 2/18/21.
//

import SwiftUI

struct DataRecord: View {
    var year: String
    
    init(year: String) {
        self.year = year
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text(year).font(.title3)
            Spacer().frame(height: Dimensions.BASE_UNIT)
            DataBar()
        }
    }
}

struct DataRecord_Previews: PreviewProvider {
    static var previews: some View {
        DataRecord(year: "2020")
    }
}
