//
//  Usuario+CoreDataProperties.swift
//  MtwIOSProyecto
//
//  Created by ByRamon on 18/04/20.
//  Copyright © 2020 ByRamon. All rights reserved.
//
//

import Foundation
import CoreData


extension Usuario {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Usuario> {
        return NSFetchRequest<Usuario>(entityName: "Usuario")
    }

    @NSManaged public var direccion: String?
    @NSManaged public var nombre: String?
    @NSManaged public var telefono: String?
    @NSManaged public var pedidos: NSSet?

}

// MARK: Generated accessors for pedidos
extension Usuario {

    @objc(addPedidosObject:)
    @NSManaged public func addToPedidos(_ value: Pedido)

    @objc(removePedidosObject:)
    @NSManaged public func removeFromPedidos(_ value: Pedido)

    @objc(addPedidos:)
    @NSManaged public func addToPedidos(_ values: NSSet)

    @objc(removePedidos:)
    @NSManaged public func removeFromPedidos(_ values: NSSet)

}
