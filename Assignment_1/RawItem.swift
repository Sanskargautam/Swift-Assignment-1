//
//  RawTax.swift
//  Assignment_1
//
//  Created by Sanskar on 24/01/22.
//

import Foundation

class RawItem : Items
{
    override init(_ name:String,_ quantity:Int,_ price:Double)
    {
        super.init(name, quantity, price)
    }

    override func calculateTax() -> Double
    {
        return (0.125 * price)
    }
    
    override func print()
    {
        super.print()
        Swift.print("Type  :  raw")
        Swift.print("Tax  :  \(calculateTax())")
        Swift.print("Total price  :  \(calculateTax() + self.price)")

        Swift.print()
        Swift.print("-------------------------------------------------")
    }
}
