//
//  MidDayRows.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct MidDayRows: View {
    var selected: String
    
    var offset: Int
    var dayCount: Int
    
    let dayInfo: FetchedResults<Date_Info_Entity>
    
    init(offset: Int, dayCount: Int, dayInfo: FetchedResults<Date_Info_Entity>, selected: String) {
        self.selected = selected
        
        self.offset = offset
        self.dayCount = dayCount
        
        self.dayInfo = dayInfo
    }
    
    var body: some View {
        ForEach(0..<dayCount/7) { i in
            MidDayRow(offset: offset, row: i, dayInfo: dayInfo, selected: selected)
        }
    }
}

struct MidDayRows_Previews: PreviewProvider {
    static var previews: some View {
        //MidDayRows(offset: 4, dayCount: 31)
        EmptyView()
    }
}
