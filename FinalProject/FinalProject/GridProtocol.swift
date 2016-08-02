//
//  Rectangle.swift
//  Assignment4
//
//  Created by Sam Brause on 7/14/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import Foundation
enum CellState: String{
    case Living = "Living"
    case Empty = "Empty"
    case Born = "Born"
    case Died = "Died"
    func toggle(value: CellState) -> CellState {
        if (value == .Empty || value == .Died) {
            return .Living
        }else{
            return .Empty
        }
    }
    func isLiving() -> Bool {
        switch self {
        case .Living, .Born: return true
        case .Died, .Empty: return false
        }
    }
}

protocol GridProtocol {
    var rows: Int { get }
    var cols: Int { get }
    var cells: [Cell] { get set }
    
    var living: Int { get }
    var dead:   Int { get }
    var alive:  Int { get }
    var born:   Int { get }
    var died:   Int { get }
    var empty:  Int { get }
    
    subscript (i:Int, j:Int) -> CellState { get set }
    
    func neighbors(pos: Position) -> [Position]
    func livingNeighbors(position: Position) -> Int
}

protocol ExampleDelegateProtocol {
    func example(example: Grid, didUpdateRows: Int)
}

struct Grid: GridProtocol {
    private(set) var rows: Int
    private(set) var cols: Int
    var cells: [Cell]
    
    var living: Int { return cells.reduce(0) { return  $1.state.isLiving() ?  $0 + 1 : $0 } }
    var dead:   Int { return cells.reduce(0) { return !$1.state.isLiving() ?  $0 + 1 : $0 } }
    var alive:  Int { return cells.reduce(0) { return $1.state == .Living  ?  $0 + 1 : $0 } }
    var born:   Int { return cells.reduce(0) { return  $1.state == .Born   ?  $0 + 1 : $0 } }
    var died:   Int { return cells.reduce(0) { return  $1.state == .Died   ?  $0 + 1 : $0 } }
    var empty:  Int { return cells.reduce(0) { return  $1.state == .Empty  ?  $0 + 1 : $0 } }

    private static var _sharedInstance = Grid(10, 10)
    static var sharedInstance: Grid {
        return _sharedInstance
    }
    
    var CollectionOfCellStates = Array(count: 20, repeatedValue:Array(count: 20, repeatedValue: CellState.Empty))
    init (_ rows: Int, _ cols: Int, cellInitializer: CellInitializer = {_ in .Empty }) {
        self.rows = rows
        self.cols = cols
        self.cells = (0..<rows*cols).map {
            let pos = Position($0/cols, $0%cols)
            return Cell(pos, cellInitializer(pos))
        }
    }
    
    var delegate: ExampleDelegateProtocol?
    
    private var grid = Array(count: 01134, repeatedValue: CellState.Empty)
    subscript (i:Int, j:Int) -> CellState {
        get {
            return cells[i*cols+j].state
        }
        set {
            cells[((i*cols+j)<cells.count ? (i*cols+j):(cells.count-1))].state = newValue
        }
    }
//    subscript(row: Int, col: Int) -> CellState? {
//        get {
//            if grid.count < Int(row*col) { return nil }
//            return grid[Int(row * col + col)]
//        }
//        set (newValue) {
//            if newValue == nil { return }
//            if row < 0 || row >= rows || col < 0 || col >= cols { return }
//            let cellRow = row * cols + col
//            grid[Int(cellRow)] = newValue!
//        }
//    }
    private static let offsets:[Position] = [
        (-1, -1), (-1, 0), (-1, 1),
        ( 0, -1),          ( 0, 1),
        ( 1, -1), ( 1, 0), ( 1, 1)
    ]
    func neighbors(pos: Position) -> [Position] {
        return Grid.offsets.map { Position((pos.row + rows + $0.row) % rows,
            (pos.col + cols + $0.col) % cols) }
    }
    
    func livingNeighbors(position: Position) -> Int {
        return neighbors(position)
            .reduce(0) {
                self[$1.row,$1.col].isLiving() ? $0 + 1 : $0
        }
    }
}