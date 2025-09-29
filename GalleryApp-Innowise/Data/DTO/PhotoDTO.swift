//
//  PhotoDTO.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 29.09.25.
//

struct PhotoDTO: Decodable {
    let id: String
    let width: Int
    let height: Int
    let color: String
    let description: String?
    let alt_description: String?
    let urls: PhotoUrlsDTO
    let user: UserDTO
}
