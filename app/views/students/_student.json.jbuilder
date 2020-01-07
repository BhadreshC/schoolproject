json.extract! student, :id, :name, :email, :standard, :created_at, :updated_at
json.url student_url(student, format: :json)
