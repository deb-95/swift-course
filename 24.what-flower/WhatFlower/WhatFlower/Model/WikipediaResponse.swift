//
//  WikipediaResponse.swift
//  WhatFlower
//
//  Created by Debora Del Vecchio on 14/09/21.

import Foundation

// MARK: - WikipediaResponse
struct WikipediaResponse: Codable {
    let query: Query
    let batchcomplete: String
}

// MARK: - Query
struct Query: Codable {
    let pageids: [String]
    let pages: [String: Page]
    let redirects, normalized: [Normalized]
}

// MARK: - Normalized
struct Normalized: Codable {
    let from, to: String
}

// MARK: - Page
struct Page: Codable {
    let title: String
    let ns: Int
    let extract: String
    let pageid: Int
    let thumbnail: Thumbnail
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let height: Double
    let width: Double
    let source: String
}
