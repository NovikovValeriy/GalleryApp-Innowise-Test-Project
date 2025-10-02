//
//  UserDTO.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 29.09.25.
//

struct UserDTO: Decodable {
    let id: String
    let username: String?
    let name: String?
    let first_name: String?
    let last_name: String?
    let profile_image: UserProfileImageLinksDTO?
    let total_photos: Int?
    
    func toDomainModel() -> User {
        User(
            id: id,
            username: username,
            name: name,
            firstName: first_name,
            lastName: last_name,
            profileImageSmallUrl: profile_image?.small ?? "",
            totalPhotos: total_photos
        )
    }
}
