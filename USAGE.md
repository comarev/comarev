## Usage

This API was built following REST pattern, then you can access all cruds this way:

- Base URL: http://localhost:3000

- Companies:

  index: GET /companies
  show: GET /companies/id
  showcase: GET /showcase
  create: POST /companies
  update: PATCH /companies/id
  update: PUT /companies/id
  destroy: DELETE /companies/id

  For `POST /companies` route you can use this payload example:

  ```json
  {
    "name": "company_name",
    "cnpj": "12345678910111",
    "phone": "11101987654321"
  }
  ```

- Users:

  index: GET /users
  show: GET /users/id
  create: POST /users
  update: PATCH /users/id
  update: PUT /users/id
  destroy: DELETE /users/id

  For `POST /users` route you can use this payload example:

  ```json
  {
    "user": {
      "full_name": "user full name",
      "cpf": "12121212112",
      "cellphone": "222222222222213",
      "address": "address example",
      "email": "test@example.com",
      "password": "123456"
    }
  }
  ```

- Invoices:

  index: GET /invoices
  show: GET /invoices/id
  create: POST /invoices
  update: PATCH /invoices/id
  update: PUT /invoices/id

  For `POST /invoices` route you can use this payload example:

  ```json
  {
    "user_id": "1",
    "amount": "50.75",
    "due_date": "2022-04-12 17:30:55.859887133 +0000"
  }
  ```

- Registrations:

  create: POST /signup

  For `POST /signup` route you can use this payload example:

  ```json
  {
    "user": {
      "full_name": "user full name",
      "cpf": "12121212121",
      "cellphone": "222222222222123",
      "address": "address example",
      "email": "example@example.com",
      "password": "123456"
    }
  }
  ```

- Sessions:

  create: POST /login
  destroy: DELETE /logout

  For `POST /login` route you can use this example:

  ```json
  {
    "user": {
      "admin": true,
      "email": "admin@example.com",
      "password": "123456"
    }
  }
  ```
