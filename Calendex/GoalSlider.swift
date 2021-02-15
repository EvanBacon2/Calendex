//
//  GoalSlider.swift
//  Calendex
//
//  Created by Evan Bacon on 2/11/21.
//

import SwiftUI

enum Metroc {
    case RANGE
    case TIME
    case DEVIATION
}

struct GoalSlider: View {
    @EnvironmentObject var goals: Goals
    
    //var lowMetrocWidth: CGFloat
    //var midMetrocWidth: CGFloat
    //var highMetrocWidth: CGFloat
    
    var dragLimit: CGFloat = UIScreen.screenWidth * (0.425) -                      UIScreen.screenHeight * 0.0115
    let sliderWidth = UIScreen.screenWidth * 0.85
    var thumbOneColor: Color
    var Metroc: Metroc
    
    init(Metroc: Metroc) {
        //lowMetrocWidth = calcWidth(range: .low, Metroc)
        //midMetrocWidth = calcWidth(range: .mid, Metroc)
        //highMetrocWidth = calcWidth(range: .high, Metroc)
        
        self.Metroc = Metroc
        
        switch Metroc {
        case .RANGE:
            thumbOneColor = AppColors.LOW_2
        case .TIME, .DEVIATION:
            thumbOneColor = AppColors.MID_2
        }
    }
    
    func calcWidth(range: Range, _ Metroc: Metroc) -> CGFloat {
        let MetrocVal = getMetrocVal(range, Metroc)
        return convertMetrocToWidth(MetrocVal, met: Metroc)
    }
    
    func convertMetrocToWidth(_ MetrocVal: Int, met: Metroc) -> CGFloat {
        let scale: CGFloat
        
            scale = (CGFloat(MetrocVal) - 60) / 340.0
        
        let width = (sliderWidth * scale)
        
        return width
    }
    
    func getMetrocVal(_ range: Range, _ Metroc: Metroc) -> Int {
        switch Metroc {
        case .RANGE:
            switch range {
            case .high:
                return 460 - goals.highBgThreshold
            case .mid:
                return goals.highBgThreshold - goals.lowBgThreshold + 60
            case .low:
                return goals.lowBgThreshold
            }
        case .TIME:
            switch range {
            case .low:
                return goals.TimeInRangeThreshold
            case .mid:
                return 0
            case .high:
                return 100 - goals.TimeInRangeThreshold
            }
        case .DEVIATION:
            switch range {
            case .low:
                return goals.DeviationThreshold
            case .mid:
                return 0
            case .high:
                return 100 - goals.DeviationThreshold
            }
        }
    }
    
    var body: some View {
        ZStack() {
            HStack(spacing: 0) {
                Spacer().frame(width: 10)
                RoundedRectangle(cornerRadius: 5)
                    .fill(thumbOneColor)
                    .frame(width: UIScreen.screenHeight * 0.0115, height: UIScreen.screenHeight * 0.0115)
                Rectangle()
                    .fill(thumbOneColor)
                    .frame(width: calcWidth(range: .low, Metroc),
                           height: UIScreen.screenHeight * 0.0115)
                    .offset(x: -5)
                if (Metroc == .RANGE) {
                    Rectangle()
                        .fill(AppColors.MID_2)
                        .frame(width: calcWidth(range: .mid, Metroc),
                               height: UIScreen.screenHeight * 0.0115)
                        .offset(x: -5)
                }
                Rectangle()
                    .fill(AppColors.HIGH_2)
                    .frame(width: calcWidth(range: .high, Metroc),
                           height: UIScreen.screenHeight * 0.0115)
                    .offset(x: -5)
                RoundedRectangle(cornerRadius: 5)
                    .fill(AppColors.HIGH_2)
                    .frame(width: UIScreen.screenHeight * 0.0115, height: UIScreen.screenHeight * 0.0115)
                    .offset(x: -10)
            }
        }
    }
}

struct GoalSlider_Previews: PreviewProvider {
    static var previews: some View {
        GoalSlider(Metroc: .RANGE).environmentObject(Goals())
    }
}
