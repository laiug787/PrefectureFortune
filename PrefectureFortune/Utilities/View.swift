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
    
    func tagStyle(color: Color) -> some View {
        self.modifier(TagStyle(color: color))
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

struct TagStyle: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(color.gradient, in: RoundedRectangle(cornerRadius: 8))
            .foregroundColor(.white)
    }
}
