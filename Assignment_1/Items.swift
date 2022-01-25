//
//  items.swift
//  Assignment_1
//
//  Created by Sanskar on 24/01/22.
//

import Foundation

class Items : Tax
{
    var name: String
    var quantity: Int
    var price: Double
    
    func calculateTax() -> Double {
        return 0
    }
    
    func print() {
        Swift.print("Name  :  \(self.name)")
        Swift.print("Price  :  \(self.price)")
        Swift.print("Quantity  :  \(self.quantity)")
    }
    
    init(_ name: String, _ quantity: Int, _ price: Double)
    {
        self.name = name
        self.quantity = quantity
        self.price = price
    }
}
