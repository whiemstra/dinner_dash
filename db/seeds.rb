appetizers = Category.create(title: "Appetizers")
sides = Category.create(title: "Sides")
meats = Category.create(title: "Meats")
seafood = Category.create(title: "Seafoods")
desserts = Category.create(title: "Desserts")

appetizers.items.create(title: "French Fries", description: "Very French", price: 4.00)
appetizers.items.create(title: "Mozzarella Sticks", description: "Very Cheesy", price: 5.00)
appetizers.items.create(title: "Onion Rings", description: "Very round rings", price: 4.50)
appetizers.items.create(title: "Dill Pickle Chips", description: "Very Interesting", price: 5.00)
appetizers.items.create(title: "Bacon and Olives", description: "Very Different", price: 5.50)

sides.items.create(title: "Side 1", description: "Description 1", price: 4.75)
sides.items.create(title: "Side 2", description: "Description 2", price: 5.00)
sides.items.create(title: "Side 3", description: "Description 3", price: 4.25)
sides.items.create(title: "Side 4", description: "Description 4", price: 5.50)
sides.items.create(title: "Side 5", description: "Description 5", price: 5.25)

meats.items.create(title: "Meat 1", description: "Description 1", price: 15.25)
meats.items.create(title: "Meat 2", description: "Description 2", price: 13.50)
meats.items.create(title: "Meat 3", description: "Description 3", price: 12.75)
meats.items.create(title: "Meat 4", description: "Description 4", price: 14.25)
meats.items.create(title: "Meat 5", description: "Description 5", price: 15.50)

seafood.items.create(title: "Sea 1", description: "Description 1", price: 13.25)
seafood.items.create(title: "Sea 2", description: "Description 2", price: 15.50)
seafood.items.create(title: "Sea 3", description: "Description 3", price: 14.75)
seafood.items.create(title: "Sea 4", description: "Description 4", price: 15.75)
seafood.items.create(title: "Sea 5", description: "Description 5", price: 16.25)

desserts.items.create(title: "Sweet 1", description: "Description 1", price: 5.00)
desserts.items.create(title: "Sweet 2", description: "Description 2", price: 6.25)
desserts.items.create(title: "Sweet 3", description: "Description 3", price: 5.75)
desserts.items.create(title: "Sweet 4", description: "Description 4", price: 7.25)
desserts.items.create(title: "Sweet 5", description: "Description 5", price: 6.50)

rachel = User.create(full_name: "Rachel Warbelow", email: "demo+rachel@jumpstartlab.com", password: "password")
jeff = User.create(full_name: "Jeff Casimir", display_name: "J3", email: "demo+jeff@jumpstartlab.com", password: "password")
jorge = User.create(full_name: "Jorge Tellez", display_name: "novohispano", email: "demo+jorge@jumpstartlab.com", password: "password")
josh = User.create(full_name: "Josh Cheek", display_name: "josh", email: "demo+josh@jumpstartlab.com", password: "password", role: 1)

order_1  = rachel.orders.create(status: 1, total_price: 6.50)
order_2  = jeff.orders.create(status: 2, total_price: 20.50)
order_3  = jorge.orders.create(status: 3, total_price: 18.00)
order_4  = rachel.orders.create(status: 4, total_price: 12.50)
order_5  = jeff.orders.create(status: 1, total_price: 16.25)
order_6  = jorge.orders.create(status: 2, total_price: 5.50)
order_7  = rachel.orders.create(status: 3, total_price: 14.25)
order_8  = jeff.orders.create(status: 4, total_price: 12.00)
order_9  = jorge.orders.create(status: 1, total_price: 54.00)
order_10 = jeff.orders.create(status: 2, total_price: 27.00)

ItemOrder.create(item_id: 16, quantity: 1, order_id: order_1.id)
ItemOrder.create(item_id: 7, quantity: 1, order_id: order_2.id)
ItemOrder.create(item_id: 15, quantity: 1, order_id: order_2.id)
ItemOrder.create(item_id: 6, quantity: 1, order_id: order_3.id)
ItemOrder.create(item_id: 16, quantity: 1, order_id: order_3.id)
ItemOrder.create(item_id: 17, quantity: 2, order_id: order_4.id)
ItemOrder.create(item_id: 15, quantity: 1, order_id: order_5.id)
ItemOrder.create(item_id: 5, quantity: 1, order_id: order_6.id)
ItemOrder.create(item_id: 1, quantity: 3, order_id: order_7.id)
ItemOrder.create(item_id: 9, quantity: 1, order_id: order_8.id)
ItemOrder.create(item_id: 20, quantity: 1, order_id: order_8.id)
ItemOrder.create(item_id: 12, quantity: 4, order_id: order_9.id)
ItemOrder.create(item_id: 3, quantity: 6, order_id: order_10.id)


