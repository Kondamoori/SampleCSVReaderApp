//
//  CSVTabView.swift
//  RABOSampleCSVReader
//
//  Created by Kondamoori, S. (Srinivasarao) on 30/06/2024.
//

import SwiftUI

// View responsible to show tab view at launch
struct CSVTabView: View {
    
    // MARK: - Private properties
    
    private let dataRequestManger = CSVDataRequestManager(requestManager: NetworkRequestManager())
    
    var body: some View {
        TabView {
            CSVDataView(viewModel: CSVDataViewViewModel(dataRequestManager: dataRequestManger, viewMode: .gridLayout))
                .tabItem {
                    Image(systemName: "table")
                    Text(LocalizedTranslator.TabTitlesTranslation.gridLayout)
                }
            
            CSVDataView(viewModel: CSVDataViewViewModel(dataRequestManager: dataRequestManger, viewMode: .plainList))
                .tabItem {
                    Image(systemName: "grid")
                    Text(LocalizedTranslator.TabTitlesTranslation.tableLayout)
                }
        }
    }
}
