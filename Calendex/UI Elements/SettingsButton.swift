//
//  SettingsButton.swift
//  Calendex
//
//  Created by Evan Bacon on 2/19/21.
//

import SwiftUI

struct SettingsButton: View {
    @EnvironmentObject var colors: Colors
    
    @Binding var settingsActive: Bool
    
    let simpleGearSymbolConfig = UIImage.SymbolConfiguration(pointSize: 14.0, weight: .black, scale: .large)
    
    init(_ settingsActive: Binding<Bool>) {
        self._settingsActive = settingsActive
    }
    
    var body: some View {
        //NavigationLink(destination: Settings()) {
        Button(action: { settingsActive.toggle() }) {
            Image(uiImage: UIImage(named: "simple.gear", in: nil, with: simpleGearSymbolConfig)!.withRenderingMode(.alwaysTemplate))
                .foregroundColor(colors.DARK_GRAY)
        }
        //}
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton_Preview_View()
    }
}

struct SettingsButton_Preview_View: View {
    @State var testToggle: Bool = false
    
    var body: some View {
        SettingsButton($testToggle)
    }
}
