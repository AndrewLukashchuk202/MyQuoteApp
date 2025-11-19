json.extract! author, :id, :fname, :lname, :biography, :birth_year, :death_year, :created_at, :updated_at
json.url author_url(author, format: :json)
