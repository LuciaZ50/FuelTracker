
import SwiftUI
import SwiftUINavigation

struct AddFuelInfoView: View {
    @ObservedObject var viewModel: AddFuelInfoViewModel
    @State var fuel = FuelInfo(date: Date(), fuelAmount: "", mileage: "")
    var closedRange = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
    
    var body: some View {
        VStack {
            Image(systemName: "car")
                .font(.system(size: 60))
                .bold()
            DatePicker("Pick a date: ", selection: $fuel.date)
                .bold()
                .padding()
            HStack {
                Text("Enter amount: ")
                    .bold()
                TextField("Enter amount of fuel", text: $fuel.fuelAmount)
                    .modifier(TextFieldModifier())
                
            }
            .padding(.horizontal)
            HStack {
                Text("Enter distance: ")
                    .bold()
                TextField("Enter distance", text: $fuel.distance)
                    .modifier(TextFieldModifier())
                
            }
            .padding(.horizontal)
            Button {
                viewModel.save(fuel: fuel)
            } label: {
                Text("Save")
                    .fontWeight(.semibold)
            }
            .foregroundColor(.black)
            .buttonStyle(.bordered)
            .tint(.white)
            .padding(.top, 40)

            
        }
        .navigationTitle("Add Fuel Info")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.greenBackground)
        .alert(unwrapping: $viewModel.destination, case: /AddFuelInfoViewModel.Destination.showAlert) { action in
            viewModel.okTapped(action: action)
        }
    }
}

struct AddFuelInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AddFuelInfoView(viewModel: AddFuelInfoViewModel(service: Service()))
    }
}

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .foregroundColor(.black)
            .background(.white)
            .clipShape(Capsule())
            .padding(.horizontal, 5)
    }
}
