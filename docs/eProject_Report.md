Flutter Parcel App - eProject Report

eProject Analysis :

Current System :

Parcel delivery systems often rely on manual booking, limited tracking, and fragmented communication between senders and recipients. Users face challenges such as lack of transparency, difficulty in managing multiple deliveries, and limited digital integration.

Proposed System :

The Flutter Parcel App provides a modern, mobile-first solution for parcel delivery. It integrates a Flutter frontend with a Node.js backend and PostgreSQL database. Key features include user authentication, parcel sending and tracking, wishlist and cart management, and profile handling. The system ensures seamless communication between users and the backend API.

Functional Requirements :

User authentication (login, register, password reset)

Parcel management (send, track, manage wishlist)

Cart functionality (add to cart, checkout)

Profile management

API integration with backend services

Non-Functional Requirements :

Security: JWT-based authentication

Performance: Efficient queries and responsive UI

Scalability: PostgreSQL database design supports growth

Usability: Intuitive Flutter UI

Maintainability: Modular architecture for easy extension

📖 User Guide :

Installation :

Clone the repository:

git clone https://github.com/preshstoner/LaptopHarbor1.git

Navigate to the project directory.

Configuration :

Create a .env file in the backend root with:

API_BASE_URL=http://192.168.0.142:3000
DATABASE_URL=postgresql://laptopharbor:secretpassword@localhost:5432/laptopharbor
JWT_SECRET=supersecret
PORT=3000

Android Emulator: Use http://10.0.2.2:3000

Physical Device: Replace 192.168.0.142 with your machine’s IP + :3000

Running the App :

Backend:

npm install
npm run dev

Frontend:

flutter pub get
flutter run

Using Features :

Login/Register: Access authentication screens.

Wishlist: Add laptops to wishlist.

Cart: Add items to cart and proceed to checkout.

Profile: Manage user details.


Developer Guide :

Architecture :

Frontend: Flutter mobile app

Backend: Node.js with Express

Database: PostgreSQL

Modules :

Auth module (login, register, token management)

Parcel module (send, track)

Wishlist & Cart module

Profile module

APIs :

/auth/login

/auth/register

/auth/refresh

/parcels

/wishlist

/cart

Database Schema :

create extension if not exists "pgcrypto";

create table if not exists users(
    id UUID primary key default gen_random_uuid(),
    name TEXT,
    email TEXT not null unique,
    password_hash TEXT not null,
    is_active BOOLEAN not null default true,
    is_email_verified BOOLEAN not null default false,
    created_at timestamp with time zone default now(),
    updated_at timestamp with time zone default now()
);

create table if not exists auth_tokens(
    id UUID primary key default gen_random_uuid(),
    user_id UUID not null references users(id) on delete cascade,
    token TEXT not null,
    token_type TEXT not null default 'refresh',
    expires_at timestamp with time zone,
    created_at timestamp with time zone default now()
);

create table if not exists password_resets(
    id UUID primary key default gen_random_uuid(),
    user_id UUID not null references users(id) on delete cascade,
    reset_code TEXT not null,
    expires_at timestamp with time zone not null,
    used BOOLEAN not null default false,
    created_at timestamp with time zone default now()
);

create index if not exists idx_users_email on users(email);
create index if not exists idx_auth_tokens_user on auth_tokens(user_id);

Extending the System : 

Add new parcel types or delivery methods

Integrate payment gateway

Enhance tracking with real-time updates

FAQs :

Q: Why does the emulator use 10.0.2.2 instead of localhost?A: Android emulator maps 10.0.2.2 to your computer’s localhost.

Q: How do I run on a physical device?A: Change API_BASE_URL to your computer’s IP + :3000.

Q: What happens if login skips?A: Ensure AuthService checks token validity and initialRoute is set correctly.

Q: How do I reset my password?A: Use the password_resets table and endpoint.

Agile SDLC Notes :

Iterative development: Features built incrementally

Sprint planning: Tasks divided into short sprints

Continuous feedback: Adjustments after each sprint

Collaboration: Team members worked closely, adapting quickly to changes
