import SwiftUI

@MainActor
@Observable
final class ListOfCarriersViewModel {
    var fromCity: Settlement?
    var fromStation: Station?
    var toCity: Settlement?
    var toStation: Station?
    
    var checks: Binding<Checks>
    
    var segments: [Segment] = [] {
        didSet {
            applyFilters()
        }
    }
    var filteredSegments: [Segment] = []
    
    private let networkClient = NetworkClient()
    
    init(fromCity: Settlement?, fromStation: Station?, toCity: Settlement?, toStation: Station?, checks: Binding<Checks>) {
        self.fromCity = fromCity
        self.fromStation = fromStation
        self.toCity = toCity
        self.toStation = toStation
        self._checks = checks
    }
    
    func loadSegments() async {
        var newSegments: [Segment] = []
        
        guard let fromStation, let toStation else {
            return
        }
        
        let segments = await networkClient.fetchSegments(from: fromStation.id, to: toStation.id)
        
        for segment in segments {
            guard let arrival = segment.arrival?.toDate(),
                  let departure = segment.departure?.toDate(),
                  let duration = segment.duration,
                  let startDate = segment.start_date?.toLocalizedDateString(),
                  let thread = segment.thread,
                  let carrier = thread.carrier,
                  let carrierCode = carrier.code,
                  let carrierTitle = carrier.title,
                  let carrierPhone = carrier.phone,
                  let carrierLogo = carrier.logo,
                  let carrierEmail = carrier.email else {
                assertionFailure("[ListOfCarriersViewModel] - loadSegments: Unexpected nil.")
                return
            }
            
            let hasTransfers = segment.has_transfers ?? false
                  
            let newCarrier = CarrierInfo(id: carrierCode, title: carrierTitle, phone: carrierPhone, logo: carrierLogo, email: carrierEmail)
            let newSegment = Segment(departure: departure, arrival: arrival, duration: duration / 3600, startDate: startDate, hasTransfers: hasTransfers, carrier: newCarrier)
            
            newSegments.append(newSegment)
        }
        
        self.segments = newSegments
    }
    
    func applyFilters() {
        var tempFilteredSegments: [Segment] = []
        print(checks)
        
        if checks.wrappedValue.isCheckedMorning {
            guard let filterDateStart = "06:00:00".toDate(),
                  let filterDateEnd = "12:00:00".toDate() else {
                return
            }
            
            tempFilteredSegments += segments.filter( {filterDateStart <= $0.departure && $0.departure <= filterDateEnd} )
        }
        
        if checks.wrappedValue.isCheckedDay {
            guard let filterDateStart = "12:00:00".toDate(),
                  let filterDateEnd = "18:00:00".toDate() else {
                return
            }
            
            tempFilteredSegments += segments.filter( {filterDateStart < $0.departure && $0.departure <= filterDateEnd} )
        }
        
        if checks.wrappedValue.isCheckedEvening {
            guard let filterDateStart = "18:00:00".toDate(),
                  let filterDateEnd = "23:59:59".toDate() else {
                return
            }
            
            tempFilteredSegments += segments.filter( {filterDateStart < $0.departure && $0.departure <= filterDateEnd} )
        }
        
        if checks.wrappedValue.isCheckedNight {
            guard let filterDateStart = "00:00:00".toDate(),
                  let filterDateEnd = "06:00:00".toDate() else {
                return
            }
            
            tempFilteredSegments += segments.filter( {filterDateStart <= $0.departure && $0.departure < filterDateEnd} )
        }
        
        if !checks.wrappedValue.isCheckedMorning,
           !checks.wrappedValue.isCheckedDay,
           !checks.wrappedValue.isCheckedEvening,
           !checks.wrappedValue.isCheckedNight {
            tempFilteredSegments = segments
        }
        
        if checks.wrappedValue.isCheckedNo {
            tempFilteredSegments = filteredSegments.filter( { !$0.hasTransfers } )
        }
        
        self.filteredSegments = tempFilteredSegments
    }
}
