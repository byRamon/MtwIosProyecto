//
//  RequestImage.swift
//  MtwIOSProyecto
//
//  Created by ByRamon on 20/04/20.
//  Copyright © 2020 ByRamon. All rights reserved.
//

import Foundation
import SwiftUI

class RequestImagen: ObservableObject {
    @Published var imagen: UIImage?
    var urlImagen: String?
    var imagenCache = ImagenCache.get()
    
    init(url: String?) {
        self.urlImagen = url
        if cargarImagenCache(){
            print("Imagen del cache")
            return
        }
        //print("imagen de internet")
        cargarImagenUrl()
    }
    
    func cargarImagenCache() -> Bool {
        guard let urlImagen = urlImagen else {
            return false
        }
        guard let imagenCache = imagenCache.get(key: urlImagen) else {
            return false
        }
        imagen = imagenCache
        return true
    }
    
    func cargarImagenUrl(){
        guard let urlImagen = urlImagen else {
            return
        }
        let url = URL(string: urlImagen)!
        URLSession.shared.dataTask(with: url, completionHandler: getImagenResponse(data:response:error:)
        ).resume()
    }
    func getImagenResponse(data: Data?, response: URLResponse?, error: Error?){
        guard error == nil else{
            print("Error: \(error!)")
            return
        }
        guard let data = data else{
            print("imagen no encontrada")
            return
        }
        DispatchQueue.main.async {
            guard let imagen = UIImage(data: data) else {
                return
            }
            self.imagenCache.set(key: self.urlImagen!, imagen: imagen)
            self.imagen = imagen
        }
    }
}

class ImagenCache{
    var cache = NSCache<NSString, UIImage>()
    func get (key: String) -> UIImage?{
        return cache.object(forKey: NSString(string: key))
    }
    
    func set (key: String, imagen: UIImage){
        cache.setObject(imagen, forKey: NSString(string: key))
    }
}

extension ImagenCache{
    private static var imagen = ImagenCache()
    static func get() -> ImagenCache{
        return imagen
    }
}
