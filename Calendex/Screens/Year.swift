//
//  Year.swift
//  Calendex
//
//  Created by Evan Bacon on 1/17/21.
//

import SwiftUI

struct Year: View {
    var blockSpace = UIScreen.screenHeight * 0.01
    
    var body: some View {
        HStack() {
            Spacer()
            VStack(alignment: .leading, spacing: 0) {
                VStack(spacing : blockSpace) {
                    ScreenTitle("Welcome")
                    OverheadBanner("2020")
                }.padding(.bottom, Spacing.HEADER_MARGIN)
                ScrollView() {
                    VStack(spacing: 0) {
                        SubBanner("Month Summary").padding(.bottom, Spacing.SUB_BANNER_MARGIN)
                        
                        MonthSummary().padding(.bottom, Spacing.SPACEING_UNIT)
                        
                        Rectangle()
                            .fill(AppColors.LIGHT_BLUE_GRAY)
                            .frame(width: UIScreen.screenWidth * 0.85, height: 1)
                            .padding(.bottom, Spacing.SPACEING_UNIT)
                        
                        
                        
                        HStack(spacing: 15) {
                            DataButton("Average")
                            DataButton("Range")
                            DataButton("Deviation")
                        }.padding(.bottom, Spacing.SUB_BANNER_MARGIN)
                        
                        Group {
                            SubBanner("Time in Range").padding(.bottom, Spacing.SUB_BANNER_MARGIN)
                            TimeBar2(8, 5, 87)
                        }
                        Spacer().frame(height: Spacing.SUB_BANNER_MARGIN)
                        
                        Group {
                            SubBanner("Standard Deviation").padding(.bottom, Spacing.SUB_BANNER_MARGIN)
                            DeviationGraph()
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct Year_Previews: PreviewProvider {
    static var previews: some View {
        Year()
    }
}
