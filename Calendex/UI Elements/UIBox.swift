//
//  UIBox.swift
//  Calendex
//
//  Created by Evan Bacon on 4/14/21.
//

import SwiftUI

struct UIBox<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var colors: Colors
    
    let contents: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.contents = content()
    }
    
    var body: some View {
        ZStack() {
            contents.background(box())
        }.padding(Spacing.SINGLE_SPACE * 1.5)
    }
    
    func box() -> some View {
        return RoundedRectangle(cornerRadius: 10)
            .fill(colors.boxColor(colorScheme))
            .padding(-Spacing.SINGLE_SPACE * 1.5)
    }
}

struct UIBox_Previews: PreviewProvider {
    static var previews: some View {
        UIBox() {
            TimeInRange(low: 33, mid: 34, high: 33)
        }.environmentObject(Colors())
    }
}
