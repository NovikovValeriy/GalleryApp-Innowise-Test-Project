//
//  PhotoEntityMapper.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 7.10.25.
//


struct PhotoEntityMapper {
    static func mapToDomain(_ entity: PhotoEntity) -> Photo {
        Photo(
            id: entity.id ?? "",
            width: Int(entity.width),
            height: Int(entity.height),
            averageColor: entity.averageColor,
            descriptionText: entity.descriptionText,
            altDescription: entity.altDescription,
            thumbnailUrl: entity.thumbnailUrl,
            fullUrl: entity.fullUrl,
            authorName: entity.authorName,
            authorUsername: entity.authorUsername
        )
    }
}
