//
//  ViewController.swift
//  WebServiceClima
//
//  Created by Mario Sanchez on 29/4/15.
//  Copyright (c) 2015 Mario Sanchez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtclima: UITextField!
    
    @IBOutlet weak var lblclima: UILabel!
    
    var clima:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
            http:// openweathermap.org/data/2.5/weather?q=mex
        */
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "1401215.jpg")!)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func btnRecuperarClima(sender: AnyObject) {
        
        //println("Estoy funcionando \(txtclima.text)")
        llamadawebService()

        
    }
    
    

    func llamadawebService(){
        let urlPath = "http://openweathermap.org/data/2.5/weather?q=\(txtclima.text )"
        let url = NSURL(string: urlPath)
        // nsurl transformar un string a url
        let session = NSURLSession.sharedSession()
        //Se crea una session (NSURLSession session compartida) para poder hacer una coneccion con el servidor
        let task = session.dataTaskWithURL(url!,completionHandler: {data, response, error -> Void in
            // la url tiene un trabajo que hacer con una url
            if (error != nil){
                // Imprime descripcion del error si es que no esta vacio
                println(error.localizedDescription)
            }
            var nsdata:NSData = NSData(data: data)
            
            
            //println(nsdata)
            
            self.recuperarClimaDeJson(nsdata)
            
            dispatch_async(dispatch_get_main_queue(), { println(self.clima!);self.lblclima.text = self.clima! })
                            // despachar al hilo principal
                                                        //se despacha lo de arriba
        })
        task.resume()
    }
    
    
    func recuperarClimaDeJson(nsdata:NSData){
        let jsonCompleto : AnyObject!  = NSJSONSerialization.JSONObjectWithData(nsdata, options: NSJSONReadingOptions.MutableContainers, error: nil)
        println(jsonCompleto)
        
        let arregloJsonWeather = jsonCompleto["weather"]
        
        if let jsoArray = arregloJsonWeather as?  NSArray{
            jsoArray.enumerateObjectsUsingBlock({model,index,stop in  self.clima = model["description"] as? String})
        }
        
        
        
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

