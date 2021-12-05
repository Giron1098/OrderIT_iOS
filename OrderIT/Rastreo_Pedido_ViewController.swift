//
//  Rastreo_Pedido_ViewController.swift
//  OrderIT
//
//  Created by Mac4 on 03/12/21.
//

import UIKit
import MapKit
import CoreLocation

class Rastreo_Pedido_ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var MV_Rastreo_Pedido: MKMapView!
    
    var manager = CLLocationManager()
    
    var direccion_recibida:String?
    var nombreRest_recibido:String?
    var tiempoEstimado_recibido:String?
    
    var latitud_recibida:CLLocationDegrees!
    var longitud_recibida:CLLocationDegrees!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MV_Rastreo_Pedido.delegate = self
        manager.delegate = self
        
        //manager.requestWhenInUseAuthorization()
        //manager.requestLocation()
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        manager.startUpdatingLocation()
        
        trazarRuta()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        trazarRuta()
    }
    
    //Trazado de la ruta
    func prepararTrazadoRuta(coordenadasDestino:CLLocationCoordinate2D)
    {
        if let LAT = latitud_recibida, let LON = longitud_recibida
        {
            let coordenadasOrigen = CLLocationCoordinate2DMake(LAT, LON)
            //Lugar Origen-Destino
            let origenPlaceMK = MKPlacemark(coordinate: coordenadasOrigen)
            let destinoPlaceMK = MKPlacemark(coordinate: coordenadasDestino)
            
            //Creación del objeto MapKitItem
            let origenItem = MKMapItem(placemark: origenPlaceMK)
            let destinoItem = MKMapItem(placemark: destinoPlaceMK)
            
            //Creación de la solicitud de ruta
            let solicitudDestino = MKDirections.Request()
            solicitudDestino.source = origenItem
            solicitudDestino.destination = destinoItem
            
            //Definimos el medio de transporte
            solicitudDestino.transportType = .automobile
            solicitudDestino.requestsAlternateRoutes = true
            
            let direcciones = MKDirections(request: solicitudDestino)
            direcciones.calculate { (respuesta, error) in
                //Guardamos la respuesta en una variable segura
                guard let respuestaSegura = respuesta else {
                    if let error = error
                    {
                        print("Error al calcular la ruta: \(error.localizedDescription)")
                    }
                    return
                }
                print(respuestaSegura.routes.count)
                let ruta = respuestaSegura.routes[0]
                
                //Agregar superposición al mapa
                self.MV_Rastreo_Pedido.addOverlay(ruta.polyline)
                self.MV_Rastreo_Pedido.setVisibleMapRect(ruta.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    //Mostrar ruta encima del mapa
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .green
        return render
    }
    
    //Métodos del CLLocationManager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    //Trazado de ruta mediante la dirección recibida
    func trazarRuta()
    {
        if let direccion = direccion_recibida, let nombre_restaurante = nombreRest_recibido, let tiempo_estimado = tiempoEstimado_recibido
        {
            let geocoder = CLGeocoder()
            
            //Limpiamos el mapa
            let overlays = MV_Rastreo_Pedido.overlays
            let anotaciones = MV_Rastreo_Pedido.annotations
            
            MV_Rastreo_Pedido.removeOverlays(overlays)
            MV_Rastreo_Pedido.removeAnnotations(anotaciones)
            
            geocoder.geocodeAddressString(direccion) { (places: [CLPlacemark]?, error:Error?) in
                //Creamos el destino para nuestra ruta
                
                guard let ruta = places?.first?.location else { return }
                
                if error == nil
                {
                    //Dirección a la que nos vamos a mover
                    let place = places?.first
                    print("Lugar: \(places!)")
                    
                    //Hacemos un zoom al lugar que buscamos
                    let anotacion = MKPointAnnotation()
                    anotacion.coordinate = (place?.location?.coordinate)!
                    
                    //Definimos un nombre a nuestra anotación
                    anotacion.title = nombre_restaurante
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
                    let region = MKCoordinateRegion(center: anotacion.coordinate, span: span)
                    
                    self.MV_Rastreo_Pedido.setRegion(region, animated: true)
                    self.MV_Rastreo_Pedido.addAnnotation(anotacion)
                    self.MV_Rastreo_Pedido.selectAnnotation(anotacion, animated: true)
                    
                    //Mandamos llamar la función creada para trazar la ruta
                    self.prepararTrazadoRuta(coordenadasDestino: ruta.coordinate)
                    self.MV_Rastreo_Pedido.showsUserLocation = true
                    
                    self.showEstimatedTimeAlert(msg: "Tu pedido llegará en aproximadamente:\n \(tiempo_estimado).")
                    
                } else {
                    print("Ubicación del restaurante no encontrada")
                }
            }
            
        }
    }
    
    //Funcion para mostrar un alert con el tiempo de entrega estimado
    func showEstimatedTimeAlert (msg:String)
    {
        let alerta = UIAlertController(title: "Aviso", message:msg, preferredStyle: .alert)
        
        let actionAceptar = UIAlertAction(title: "Aceptar", style:.default, handler: nil)
        
        alerta.addAction(actionAceptar)
        
        present(alerta, animated: true, completion: nil)
    }
}
