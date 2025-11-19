# 📚 MyQuote – A Ruby on Rails Quote Collection App

A personal quote collection application built using Ruby on Rails.
Users can create, edit, delete, and view quotes with associated authors, categories, and personal notes.
The project was developed for academic assessment in the **CSI1241 Web Application Development** unit.

## ⭐ Features:
### 🔐 Authentication
- Users must be logged in to create or manage quotes.
- Each quote belongs to a specific user.
- Only the owner can edit or delete their quotes.

### 📝 Quote Management (CRUD)
- Add new quotes with the following:
- Quote text
- Author details (first name, last name, birth year, death year, and biography)
- Publication year
- Custom user comment
- One or multiple categories

### 📚 Nested Author Creation

- Quotes allow adding author information directly inside the quote form via accepts_nested_attributes_for.

### 🏷️ Categories
- Many-to-many relationship via quote_categories.
- Users can tag quotes with categories like Inspiration, Philosophy, History, etc.

### 🎨 Bootstrap UI
- Clean and responsive interface.
- Simple and easy-to-use layouts.

### 🏗️ Tech Stack
- Layer	Technology
- Backend	Ruby on Rails
- Database	SQLite3
- Frontend	ERB templates + Bootstrap 5
- Authentication	Custom session-based system
- Architecture	MVC

🔧 Installation & Setup
1. Clone the Repository
```
git clone https://github.com/<your-username>/myquote.git
cd myquote
```

2. Install Dependencies
```bundle install```

3. Set Up the Database
```
rails db:migrate
rails db:seed  # if you add seeds later
```

4. Start the Server
```rails server```

Go to:
👉 http://localhost:3000

## 🗂️ Database Models:

### User

- has_many :quotes

### Quote

- belongs_to :user
- belongs_to :author
- has_many :quote_categories
- has_many :categories, through: :quote_categories

### Author
- has_many :quotes

### Category
- has_many :quote_categories
- has_many :quotes, through: :quote_categories

### QuoteCategory
- Join table between quotes and categories

### 🧪 Key Concepts Demonstrated:
- ✔ MVC architecture
- ✔ RESTful routing
- ✔ CRUD operations
- ✔ Authentication & authorization
- ✔ Nested forms
- ✔ ActiveRecord associations
- ✔ Form validations
- ✔ Bootstrap layout
- ✔ Partials & reusable views

### 🧭 Project Purpose

- This application was designed as a practical demonstration of:
- Rails MVC principles
- Database relationships
- Rails form helpers
- User authentication
- Secure CRUD operations
- Web app development workflow
