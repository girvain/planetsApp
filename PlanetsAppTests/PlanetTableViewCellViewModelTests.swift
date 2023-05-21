//
//  PlanetTableViewCellViewModel.swift
//  PlanetsAppTests
//
//  Created by Gavin Ross on 21/05/2023.
//

import XCTest
@testable import PlanetsApp

class NetworkMockClass: Network {
    // log of how many times it's executed
    var calls = 0
    override func get<T>(url: String, model: T.Type, completion: @escaping (Swift.Result<T, Network.NetworkErrorType>) -> Void) where T : Decodable, T : Encodable {
        calls += 1
        print("get called \(calls)")
    }
}

final class PlanetTableViewCellViewModelTests: XCTestCase {
    
    // pass in the mock so we can test the vm locally
    let networkMock = NetworkMockClass()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetDataModel() throws {
        let vm = PlanetTableViewCellViewModel()
        vm.network = networkMock
        let model = Result(name: "Dagobah", rotationPeriod: "", orbitalPeriod: "", diameter: "", climate: "", gravity: "", terrain: "", surfaceWater: "", population: "", residents: [], films: ["https://swapi.dev/api/films/2/", "https://swapi.dev/api/films/3/", "https://swapi.dev/api/films/6/"], created: "", edited: "", url: "")
        
        vm.setDataModel(model: model)
        // test the filmsData array is being init'd from having films data
        XCTAssertNotNil(vm.model?.filmsData)
        // should call the network get method 3 times, for the 3 urls in fims
        XCTAssertTrue(networkMock.calls == 3)
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
