//
//  Settings.swift
//  Calendex
//
//  Created by Evan Bacon on 2/5/21.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            OverheadBanner("Settings")
            ScrollView {
                VStack() {
                    Spacer().frame(height: 15)
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
                        DataRecord(year: "2020")
                        DataRecord(year: "2019")
                        DataRecord(year: "2018")
                    }
                    Group {
                        SubBanner("Color")
                        HStack(spacing: UIScreen.screenHeight * 0.04)
                        {
                            ColorPicker(range: .low, alignment: .center)
                            ColorPicker(range: .mid, alignment: .center)
                            ColorPicker(range: .high, alignment: .trailing)
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
