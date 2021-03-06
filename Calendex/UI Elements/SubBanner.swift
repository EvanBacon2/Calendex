//
//  SubBanner.swift
//  Calendex
//
//  Created by Evan Bacon on 1/18/21.
//

import SwiftUI

struct SubBanner: View {
    var title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(self.title).font(.title2)
            Spacer().frame(height: UIScreen.screenHeight * 0.01)
            Rectangle()
                .fill(AppColors.DARK_GRAY)
                .frame(width: UIScreen.screenWidth * 0.9, height: Dimensions.BASE_UNIT)
        }
    }
}

struct SubBanner_Previews: PreviewProvider {
    static var previews: some View {
        SubBanner("Month Summary").environmentObject(Colors())
    }
}
