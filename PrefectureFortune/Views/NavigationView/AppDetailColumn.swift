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
                VStack {
                    Image(systemName: "rectangle.stack")
                        .font(.system(size: 100))
                        .foregroundColor(.secondary)
                        .padding(4)
                    Text("Select a Tab")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                    Text("Pick something from the list.")
                        .font(.title)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct AppDetailColumn_Previews: PreviewProvider {
    static var previews: some View {
        AppDetailColumn(screen: .constant(.predict))
    }
}
