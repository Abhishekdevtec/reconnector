json.extract! contact, :id, :type, :agent_id, :account_id, :share, :first_name, :last_name, :business_name, :legal_name, :job_title, :email, :phone, :mobile, :fax, :url, :registration, :notes, :created_at, :updated_at
json.url contact_url(contact, format: :json)
