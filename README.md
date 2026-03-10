# Flutter Basic Crud App

## Setup Instructions

1. **Clone the repository**

```bash
git clone <https://github.com/subsavage/basic_crud_app>
cd <project-folder>
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Run the application**

Make sure an emulator or physical device is connected.

```bash
flutter run
```

---

## Packages Used

- **dio (5.9.2)**  
  Used for handling API requests and networking.

- **get (4.7.3)**  
  Used for state management, dependency injection, and navigation.

---

## Assumptions Made

- The API endpoint `https://jsonplaceholder.typicode.com/users` is available and returns valid user data
- The response structure from the API remains consistent and includes fields: `name`, `email`, `phone`, `website`, `company.name`, and `address.city`
- The application requires an active internet connection to fetch users
- Basic error handling is implemented for API failures
