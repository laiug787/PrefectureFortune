//
//  View.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/02
//

import SwiftUI

extension View {
    func glassCardStyle() -> some View {
        self.modifier(GlassCardStyle())
    }
}

struct GlassCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
            .frame(minWidth: 90, maxWidth: 350)
            .compositingGroup()
            .shadow(radius: 8)
    }
}
