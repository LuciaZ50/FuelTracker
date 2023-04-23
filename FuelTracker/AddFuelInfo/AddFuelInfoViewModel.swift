
import Foundation
import _SwiftUINavigationState

class AddFuelInfoViewModel: ObservableObject {
    
    private var service: Service
    var onSaveTapped: (() -> Void)?
    var onOkTapped: (() -> Void)?
    @Published var destination: Destination?
    
    enum Destination {
        case showAlert(AlertState<AlertAction>)
    }
    enum AlertAction {
        case ok
    }
    init(service: Service, destination: Destination? = nil) {
        self.service = service
        self.destination = destination
    }
    func okTapped(action: AlertAction) {
        switch action {
        case .ok:
            onOkTapped?()
        }
    }
    
    func save(fuel: FuelInfo) {
        if validateFields(fuel: fuel) {
            service.writeToRealm(fuel: fuel)
            onSaveTapped?()
        } else {
            destination = .showAlert(AlertState<AlertAction>(
                title: TextState("Invalid input"),
                message: TextState("Please provide a valid amount and distance"),
                buttons: [.default(TextState("OK"), action: .send(.ok))
                         ]
            ))
        }
    }
    func validateFields(fuel: FuelInfo) -> Bool {
        if fuel.fuelAmount.isEmpty || fuel.distance.isEmpty {
                return false
        }
        if !fuel.fuelAmount.isNumeric || !fuel.distance.isNumeric {
            return false
        }
        return true
    }
}
