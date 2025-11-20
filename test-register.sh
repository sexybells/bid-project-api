#!/bin/bash

# Test the registration endpoint
echo "Testing user registration endpoint..."

# Generate a random email to avoid unique constraint violations
RANDOM_EMAIL="test_$(date +%s)@example.com"

# Make the API request
curl -X POST http://localhost:8000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "'"$RANDOM_EMAIL"'",
    "password": "password123",
    "password_confirmation": "password123"
  }' | json_pp

echo -e "\n\nTest completed."
