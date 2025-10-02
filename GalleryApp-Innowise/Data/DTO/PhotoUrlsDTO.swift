//
//  PhotoUrlsDTO.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 29.09.25.
//

struct PhotoUrlsDTO: Decodable {
    let raw: String?
    let full: String?
    let regular: String?
    let small: String?
    let thumb: String?
}
