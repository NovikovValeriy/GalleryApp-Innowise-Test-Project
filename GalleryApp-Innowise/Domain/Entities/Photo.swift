//
//  Photo.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 29.09.25.
//

struct Photo {
    let id: String
    let width: Int
    let height: Int
    let averageColor: String
    let description: String?
    let altDescription: String?
    let thumbnailUrl: String?
    let fullUrl: String?
    let author: User
}
