//
//  ResponseTiendas.swift
//  MtwIOSProyecto
//
//  Created by ByRamon on 19/04/20.
//  Copyright © 2020 ByRamon. All rights reserved.
//

import Foundation
struct ResultTiendas: Codable{
    var id: UUID
    var nombre: String
    var descripcion: String
    var telefono: String
    var ubicacion: String
    var imagen: String
    
    #if DEBUG
    static let example = ResultTiendas(id: UUID(), nombre: "tienda", descripcion: "tienda de prueba",  telefono:"1234567890", ubicacion: "ubicacion ejemplo", imagen: "https://www.indiaspora.org/wp-content/uploads/2018/10/image-not-available-240x240.jpg")
    #endif
}


struct ResulProductos: Codable{
    var id: UUID
    var nombre: String
    var descripcion: String
    var telefono: String
    var ubicacion: String
    var imagen: String
    
    #if DEBUG
    static let example = ResultTiendas(id: UUID(), nombre: "tienda", descripcion: "tienda de prueba",  telefono:"1234567890", ubicacion: "ubicacion ejemplo", imagen: "https://www.indiaspora.org/wp-content/uploads/2018/10/image-not-available-240x240.jpg")
    #endif
}
