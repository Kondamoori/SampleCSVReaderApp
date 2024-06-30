//
//  CSVDataView.swift
//  RABOSampleCSVReader
//
//  Created by Kondamoori, S. (Srinivasarao) on 30/06/2024.
//

import Foundation
import SwiftUI
import TabularData

/// A view which represents CSV data with different layouts.
struct CSVDataView: View {
    
    // MARK: - Internal properties
    
    @StateObject var viewModel: CSVDataViewViewModel = CSVDataViewViewModel(dataRequestManager: CSVDataRequestManager(requestManager: NetworkRequestManager()))
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if viewModel.isLoading {
                    ProgressView(LocalizedTranslator.LoadingViewTranslation.loading)
                } else {
                    if viewModel.viewMode == .plainList {
                        CSVDataListView(userList: viewModel.users)
                    } else {
                        CSVDataFrameView(dataFrame: viewModel.dataFrame).padding(.top, -400)
                    }
                }
            }
            .navigationTitle(LocalizedTranslator.CSVScreenTranslation.title)
            .onAppear {
                Task {
                    try await viewModel.loadCSVData()
                }
            }
            .alert(isPresented: Binding<Bool>(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil } }
            )) {
                Alert(
                    title: Text(LocalizedTranslator.AlertViewTranslation.alertViewTitle),
                    message: Text(viewModel.errorMessage ?? LocalizedTranslator.AlertViewTranslation.defaultAlertMessage),
                    dismissButton: .default(Text(LocalizedTranslator.AlertViewTranslation.dismissButtonTitle))
                )
            }
        }
    }
}

// MARK: - Preview

#Preview {
    CSVDataView()
}
