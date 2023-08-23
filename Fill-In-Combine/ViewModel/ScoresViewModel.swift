//
//  ScoreListViewModel.swift
//  Fill-In-Combine
//
//  Created by 윤범태 on 2023/08/23.
//

import Foundation
import Combine

fileprivate let scoreURL = URL(string: "http://yoonbumtae.com/util/misc/score_list.json")

struct Score: Codable {
    var id: UUID
    var name: String
    var width: Double
    var height: Double
    var offsetY: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case width
        case height
        case offsetY = "offset_y"
    }
}

class ScoresViewModel: ObservableObject {
    @Published var scores: [Score] = []
    @Published var randomScore: Score?
    
    init() {}
    
    func getScores() {
        guard let scoreURL else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: scoreURL)
            // .print()
            .map(\.data)
            .decode(type: [Score].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: &$scores)
    }
    
    func getNewRandomScore() {
        randomScore = scores.filter({ $0.name != "base" && randomScore?.name != $0.name }).randomElement()
    }
}
