//
//  DeviationGraph.swift
//  Calendex
//
//  Created by Evan Bacon on 1/24/21.
//

import SwiftUI

struct DeviationGraph: View {
    let BAR_WIDTH = UIScreen.screenWidth * 0.025
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(){
                Rectangle()
                    .fill(AppColors.LIGHT_BLUE_GRAY)
                    .frame(width: 2, height: UIScreen.screenHeight * 0.1)
                    Spacer()
            }.frame(height: UIScreen.screenHeight * 0.1 + 7)
            VStack(spacing: 5) {
                HStack(alignment: .bottom, spacing: 1) {
                    DeviationBar(.low, 2)
                    DeviationBar(.low, 5)
                    DeviationBar(.low, 2)
                }
                Rectangle()
                    .fill(AppColors.LOW_2)
                    .frame(width: BAR_WIDTH * 3 + 2, height: 2)
            }
            
            VStack() {
                Spacer().frame(width: 4, height: UIScreen.screenHeight * 0.1)
            }
        }
    }
}

struct DeviationGraph_Previews: PreviewProvider {
    static var previews: some View {
        DeviationGraph()
    }
}
