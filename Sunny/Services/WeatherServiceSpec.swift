import Foundation
import Quick
import Nimble
import RxSwift

@testable import Sunny

class WeatherServiceSpec: QuickSpec {
    override func spec() {
        describe("WeatherService") {
            var sut: MainWeatherService!
            var fakeClient: FakeAPIClient!
            var disposeBag: DisposeBag!

            beforeEach {
                disposeBag = DisposeBag()
                fakeClient = FakeAPIClient()

                sut = MainWeatherService(client: fakeClient)
            }

            describe("weather for location") {
                var result: Weather!

                beforeEach {
                    fakeClient.requestResult = Weather.fixture()

                    sut.weather(for: Location.fixture())
                        .subscribe(onNext: { weather in
                            result = weather
                        })
                        .disposed(by: disposeBag)
                }

                it("should request client for resource") {
                    expect(fakeClient.capturedResource as? Resource<Weather>) == Weather.current(in: Location.fixture())
                }

                it("should return response from client") {
                    expect(result) == fakeClient.requestResult as! Weather?
                }
            }
        }
    }
}

private class FakeAPIClient: APIClient {
    //TODO: change Any? to Resource<Any>? - currently there are issuses with type casting
    var capturedResource: Any?
    var requestResult: Any?

    func request<A>(_ resource: Resource<A>) -> Observable<A> {
        capturedResource = resource

        if let result = requestResult as? A {
            return Observable.just(result)
        }
        return Observable.empty()
    }
}

extension Resource: Equatable {
    public static func ==(lhs: Resource, rhs: Resource) -> Bool {
        return lhs.path == rhs.path && lhs.method == rhs.method
    }
}
