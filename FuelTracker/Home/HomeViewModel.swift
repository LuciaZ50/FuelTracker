
import Foundation
import RealmSwift

class HomeViewModel: ObservableObject {
    
    @Published var destination: Destination? {
        didSet {
            bind()
        }
    }
    @Published var fuels: [FuelInfo] = []
    private let service: Service
    private let loginService: LoginService
    
    enum Destination {
        case addFuelInfo(AddFuelInfoViewModel)
        case goToLogin(LoginViewModel)
    }
    
    init(destination: Destination? = nil, service: Service, loginService: LoginService) {
        self.destination = destination
        self.service = service
        self.fuels = service.readFromRealm()
        self.loginService = loginService
        getFuelInputs()
    }
    
    func addNewFuelInfoTapped() {
        destination = .addFuelInfo(AddFuelInfoViewModel(service: Service()))
    }
    func delete(at index: Int) {
        service.deleteFromRealm(at: index)
        self.fuels = service.readFromRealm()
    }
    
    func getFuelInputs() {
        self.fuels = service.readFromRealm()
    }
    func bind() {
        switch destination {
        case let .addFuelInfo(addFuelInfoViewModel):
            addFuelInfoViewModel.onSaveTapped = { [weak self] in
                guard let self else { return }
                self.destination = nil
                self.fuels = self.service.readFromRealm()
            }
        default:
            break
        }
    }
    
    func signOut() {
        loginService.signout()
        destination = .goToLogin(LoginViewModel(service: LoginService()))
    }
}

