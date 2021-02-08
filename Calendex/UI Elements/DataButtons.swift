//
//  DataButtons.swift
//  Calendex
//
//  Created by Evan Bacon on 2/7/21.
//

import SwiftUI

struct DataButtons: View {
    var body: some View {
        HStack(spacing: 0) {
            DataButton("Average")
            Spacer()
            DataButton("Range")
            Spacer()
            DataButton("Deviation")
        }.frame(width: UIScreen.screenWidth * 0.86)
    }
}

struct DataButtons_Previews: PreviewProvider {
    static var previews: some View {
        DataButtons()
    }
}
