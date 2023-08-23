//
//  MusicSheet.swift
//  Fill-In-Combine
//
//  Created by 윤범태 on 2023/08/23.
//

import SwiftUI

struct MusicSheet: View {
    @EnvironmentObject var scoresViewModel: ScoresViewModel
    @State var currentPartialScore: Score?
    
    let scoreHighlightOpacity: Double = 0.3
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
            HStack(spacing: 0) {
                Image(uiImage: bundleImage(name: "base"))
                    .resizable()
                    .frame(width: 1044 / 2, height: 368 / 2)
                // 랜덤 이미지
                ZStack {
                    if let score = scoresViewModel.randomScore {
                        Rectangle()
                            .fill(.gray)
                            .opacity(scoreHighlightOpacity)
                            .frame(width: (score.width) / 2, height: (score.height) / 2)
                        Image(uiImage: bundleImage(name: score.name))
                            .resizable()
                            .frame(width: (score.width) / 2, height: (score.height) / 2)
                            .offset(x: 0, y: score.offsetY)
                    } else {
                        Rectangle()
                            .fill(.gray)
                            .opacity(scoreHighlightOpacity)
                            .frame(width: 298 / 2, height: 241 / 2)
                        Image(uiImage: bundleImage(name: "16"))
                            .resizable()
                            .frame(width: 298 / 2, height: 241 / 2)
                            .offset(x: 0, y: -8.5)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            // Button {
            //     scoresViewModel.getNewRandomScore()
            // } label: {
            //     Text("Refresh")
            // }
        }
        .onAppear {
            
        }
    }
    
    func bundleImage(name: String, type: String = "png") -> UIImage {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            return UIImage()
        }
            return UIImage(contentsOfFile: path) ?? UIImage()
        }
}

struct MusicSheet_Previews: PreviewProvider {
    static var previews: some View {
        MusicSheet()
            .environmentObject(ScoresViewModel())
    }
}
