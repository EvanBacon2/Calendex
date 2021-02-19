//
//  ScreenHeader.swift
//  Calendex
//
//  Created by Evan Bacon on 2/7/21.
//

import SwiftUI

struct ScreenHeader: View {
    var title: String
    var banner: String
    
    init(title: String, banner: String) {
        self.title = title
        self.banner = banner
    }
    
    var body: some View {
        VStack(spacing : Spacing.SINGLE_SPACE) {
            ScreenTitle(title)
            OverheadBanner(banner)
        }
    }
}

struct ScreenHeader_Previews: PreviewProvider {
    static var previews: some View {
        ScreenHeader(title: "Welcome", banner: "2020").environmentObject(Colors())
    }
}
