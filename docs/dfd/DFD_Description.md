📊 LaptopHarbor – Data Flow Diagrams
Level 0 – Context Diagram
This is the highest‑level view: LaptopHarbor as a single process interacting with external entities.

Entities:

User (customer browsing and buying laptops)

Vendor (provides laptop inventory)

Payment Gateway (handles transactions)

Delivery Service (ships laptops)

Flows:

User → LaptopHarbor → Vendor

User → LaptopHarbor → Payment Gateway

LaptopHarbor → Delivery Service → User

This diagram shows LaptopHarbor as the central hub connecting all stakeholders.

Level 1 – Main Processes
Here we break LaptopHarbor into its major modules.

Processes:

Authentication (login, registration)

Product Management (browse, search, filter laptops)

Shopping Cart (add/remove items, view cart)

Order Processing (checkout, payment, confirmation)

User Profile (manage account, preferences)

Data Stores:

User Database

Product Database

Order Database

Flows:

User credentials → Authentication → User Database

Product queries → Product Management → Product Database

Cart actions → Shopping Cart → Order Database

Checkout → Order Processing → Payment Gateway & Delivery Service

Level 2 – Detailed Processes
Now we expand one module (example: Order Processing) into sub‑processes.

Sub‑Processes:

Checkout (collect shipping & billing info)

Payment Verification (communicate with Payment Gateway)

Order Confirmation (generate Order ID, update Order Database)

Order Tracking (update status, notify user)

Flows:

Cart items → Checkout → Payment Verification → Order Confirmation → Order Tracking

Order Database stores all order details

Delivery Service updates tracking info

This level shows the internal logic of how orders move through the system.