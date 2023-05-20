//
//  RocketDetailsView.swift
//  SpaceApp1000
//
//  Created by Tiger Nixon on 4/13/23.
//

import SwiftUI

struct RocketDetailsView: View {
    @ObservedObject var rocketDetailsViewModel: RocketDetailsViewModel
    var body: some View {
        VStack(spacing: 0.0) {
            TitleBarView(title: rocket.name) {
                rocketDetailsViewModel.back()
            }
            ScrollView {
                VStack {
                    rocketStatsView()
                    enginesView()
                    firstStageView()
                    secondStageView()
                    
                }
                .padding(.vertical, 16.0)
            }
        }
        .background(Color.midnight)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var rocket: Rocket { rocketDetailsViewModel.rocket }
    
    func rocketStatsView() -> some View {
        VStack {
            VStack {
                VStack {
                    HStack {
                        Text("Rocket Information")
                            .font(.system(size: 22.0).bold())
                            .foregroundColor(.ghost)
                        
                        Spacer()
                    }
                }
                .padding(.leading, 8.0)
                .padding(.top, 8.0)
                rocketStatsViewGuts1()
                rocketStatsViewGuts2()
                Spacer()
                    .frame(height: 8.0)
            }
            .padding(.all, 6.0)
        }
        .background(RoundedRectangle(cornerRadius: 12.0).stroke().foregroundColor(.silver))
        .padding(.horizontal, 16.0)
    }
    
    func rocketStatsViewGuts1() -> some View {
        VStack {
            if let active = rocket.active {
                titleValueCell(title: "Active", value: "\(active)")
            }
            
            if let company = rocket.company {
                titleValueCell(title: "Company", value: company)
            }
            
            if let stages = rocket.stages {
                titleValueCell(title: "Stages", value: "\(stages)")
            }
            
            if let boosters = rocket.boosters {
                titleValueCell(title: "Boosters", value: "\(boosters)")
            }
        }
    }
    
    func rocketStatsViewGuts2() -> some View {
        VStack {
            if let rocketHeight = rocket.height?.meters {
                titleValueCell(title: "Height", value: String(format: "%.2f m", rocketHeight))
            }
            
            if let rocketDiameter = rocket.diameter?.meters {
                titleValueCell(title: "Diameter", value: String(format: "%.2f m", rocketDiameter))
            }
            
            if let rocketMass = rocket.mass?.kg {
                titleValueCell(title: "Mass", value: String(format: "%.2f kg", rocketMass))
            }
            
            if let firstFlight = rocket.firstFlight {
                titleValueCell(title: "First Flight", value: firstFlight)
            }
            
            if let description = rocket.description {
                titleValueCell(title: "Description", value: description)
            }
        }
    }
    
    func enginesView() -> some View {
        VStack {
            VStack {
                VStack {
                    HStack {
                        Text("Engines")
                            .font(.system(size: 22.0).bold())
                            .foregroundColor(.ghost)
                        
                        Spacer()
                    }
                }
                .padding(.leading, 8.0)
                .padding(.top, 8.0)
                
                if let engines = rocket.engines,
                    let thrustVacuum = engines.thrustVacuum?.kN,
                    let thrustSeaLevel = engines.thrustSeaLevel?.kN,
                    let thrustToWeight = engines.thrustToWeight {
                    VStack {
                        VStack {
                            HStack {
                                Text("Specific Impulse")
                                    .font(.system(size: 18.0).bold())
                                    .foregroundColor(.ghost)
                                Spacer()
                            }
                        }
                        .padding(.leading, 8.0)
                        .padding(.top, 8.0)
                        titleValueCell(title: "Thrust (Sea Level)",
                                       value: String(format: "%.2f kN", thrustSeaLevel))
                        titleValueCell(title: "Thrust (Vacuum)",
                                       value: String(format: "%.2f kN", thrustVacuum))
                        titleValueCell(title: "Thrust To Weight",
                                       value: String(format: "%.2f", thrustToWeight))
                        Spacer()
                            .frame(height: 8.0)
                    }
                    .background(RoundedRectangle(cornerRadius: 12.0).stroke().foregroundColor(.silver))
                    .padding(.horizontal, 16.0)
                    .padding(.bottom, 8.0)
                }
                enginesViewGuts1()
                enginesViewGuts2()
                Spacer()
                    .frame(height: 8.0)
            }
            .padding(.all, 6.0)
            
        }
        .background(RoundedRectangle(cornerRadius: 12.0).stroke().foregroundColor(.silver))
        .padding(.horizontal, 16.0)
    }
    
    func enginesViewGuts1() -> some View {
        VStack {
            if let type = rocket.engines?.type {
                titleValueCell(title: "Type",
                               value: type)
            }
            if let number = rocket.engines?.number {
                titleValueCell(title: "Number",
                               value: "\(number)")
            }
            if let version = rocket.engines?.version {
                titleValueCell(title: "Version",
                               value: version)
            }
            if let layout = rocket.engines?.layout {
                titleValueCell(title: "Layout",
                               value: layout)
            }
            if let engineLossMax = rocket.engines?.number {
                titleValueCell(title: "Engine Loss Max",
                               value: "\(engineLossMax)")
            }
        }
    }
    
    func enginesViewGuts2() -> some View {
        VStack {
            if let thrustSeaLevel = rocket.engines?.thrustSeaLevel?.kN {
                titleValueCell(title: "Thrust (Sea Level)", value: String(format: "%.2f kN", thrustSeaLevel))
            }
            if let thrustVacuum = rocket.engines?.thrustVacuum?.kN {
                titleValueCell(title: "Thrust (Vacuum)", value: String(format: "%.2f kN", thrustVacuum))
            }
            if let thrustToWeight = rocket.engines?.thrustToWeight {
                titleValueCell(title: "Thrust To Weight", value: String(format: "%.2f", thrustToWeight))
            }
            if let propellant1 = rocket.engines?.propellant1 {
                titleValueCell(title: "Propellant 1", value: propellant1)
            }
            if let propellant2 = rocket.engines?.propellant2 {
                titleValueCell(title: "Propellant 2", value: propellant2)
            }
        }
    }
    
    func secondStageView() -> some View {
        VStack {
            VStack {
                VStack {
                    HStack {
                        Text("Second Stage")
                            .font(.system(size: 22.0).bold())
                            .foregroundColor(.ghost)
                        
                        Spacer()
                    }
                }
                .padding(.leading, 8.0)
                .padding(.top, 8.0)
                
                if let payloads = rocket.secondStage?.payloads,
                    let compositeFairing = payloads.compositeFairing,
                    let compositeFairingHeight = compositeFairing.height?.meters,
                    let compositeFairingDiameter = compositeFairing.diameter?.meters,
                    let option1 = payloads.option1 {
                    VStack {
                        VStack {
                            HStack {
                                Text("Composite Fairing")
                                    .font(.system(size: 18.0).bold())
                                    .foregroundColor(.ghost)
                                Spacer()
                            }
                        }
                        .padding(.leading, 8.0)
                        .padding(.top, 8.0)
                        
                        titleValueCell(title: "Diameter",
                                       value: String(format: "%.2f m", compositeFairingDiameter))
                        titleValueCell(title: "Height",
                                       value: String(format: "%.2f m", compositeFairingHeight))
                        titleValueCell(title: "Option 1",
                                       value: option1)
                        
                        Spacer()
                            .frame(height: 8.0)
                        
                    }
                    .background(RoundedRectangle(cornerRadius: 12.0).stroke().foregroundColor(.silver))
                    .padding(.horizontal, 16.0)
                    .padding(.bottom, 8.0)
                }
                   
                if let thrust = rocket.secondStage?.thrust?.kN {
                    titleValueCell(title: "Thrust",
                                   value: String(format: "%.2f kN", thrust))
                }
                
                if let reusable = rocket.secondStage?.reusable {
                    titleValueCell(title: "Reusable",
                                   value: "\(reusable)")
                }
                
                if let engines = rocket.secondStage?.engines {
                    titleValueCell(title: "Engines",
                                   value: "\(engines)")
                }
                
                if let fuelAmountTons = rocket.secondStage?.fuelAmountTons {
                    titleValueCell(title: "Fuel Amount",
                                   value: String(format: "%.2f tons", fuelAmountTons))
                }
                
                if let burnTimeSec = rocket.secondStage?.burnTimeSec {
                    titleValueCell(title: "Burn Time",
                                   value: String(format: "%.2f seconds", burnTimeSec))
                }
                Spacer()
                    .frame(height: 8.0)
            }
            .padding(.all, 6.0)
            
        }
        .background(RoundedRectangle(cornerRadius: 12.0).stroke().foregroundColor(.silver))
        .padding(.horizontal, 16.0)
    }
    
    func firstStageView() -> some View {
        VStack {
            VStack {
                VStack {
                    HStack {
                        Text("First Stage")
                            .font(.system(size: 22.0).bold())
                            .foregroundColor(.ghost)
                        
                        Spacer()
                    }
                }
                .padding(.leading, 8.0)
                .padding(.top, 8.0)
                
                if let thrustSeaLevel = rocket.firstStage?.thrustSeaLevel?.kN {
                    titleValueCell(title: "Thrust (Sea Level)", value: String(format: "%.2f kN", thrustSeaLevel))
                }
                if let thrustVacuum = rocket.firstStage?.thrustVacuum?.kN {
                    titleValueCell(title: "Thrust ( Vacuum)", value: String(format: "%.2f kN", thrustVacuum))
                }
                
                if let reusable = rocket.firstStage?.reusable {
                    titleValueCell(title: "Reusable", value: "\(reusable)")
                }
                if let engines = rocket.firstStage?.engines {
                    titleValueCell(title: "Engines", value: "\(engines)")
                }
                if let fuelAmountTons = rocket.firstStage?.fuelAmountTons {
                    titleValueCell(title: "Fuel Amount", value: String(format: "%.2f tons", fuelAmountTons))
                }
                if let burnTimeSec = rocket.firstStage?.burnTimeSec {
                    titleValueCell(title: "Burn Time", value: String(format: "%.2f seconds", burnTimeSec))
                }
                
                Spacer()
                    .frame(height: 8.0)
            }
            .padding(.all, 6.0)
            
        }
        .background(RoundedRectangle(cornerRadius: 12.0).stroke().foregroundColor(.silver))
        .padding(.horizontal, 16.0)
    }
    
    private func titleValueCell(title: String, value: String) -> some View {
        VStack {
            VStack {
                HStack {
                    Text("\(title):")
                        .font(.system(size: 18.0))
                        .foregroundColor(.ghost)
                    
                    Spacer()
                }
                HStack {
                    Text(value)
                        .font(.system(size: 18.0).bold())
                        .foregroundColor(.silver)
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 12.0)
            .padding(.vertical, 8.0)
        }
        .background(RoundedRectangle(cornerRadius: 12.0).foregroundColor(.mauve))
        .padding(.horizontal, 8.0)
        .padding(.vertical, 2.0)
    }
    
}

struct RocketDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RocketDetailsView(rocketDetailsViewModel: RocketDetailsViewModel.mock())
    }
}
