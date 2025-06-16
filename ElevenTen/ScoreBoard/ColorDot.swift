//
//  ColorDot.swift
//  ElevenTen
//
//  Created by Jorge Romo on 15/06/25.
//
import SwiftUI

struct ColorDot: View {
    let color: Color
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 24, height: 24)
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: isSelected ? 3 : 0)
            )
            .onTapGesture {
                onTap()
            }
    }
}
