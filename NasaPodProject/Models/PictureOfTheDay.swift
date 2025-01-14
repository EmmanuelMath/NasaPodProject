//
//  PictureOfTheDay.swift
//  NasaPodProject
//
//  Created by Emmanuel Mathar on 14/01/2025.
//


struct PictureOfTheDay: Codable, Identifiable {
    var id: String {date}
    let copyright : String?
    let date: String
    let title: String
    let explanation: String
    let url: String
    let mediaType: String

    enum CodingKeys: String, CodingKey {
        case copyright, date, title, explanation, url
        case mediaType = "media_type"
    }
}
