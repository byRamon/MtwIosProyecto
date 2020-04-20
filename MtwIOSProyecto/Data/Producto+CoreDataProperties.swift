//
//  Producto+CoreDataProperties.swift
//  MtwIOSProyecto
//
//  Created by ByRamon on 18/04/20.
//  Copyright © 2020 ByRamon. All rights reserved.
//
//

import Foundation
import CoreData


extension Producto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Producto> {
        return NSFetchRequest<Producto>(entityName: "Producto")
    }

    @NSManaged public var costo: Double
    @NSManaged public var descripcion: String?
    @NSManaged public var imagen: URL?
    @NSManaged public var nombre: String?
    @NSManaged public var pedidos: NSManagedObject?
    
    public var wNombre: String{
        nombre ?? ""
    }
}
