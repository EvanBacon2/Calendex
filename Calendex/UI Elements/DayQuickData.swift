//
//  DayQuickData.swift
//  Calendex
//
//  Created by Evan Bacon on 2/7/21.
//

import SwiftUI

struct DayQuickData: View {
    var body: some View {
        VStack(spacing: 0) {
            SubBanner("Summary").padding(.bottom, Spacing.DOUBLE_SPACE)
            DayFields()
        }
    }
}

struct DayQuickData_Previews: PreviewProvider {
    static var previews: some View {
        DayQuickData().environmentObject(Colors())
    }
}
