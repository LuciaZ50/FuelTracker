
import SwiftUI
import SwiftUINavigation
import RealmSwift

struct ContentView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.fuels) { fuel in
                        FuellCellView(fuel: fuel)
                            .background(Color.greenBackground)
                    }
                    .onDelete { indexSet in
                        for index in indexSet{
                            viewModel.delete(at: index)
                    }
                        
                    }
                    .background(Color.greenBackground)
                }
                .listStyle(.grouped)
                .listRowBackground(Color.greenBackground)
                .scrollContentBackground(.hidden)
                .background(Color.greenBackground)
                .sheet(unwrapping: $viewModel.destination, case: /HomeViewModel.Destination.addFuelInfo) { $addFuelVM in
                    AddFuelInfoView(viewModel: addFuelVM)
                }
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        viewModel.addNewFuelInfoTapped()
                    } label: {
                        Text("+")
                            .font(.system(.largeTitle))
                            .frame(width: 77, height: 70)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 7)
                    }
                    .background(Color.brown)
                    .cornerRadius(38.5)
                    .padding()
                    .shadow(color: Color.black.opacity(0.3),
                            radius: 3,
                            x: 3,
                            y: 3)
                }
            }
            .padding()
            .navigationTitle("Fuel tracker")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.greenBackground)
            .navigationDestination(unwrapping: $viewModel.destination, case: /HomeViewModel.Destination.goToLogin, destination: { $VM in
                LoginView(viewModel: VM)
            })
            .toolbar {
                ToolbarItem {
                    Button {
                        viewModel.signOut()
                    } label: {
                        Text("Sign Out")
                            .foregroundColor(.black)
                    }

                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: HomeViewModel(service: Service(), loginService: LoginService()))
    }
}
