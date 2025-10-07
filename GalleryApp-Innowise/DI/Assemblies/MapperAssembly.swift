//
//  MapperAssembly.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 8.10.25.
//


import Swinject

final class MapperAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ErrorMapper.self) { r in
            return DefaultErrorMapper()
        }.inObjectScope(.container)
    }
}
