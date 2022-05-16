//
//  Post.swift
//  NewsApp
//
//  Created by Алина Бондарчук on 25.03.2022.
//

import Foundation

struct PostItems: Codable {
    var posts: [PostItem]
}

struct PostItem: Codable {
    let postID, timeshamp: Int
    let title, previewText: String
    let likesCount: Int

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
    

}
