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
}
