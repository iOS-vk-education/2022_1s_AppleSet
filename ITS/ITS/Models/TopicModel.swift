//
//  TopicModel.swift
//  ITS
//
//  Created by Всеволод on 27.12.2022.
//

import Foundation


final class TopicModel {
    let topics: [String]
    
    init(topics: [String] = []) {
        self.topics = topics
    }
}

struct CreateTopicData {
    let topics : [String]
    
    func dict() -> [String: Any] {
        return [
            "topics": topics,
        ]
    }
}
