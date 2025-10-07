//
//  NetworkError.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 7.10.25.
//

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingFailed
    case unauthorized
    case serverError(statusCode: Int)
    case unknown(Error)
}
