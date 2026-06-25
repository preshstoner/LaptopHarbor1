📦 Flutter Parcel App
Overview
This project is a parcel delivery application built with Flutter for the frontend and a Node.js + PostgreSQL backend. It was developed using the Agile Software Development Life Cycle (SDLC), with iterative sprints, continuous feedback, and collaboration guiding the process.

🚀 Getting Started
1. Clone the Repository
bash
git clone https://github.com/preshstoner/LaptopHarbor1.git
2. Environment Configuration
Create a .env file in your backend project root with the following values:

env
API_BASE_URL=http://192.168.0.142:3000
DATABASE_URL=postgresql://laptopharbor:secretpassword@localhost:5432/laptopharbor
JWT_SECRET=supersecret
PORT=3000
API_BASE_URL: Use http://10.0.2.2:3000 if running on an Android emulator (special host for local backend).

DATABASE_URL: Update with your PostgreSQL username, password, and database name.

JWT_SECRET: Any secure string for signing tokens.

PORT: Port your backend server will run on.

3. Database Setup (PostgreSQL)
Run the following SQL to set up your authentication tables:

sql
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
4. Backend Setup
bash
npm install
npm run dev
This will start your backend server on the port specified in .env.

5. Frontend Setup (Flutter)
bash
flutter pub get
flutter run
Make sure your API base URL in the Flutter app points to the same value as in .env.

⚙️ API Base URL Configuration
Android Emulator:
Use the special emulator host to connect to your local backend:

Code
API_BASE_URL=http://10.0.2.2:3000
Physical Device (same WiFi network):
Change the API_BASE_URL in your .env file to your machine’s IP address, followed by :3000.
Example:

Code
API_BASE_URL=http://192.168.0.142:3000
Replace 192.168.0.142 with your own computer’s IP address.

On Windows, run ipconfig in Command Prompt to find your IPv4 address.

On macOS/Linux, run ifconfig or ip addr to find your local IP.

Ensure your device and computer are connected to the same WiFi network.

For Android emulator: http://10.0.2.2:3000

For physical device on same WiFi: use your machine’s IP (e.g., http://192.168.0.142:3000).

📌 Agile SDLC Notes
Iterative development: Features were built incrementally.

Sprint planning: Work was divided into short sprints.

Continuous feedback: Adjustments made after each sprint.

Collaboration: Team members worked closely, adapting quickly to changes.

✅ Summary
To run this project:

Set up PostgreSQL with the schema above.

Configure .env with your API base URL, database URL, JWT secret, and port.

Start the backend server.

Run the Flutter app, ensuring the API base URL matches your environment.
