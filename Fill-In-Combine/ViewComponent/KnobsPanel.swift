//
//  KnobsPanel.swift
//  Fill-In-Combine
//
//  Created by 윤범태 on 2023/08/22.
//

import SwiftUI
import AVFoundation

struct KnobsPanelValues {
    var wholeVolume: Float = 1.0
    var quarterVolume: Float = 0.7
    var eighthVolume: Float = 0.0
    var masterVolume: Float = 0.3
}

class KnobsPanelViewModel: ObservableObject {
    @Published var values = KnobsPanelValues()
}

struct KnobsPanel: View {
    @StateObject var viewModel: KnobsPanelViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ArcKnob("|w", value: $viewModel.values.wholeVolume, range: 0...1)
                ArcKnob("q", value: $viewModel.values.quarterVolume, range: 0...1)
            }
            HStack(spacing: 0) {
                ArcKnob("Ee", value: $viewModel.values.eighthVolume, range: 0...1)
                ArcKnob("MAS", value: .constant(0.5), range: 0...1, useMusisyncFontForLabel: false)
            }
        }.onAppear {
            
        }
    }
}

struct KnobsPanel_Previews: PreviewProvider {
    static var previews: some View {
        KnobsPanel(viewModel: KnobsPanelViewModel())
    }
}
