//
//  DependenciesContainer.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 1.10.25.
//

import Swinject
import Foundation

final class DependenciesContainer {
    static let shared = DependenciesContainer()
    private let assembler: Assembler
    
    func inject<T>() throws -> T {
        if let container = assembler.resolver.resolve(T.self) {
            return container
        } else {
            throw NSError()
        }
    }
    
    private init() {
        self.assembler = Assembler([
            RepositoryAssembly(),
            UseCaseAssembly(),
            MapperAssembly(),
            ViewModelAssembly()
        ])
    }
}
