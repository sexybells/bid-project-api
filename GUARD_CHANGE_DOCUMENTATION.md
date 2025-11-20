# Authentication Guard Change Documentation

## Changes Made

The authentication guard name has been changed from `api` to `user` in the application. This change affects how the JWT authentication is configured and used throughout the application.

## Files Modified

1. **config/auth.php**
   - Changed the guard name from `api` to `user` while keeping the JWT driver and users provider

2. **app/Http/Controllers/AuthController.php**
   - Updated all instances of `auth('api')` to `auth('user')` in the following methods:
     - `login()`: For attempting authentication
     - `me()`: For retrieving the authenticated user
     - `logout()`: For logging out the user
     - `refresh()`: For refreshing the JWT token
     - `respondWithToken()`: For generating the token response
   - Updated the middleware in the constructor from `auth:api` to `auth:user`

## How to Use

The authentication endpoints remain the same:
- POST `/api/auth/login`
- POST `/api/auth/logout`
- POST `/api/auth/refresh`
- GET `/api/auth/me`

However, when implementing authentication in other parts of the application, make sure to:
1. Use `auth('user')` instead of `auth('api')` in your code
2. Use `auth:user` middleware instead of `auth:api` middleware in your routes

## Testing

A test script has been created at `test-user-auth.php` to verify the authentication functionality with the new guard name. To run the test:

1. Start the Laravel development server:
   ```bash
   php artisan serve
   ```

2. Run the test script:
   ```bash
   php test-user-auth.php
   ```

The script tests both the login and me endpoints to ensure the JWT authentication works correctly with the new guard name.
