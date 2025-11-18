# Authentication API Documentation

This document provides information about the authentication endpoints available in the API.

## Base URL

All endpoints are prefixed with `/api/auth`.

## Authentication Endpoints

### Login

Authenticates a user and returns a JWT token.

- **URL**: `/api/auth/login`
- **Method**: `POST`
- **Request Body**:
  ```json
  {
    "email": "test@example.com",
    "password": "password"
  }
  ```
- **Success Response**:
  - **Code**: 200
  - **Content**:
    ```json
    {
      "status": "success",
      "message": "Login successful",
      "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...",
      "token_type": "bearer",
      "expires_in": 3600,
      "user": {
        "id": 1,
        "name": "Test User",
        "email": "test@example.com",
        "status": true
      }
    }
    ```
- **Error Responses**:
  - **Code**: 401 Unauthorized
    ```json
    {
      "status": "error",
      "message": "Invalid login credentials"
    }
    ```
  - **Code**: 422 Unprocessable Entity
    ```json
    {
      "status": "error",
      "message": "Validation error",
      "errors": {
        "email": ["The email field is required."],
        "password": ["The password field is required."]
      }
    }
    ```
  - **Code**: 403 Forbidden
    ```json
    {
      "status": "error",
      "message": "Your account is inactive"
    }
    ```

### Logout

Logs out the authenticated user by invalidating the token.

- **URL**: `/api/auth/logout`
- **Method**: `POST`
- **Headers**:
  - `Authorization: Bearer {token}`
- **Success Response**:
  - **Code**: 200
  - **Content**:
    ```json
    {
      "status": "success",
      "message": "Logged out successfully"
    }
    ```
- **Error Response**:
  - **Code**: 401 Unauthorized
    ```json
    {
      "message": "Unauthenticated"
    }
    ```

### Refresh Token

Refreshes the JWT token.

- **URL**: `/api/auth/refresh`
- **Method**: `POST`
- **Headers**:
  - `Authorization: Bearer {token}`
- **Success Response**:
  - **Code**: 200
  - **Content**:
    ```json
    {
      "status": "success",
      "message": "Login successful",
      "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...",
      "token_type": "bearer",
      "expires_in": 3600,
      "user": {
        "id": 1,
        "name": "Test User",
        "email": "test@example.com",
        "status": true
      }
    }
    ```
- **Error Response**:
  - **Code**: 401 Unauthorized
    ```json
    {
      "message": "Unauthenticated"
    }
    ```

### Get User Info

Returns the authenticated user's information.

- **URL**: `/api/auth/me`
- **Method**: `GET`
- **Headers**:
  - `Authorization: Bearer {token}`
- **Success Response**:
  - **Code**: 200
  - **Content**:
    ```json
    {
      "id": 1,
      "name": "Test User",
      "email": "test@example.com",
      "status": true
    }
    ```
- **Error Response**:
  - **Code**: 401 Unauthorized
    ```json
    {
      "message": "Unauthenticated"
    }
    ```

## Testing Authentication

You can test the authentication endpoints using the following test user:

- **Email**: `test@example.com`
- **Password**: `password`

To create this test user, run:

```bash
php artisan db:seed
```

## JWT Configuration

The JWT authentication is configured to use the following settings:

- **Guard**: `api`
- **Provider**: `users`
- **Driver**: `jwt`

The token expires after 60 minutes by default.
