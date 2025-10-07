//
//  Photo.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 29.09.25.
//

struct Photo: Hashable {
    let id: String
    let width: Int
    let height: Int
    let averageColor: String
    let descriptionText: String?
    let altDescription: String?
    let thumbnailUrl: String
    let fullUrl: String
    let authorName: String
    let authorUsername: String
    
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
