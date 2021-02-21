//
//  SettingsButton.swift
//  Calendex
//
//  Created by Evan Bacon on 2/19/21.
//

import SwiftUI

struct SettingsButton: View {
    @EnvironmentObject var colors: Colors
    
    let simpleGearSymbolConfig = UIImage.SymbolConfiguration(pointSize: 14.0, weight: .black, scale: .large)
    
    var body: some View {
        NavigationLink(destination: Settings()) {
            Image(uiImage: UIImage(named: "simple.gear", in: nil, with: simpleGearSymbolConfig)!.withRenderingMode(.alwaysTemplate))
                .foregroundColor(colors.DARK_GRAY)
        }
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton().environmentObject(Colors())
    }
}
