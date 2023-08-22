//
//  LEDIndicator.swift
//  Fill-In-Combine
//
//  Created by 윤범태 on 2023/08/22.
//

import SwiftUI

struct LEDIndicator: View {
    @Binding var fillColor: Color
    @Binding var isOn: Bool
    @State private var isFlicked: Bool = false
    
    private let flickerMillisecond = 50
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                Spacer()
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(isOn && !isFlicked ? fillColor : .gray)
                    .animation(.linear, value: isFlicked)
                Spacer()
            }
            .onChange(of: isOn) { isOn in
                if isOn {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(flickerMillisecond)) {
                        isFlicked = true
                    }
                } else {
                    isFlicked = false
                }
            }
            Spacer()
        }
    }
}

@available(iOS 15.0, *)
struct LEDIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LEDIndicator(fillColor: .constant(.cyan), isOn: .constant(true))
    }
}
