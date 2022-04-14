//
//  CarRepositoryTests.swift
//  MVVMTests
//
//  Created by administrator on 4/14/22.
//

import XCTest
@testable import MVVM

class MockNetworkService : NetworkServiceable {
    
    var fecthRequestCalled = false
    var loadCarsCalled = false
    
    func fetchRequest<DataType>(url: String, result: @escaping Completion<DataType>) where DataType : Decodable {
        fecthRequestCalled = true
        
        let cars: [Car] = []
        result(.success(cars as! DataType))
    }
    
    func loadCarsWithAlamofire() {
        loadCarsCalled = true
    }
}

class CarRepositoryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFecthRequestMethod() throws {
        
        let mock = MockNetworkService()
        
        let repository = CarRepository(networkHttpService: mock)
        
        repository.getCars { (result: Result<[Car], Error>)  in
            guard case .success(let value) = result else {
                return XCTFail("Invalid Result")
            }
            
            XCTAssertEqual(value.count, 0)
        }
        
        XCTAssertTrue(mock.fecthRequestCalled)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
