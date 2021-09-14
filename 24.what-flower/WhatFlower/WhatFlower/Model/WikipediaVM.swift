//
//  WikipediaVM.swift
//  WhatFlower
//
//  Created by Debora Del Vecchio on 14/09/21.
//

import Foundation

struct WikipediaVM {
    let title: String
    let extract: String
    let image: String?
    
    static func fromDto(dto: WikipediaResponse) -> WikipediaVM {
        let firstPageId = dto.query.pageids.first
        if let pageId = firstPageId {
            if let firstResult = dto.query.pages[pageId] {
                return WikipediaVM(
                    title: firstResult.title,
                    extract: firstResult.extract,
                    image: firstResult.thumbnail.source
                )
            }
        }
        return WikipediaVM(title: "Not Found", extract: "Couldn't find flower", image: nil)
    }
}
