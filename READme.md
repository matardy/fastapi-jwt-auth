# FastAPI Authentication Service
This service provides a RESTful API to handle user authentication using FastAPI, a high-performance web framework for building APIs with Python based on standard Python type hints. 

## Key Features
- **User Registration** : Securely register new users.
- **User Authentication** : Login and token generation using OAuth2 with Password (and hashing), Bearer with JWT Tokens.
- **User Verification** : Endpoints that require authentication validate JWT tokens. 

## Key Concepts
### Dependency Injection
Dependency injection in FastAPI is a powerful feature that allows you to create reusable components (dependencies) that can be injected into your endpoint functions. This means that the framework takes care of providing the necessary objects for your functions to operate. It helps with:
  - **Separation of Concerns** : Each part of the system is responsible for a specific role and is independent of others.
  - **Ease of Testing** : Dependencies can be replaced with mock implementations in tests.
  - **Reusability and Modularity**: Shared functionality can be encapsulated into depependencies and used across multiple endpoints. 

### JWT Authentication
JSON Web Tokens are used for secure user authentication. A token is generated upon login and must be included in the header of HTTP requests to access protected endpoints.

### bcrypt_context
This is a CryptContext object fromm the passlib library. It is configured to use the bcrypt hashing algorithm, which is a secure way to hash passwords. FastAPI uses this context to hash passwords upon user creation and to verify passwords during user login. 

### oath2_bearer
An instance of `OAuth2PasswordBearer` from FastAPI that us used to implement the OAuth password flow. It provides a way to receive and validate the token and to extract the user information from it.

## Application Structure
### Endpoints
- `POST /auth/`: Register a new user. The password is hashed before being stored in the database.
- `POST /auth/token`: Login endpoint that authenticates a user and returns a JWT token.
- `GET /`: Example of a protected endpoint that requires a valid JWT token to access.

### Dependencies
- `bcrypt_context` : Used to hash and verify passwords securely.
- `oauth2_bearer` : Used to extract and validate JWT tokens from the Authorization header in requests. 
- `get_db` : A generator dependency that provides a database session and ensures proper session closure. 
- `get_current_user`: A function that depends on `oauth2_bearer` to extract the current user from a JWT token.

## How to use
#### Setup
1. Set the required enviroment variables in a `.env` in the root directory.
```
POSTGRES_USER
POSTGRES_PASSWORD
POSTGRES_DB
DATABASE_URL=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@db:5432/${POSTGRES_DB}
SECRET_KEY
ALGORITHM
```
2. Run `docker compose up` 

### User Registration
Send a POST request with a JSON body containing username and password to `/auth/` to register a new user.

### User Login
Send a POST request with a `form-data` body containing username and password to `/auth/token` to log in and receive a JWT token.

### Accessing Protected Endpoints
Include the JWT token received from login in the Authorization header as `Bearer <token>` when sending requests to protected endpoints.