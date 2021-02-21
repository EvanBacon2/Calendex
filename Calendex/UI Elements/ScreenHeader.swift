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
    var bannerOnly: Bool
    
    init(title: String, banner: String, bannerOnly: Bool) {
        self.title = title
        self.banner = banner
        self.bannerOnly = bannerOnly
    }
    
    var body: some View {
        VStack(spacing : Spacing.SINGLE_SPACE) {
            if (bannerOnly) {
                ScreenTitle(title).hidden()
            } else {
                ScreenTitle(title)
            }
            OverheadBanner(banner)
        }
    }
}

struct ScreenHeader_Previews: PreviewProvider {
    static var previews: some View {
        ScreenHeader(title: "Welcome", banner: "2020", bannerOnly: false).environmentObject(Colors())
    }
}
