//
//  QuizModels.swift
//  TitleTestApp
//
//  Created by Matt on 3/13/25.
//

import Foundation

struct QuizQuestion: Identifiable, Codable, Equatable {
    let id: Int
    let theme: String
    let title: String
    let description: String?
    let answers: [QuizAnswer]
    
    init(id: Int, theme: String, title: String, description: String? = nil, answers: [QuizAnswer]) {
        self.id = id
        self.theme = theme
        self.title = title
        self.description = description
        self.answers = answers
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.theme = try container.decode(String.self, forKey: .theme)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.answers = try container.decode([QuizAnswer].self, forKey: .answers)
    }
}

struct QuizAnswer: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let description: String?
    let imageURL: String?
    let colorHex: String?
    
    init(id: Int, title: String, description: String? = nil, imageURL: String? = nil, colorHex: String? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.colorHex = colorHex
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
        self.colorHex = try container.decodeIfPresent(String.self, forKey: .colorHex)
    }
}
