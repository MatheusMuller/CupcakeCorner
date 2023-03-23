//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Matheus Müller on 11/03/23.
//

//    class User: ObservableObject, Codable {
//        enum CodinKeys: CodingKey {
//            case name
//        }
//
//        @Published var name = "Paul Hudson"
//
//        required init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: CodinKeys.self)
//            name = try container.decode(String.self, forKey: .name)
//        }
//
//        func encode(to encoder: Encoder) throws {
//            var container = encoder.container(keyedBy: CodinKeys.self)
//            try container.encode(name, forKey: .name)
//        }
//    }

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Deliver details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
