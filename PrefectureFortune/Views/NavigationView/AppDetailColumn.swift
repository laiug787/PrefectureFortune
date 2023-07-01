//
//  AppDetailColumn.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/29
//

import SwiftUI

struct AppDetailColumn: View {
    @Binding var screen: AppScreen?
    
    var body: some View {
        Group {
            if let screen = screen {
                screen.destination
            } else {
                ContentUnavailableView(
                    text: "Select a Tab",
                    systemImage: "rectangle.stack",
                    description: "Pick something from the list."
                )
            }
        }
    }
}

struct AppDetailColumn_Previews: PreviewProvider {
    static var previews: some View {
        AppDetailColumn(screen: .constant(.predict))
    }
}
