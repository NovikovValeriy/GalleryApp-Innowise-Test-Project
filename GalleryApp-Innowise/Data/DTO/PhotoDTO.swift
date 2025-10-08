//
//  PhotoDTO.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 29.09.25.
//

struct PhotoDTO: Decodable {
    let id: String
    let width: Int?
    let height: Int?
    let color: String?
    let description: String?
    let altDescription: String?
    let urls: PhotoUrlsDTO?
    let user: UserDTO?
    
    func toDomainModel() -> Photo {
        Photo(
            id: id,
            width: width ?? 100,
            height: height ?? 100,
            averageColor: color ?? "#000000",
            descriptionText: description,
            altDescription: altDescription,
            thumbnailUrl: urls?.small ?? "",
            fullUrl: urls?.regular ?? "",
            authorName: user?.name ?? "",
            authorUsername: user?.username ?? ""
        )
    }
}
