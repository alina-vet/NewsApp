//
//  PostNews.swift
//  NewsApp
//
//  Created by Алина Бондарчук on 26.03.2022.
//

import Foundation

struct Posts: Codable {
    let post: Post
}

struct Post: Codable {
    let postID, timeshamp: Int
    let title, text: String
    let images: [String]?
    let likesCount: Int

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title, text, images
        case likesCount = "likes_count"
    }
}


