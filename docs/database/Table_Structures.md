Users Table
- UserID (PK)
- Name
- Email
- Password
- Address

Products Table
- ProductID (PK)
- Name
- Brand
- Specs
- Price
- Stock

Orders Table
- OrderID (PK)
- UserID (FK)
- Date
- Status
- TotalAmount

Payments Table
- PaymentID (PK)
- OrderID (FK → Orders.OrderID)
- Method (Credit Card, PayPal, etc.)
- Status (Pending, Completed, Failed)
- TransactionDate

Cart Table
- CartID (PK)
- UserID (FK → Users.UserID)
- ProductID (FK → Products.ProductID)
- Quantity
- DateAdded
(This supports many‑to‑many between Users and Products, with Cart as the linking table.)

Wishlist Table
- WishlistID (PK)
- UserID (FK → Users.UserID)
- ProductID (FK → Products.ProductID)
- DateAdded

Reviews Table
- ReviewID (PK)
- UserID (FK → Users.UserID)
- ProductID (FK → Products.ProductID)
- Rating (1–5 stars)
- Comment (text)
- ReviewDate