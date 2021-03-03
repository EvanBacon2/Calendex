//
//  DataButtons.swift
//  Calendex
//
//  Created by Evan Bacon on 2/7/21.
//

import SwiftUI

struct DataButtons: View {
    @Binding var selected: String
    
    init(selected: Binding<String>) {
        self._selected = selected
    }
    
    var body: some View {
        HStack(spacing: 0) {
            DataButton("Average", selected: _selected)
            Spacer()
            DataButton("Range", selected: _selected)
            Spacer()
            DataButton("Deviation", selected: _selected)
        }.frame(width: UIScreen.screenWidth * 0.86)
    }
}

struct DataButtons_Previews: PreviewProvider {
    static var previews: some View {
        //DataButtons().environmentObject(Colors())
        EmptyView()
    }
}
