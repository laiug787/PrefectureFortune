//
//  LabelIcon.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/03
//

import SwiftUI

struct LabelIcon: View {
    let systemName: String
    let color: Color
    
    var body: some View {
        Image(systemName: systemName)
            .frame(width: 26, height: 26)
            .background(in: RoundedRectangle(cornerRadius: 5, style: .continuous))
            .backgroundStyle(color.gradient)
            .foregroundStyle(.white.shadow(.drop(radius: 1)))
    }
}

struct LabelIcon_Previews: PreviewProvider {
    static var previews: some View {
        LabelIcon(systemName: "pin", color: .blue)
    }
}
