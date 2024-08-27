// homework

struct RestaurantEmployee {
    var name: String
    var salary: Double
    var position: String
    
    init(name: String, salary: Double, position: String) {
        self.name = name
        self.salary = salary
        if position == "Cashier" || position == "Chef" {
            self.position = position
        } else {
            fatalError("Invalid position for restaurant employee")
        }
    }
}

class Table {
    var numberOfSeats: Int
    var restaurant: Restaurant
    var guests: Int = 0
    
    init(numberOfSeats: Int, restaurant: Restaurant) {
        self.numberOfSeats = numberOfSeats
        self.restaurant = restaurant
    }
    
    func seatGuests(numberOfGuests: Int) -> Bool {
        if numberOfGuests <= numberOfSeats {
            guests = numberOfGuests
            return true
        } else {
            return false
        }
    }
}

class Restaurant {
    var employees: [RestaurantEmployee]
    var tables: [Table]
    
    init() {
        self.employees = []
        self.tables = []
        self.tables.append(Table(numberOfSeats: 4, restaurant: self))
        self.tables.append(Table(numberOfSeats: 6, restaurant: self))
        self.tables.append(Table(numberOfSeats: 2, restaurant: self))
    }
}

// Пример использования
let restaurant = Restaurant()
restaurant.employees.append(RestaurantEmployee(name: "Julia", salary: 2000, position: "Cashier"))
restaurant.employees.append(RestaurantEmployee(name: "Igor", salary: 3500, position: "Chef"))

for table in restaurant.tables {
    let guests = Int.random(in: 1...9)
    if table.seatGuests(numberOfGuests: guests) {
        print("Seated \(guests) guests at a table with \(table.numberOfSeats) seats")
    } else {
        print("Not enough seats for \(guests) guests at a table with \(table.numberOfSeats) seats")
    }
}