//
//  PrefectureNavigationStack.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/27
//

import SwiftUI

struct PrefectureNavigationStack: View {    
    @StateObject private var prefectureVM = PrefectureViewModel()
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var sizeClass
    #endif
    
    var displayAsList: Bool {
        #if os(iOS)
        return sizeClass == .compact
        #else
        return false
        #endif
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if prefectureVM.viewStyle == .gridView {
                    PrefectureGridView(prefectures: prefectureVM.searchResults)
                } else if displayAsList {
                    PrefectureListView(prefectures: prefectureVM.searchResults)
                } else {
                    PrefectureTableView(prefectures: prefectureVM.searchResults)
                }
            }
            .navigationTitle("Prefectures")
            .navigationDestination(for: Prefecture.self) { prefecture in
                PrefectureDetailView(prefecture: prefecture)
            }
//            .searchable(text: $prefectureVM.searchText)
            .toolbar {
                ToolbarItem {
                    Picker("ViewStyle", selection: $prefectureVM.viewStyle) {
                        Label("Grid", systemImage: "square.grid.2x2").tag(ViewStyle.gridView)
                        Label("List", systemImage: "list.bullet").tag(ViewStyle.ListView)
                    }
                }
            }
        }
    }
}

struct PrefectureNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        PrefectureNavigationStack()
    }
}
