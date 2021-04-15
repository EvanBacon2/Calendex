//
//  MonthSummary.swift
//  Calendex
//
//  Created by Evan Bacon on 1/24/21.
//

import SwiftUI

struct MonthButtons: View {
    @Binding var monthNav: Int?
    
    @State private var monthIndex: Int = 0
    
    var selected: String
    
    let year: Int
    
    init(year: Int, selected: String, monthNav: Binding<Int?>) {
        self.selected = selected
        self.year = year
        self._monthNav = monthNav
    }
    
    var body: some View {
        VStack(spacing: UIScreen.screenWidth * 0.018) {
            HStack(spacing: UIScreen.screenWidth * 0.018) {
                ForEach((1..<7), id: \.self) { i in
                    MonthButton(year: year, month: i, selected: selected, monthNav: _monthNav)
                }
            }
            HStack(spacing: UIScreen.screenWidth * 0.018) {
                ForEach((7..<13), id: \.self) { i in
                    MonthButton(year: year, month: i, selected: selected, monthNav: _monthNav)
                }
            }
        }
    }
}

struct MonthButtons_Previews: PreviewProvider {
    static var previews: some View {
        //MonthButtons(year: 2020)
        EmptyView()
    }
}
