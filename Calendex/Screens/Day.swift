//
//  Day.swift
//  Calendex
//
//  Created by Evan Bacon on 1/26/21.
//

import SwiftUI

struct Day: View {
    var blockSpace = UIScreen.screenHeight * 0.02
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            VStack(alignment: .leading, spacing: 0) {
                VStack() {
                    ScreenTitle("Welcome")
                    OverheadBanner("15")
                }.padding(.bottom, blockSpace)
                ScrollView {
                    DayChart()
                    SubBanner("Summary")
                    DayFields().padding(.bottom)
                    Group {
                        SubBanner("Time in Range")
                        VStack(spacing: 0) {
                            Spacer().frame(height: 10)
                            TimeBar2(8, 5, 87)
                        }.frame(width: UIScreen.screenWidth * 0.9)
                    }
                    Spacer().frame(height: 10)
                    Group {
                        SubBanner("Standard Deviation")
                        VStack(spacing: 0) {
                            Spacer().frame(height: 10)
                            DeviationGraph()
                        }.frame(width: UIScreen.screenWidth * 0.9)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct Day_Previews: PreviewProvider {
    static var previews: some View {
        Day()
    }
}
