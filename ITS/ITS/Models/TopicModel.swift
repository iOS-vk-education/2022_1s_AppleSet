//
//  TopicModel.swift
//  ITS
//
//  Created by Всеволод on 27.12.2022.
//

import Foundation


final class TopicModel {
    let topic: String
    
    init(topic: String = "") {
        self.topic = topic
    }
}

struct CreateTopicData {
    let topic : String
    
    func dict() -> [String: Any] {
        return [
            "topic": topic,
        ]
    }
}
