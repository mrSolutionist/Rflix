//
//  ApiManager.swift
//  Rflix
//
//  Created by Robin George on 12/11/21.
//

import Foundation

//FIXME: SHOULD I RENAME IT TO ApiDataManager?
protocol ApiDataManagerDelegate{
    func apiData()
}

struct ApiManager{
    
    static let shared = ApiManager()
    
    public let imageUrl = "https://image.tmdb.org/t/p/w500"
    
    private let baseUrl = "https://api.themoviedb.org/3/"
    
    private let apiKey = "?api_key=4aede8b2ecf032bef5691734ca5e1d5a"
    
    //main url for fetching the movies , add genre or any other to get the data
    private let mainListUrl = "discover/movie"
    
    private let genreUrl = "&with_genres="
    
    //use this for getting the list of ids of genre
    private let genreListUrl = "genre/movie/list"
    
    //variable for ApiDataManagerDelegate
    
    //TODO: havint useded delegate
    var apiManagerDelegate : ApiDataManagerDelegate?
    
    private init (){}
    
    //https://api.themoviedb.org/3/discover/movie?api_key=4aede8b2ecf032bef5691734ca5e1d5a&language=en-US
    
    //https://api.themoviedb.org/3/genre/movie/list?api_key=4aede8b2ecf032bef5691734ca5e1d5a
    
    //URLSESSION function
    private func urlSessionManager(url:URL, complition: @escaping ((_ json:GenreModel?) -> () )){
        
        URLSession.shared.dataTask(with: url) { data, resp, error in
            guard let data = data else {
                return
            }
            
            do {
                let movieJsonObject = try JSONDecoder().decode(GenreModel.self, from: data)
                
                //FIXME: should i pass the data  as clousure or as delegate?
                
                //passing as clousure :
                complition(movieJsonObject)
                
                
            }
            
            catch DecodingError.dataCorrupted(let context) {
                print(context)
            } catch DecodingError.keyNotFound(let key, let context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.valueNotFound(let value, let context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.typeMismatch(let type, let context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
            
        }.resume()
    }
    
    
    //STEP 1: GENERATE GENRE KEYS
    //TODO: FUNCTION FOR GENERATING GENRE IDS
    
    
    
    // STEP 2: LOAD WITH GENRE
    func loadDataWithGenreKey(genreKeyValue:String, complition: @escaping (_ json : GenreModel) -> ()){            // for loading the contet with genre key
        
        let moviesUrl = URL(string: "\(baseUrl)\(mainListUrl)\(apiKey)\(genreUrl)\(genreKeyValue)")!  //FIXME: GENRE KEY IS PROVIED ALREADY ,CHANGE IT TO DYNAMIC
        urlSessionManager(url:moviesUrl) { json in
            
            
            //MARK: completion json data for populating to Views
            guard let jsonData = json else {return}
            complition(jsonData)
            
            //MARK: saving to coredata so once loaded data will be fetched from database
            //FIXME: save this json to coreData BUT NOT SAVED
            CoreDataManager.shared.saveObjectForOfflineLoading(jsonData: json!)
        }
        
    }
    
    func getImageData(imageUrl : String , complition: @escaping (_ imageData : Data?) -> ()){
        let baseImageUrl = ApiManager.shared.imageUrl
        let url = URL(string: "\(baseImageUrl)\(imageUrl)")
        let imageData = try! Data(contentsOf: url!)
        complition(imageData)
    }
    
}



