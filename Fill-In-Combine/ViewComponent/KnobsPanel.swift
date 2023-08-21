//
//  KnobsPanel.swift
//  Fill-In-Combine
//
//  Created by 윤범태 on 2023/08/22.
//

import SwiftUI

struct KnobsPanel: View {
    @State var value: Float = 0.5
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ArcKnob("|w", value: $value)
                ArcKnob("q", value: $value)
            }
            HStack(spacing: 0) {
                ArcKnob("Ee", value: $value)
                ArcKnob("MAS", value: $value, useMusisyncFontForLabel:  false)
            }
        }
    }
}

struct KnobsPanel_Previews: PreviewProvider {
    static var previews: some View {
        KnobsPanel()
    }
}
