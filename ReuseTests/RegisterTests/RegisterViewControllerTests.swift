//
//  RegisterViewControllerTests.swift
//  ReuseTests
//
//  Created by Julian Marzabal on 23/07/2023.
//

import XCTest
@testable import Reuse

class RegisterViewControllerTests: XCTestCase {
    var sut: RegisterViewController!
    var viewmodel: RegisterViewModel!
    var delegate: registerDelegateMock!
    

    override func setUpWithError() throws {
        viewmodel = RegisterViewModel()
        delegate = registerDelegateMock()
        sut = RegisterViewController(viewmodel: viewmodel)
        sut.viewmodel = viewmodel
        sut.viewmodel.delegate = delegate
        
    }

    override func tearDownWithError() throws {
        viewmodel = nil
        sut = nil
        delegate = nil
        
    }

    func testLoginButtonTapped() throws {
        
        sut.loginButtonTapped()
        
     
        XCTAssertTrue(delegate.toLoginViewCalled)
       
    }


}
