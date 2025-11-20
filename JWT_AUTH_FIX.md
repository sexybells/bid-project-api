# JWT Authentication Fix

## Issue
The application was encountering the following error:
```
BadMethodCallException
vendor/laravel/framework/src/Illuminate/Macroable/Traits/Macroable.php:115
Method Illuminate\Auth\SessionGuard::factory does not exist.
```

## Root Cause
The error occurred because:
1. The default guard was set to 'web' which uses the SessionGuard
2. The SessionGuard does not have a factory() method
3. In the AuthController, we were calling `auth()->factory()->getTTL()` without specifying which guard to use

## Solution
We made the following changes to fix the issue:

### 1. Updated Auth Configuration
In `config/auth.php`, we initially renamed the 'user' guard to 'api', but have now changed it back to 'user' as per the latest requirements:

```php
'guards' => [
    'web' => [
        'driver' => 'session',
        'provider' => 'users',
    ],
    'user' => [  // Changed from 'api' to 'user'
        'driver' => 'jwt',
        'provider' => 'users',
    ],
],
```

### 2. Updated AuthController
Initially, we modified all auth() calls in the AuthController to explicitly use the 'api' guard. Now, we've updated them to use the 'user' guard:

```php
// Initially
auth()->factory()->getTTL()
auth()->user()
auth()->attempt($credentials)
auth()->logout()
auth()->refresh()

// First update (using 'api' guard)
auth('api')->factory()->getTTL()
auth('api')->user()
auth('api')->attempt($credentials)
auth('api')->logout()
auth('api')->refresh()

// Current update (using 'user' guard)
auth('user')->factory()->getTTL()
auth('user')->user()
auth('user')->attempt($credentials)
auth('user')->logout()
auth('user')->refresh()
```

## Why This Works
By explicitly specifying the 'user' guard in all auth() calls, we ensure that:
1. The JWT guard is used consistently throughout the authentication process
2. The factory() method is available since it exists in the JWT guard but not in the SessionGuard
3. The correct user provider is used for authentication

The guard name ('api' or 'user') is not important as long as it's used consistently throughout the application and matches the configuration in auth.php.

## Testing
The implementation can be tested by:
1. Making a login request to get a JWT token
2. Using the token to access protected endpoints
3. Verifying that the token expiration time is correctly calculated

A test script (test-user-auth.php) has been created to verify the functionality with the 'user' guard. All authentication endpoints should work as expected:
- POST /api/auth/login
- POST /api/auth/logout
- GET /api/auth/me
- POST /api/auth/refresh

For more detailed information about the guard change, refer to the GUARD_CHANGE_DOCUMENTATION.md file.
