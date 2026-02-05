# API Documentation

This document describes the API endpoints and data structures used in the mobile template.

## Base Configuration

### Environment URLs
| Environment | Base URL |
|-------------|----------|
| Development | `https://dev-api.example.com/v1` |
| Staging | `https://staging-api.example.com/v1` |
| Production | `https://api.example.com/v1` |

### Headers
All requests should include:
```
Content-Type: application/json
Accept: application/json
Authorization: Bearer <token>  (for authenticated endpoints)
```

### Response Format
All responses follow this structure:
```json
{
  "success": true,
  "data": { ... },
  "message": "Success",
  "errors": null
}
```

Error responses:
```json
{
  "success": false,
  "data": null,
  "message": "Error description",
  "errors": {
    "field": ["Error message"]
  }
}
```

## Authentication

### POST `/auth/login`
Authenticate a user with email and password.

**Request:**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "user": {
      "id": "uuid",
      "email": "user@example.com",
      "name": "John Doe",
      "avatarUrl": "https://...",
      "createdAt": "2024-01-01T00:00:00Z"
    },
    "accessToken": "eyJhbGciOiJIUzI1NiIs...",
    "refreshToken": "eyJhbGciOiJIUzI1NiIs...",
    "expiresIn": 3600
  }
}
```

**Errors:**
- `401` - Invalid credentials
- `422` - Validation error

### POST `/auth/register`
Register a new user account.

**Request:**
```json
{
  "email": "newuser@example.com",
  "password": "password123",
  "name": "Jane Doe"
}
```

**Response (201):**
```json
{
  "success": true,
  "data": {
    "user": {
      "id": "uuid",
      "email": "newuser@example.com",
      "name": "Jane Doe"
    },
    "accessToken": "...",
    "refreshToken": "..."
  }
}
```

**Errors:**
- `409` - Email already exists
- `422` - Validation error

### POST `/auth/refresh`
Refresh the access token.

**Request:**
```json
{
  "refreshToken": "eyJhbGciOiJIUzI1NiIs..."
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "accessToken": "new-access-token",
    "refreshToken": "new-refresh-token",
    "expiresIn": 3600
  }
}
```

### POST `/auth/logout`
Invalidate the current session.

**Headers:**
```
Authorization: Bearer <accessToken>
```

**Response (200):**
```json
{
  "success": true,
  "message": "Logged out successfully"
}
```

### GET `/auth/me`
Get the current authenticated user.

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "email": "user@example.com",
    "name": "John Doe",
    "avatarUrl": "https://...",
    "createdAt": "2024-01-01T00:00:00Z"
  }
}
```

## Pagination

Paginated endpoints follow this format:

**Request Parameters:**
- `page` - Page number (default: 1)
- `limit` - Items per page (default: 20, max: 100)
- `sort` - Sort field
- `order` - Sort order: `asc` | `desc`

**Response:**
```json
{
  "success": true,
  "data": {
    "items": [...],
    "pagination": {
      "total": 100,
      "page": 1,
      "limit": 20,
      "totalPages": 5,
      "hasMore": true
    }
  }
}
```

## Error Codes

| Code | Description |
|------|-------------|
| 400 | Bad Request - Invalid parameters |
| 401 | Unauthorized - Invalid or missing token |
| 403 | Forbidden - Insufficient permissions |
| 404 | Not Found - Resource doesn't exist |
| 409 | Conflict - Resource already exists |
| 422 | Unprocessable Entity - Validation error |
| 429 | Too Many Requests - Rate limit exceeded |
| 500 | Internal Server Error |
| 502 | Bad Gateway |
| 503 | Service Unavailable |

## Rate Limiting

- **Default:** 100 requests per minute
- **Auth endpoints:** 10 requests per minute
- Rate limit headers:
  - `X-RateLimit-Limit`
  - `X-RateLimit-Remaining`
  - `X-RateLimit-Reset`

## Implementing API Calls

### Using NetworkClient

```dart
// GET request
final response = await networkClient.get<Map<String, dynamic>>(
  '/users',
  queryParameters: {'page': 1, 'limit': 20},
);

// POST request
final response = await networkClient.post<Map<String, dynamic>>(
  '/auth/login',
  data: {'email': email, 'password': password},
);

// PUT request
final response = await networkClient.put<Map<String, dynamic>>(
  '/users/\$id',
  data: {'name': 'New Name'},
);

// DELETE request
final response = await networkClient.delete<void>('/users/\$id');
```

### Using ApiService

```dart
class UserApiService extends BaseApiService {
  Future<Result<UserEntity, AppFailure>> getUser(String id) async {
    return get<UserEntity>(
      '/users/\$id',
      fromJson: (json) => UserEntity.fromJson(json),
    );
  }

  Future<Result<List<UserEntity>, AppFailure>> getUsers({
    int page = 1,
    int limit = 20,
  }) async {
    return getList<UserEntity>(
      '/users',
      fromJson: (json) => UserEntity.fromJson(json),
      queryParameters: {'page': page, 'limit': limit},
    );
  }
}
```

### Error Handling

```dart
final result = await userApiService.getUser(userId);

result.fold(
  onSuccess: (user) {
    // Handle success
  },
  onFailure: (failure) {
    failure.when(
      server: (message, statusCode, _) => showError(message),
      network: (_) => showError('No internet connection'),
      authentication: (_, __) => redirectToLogin(),
      // ... handle other failures
    );
  },
);
```
