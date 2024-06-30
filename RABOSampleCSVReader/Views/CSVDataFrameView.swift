//
//  CSVDataFrameView.swift
//  RABOSampleCSVReader
//
//  Created by Kondamoori, S. (Srinivasarao) on 30/06/2024.
//

import Foundation
import SwiftUI
import TabularData

/// View that represent grid layout.
struct CSVDataFrameView: View {
    
    // MARK: - Internal properties
    
    let dataFrame: DataFrame
    
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            VStack(alignment: .leading) {
                // Header Row
                HStack {
                    ForEach(dataFrame.columns.indices, id: \.self) { index in
                        Text(dataFrame.columns[index].name)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                }
                Divider()
                // Data Rows
                ForEach(0..<dataFrame.rows.count, id: \.self) { rowIndex in
                    HStack {
                        ForEach(dataFrame.columns.indices, id: \.self) { colIndex in
                            Text(valueForCell(rowIndex: rowIndex, columnName: dataFrame.columns[colIndex].name))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    // MARK: - Private functions
    
    private func valueForCell(rowIndex: Int, columnName: String) -> String {
        guard let value = dataFrame[row: rowIndex][columnName] else {
            return ""
        }
        return "\(value)"
    }
}
