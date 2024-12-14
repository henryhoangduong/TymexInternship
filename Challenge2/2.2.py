class Product:
    def __init__(self, name, price, quantity):
        self.name = name
        self.price = price
        self.quantity = quantity

inventory = [
    Product("Laptop", 999.99, 5),
    Product("Smartphone", 499.99, 10),
    Product("Tablet", 299.99, 0),
    Product("Smartwatch", 199.99, 3)
]

def calculate_total_inventory_value(products):
    total_value = 0
    for product in products:
        total_value += product.price * product.quantity
    return total_value

total_value = calculate_total_inventory_value(inventory)
print(f"Total Inventory Value: ${total_value:.2f}") 

def find_most_expensive_product(products):
    if not products:
        return None
    most_expensive = max(products, key=lambda product: product.price)
    return most_expensive.name

most_expensive_product = find_most_expensive_product(inventory)
print(f"Most Expensive Product: {most_expensive_product}") 

def is_product_in_stock(products, product_name):
    for product in products:
        if product.name == product_name and product.quantity > 0:
            return True
    return False

is_headphones_in_stock = is_product_in_stock(inventory, "Headphones")
print(f"Headphones in Stock: {is_headphones_in_stock}")  

def sort_products(products, key, descending=True):
    return sorted(products, key=lambda product: getattr(product, key), reverse=descending)

sorted_by_price = sort_products(inventory, "price", descending=True)
print("Products sorted by price (descending):")
for product in sorted_by_price:
    print(f"{product.name}: ${product.price}, Quantity: {product.quantity}")

sorted_by_quantity = sort_products(inventory, "quantity", descending=False)
print("\nProducts sorted by quantity (ascending):")
for product in sorted_by_quantity:
    print(f"{product.name}: ${product.price}, Quantity: {product.quantity}")
