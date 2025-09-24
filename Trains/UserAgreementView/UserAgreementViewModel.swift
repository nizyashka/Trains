//
//  UserAgreementViewModel.swift
//  Trains
//
//  Created by Алексей Непряхин on 15.09.2025.
//

import Foundation

@MainActor
@Observable
final class UserAgreementViewModel {
    let networkClient = NetworkClient()
    
    var copyrightText = ""
    
    func loadCopyright() async {
        guard let copyright = await networkClient.fetchCopyrightTextAndImage() else {
            assertionFailure("[UserAgreementViewModel] - loadCopyright: Error loading copyright.")
            return
        }
        
        guard let copyrightText = copyright.text else {
            assertionFailure("[UserAgreementViewModel] - loadCopyright: Error getting html or text.")
            return
        }
        
        self.copyrightText = copyrightText
    }
}
