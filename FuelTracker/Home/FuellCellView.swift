
import SwiftUI
import RealmSwift

struct FuellCellView: View {
    
    var fuel: FuelInfo
    
    var body: some View {
        HStack {
            Image(systemName: "car")
                .font(.system(size: 30))
            Spacer()
            VStack(alignment: .leading, spacing: 10) {
                Text(formatDate(time: fuel.date))
                    .font(.headline)
                Text("\(fuel.fuelAmount) L")
                    .bold()
                    .font(.headline)
                Text("\(fuel.distance) km")
                    .bold()
                    .font(.subheadline)
            }
            
        }
        .background(Color.greenBackground)
        .padding()
    }
}

struct FuellCellView_Previews: PreviewProvider {
    static var previews: some View {
        FuellCellView(fuel: FuelInfo(date: Date(), fuelAmount: "", mileage: ""))
    }
}
