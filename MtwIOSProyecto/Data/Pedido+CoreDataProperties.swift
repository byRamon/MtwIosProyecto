//
//  Pedido+CoreDataProperties.swift
//  MtwIOSProyecto
//
//  Created by ByRamon on 18/04/20.
//  Copyright © 2020 ByRamon. All rights reserved.
//
//

import Foundation
import CoreData


extension Pedido {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pedido> {
        return NSFetchRequest<Pedido>(entityName: "Pedido")
    }

    @NSManaged public var descripcion: String?
    @NSManaged public var total: Double
    @NSManaged public var productos: NSSet?
    @NSManaged public var usuario: Usuario?
    
    public var wDescription: String{
        descripcion ?? ""
    }
    
    public var arrayProductos: [Producto]{
        let set = productos as? Set<Producto> ?? []
        return set.sorted{ $0.wNombre < $1.wNombre}
    }
}

// MARK: Generated accessors for productos
extension Pedido {

    @objc(addProductosObject:)
    @NSManaged public func addToProductos(_ value: Producto)

    @objc(removeProductosObject:)
    @NSManaged public func removeFromProductos(_ value: Producto)

    @objc(addProductos:)
    @NSManaged public func addToProductos(_ values: NSSet)

    @objc(removeProductos:)
    @NSManaged public func removeFromProductos(_ values: NSSet)

}
