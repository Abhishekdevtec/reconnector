json.extract! classifier, :id, :account_id, :name, :created_at, :updated_at
json.url console_account_classifier_path(@account, classifier, format: :json)
