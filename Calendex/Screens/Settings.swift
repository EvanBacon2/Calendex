//
//  Settings.swift
//  Calendex
//
//  Created by Evan Bacon on 2/5/21.
//

import SwiftUI

struct Settings: View {
    @State private var toggleAvailable: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            OverheadBanner("Settings")
            ScrollView {
                VStack() {
                    Spacer().frame(height: Spacing.HEADER_MARGIN)
                    Group {
                        SubBanner("Goals")
                        AverageSlider()
                        Spacer().frame(height: UIScreen.screenHeight * 0.03)
                        TimeSlider()
                        Spacer().frame(height: UIScreen.screenHeight * 0.03)
                        DeviationSlider()
                    }
                    Group {
                        SubBanner("Data")
                        DataRecord()
                    }
                    Group {
                        SubBanner("Color")
                        HStack(spacing: UIScreen.screenHeight * 0.04)
                        {
                            ColorPicker(range: .low, alignment: .center, toggleAvailable: $toggleAvailable)
                            ColorPicker(range: .mid, alignment: .center, toggleAvailable: $toggleAvailable)
                            ColorPicker(range: .high, alignment: .trailing, toggleAvailable: $toggleAvailable)
                        }
                    }
                    Spacer()
                }
            }
        }.navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: SettingsButtonSelected())
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings().environmentObject(Goals())
                  .environmentObject(Colors())
    }
}
