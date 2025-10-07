//
//  ErrorMapper.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 7.10.25.
//

protocol ErrorMapper {
    func map(_ error: Error) -> String
}

final class DefaultErrorMapper: ErrorMapper {
    func map(_ error: Error) -> String {
        if let repoError = error as? PhotoRepositoryError {
            return mapPhotoRepositoryError(repoError)
        }
        if let savedError = error as? SavedPhotoRepositoryError {
            return mapSavedPhotoRepositoryError(savedError)
        }
        return "Unknow error. Try again later."
    }
    
    private func mapPhotoRepositoryError(_ error: PhotoRepositoryError) -> String {
        switch error {
        case .network(let netErr):
            return mapNetworkError(netErr)
        case .cache:
            return "Cache access failed."
        case .emptyResult:
            return "No new photos."
        }
    }
    
    private func mapSavedPhotoRepositoryError(_ error: SavedPhotoRepositoryError) -> String {
        switch error {
        case .database(let dbError):
            switch dbError {
            case .saveFailed:
                return "Image saving error."
            case .fetchFailed:
                return "Was unable to receive saved photos."
            case .deleteFailed:
                return "Iamge deleting error."
            case .objectNotFound:
                return "Photo was not found."
            }
        case .noSavedPhotos:
            return "No saved photos."
        }
    }
    
    private func mapNetworkError(_ error: NetworkError) -> String {
        switch error {
        case .invalidURL:
            return "Invalid request to the server."
        case .unauthorized:
            return "Authorization error. Check API key."
        case .serverError(let code):
            return "Server error (\(code))."
        case .decodingFailed:
            return "Decoding data error."
        case .noData:
            return "No data from server."
        case .invalidResponse:
            return "Invalid server response."
        case .requestFailed:
            return "Request failed. Check your internet connection."
        }
    }
}
