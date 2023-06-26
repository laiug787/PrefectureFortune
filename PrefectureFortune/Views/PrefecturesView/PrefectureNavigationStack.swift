//
//  PrefectureNavigationStack.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/27
//

import SwiftUI

struct PrefectureNavigationStack: View {
    var body: some View {
        NavigationStack {
            List {
                Text("Prefecture 1")
                Text("Prefecture 2")
                Text("Prefecture 3")
            }
            .navigationTitle("Prefectures")
        }
    }
}

struct PrefectureNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        PrefectureNavigationStack()
    }
}
