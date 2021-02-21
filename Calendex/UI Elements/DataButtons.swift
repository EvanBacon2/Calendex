//
//  DataButtons.swift
//  Calendex
//
//  Created by Evan Bacon on 2/7/21.
//

import SwiftUI

struct DataButtons: View {
    @State var selected: String = "Average"
    
    var body: some View {
        HStack(spacing: 0) {
            DataButton("Average", selected: $selected)
            Spacer()
            DataButton("Range", selected: $selected)
            Spacer()
            DataButton("Deviation", selected: $selected)
        }.frame(width: UIScreen.screenWidth * 0.86)
    }
}

struct DataButtons_Previews: PreviewProvider {
    static var previews: some View {
        DataButtons().environmentObject(Colors())
    }
}
