//
//  DateShell.swift
//  Calendex
//
//  Created by Evan Bacon on 4/15/21.
//

import SwiftUI

struct DateShell: View {
    @FetchRequest var metaData: FetchedResults<Meta_Entity>
    
    @State var settingsActive: Bool = false
    @State var activeTab: Int
    
    let year: Int
    let month: Int
    let day: Int
    
    init(year: Int = -1, month: Int = -1, day: Int = -1) {
        self.year = year
        self.month = month
        self.day = day
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    var swipe: some Gesture {
        DragGesture(minimumDistance: 20.0, coordinateSpace: .local)
            .onEnded { value in
                print(value.translation)
                
                if value.translation.width > 0 && value.translation.height > -80 && value.translation.height < 80 {
                    self.activeTab = activeTab > self.metaData.first!.startYear ? activeTab - 1 : activeTab
                    print("left swipe")
                }
                else if value.translation.width < 0 && value.translation.height > -80 && value.translation.height < 80 {
                    self.activeTab = activeTab < self.metaData.first!.endYear ? activeTab + 1 : activeTab
                    print("right swipe")
                }
                else {
                    print("no clue")
                }
            }
    }
}

struct DateShell_Previews: PreviewProvider {
    static var previews: some View {
        //Date()
        EmptyView()
    }
}
