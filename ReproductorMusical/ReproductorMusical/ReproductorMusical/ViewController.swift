//
//  ViewController.swift
//  ReproductorMusical
//
//  Created by XCode on 15/12/2021.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController, UITextViewDelegate, AVAudioPlayerDelegate  {

    //Objetos asociados
    @IBOutlet var playSound: UIButton!
    @IBOutlet var portada: UIImageView!
    @IBOutlet var titulo_cancion: UILabel!
    @IBOutlet var artista: UILabel!
    @IBOutlet var letraCancion: UITextView!
    
    //Varaibles a Utilizar
    var cancion = 0
    var titulocancion=""
    var nombreArtista = ""
    var nombre_cancion = " "
    var letra = ""
    var fileName = "letra.txt"
    var mp3File: URL!
    var mp3Filesarchivos: [URL] = []
    var mp3FileNombres = ["Canciones"]
    var player: AVAudioPlayer!

    override func viewDidLoad() {
            super.viewDidLoad()
        letraCancion.isEditable = false  // bloquear el textview
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reproducirDelista()
        // Establecemos un playerItem
    }
  //reproduce cancion directo de la lista de la tabla
    @objc func reproducirDelista () {
        
        player = try! AVAudioPlayer(contentsOf: mp3Filesarchivos[cancion] )
        player.prepareToPlay()
        player.stop()
        let session = AVAudioSession.sharedInstance()
        do{try session.setCategory(AVAudioSession.Category.playback)}//pone cancion en background
        catch
        {print("error de sesion")}
        player.play()
        //obtiene letra de canción
        let lyri = getLyrics(url: mp3Filesarchivos[cancion])
        if ((lyri?.isEmpty) != nil)
        {
            letraCancion.text = lyri
        }else{letraCancion.text = "No hay Información de la letra"}
        
        //Obtiene metadatos de la canción
        let playerItem = AVPlayerItem(url: mp3Filesarchivos[cancion])
        let metadataList = playerItem.asset.commonMetadata
        // Recorremos el array de metadatos para obtener el nombre del artista
        for item in metadataList {
            guard let key = item.commonKey?.rawValue, let value = item.value else{
                continue}
           switch key {
            case "title" :
                titulocancion = value as! String
           case "artist":
            nombreArtista = value as! String
           case "artwork"
                where value is Data : portada.image = UIImage(data: value as! Data)
            default: //si no encuentra datos coloca por defecto los siguientes
                titulocancion = "Desconocido"
                nombreArtista = "Desconocido"
                portada.image = UIImage(named: "vinilo.png")
              continue
           }
        }
        artista.text =  nombreArtista
        titulo_cancion.text = "Titulo: " + nombre_cancion
        player.delegate = self  // delegado para escuchar que la canción ha termiando
    }
    
    @IBAction func reproducir_pausar(_ sender: Any) {
        if (player.isPlaying){
            player.pause()
        }else{
            player.play()}
        }
    
    @IBAction func siguiente_cancion(_ sender: Any) {
        reproducir_siguiente()
    }

    //obtiene letra de canción
    func getLyrics(url: URL) -> String? {
        let asset = AVAsset(url: url)
        return asset.lyrics
    }
    // reproduce canción siguiente
    func reproducir_siguiente()
    {
        if (cancion == mp3Filesarchivos.count-1)
        {cancion = 0}else {cancion+=1}
        let playerItem = AVPlayerItem(url: mp3Filesarchivos[cancion])
        let metadataList = playerItem.asset.commonMetadata
        let lyri = getLyrics(url: mp3Filesarchivos[cancion])
        if ((lyri?.isEmpty) != nil)
        {
            letraCancion.text = lyri
        }else{letraCancion.text = "No hay Información de la letra"}
        for item in metadataList {
            guard let key = item.commonKey?.rawValue, let value = item.value else{
                continue
            }
           switch key {
            case "title" :
                titulocancion = value as! String
            case "artist":
                nombreArtista = value as! String
            case "artwork"
                    where value is Data : portada.image = UIImage(data: value as! Data)
            default:
                letra = "Desconocido"
                titulocancion = "Desconocido"
                nombreArtista = "Desconocido"
                portada.image = UIImage(named: "vinilo.png")
              continue
           }
        }
        artista.text = nombreArtista
        titulo_cancion.text = "Titulo: " + mp3FileNombres[cancion]
        player = try! AVAudioPlayer(contentsOf: mp3Filesarchivos[cancion] )
        player.prepareToPlay()
        player.stop()
        let session = AVAudioSession.sharedInstance()
        do{
            try session.setCategory(AVAudioSession.Category.playback)}
        catch
        {
            print("error de sesion")}
        player.play()
    }
    @IBAction func anterior_cancion(_ sender: Any) {
        
        if (cancion == 0)
        {
            cancion = mp3Filesarchivos.count-1
        }else {
            cancion-=1
        }
        let lyri = getLyrics(url: mp3Filesarchivos[cancion])
        if ((lyri?.isEmpty) != nil)
        {
            letraCancion.text = lyri
        }else{letraCancion.text = "No hay Información de la letra"}
        
        let playerItem = AVPlayerItem(url: mp3Filesarchivos[cancion])
        let metadataList = playerItem.asset.commonMetadata
        for item in metadataList {
            guard let key = item.commonKey?.rawValue, let value = item.value else{
                continue
            }
           switch key {
                case "title" :
                    titulocancion = value as! String
                case "artist":
                    nombreArtista = value as! String
                case "artwork"
                    where value is Data : portada.image = UIImage(data: value as! Data)
                default:
                    titulocancion = "Desconocido"
                    nombreArtista = "Desconocido"
                    portada.image = UIImage(named: "vinilo.png")
                    continue
           }
        }
        artista.text = nombreArtista
        titulo_cancion.text = "Titulo: " + mp3FileNombres[cancion]
        player = try! AVAudioPlayer(contentsOf: mp3Filesarchivos[cancion] )
        player.prepareToPlay()
        player.stop()
        let session = AVAudioSession.sharedInstance()
        do{
            try session.setCategory(AVAudioSession.Category.playback)}
        catch
        {
            print("error de sesion")}
        player.play()
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        reproducir_siguiente()
         }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! TableViewController
        if vc.view != nil {
        }
    }
}
