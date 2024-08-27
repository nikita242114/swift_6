// block 1

protocol Menu {
    var name: String { get }
    var cost: Double { get }
}

struct Tea: Menu {
    enum TeaType {
        case black
        case fruit
        case green
    }
    
    private var teaCost: Double
    var type: TeaType
    
    var name: String {
        return "\(type) tea"
    }
    
    var cost: Double {
        return teaCost
    }
    
    init(cost: Double, type: TeaType) {
        self.teaCost = cost
        self.type = type
    }
}

var a: [Tea] = []
var b = a

print(Unmanaged.passUnretained(a as AnyObject).toOpaque())
print(Unmanaged.passUnretained(b as AnyObject).toOpaque())

b.append(Tea(cost: 2.0, type: .black))

print(Unmanaged.passUnretained(a as AnyObject).toOpaque())
print(Unmanaged.passUnretained(b as AnyObject).toOpaque())
// Результат: При присвоении переменной b значения переменной a, b указывает на тот же массив, что и a. Поэтому при изменении b, меняется и a.

class TestClass {
    var test: String
    init(test: String) {
        self.test = test
    }
}

var c = TestClass(test: "Hello")
var d = c

d.test = "World"

print(c.test) // Выведет "World"
print(d.test) // Выведет "World"
// Результат: При присвоении переменной d значения переменной c, d указывает на тот же объект, что и c. Поэтому при изменении d, меняется и c.

struct TestStruct {
    var test: String
}
var e = TestStruct(test: "Hello")
var f = e

f.test = "World"

print(e.test) // Выведет "Hello"
print(f.test) // Выведет "World"
// Результат: Структуры передаются по значению, поэтому при присвоении переменной f значения переменной e, изменение f не влияет на e.

class Shop {
    struct Employee {
        var name: String
        var position: String
    }
    
    struct Product {
        var name: String
        var category: String
        var price: Double
    }
    
    var products: [Product]
    var employees: [Employee]
    var owner: ShopOwner?
    
    init(products: [Product], employees: [Employee]) {
        self.products = products
        self.employees = employees
    }
    
    func addEmployee(employee: Employee) {
        employees.append(employee)
    }
    
    func addProduct(product: Product) {
        products.append(product)
    }
}

class ShopOwner {
    var shop: Shop
    init(shop: Shop) {
        self.shop = shop
        shop.owner = self
    }
}
// Ответ на вопрос: В такой связке магазин -> директор и директор -> магазин может возникнуть проблема циклической зависимости. 
// Для ее решения можно вынести общую логику в отдельный класс или протокол, чтобы избежать прямой зависимости между классами.

// block 2

protocol Menu {
    var name: String { get }
    var cost: Double { get }
}

struct Tea: Menu {
    enum TeaType {
        case black
        case fruit
        case green
    }
    
    private var teaCost: Double
    var type: TeaType
    var temperature: Int
    
    var name: String {
        return "\(type) tea"
    }
    
    var cost: Double {
        return teaCost
    }
    
    init(cost: Double, type: TeaType, temperature: Int) {
        self.teaCost = cost
        self.type = type
        self.temperature = temperature
    }
}

struct Lemonade: Menu {
    var name: String
    var cost: Double
}

struct Salad: Menu {
    var name: String
    var cost: Double
}

class Shop {
    struct Employee {
        var name: String
        var position: String
    }
    
    struct Product {
        var name: String
        var category: String
        var price: Double
    }
    
    var products: [Product]
    var employees: [Employee]
    var owner: ShopOwner?
    var cafe: Cafe
    
    init(products: [Product], employees: [Employee], owner: ShopOwner) {
        self.products = products
        self.employees = employees
        self.owner = owner
        self.cafe = Cafe(owner: owner)
    }
    
    func getCafeMenu() -> [String: [Menu]] {
        var menuDict: [String: [Menu]] = [:]
        for menu in cafe.menu {
            let key = menu.name
            if menuDict[key] == nil {
                menuDict[key] = [menu]
            } else {
                menuDict[key]?.append(menu)
            }
        }
        return menuDict
    }
    
    func getCafeMenuCosts() -> [String: [Double]] {
        var menuCostsDict: [String: [Double]] = [:]
        for menu in cafe.menu {
            let key = menu.name
            if menuCostsDict[key] == nil {
                menuCostsDict[key] = [menu.cost]
            } else {
                menuCostsDict[key]?.append(menu.cost)
            }
        }
        return menuCostsDict
    }
}

class ShopOwner {
    var shop: Shop
    init(shop: Shop) {
        self.shop = shop
        shop.owner = self
    }
}

class Cafe {
    fileprivate var menu: [Menu]
    var owner: ShopOwner
    
    init(owner: ShopOwner) {
        self.menu = []
        self.owner = owner
    }
    
    func add(menuItem: Menu) {
        menu.append(menuItem)
    }
    
    func printTeaTemperatures() {
        for item in menu {
            if let tea = item as? Tea {
                print("\(tea.name) - Temperature: \(tea.temperature)")
            }
        }
    }
}