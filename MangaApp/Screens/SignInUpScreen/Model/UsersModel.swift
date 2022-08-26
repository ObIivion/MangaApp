//
//  UsersModel.swift
//  MangaApp
//
//  Created by Павел Виноградов on 26.08.2022.
//

import Foundation

struct UsersModel: Codable {
    
    let createdAt: String
    let updatedAt: String
    let name: String
    let pastNames: [String]
    let slug: String
    let about: String
    let location: String
    let waifuOrHusbando: String
    let followersCount: String
    let followingCount: String
    let lifeSpentOnAnime: String
    let birthday: String
    let gender: String
    let commentsCount: Int
    let favouritesCount: Int
    let likesGivenCount: Int
    let reviewsCount: Int
    let likesReceivedCount: Int
    let postsCount: Int
    let mediaReactoinsCount: Int
    let proExpiresAt: String
    let title: String
    let profileCompleted: Bool
    let feedCompleted: Bool
    let website: String
    let proTier: String
    let avatar: URL
    let coverImage: URL
    let email: String
    let password: String
    let confirmed: Bool
    let previousEmail: String
    let language: String
    let timeZone: String
    let country: String
    let shareToGlobal: String
    let titleLanguagePreferenceCanonical: TitleLanguagePreferenceCanonical
    var sfwFilter: Bool = false
    let ratingSystem: RatingSystem
    let theme: Theme
    let faceBookid: String
    let hasPassword: Bool
    let status: String?
    let subscribedToNewsletter: Bool
    let aoPro: String
}


enum TitleLanguagePreferenceCanonical: Codable {
    case canonical
    case romanized
    case english
}

extension TitleLanguagePreferenceCanonical {
    
    var canonTitle: String{
        switch self {
        case .canonical:
            return "canonical"
        case .romanized:
            return "romanized"
        case .english:
            return "english"
        }
    }
}

enum RatingSystem: Codable {
    case advanced
    case regular
    case simple
}

extension RatingSystem {
    
    var rating: String {
        switch self {
        case .advanced:
            return "advanced"
        case .regular:
            return "regular"
        case .simple:
            return "simple"
        }
    }
}

enum Theme: Codable {
    case dark
    case light
}

extension Theme {
    var theme: String {
        switch self {
        case .dark:
            return "dark"
        case .light:
            return "light"
        }
    }
}
