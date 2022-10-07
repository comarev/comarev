customer = User.find_by_email('customer@example.com')

Invoice.find_or_create_by(amount_cents: 2990, user: customer, created_at: Date.today - 60, due_date: Date.today - 30, paid: true)
Invoice.find_or_create_by(amount_cents: 2990, user: customer, created_at: Date.today - 30, due_date: Date.today, paid: true)
Invoice.find_or_create_by(amount_cents: 2990, user: customer, due_date: Date.today + 30)
