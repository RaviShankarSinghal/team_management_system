# Team Management System

A RESTful API backend for managing teams and team members within an organization. Built with Ruby on Rails and PostgreSQL.

## Features

- **Team Management**
  - Create, view, update, and delete teams
  - List all teams with pagination
  - Search and filter capabilities

- **Member Management**
  - Add and remove team members
  - List team members with pagination
  - Filter members by last name
  - View member details

- **Authorization**
  - Role-based access control
  - Team owner privileges
  - Secure authentication system

## Prerequisites

- Ruby 3.2.0+
- Rails 7.0+
- PostgreSQL 14+

## Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/team-management-system.git
cd team-management-system
```

2. Install dependencies
```bash
bundle install
```

3. Set up the database
```bash
rails db:create
rails db:migrate
```


5. Start the server
```bash
rails server
```

## API Documentation

### Base URL

All API endpoints are prefixed with `/api/v1`

### Authentication

The API uses JWT tokens for authentication. First, sign up or sign in to obtain a token, then include it in the Authorization header for all subsequent requests:

```
Authorization: Bearer <your_jwt_token>
```

### Authentication Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/v1/signup` | Create a new user account |
| POST | `/api/v1/signin` | Sign in and receive JWT token |
| DELETE | `/api/v1/signout` | Sign out (invalidate token) |

#### Sign Up Example
```http
POST /api/v1/signup
Content-Type: application/json

{
  "user": {
    "email": "user@example.com",
    "password": "password123",
    "password_confirmation": "password123",
    "name": "John Doe"
  }
}
```

Response:
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9...",
  "user": {
    "id": 1,
    "email": "user@example.com",
    "name": "John Doe"
  }
}
```

#### Sign In Example
```http
POST /api/v1/signin
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123"
}
```

### Teams Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/teams` | List all teams |
| GET | `/api/v1/teams/:id` | Get team details |
| POST | `/api/v1/teams` | Create a new team |
| PUT | `/api/v1/teams/:id` | Update team details |
| DELETE | `/api/v1/teams/:id` | Delete a team |

#### Create Team Example
```http
POST /api/v1/teams
Authorization: Bearer <your_jwt_token>
Content-Type: application/json

{
  "team": {
    "name": "Engineering Team",
    "description": "Core engineering team"
  }
}
```

Response:
```json
{
  "id": 1,
  "name": "Engineering Team",
  "description": "Core engineering team",
  "owner_id": 1,
  "created_at": "2024-11-13T10:00:00.000Z"
}
```

### Team Members Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/teams/:team_id/members` | List team members |
| POST | `/api/v1/teams/:team_id/members` | Add team member |
| DELETE | `/api/v1/teams/:team_id/members/:id` | Remove team member |

#### Add Team Member Example
```http
POST /api/v1/teams/1/members
Authorization: Bearer <your_jwt_token>
Content-Type: application/json

{
  "member": {
    "user_id": 2,
    "role": "developer"
  }
}
```

## Testing

### Running Tests

1. Run API tests
```bash
rspec
```


## Error Handling

The API uses standard HTTP status codes and returns error messages in the following format:

```json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "Human readable error message"
  }
}
```