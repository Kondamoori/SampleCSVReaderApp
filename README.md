# RABOSampleCSVReader App

RABOSampleCSVReader is a SwiftUI application that allows users to visualise CSV data in both a grid view and a table (list) view. This app  uses SwiftUI's `TabView` to switch between different data presentation styles and how to parse CSV files using the `TabularData` apple API to read CSV files with different options.

**Kindly Please Note: This is just sample project for interiew purpose, all sample names are used for demo purpose, RABO is not resposnible for any of the code or patterens followed here. Thanks**:

## Features

- **Tab Bar Interface**: Switch between grid view and table view using a tab bar.
- **Grid View**: Displays CSV data in a grid layout.
- **Table View**: Displays CSV data in a list layout.
- **CSV Parsing**: Parses CSV files asynchronously without blocking the UI thread.
- **Data Fetch From Remove**: fetch CSV file from Server with async await.
- **Offline Mode**: Supports offline mode by loading local CSV file.

## Requirements

- iOS 15.0+ / macOS 12.0+
- Xcode 15.0+
- Swift 5.0+

## Viewing CSV Data

1. **Grid View**:
    - Accessible via the first tab.
    - Displays CSV data in a grid format, with each cell representing a CSV value.
    - Note: Please scroll the conent both horizontally & vertically to view the CSV file content on this grid layout.

2. **Table View**:
    - Accessible via the second tab (icon: list).
    - Displays CSV data in a list format, with each row representing a CSV row.

### Sample CSV File

 -- Note: To test the app, we have place a sample CSV file named `issues.csv` in project bundle. The app will load and display this file when launched as APIRequest environment mode configured as .offlineMode for CSVDataRequestManager.

You can also try different type of CSV files with configurable `CSVReadingOptions` options. Example below.       
- ** let csvOptions = CSVReadingOptions(hasHeaderRow: true, ignoresEmptyLines: true, delimiter: ",") etc..**
- ** let csvDataViewViewModel = CSVDataViewViewModel(csvReadingOptions: csvOptions)**



## Project Structure

- **CSVTabView.swift**: Contains the main `TabView` with tabs for `GridView` and `TableView`.
- **CSVDataView.swift**:  Main view which can load CSV file data in two different layout.
- **CSVDataViewViewModel.swift**: View model which is responsible for the fetch & process data for `CSVDataView`.
- **CSVDataRequestManager.swift**: Manages the network request to fetch CSV data.
- **NetworkRequestManager.swift**: Generic network manager to connect backend or local with file path.

## Screenshots
![Simulator Screenshot - iPhone 15 Pro - 2024-06-30 at 23 54 45](https://github.com/Kondamoori/SampleCSVReaderApp/assets/167027211/41225f9d-ad72-45ec-9945-b4abaa07de1a)
![Simulator Screenshot - iPhone 15 Pro - 2024-06-30 at 23 54 51](https://github.com/Kondamoori/SampleCSVReaderApp/assets/167027211/f8b9ec45-0ba9-4add-9741-cc533db74eb9)

-- Demo Video.
https://github.com/Kondamoori/SampleCSVReaderApp/assets/167027211/2bb9da62-235b-4edd-b8c1-d87a81dd91c7

## Unit Test Coverage
- This application has good unit test coverage with 80%.

## Improvements can be considered if we have some more time.
- Enrich grid layout with outlines and rows & sections
- Accessibility.
- UITests
- Search bar for list view.
- Load or browse list of CSV files with FileManager from Local data store or Folder. 
