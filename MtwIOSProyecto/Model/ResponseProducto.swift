//
//  ResponseProducto.swift
//  MtwIOSProyecto
//
//  Created by ByRamon on 19/04/20.
//  Copyright © 2020 ByRamon. All rights reserved.
//

import Foundation

class Orden {
    var productos = [ResultProductos]()
    var total: Double {
        if productos.count > 0{
            return productos.reduce(0){$0 + $1.costo}
        }
        return 0.0
    }
    func add(producto: ResultProductos){
        productos.append(producto)
    }
    func remove(producto:ResultProductos){
        if let index = productos.firstIndex(of: producto){
            productos.remove(at: index)
        }
    }
}

struct ResultProductos: Codable, Equatable{
    var id: UUID
    var nombre: String
    var descripcion: String
    var imagen: String
    var costo: Double
    
    #if DEBUG
    static let example = ResultProductos(id: UUID(), nombre: "producto", descripcion: "producto de prueba",  imagen: "https://www.indiaspora.org/wp-content/uploads/2018/10/image-not-available-240x240.jpg", costo: 0)
    #endif
}
