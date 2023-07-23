//
//  ReuseTests.swift
//  ReuseTests
//
//  Created by Julian Marzabal on 18/07/2023.
//

import XCTest
@testable import Reuse
class registerDelegateMock: RegisterViewDelegate {
    var toLoginViewCalled = false
    var toHomeViewCalled = false
    var showErrorCalled = false
    var showErrorText = "ss"
    func toLoginView() {
        toLoginViewCalled = true
    }
    
    func toHomeView() {
        toHomeViewCalled = true
    }
    
    func showError(text: String) {
        showErrorCalled = true
        showErrorText = text
    }
    
    
}

class ReuseTests: XCTestCase {
    var sut: RegisterViewModel!
    var  delegate: registerDelegateMock!
    var firebaseMock: FirebaseMock!
    
    
    
    

    override func setUpWithError() throws {
        sut = .init()
        delegate = .init()
        firebaseMock = .init()
        sut.firebaseManager = firebaseMock
        sut.delegate = delegate
        
     
        
        
    }

    override func tearDownWithError() throws {
       sut = nil
        delegate = nil
       firebaseMock = nil
        
    }

    func testRegisterSuccess() throws {
        sut.name = "frfr"
        sut.password = "frfr"
        sut.email = "pepe"
        sut.surname = "sese"
        sut.passwordConfirm = "frfr"
        
        firebaseMock.response = .success(UserModel.init(name: "hola"))
        sut.registerButtonTapped()
        
    
        XCTAssertTrue(delegate.toHomeViewCalled)
        XCTAssertFalse(delegate.showErrorCalled)
        XCTAssertFalse(delegate.toLoginViewCalled)
        
    }
    func testRegisterUnsuccess() throws {
        sut.name = "frfr"
        sut.password = "frfr"
        sut.email = "pepe"
        sut.surname = "sese"
        sut.passwordConfirm = "frfr"
        
        firebaseMock.response = .failure(APIError.invalidURL)
        sut.registerButtonTapped()
        
    
        XCTAssertFalse(delegate.toHomeViewCalled)
        XCTAssertTrue(delegate.showErrorCalled)
        XCTAssertEqual(delegate.showErrorText, "The operation couldn’t be completed. (Reuse.APIError error 0.)")
        
    }
    
    func testOnViewDidLoadRegisterButtonPressed() {
        sut.onViewDidLoad()
        
        
       
        
    }



}
