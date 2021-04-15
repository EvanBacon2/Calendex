//
//  SettingsButtonSelected.swift
//  Calendex
//
//  Created by Evan Bacon on 2/20/21.
//

import SwiftUI

struct SettingsButtonSelected: View {
    let simpleGearSymbolConfig = UIImage.SymbolConfiguration(pointSize: 14.0, weight: .black, scale: .large)
    
    var body: some View {
        Image(uiImage: UIImage(named: "simple.gear", in: nil, with:simpleGearSymbolConfig)!.withRenderingMode(.alwaysTemplate))
            .foregroundColor(AppColors.ACCENT_COLOR)
    }
}

struct SettingsButtonSelected_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButtonSelected().environmentObject(Colors())
    }
}
