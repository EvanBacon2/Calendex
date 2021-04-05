//
//  DataRecord.swift
//  Calendex
//
//  Created by Evan Bacon on 2/18/21.
//

import SwiftUI

struct DataRecord: View {
    @StateObject var viewModel: DataRecordViewModel = DataRecordViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<viewModel.records.count) { i in
                Spacer().frame(height: Spacing.DOUBLE_SPACE)
                Text(String(viewModel.records[i].0)).font(.title3)
                Spacer().frame(height: Spacing.SINGLE_SPACE)
                DataBar(record: viewModel.records[i].1)
            }
        }
    }
}

struct DataRecord_Previews: PreviewProvider {
    static var previews: some View {
        DataRecord()
    }
}
