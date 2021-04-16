//
//  Settings.swift
//  Calendex
//
//  Created by Evan Bacon on 2/5/21.
//

import SwiftUI

struct Settings: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var colors: Colors
    
    @State private var toggleAvailable: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            OverheadBanner("Settings")
            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: Spacing.HEADER_MARGIN)
                    UIBox {
                        VStack() {
                            SubBanner("Goals")
                            AverageSlider()
                            Spacer().frame(height: UIScreen.screenHeight * 0.03)
                            TimeSlider()
                            Spacer().frame(height: UIScreen.screenHeight * 0.03)
                            DeviationSlider()
                        }
                    }
                    Group {
                        //SubBanner("Data")
                        //DataRecord()
                    }
                    Spacer().frame(height: Spacing.DOUBLE_SPACE)
                    UIBox {
                        VStack() {
                            SubBanner("Color")
                            HStack(spacing: UIScreen.screenHeight * 0.04)
                            {
                                ColorPicker(range: .low, alignment: .center, toggleAvailable: $toggleAvailable)
                                ColorPicker(range: .mid, alignment: .center, toggleAvailable: $toggleAvailable)
                                ColorPicker(range: .high, alignment: .trailing, toggleAvailable: $toggleAvailable)
                            }
                        }
                    }
                    Spacer().frame(height: UIScreen.screenHeight * 0.13)
                    Spacer()
                }
            }
        }.navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: SettingsButtonSelected())
        .frame(width: UIScreen.screenWidth)
        .background(colors.backgroundColor(colorScheme))
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings().environmentObject(Goals())
                  .environmentObject(Colors())
    }
}
