# API Design

## RESTful URL Structure

```
GET    /api/resources              # List resources
GET    /api/resources/:id          # Get single resource
POST   /api/resources              # Create (server assigns ID)
PUT    /api/resources/:id          # Create or replace at specific ID
PATCH  /api/resources/:id          # Partial update
DELETE /api/resources/:id          # Delete resource

# Query parameters for filtering, sorting, pagination
GET /api/resources?status=active&sort=created_at&limit=20&offset=0
```

## HTTP Methods and Idempotency

| Method | Idempotent | Use Case |
|--------|------------|----------|
| GET | Yes | Retrieve resource(s) |
| PUT | Yes | Create or replace at specific URI |
| PATCH | No* | Partial update |
| DELETE | Yes | Remove resource |
| POST | No | Non-idempotent operations |

**Key Principle**: Idempotency means multiple identical requests produce the same result.

### PUT vs POST

```
# PUT: Idempotent - client specifies the ID
PUT /users/123
# Creates user 123 if not exists, replaces if exists
# Running twice = same result

# POST: Non-idempotent - server assigns the ID
POST /users
# Creates new user with server-generated ID
# Running twice = two users created
```

**Common misconception**: "POST = create, PUT = update"
**Reality**: PUT can create, POST can do various things. The difference is idempotency.

## Response Format

```json
{
  "success": true,
  "data": { },
  "error": null,
  "meta": {
    "total": 100,
    "page": 1,
    "limit": 10
  }
}
```

## HTTP Status Codes

| Code | Meaning | Use Case |
|------|---------|----------|
| 200 | OK | Successful GET, PUT, PATCH |
| 201 | Created | Successful POST that creates |
| 204 | No Content | Successful DELETE |
| 400 | Bad Request | Invalid input |
| 401 | Unauthorized | Authentication required |
| 403 | Forbidden | Insufficient permissions |
| 404 | Not Found | Resource doesn't exist |
| 409 | Conflict | Resource state conflict |
| 429 | Too Many Requests | Rate limit exceeded |
| 500 | Internal Server Error | Server-side error |
