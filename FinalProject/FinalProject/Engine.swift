//
//  Engine.swift
//  Assignment4
//
//  Created by Sam Brause on 7/15/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import Foundation

protocol EngineProtocol{
    var delegate: EngineDelegate? {get }
    var grid: GridProtocol{ get }
    var refreshRate: Double{get set}
    var refreshTimer: NSTimer?{get set}
    var rows: Int{get set}
    var cols: Int{get set}
    func step() -> GridProtocol
}

protocol EngineDelegate: class{
    func engineDidUpdate(withGrid: GridProtocol)
    func engineDidUpdate(withConfigurations: Array<Configuration>)
}

extension EngineDelegate{
    func engineDidUpdate(withConfigurations: Array<Configuration>){
        //empty default implementation
    }
}

typealias Cell = (position: Position, state: CellState)
typealias CellInitializer = (Position) -> CellState

class StandardEngine: EngineProtocol{
    
    var configurationIndex: Int?
    var configuration: Configuration? {
        get {
            if delegate is ConfigurationEditorViewController {
                return configurations[configurationIndex!]
            }
            return nil
        }
        set {
            if delegate is ConfigurationEditorViewController {
                configurations[configurationIndex!] = newValue!
            }
        }
    }
    var configurations:Array<Configuration> = [] {
        didSet {
            if let delegate = self.delegate { delegate.engineDidUpdate(self.configurations) }
        }
    }
    
    var timeInterval = 0.2
    func loadConfigurations(urlString: String){
        let url = NSURL(string: urlString)!
        let fetcher = Fetcher()
        fetcher.requestJSON(url) {[weak self] (json, message) in
            if let json = json, array = json as? Array<Dictionary<String,AnyObject>> {
                
                self?.configurations = array.map({ (dict) -> Configuration in
                    return Configuration.fromJSON(dict)
                })
                
                let op = NSBlockOperation {
                    if let delegate = self?.delegate{delegate.engineDidUpdate((self?.configurations)!) }
                }
                NSOperationQueue.mainQueue().addOperation(op)
            }
        }
    }
    
    func updateGridBasedOnConfiguration() {
        if let configuration = configuration {
            let newGrid = Grid(rows, cols) { position in
                return configuration.positions.contains({ return position.row == $0.row && position.col == $0.col }) ? .Living : .Empty
            }
            
            grid = newGrid
        }
    }
    
    var grid: GridProtocol
    
    var rows: Int = 20 {
        didSet {
            grid = Grid(self.rows, self.cols) { _,_ in .Empty }
            if let delegate = delegate { delegate.engineDidUpdate(grid) }
        }
    }
    
    var cols: Int = 20 {
        didSet {
            grid = Grid(self.rows, self.cols) { _,_ in .Empty }
            if let delegate = delegate { delegate.engineDidUpdate(grid) }
        }
    }
    
    func countCells() -> Array<Int> {
        var cellStates = Array(count: 4, repeatedValue:0)
        for a in 0..<cols{
            for b in 0..<rows{
                if(grid[b,a] == .Living){
                    cellStates[0] += 1
                }else if(grid[b,a] == .Born){
                    cellStates[1] += 1
                }else if(grid[b,a] == .Died){
                    cellStates[2] += 1
                }else if(grid[b,a] == .Empty){
                    cellStates[3] += 1
                }
            }
        }
        return cellStates
    }
    
    subscript (i:Int, j:Int) -> CellState {
        get {
            return grid.cells[i*cols+j].state
        }
        set {
            grid.cells[i*cols+j].state = newValue
        }
    }
    
    private init(_ rows: Int, _ cols: Int, cellInitializer: CellInitializer = {_ in .Empty }) {
        self.rows = rows
        self.cols = cols
        self.grid = Grid(rows,cols, cellInitializer: cellInitializer)
    }
    
    func initialize() -> GridProtocol {
        for a in 0..<cols{
            for b in 0..<rows{
                grid[b,a] = .Empty
            }
        }
        for a in 0..<cols{
            for b in 0..<rows{
                if arc4random_uniform(3) == 1 {
                    grid[b,a] = .Living
                }
            }
        }
        return grid
    }
    
    private static var _sharedInstance = StandardEngine(10, 10)
    static var sharedInstance: StandardEngine {
        return _sharedInstance
    }
    
    var delegate: EngineDelegate?
    
    var grid2 = Array(count: 011340, repeatedValue: Array(count: 011340, repeatedValue: CellState.Empty))
    
    var refreshRate: Double{
        get{
            return 0.0
        }
        set(newValue){
            self.refreshRate = newValue
        }
    }
    
    var refreshTimer: NSTimer?
    
    func step() -> GridProtocol{
        var newGrid = Grid(self.rows, self.cols)
        newGrid.cells = grid.cells.map {
            switch grid.livingNeighbors($0.position) {
            case 2 where $0.state.isLiving(),
            3 where $0.state.isLiving():  return Cell($0.position, .Living)
            case 3 where !$0.state.isLiving(): return Cell($0.position, .Born)
            case _ where $0.state.isLiving():  return Cell($0.position, .Died)
            default:                           return Cell($0.position, .Empty)
            }
        }
        grid = newGrid
        if let delegate = delegate { delegate.engineDidUpdate(grid) }
        return grid
    }
}
