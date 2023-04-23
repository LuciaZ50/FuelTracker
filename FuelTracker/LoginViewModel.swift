
import Foundation

class LoginViewModel: ObservableObject {
    @Published var isLoading = false
    
    private let service: LoginService
    
    init(service: LoginService) {
        self.service = service
    }
    
    func login() {
        self.isLoading = true
        service.handleLogin()
        service.onFinishedLoggingIn = {
            self.isLoading = false
        }
        service.onErrorLoggingIn = {
            self.isLoading = false
        }
    }
}
