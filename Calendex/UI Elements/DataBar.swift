//
//  DataBar.swift
//  Calendex
//
//  Created by Evan Bacon on 2/18/21.
//

import SwiftUI

struct DataBar: View {
    let record: [Bool]
    
    let barWidth: CGFloat = UIScreen.screenWidth * 0.85 - UIScreen.screenHeight * 0.023
    let barHeight: CGFloat = UIScreen.screenHeight * 0.0115
    
    init(record: [Bool]) {
        self.record = record
    }
    
    var body: some View {
        HStack(spacing: 0) {
            barCap(data: self.record[0], endCap: false)
            ForEach(1..<self.record.count - 1) { i in
                barSlice(data: self.record[i])
            }
            barCap(data: self.record[self.record.count - 1], endCap: true)
        }
    }
    
    func barSlice(data: Bool) -> some View {
        return Rectangle()
            .fill(data ? AppColors.BRAND_COLOR: AppColors.LIGHT_BLUE_GRAY)
            .frame(width: barWidth / 363.0,
                   height: barHeight)
    }
    
    func barCap(data: Bool, endCap: Bool) -> some View {
        return HStack(spacing: 0) {
            RoundedRectangle(cornerRadius: barHeight)
                .fill(data ? AppColors.BRAND_COLOR: AppColors.LIGHT_BLUE_GRAY)
                .frame(width: barHeight,
                       height: barHeight)
                .offset(x: barHeight / 2)
            Rectangle()
                .fill(data ? AppColors.BRAND_COLOR: AppColors.LIGHT_BLUE_GRAY)
                .frame(width: barHeight / 2,
                       height: barHeight)
        }.frame(height: barHeight)
         .rotationEffect(.degrees(endCap ? 180 : 0))
    }
}

struct DataBar_Previews: PreviewProvider {
    static var previews: some View {
        //DataBar()
        EmptyView()
    }
}
