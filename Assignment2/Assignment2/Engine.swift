//
//  Engine.swift
//  Assignment2
//
//  Created by Sam Brause on 7/5/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import Foundation

func step(before: [[Bool]], count: Int) -> ([[Bool]], Int, Int) {
    var after = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: false))
    var neighbors = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: 0))
    for a in 0...9{
        for b in 0...9{
            switch true{
            case (a>0&&a<9&&b<9):
                switch true{
                case b>0:
                    if(before[a+1][b-1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a-1][b-1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a][b-1]){
                        neighbors[a][b] += 1
                    }
                    fallthrough
                default:
                    if(before[a-1][b+1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a][b+1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a+1][b]){
                        neighbors[a][b] += 1
                    }
                    if(before[a-1][b]){
                        neighbors[a][b] += 1
                    }
                    if(before[a+1][b+1]){
                        neighbors[a][b] += 1
                    }
                }
            case (b>0&&a<9&&b<9):
                switch true{
                case a>0:
                    if(before[a-1][b+1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a-1][b-1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a-1][b]){
                        neighbors[a][b] += 1
                    }
                    fallthrough
                default:
                    if(before[a+1][b+1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a+1][b-1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a][b-1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a][b+1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a+1][b]){
                        neighbors[a][b] += 1
                    }
                }
            case (a==0&&b>0):
                switch true{
                case b<9:
                    if(before[a+1][b+1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a+9][b+1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a][b+1]){
                        neighbors[a][b] += 1
                    }
                    fallthrough
                case b==9:
                    if(b==9){
                        if(before[a+1][b-9]){
                            neighbors[a][b] += 1
                        }
                        if(before[a+9][b-9]){
                            neighbors[a][b] += 1
                        }
                        if(before[a][b-9]){
                            neighbors[a][b] += 1
                        }
                    }
                    fallthrough
                default:
                    if(before[a+1][b-1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a+9][b-1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a][b-1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a+1][b]){
                        neighbors[a][b] += 1
                    }
                    if(before[a+9][b]){
                        neighbors[a][b] += 1
                    }
                }
            case (b==0&&a>0):
                switch true{
                case a<9:
                    if(before[a+1][b+1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a+1][b+9]){
                        neighbors[a][b] += 1
                    }
                    if(before[a+1][b]){
                        neighbors[a][b] += 1
                    }
                    fallthrough
                case a==9:
                    if(a==9){
                        if(before[a-9][b+1]){
                            neighbors[a][b] += 1
                        }
                        if(before[a-9][b+9]){
                            neighbors[a][b] += 1
                        }
                        if(before[a-9][b]){
                            neighbors[a][b] += 1
                        }
                    }
                    fallthrough
                default:
                    if(before[a-1][b+1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a-1][b+9]){
                        neighbors[a][b] += 1
                    }
                    if(before[a][b+9]){
                        neighbors[a][b] += 1
                    }
                    if(before[a][b+1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a-1][b]){
                        neighbors[a][b] += 1
                    }
                }
            case (b==0&&a==0):
                if(before[a+1][b+1]){
                    neighbors[a][b] += 1
                }
                if(before[a+9][b+1]){
                    neighbors[a][b] += 1
                }
                if(before[a+1][b+9]){
                    neighbors[a][b] += 1
                }
                if(before[a+9][b+9]){
                    neighbors[a][b] += 1
                }
                if(before[a][b+9]){
                    neighbors[a][b] += 1
                }
                if(before[a][b+1]){
                    neighbors[a][b] += 1
                }
                if(before[a+1][b]){
                    neighbors[a][b] += 1
                }
                if(before[a+9][b]){
                    neighbors[a][b] += 1
                }
            case (b==9&&a==9):
                if(before[a-9][b-9]){
                    neighbors[a][b] += 1
                }
                if(before[a-1][b-9]){
                    neighbors[a][b] += 1
                }
                if(before[a-9][b-1]){
                    neighbors[a][b] += 1
                }
                if(before[a-1][b-1]){
                    neighbors[a][b] += 1
                }
                if(before[a][b-1]){
                    neighbors[a][b] += 1
                }
                if(before[a][b-9]){
                    neighbors[a][b] += 1
                }
                if(before[a-9][b]){
                    neighbors[a][b] += 1
                }
                if(before[a-1][b]){
                    neighbors[a][b] += 1
                }
            default:
                break
            }
        }
    }
    for a in 0...9{
        for b in 0...9{
            if(before[a][b]){
                if(neighbors[a][b]<2){
                    after[a][b]=false
                }else if(neighbors[a][b]>1&&neighbors[a][b]<4){
                    after[a][b]=true
                }else if(neighbors[a][b]>3){
                    after[a][b]=false
                }
            }else{
                if(neighbors[a][b]==3){
                    after[a][b]=true
                }else{
                    after[a][b]=false
                }
            }
        }
    }
    var count2=0
    for a in 0...9{
        for b in 0...9{
            if(after[a][b]){
                count2+=1
            }
        }
    }
    return (after, count, count2)
}

func neighborsA(coordinates: (Int, Int)) -> ([(Int, Int)]){
    var neighbor = Array(count: 8, repeatedValue: (0,0))
    let (a,b)=coordinates
    var c = 0
    switch true{
    case (a>0&&a<9&&b<9):
        switch true{
        case b>0:
            neighbor[c] = (a+1, b-1)
            c+=1
            neighbor[c] = (a-1, b-1)
            c+=1
            neighbor[c] = (a, b-1)
            c+=1
            fallthrough
        default:
            neighbor[c] = (a-1, b+1)
            c+=1
            neighbor[c] = (a, b+1)
            c+=1
            neighbor[c] = (a+1, b)
            c+=1
            neighbor[c] = (a-1, b)
            c+=1
            neighbor[c] = (a+1, b+1)
        }
    case (b>0&&a<9&&b<9):
        switch true{
        case a>0:
            neighbor[c] = (a-1, b+1)
            c+=1
            neighbor[c] = (a-1, b-1)
            c+=1
            neighbor[c] = (a-1, b)
            c+=1
            fallthrough
        default:
            neighbor[c] = (a+1, b+1)
            c+=1
            neighbor[c] = (a+1, b-1)
            c+=1
            neighbor[c] = (a, b-1)
            c+=1
            neighbor[c] = (a, b+1)
            c+=1
            neighbor[c] = (a+1, b)
        }
    case (a==0&&b>0):
        switch true{
        case b<9:
            neighbor[c] = (a+1, b+1)
            c+=1
            neighbor[c] = (a+9, b+1)
            c+=1
            neighbor[c] = (a, b+1)
            c+=1
            fallthrough
        case b==9:
            if(b==9){
                neighbor[c] = (a+1, b-9)
                c+=1
                neighbor[c] = (a+9, b-9)
                c+=1
                neighbor[c] = (a, b-9)
                c+=1
            }
            fallthrough
        default:
            neighbor[c] = (a+1, b-1)
            c+=1
            neighbor[c] = (a+9, b-1)
            c+=1
            neighbor[c] = (a, b-1)
            c+=1
            neighbor[c] = (a+1, b)
            c+=1
            neighbor[c] = (a+9, b)
        }
    case (b==0&&a>0):
        switch true{
        case a<9:
            neighbor[c] = (a+1, b+1)
            c+=1
            neighbor[c] = (a+1, b+9)
            c+=1
            neighbor[c] = (a+1, b)
            c+=1
            fallthrough
        case a==9:
            if(a==9){
                neighbor[c] = (a-9, b+1)
                c+=1
                neighbor[c] = (a-9, b+9)
                c+=1
                neighbor[c] = (a-9, b)
                c+=1
            }
            fallthrough
        default:
            neighbor[c] = (a+1, b+1)
            c+=1
            neighbor[c] = (a-1, b+9)
            c+=1
            neighbor[c] = (a, b+9)
            c+=1
            neighbor[c] = (a, b+1)
            c+=1
            neighbor[c] = (a-1, b)
        }
    case (b==0&&a==0):
        neighbor[c] = (a+1, b+1)
        c+=1
        neighbor[c] = (a+9, b+1)
        c+=1
        neighbor[c] = (a+1, b+9)
        c+=1
        neighbor[c] = (a+9, b+9)
        c+=1
        neighbor[c] = (a, b+9)
        c+=1
        neighbor[c] = (a, b+1)
        c+=1
        neighbor[c] = (a+1, b)
        c+=1
        neighbor[c] = (a+9, b)
    case (b==9&&a==9):
        neighbor[c] = (a-9, b-9)
        c+=1
        neighbor[c] = (a-1, b-9)
        c+=1
        neighbor[c] = (a-9, b-1)
        c+=1
        neighbor[c] = (a-1, b-1)
        c+=1
        neighbor[c] = (a, b-1)
        c+=1
        neighbor[c] = (a, b-9)
        c+=1
        neighbor[c] = (a-9, b)
        c+=1
        neighbor[c] = (a-1, b)
    default:
        break
    }
    return neighbor
}

func step2(before: [[Bool]], count: Int) -> ([[Bool]], Int, Int) {
    for element in before {
        print(element, terminator: "")
    }
    var after = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: false))
    var neighbors = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: 0))
    var s = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: (0,0))))
    for a in 1...9{
        for b in 1...9{
            s[a][b] = neighborsA((a, b))
        }
    }
    for r in 1...9{
        for g in 1...9{
            for b in 1...9{
                let (left, right) = s[r][g][b]
                if(before[left][right]){
                    neighbors[left][right] += 1
                }
            }
        }
    }
    for a in 0...9{
        for b in 0...9{
            if(before[a][b]){
                if(neighbors[a][b]<2){
                    after[a][b]=false
                }else if(neighbors[a][b]>1&&neighbors[a][b]<4){
                    after[a][b]=true
                }else if(neighbors[a][b]>3){
                    after[a][b]=false
                }
            }else{
                if(neighbors[a][b]==3){
                    after[a][b]=true
                }else{
                    after[a][b]=false
                }
            }
        }
    }
    var count2=0
    for a in 0...9{
        for b in 0...9{
            if(after[a][b]){
                count2+=1
            }
        }
    }
    return (after, count, count2)
}