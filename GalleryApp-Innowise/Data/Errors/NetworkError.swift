//
//  NetworkError.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 7.10.25.
//

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case unauthorized
    case serverError(statusCode: Int)
    case decodingFailed
    case noData
}

