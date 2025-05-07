# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2025_04_11_111755) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "access_requests", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "company"
    t.string "agent_count"
    t.string "email"
    t.string "phone"
    t.text "request"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.string "company_name"
    t.string "legal_name"
    t.string "domain_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rea_host"
    t.string "rea_username"
    t.string "rea_encrypted_password"
    t.string "domain_com_au_agency_id"
    t.string "phone"
    t.string "email"
    t.string "fax"
    t.string "rea_party_id"
    t.string "rea_client_id"
    t.string "rea_encrypted_client_secret"
    t.string "domain_com_au_encrypted_authorization_code"
    t.string "domain_com_au_encrypted_access_token"
    t.datetime "domain_com_au_access_token_expires_at"
    t.string "domain_com_au_access_token_type"
    t.string "domain_com_au_encrypted_refresh_token"
    t.string "domain_com_au_client_id"
    t.string "domain_com_au_encrypted_client_secret"
    t.string "domain_com_au_agents_and_listings_api_key"
    t.string "domain_com_au_properties_and_locations_api_key"
    t.string "domain_com_au_price_estimation_api_key"
    t.string "domain_com_au_address_suggestions_api_key"
    t.string "domain_com_au_schools_data_api_key"
    t.string "domain_com_au_listings_management_api_key"
    t.string "domain_com_au_webhooks_api_key"
    t.boolean "ews_synchronize", default: false
    t.string "ews_endpoint"
    t.string "griffin_property_host_url"
    t.string "griffin_property_username"
    t.string "griffin_property_encrypted_password"
    t.string "griffin_property_destination_folder"
    t.string "encrypted_griffin_property_com_au_api_token"
    t.string "primary_color"
    t.string "secondary_color"
    t.string "brochure_disclaimer"
    t.string "domain_com_au_webhooks_verification_code"
    t.string "domain_com_au_webhooks_id"
    t.string "azure_application_id", comment: "This is generated when you register the application on Azure"
    t.string "azure_tenant_id", comment: "This is generated when you register the application on Azure"
    t.string "azure_encrypted_client_secret"
    t.boolean "enable_microsoft_graph_support", default: false
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activity_logs", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "agent_id"
    t.string "activityloggable_type", null: false
    t.bigint "activityloggable_id", null: false
    t.string "action"
    t.string "result"
    t.string "body"
    t.string "payload"
    t.datetime "created_at"
    t.index ["account_id"], name: "index_activity_logs_on_account_id"
    t.index ["activityloggable_type", "activityloggable_id"], name: "index_activity_logs_on_activityloggable"
    t.index ["agent_id"], name: "index_activity_logs_on_agent_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.integer "category", default: 0
    t.string "line_1"
    t.string "line_2"
    t.string "line_3"
    t.string "city"
    t.string "postal_code"
    t.string "state"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
  end

  create_table "agents", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "mobile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id", null: false
    t.string "rea_agent_id"
    t.string "domain_com_au_agent_id"
    t.string "fax"
    t.string "ews_username"
    t.string "encrypted_ews_password"
    t.integer "role", default: 0
    t.string "current_country", comment: "Holds the last used country for the agent"
    t.string "current_state", comment: "Holds the last used state for the agent"
    t.index ["account_id"], name: "index_agents_on_account_id"
    t.index ["email"], name: "index_agents_on_email", unique: true
    t.index ["reset_password_token"], name: "index_agents_on_reset_password_token", unique: true
  end

  create_table "cities", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.string "name"
    t.string "postal_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "district_id"
    t.index ["district_id"], name: "index_cities_on_district_id"
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "classifications", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "classifiable_type"
    t.bigint "classifiable_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_classifications_on_account_id"
    t.index ["classifiable_type", "classifiable_id"], name: "index_classifications_on_classifiable"
  end

  create_table "classifier_tags", force: :cascade do |t|
    t.string "taggable_type", null: false
    t.bigint "taggable_id", null: false
    t.bigint "classifier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classifier_id"], name: "index_classifier_tags_on_classifier_id"
    t.index ["taggable_type", "taggable_id"], name: "index_classifier_tags_on_taggable"
  end

  create_table "classifiers", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_classifiers_on_account_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "type"
    t.bigint "agent_id", null: false
    t.bigint "account_id", null: false
    t.boolean "share", default: false
    t.string "first_name"
    t.string "last_name"
    t.string "business_name"
    t.string "legal_name"
    t.string "job_title"
    t.string "email"
    t.string "phone"
    t.string "mobile"
    t.string "fax"
    t.string "url"
    t.string "registration"
    t.string "source_id"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "business_id"
    t.string "classifiable_type"
    t.bigint "classifiable_id"
    t.string "ews_item_id"
    t.string "ews_change_key"
    t.datetime "ews_received_at"
    t.datetime "ews_sent_at"
    t.datetime "ews_created_at"
    t.datetime "ews_last_modified_at"
    t.boolean "ews_imported_from_ews", default: false
    t.boolean "synchronize_with_office_online", default: false
    t.index ["account_id"], name: "index_contacts_on_account_id"
    t.index ["agent_id"], name: "index_contacts_on_agent_id"
    t.index ["business_id"], name: "index_contacts_on_business_id"
    t.index ["classifiable_type", "classifiable_id"], name: "index_contacts_on_classifiable"
  end

  create_table "contracts", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.boolean "for_sale", default: false
    t.boolean "for_lease", default: false
    t.bigint "sale_price_cents"
    t.bigint "sale_price_from_cents"
    t.bigint "sale_price_to_cents"
    t.string "sale_auction_venue"
    t.date "sale_auction_date"
    t.date "sale_inspection_on"
    t.bigint "sale_reserve_price_cents"
    t.bigint "sale_actual_sale_price_cents"
    t.bigint "private_treaty_minimum_price_cents"
    t.bigint "private_treaty_target_price_cents"
    t.date "eoi_close_on"
    t.date "eoi_inspection_on"
    t.bigint "eoi_minimum_price_cents"
    t.bigint "eoi_target_price_cents"
    t.bigint "lease_cleaning_cents"
    t.bigint "lease_covered_parking_space_cents"
    t.bigint "lease_on_grade_parking_space_cents"
    t.bigint "lease_other_rental_costs_cents"
    t.date "lease_commencement_on"
    t.date "lease_expires_on"
    t.string "lease_term"
    t.date "lease_rent_review_on"
    t.text "lease_escalation_rate"
    t.string "lease_escalation_formulae"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "lease_net_rent", precision: 20, scale: 8
    t.decimal "lease_gross_rent", precision: 20, scale: 8
    t.decimal "lease_outgoings", precision: 20, scale: 8
    t.index ["property_id"], name: "index_contracts_on_property_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "country_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_countries_on_name"
    t.index ["slug"], name: "index_countries_on_slug"
  end

  create_table "districts", force: :cascade do |t|
    t.bigint "country_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_districts_on_country_id"
  end

  create_table "inbound_webhooks", force: :cascade do |t|
    t.string "status", default: "pending"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_inbound_webhooks_on_account_id"
  end

  create_table "integrations_realestate_com_au_leads_apis", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.boolean "enabled"
    t.datetime "last_requested_at"
    t.string "last_request_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_integrations_realestate_com_au_leads_apis_on_account_id"
  end

  create_table "listing_enquiries", force: :cascade do |t|
    t.integer "property_id"
    t.string "property_portal", comment: "The property portal that the enquiry came from. E.g. domain_com_au, realestate_com_au, etc."
    t.string "enquiry_id", comment: "The ID of the enquiry in the property portal. This is an external ID which can be used to look up the enquiry in the property portal."
    t.string "reference_id", comment: "The ID of the listing in the property portal. This is an external ID which can be used to look up the listing in the property portal."
    t.string "sender_first_name"
    t.string "sender_last_name"
    t.string "sender_email"
    t.string "sender_phone"
    t.text "message"
    t.datetime "enquired_at"
    t.datetime "created_at", null: false
    t.bigint "contact_id"
    t.bigint "agent_id"
    t.bigint "account_id"
    t.index ["account_id"], name: "index_listing_enquiries_on_account_id"
    t.index ["agent_id"], name: "index_listing_enquiries_on_agent_id"
    t.index ["contact_id"], name: "index_listing_enquiries_on_contact_id"
    t.index ["property_id"], name: "index_listing_enquiries_on_property_id"
  end

  create_table "locations", force: :cascade do |t|
    t.bigint "agent_id", null: false
    t.string "time_zone", default: "UTC"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_locations_on_agent_id"
  end

  create_table "matching_properties_emails", force: :cascade do |t|
    t.bigint "agent_id", null: false
    t.bigint "contact_id", null: false
    t.integer "property_ids", array: true
    t.boolean "attach_brochures", default: false
    t.datetime "email_sent_at"
    t.datetime "created_at"
    t.index ["agent_id"], name: "index_matching_properties_emails_on_agent_id"
    t.index ["contact_id"], name: "index_matching_properties_emails_on_contact_id"
  end

  create_table "ms_graph_object_data", force: :cascade do |t|
    t.string "object_id"
    t.string "change_key"
    t.string "parent_folder_id"
    t.string "etag"
    t.datetime "created_date_time"
    t.datetime "last_modified_date_time"
    t.datetime "last_sent_at"
    t.datetime "last_received_at"
    t.string "microsoft_graph_synchronizable_type", null: false
    t.bigint "microsoft_graph_synchronizable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["microsoft_graph_synchronizable_type", "microsoft_graph_synchronizable_id"], name: "index_ms_graph_object_data_on_microsoft_graph_synchronizable"
  end

  create_table "o_auth_tokens", force: :cascade do |t|
    t.bigint "tokenable_id"
    t.string "tokenable_type"
    t.string "access_token", null: false
    t.datetime "expires_at", null: false
    t.string "provider", null: false, comment: "The name of the OAuth token service (Microsoft Graph, Twitter, Google, etc.)"
    t.string "refresh_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tokenable_id"], name: "index_o_auth_tokens_on_tokenable_id"
    t.index ["tokenable_type"], name: "index_o_auth_tokens_on_tokenable_type"
  end

  create_table "overlords", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_overlords_on_email", unique: true
    t.index ["reset_password_token"], name: "index_overlords_on_reset_password_token", unique: true
  end

  create_table "portal_listings", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.string "type"
    t.string "listing_id"
    t.string "upload_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_portal_listings_on_property_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "type"
    t.bigint "agent_id", null: false
    t.string "internal_id"
    t.string "usages", default: [], array: true
    t.string "unique_space_deprecated"
    t.string "floor_level"
    t.string "name"
    t.string "building"
    t.string "naming_rights"
    t.integer "naming_rights_cost_cents"
    t.string "estate"
    t.string "unit_suite_shop"
    t.string "floor"
    t.string "street_number"
    t.string "street_name"
    t.string "state"
    t.string "city"
    t.string "postal_code"
    t.string "country"
    t.string "local_council"
    t.decimal "office_area", precision: 10, scale: 2
    t.decimal "warehouse_area", precision: 10, scale: 2
    t.decimal "showroom_area", precision: 10, scale: 2
    t.decimal "storage_area", precision: 10, scale: 2
    t.decimal "production_area", precision: 10, scale: 2
    t.decimal "trading_area", precision: 10, scale: 2
    t.decimal "floor_area", precision: 10, scale: 2
    t.decimal "land_area", precision: 10, scale: 2
    t.decimal "hard_stand_yard_area", precision: 10, scale: 2
    t.string "land_area_description"
    t.string "hard_stand_yard_description"
    t.string "headline"
    t.string "grabline"
    t.string "keywords"
    t.text "brochure_description_deprecated"
    t.text "website_description_deprecated"
    t.integer "parking_spaces"
    t.string "parking_comments"
    t.text "fit_out_deprecated"
    t.text "furniture_deprecated"
    t.string "lifts_escalators_travelators"
    t.decimal "min_clearance_height", precision: 10, scale: 2
    t.decimal "max_clearance_height", precision: 10, scale: 2
    t.string "clear_span_columns"
    t.string "lot_number"
    t.string "crane"
    t.string "entrances_roller_doors_container_access"
    t.string "zoning"
    t.string "disability_access"
    t.string "rating"
    t.text "notes_deprecated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rea_listing_id"
    t.string "domain_com_au_listing_id"
    t.boolean "domain_com_au_listed", default: false
    t.boolean "rea_listed", default: false
    t.string "domain_com_au_process_id"
    t.string "website_url"
    t.decimal "calculated_building_area"
    t.datetime "archived_at"
    t.boolean "share", default: false
    t.index ["agent_id"], name: "index_properties_on_agent_id"
    t.index ["usages"], name: "index_properties_on_usages", using: :gin
  end

  create_table "property_contacts", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.bigint "contact_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_property_contacts_on_contact_id"
    t.index ["property_id"], name: "index_property_contacts_on_property_id"
  end

  create_table "property_requirements", force: :cascade do |t|
    t.bigint "contact_id", null: false
    t.string "property_type"
    t.string "contract_type"
    t.decimal "area_from", precision: 10, scale: 2
    t.decimal "area_to", precision: 10, scale: 2
    t.integer "price_from_cents"
    t.integer "price_to_cents"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "for_sale", default: false
    t.boolean "for_lease", default: false
    t.bigint "suburbs", default: [], array: true
    t.bigint "district_id"
    t.index ["contact_id"], name: "index_property_requirements_on_contact_id"
    t.index ["district_id"], name: "index_property_requirements_on_district_id"
  end

  create_table "prospect_notification_emails", force: :cascade do |t|
    t.bigint "contact_id", null: false
    t.bigint "property_id", null: false
    t.datetime "emailed_at"
    t.index ["contact_id"], name: "index_prospect_notification_emails_on_contact_id"
    t.index ["property_id"], name: "index_prospect_notification_emails_on_property_id"
  end

  create_table "prospects_properties_emails", force: :cascade do |t|
    t.bigint "agent_id", null: false
    t.bigint "contact_ids", array: true
    t.bigint "property_ids", array: true
    t.boolean "attach_brochures", default: false
    t.datetime "sent_at"
    t.datetime "created_at"
    t.index ["agent_id"], name: "index_prospects_properties_emails_on_agent_id"
  end

  create_table "raw_listing_enquiries", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "type"
    t.jsonb "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_raw_listing_enquiries_on_account_id"
  end

  create_table "states", force: :cascade do |t|
    t.bigint "country_id", null: false
    t.string "name"
    t.string "abbreviation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abbreviation"], name: "index_states_on_abbreviation"
    t.index ["country_id"], name: "index_states_on_country_id"
    t.index ["name"], name: "index_states_on_name"
  end

  create_table "views", force: :cascade do |t|
    t.string "viewable_type", null: false
    t.bigint "viewable_id", null: false
    t.datetime "viewed_at", null: false
    t.bigint "viewed_by_id", null: false
    t.datetime "created_at", null: false
    t.index ["viewable_type", "viewable_id"], name: "index_views_on_viewable"
    t.index ["viewed_by_id"], name: "index_views_on_viewed_by_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activity_logs", "accounts"
  add_foreign_key "activity_logs", "agents"
  add_foreign_key "agents", "accounts"
  add_foreign_key "cities", "districts"
  add_foreign_key "cities", "states"
  add_foreign_key "classifications", "accounts"
  add_foreign_key "classifier_tags", "classifiers"
  add_foreign_key "classifiers", "accounts"
  add_foreign_key "contacts", "accounts"
  add_foreign_key "contacts", "agents"
  add_foreign_key "contacts", "contacts", column: "business_id"
  add_foreign_key "contracts", "properties"
  add_foreign_key "districts", "countries"
  add_foreign_key "inbound_webhooks", "accounts"
  add_foreign_key "integrations_realestate_com_au_leads_apis", "accounts"
  add_foreign_key "listing_enquiries", "accounts"
  add_foreign_key "listing_enquiries", "agents"
  add_foreign_key "listing_enquiries", "contacts"
  add_foreign_key "listing_enquiries", "properties"
  add_foreign_key "locations", "agents"
  add_foreign_key "matching_properties_emails", "agents"
  add_foreign_key "matching_properties_emails", "contacts"
  add_foreign_key "portal_listings", "properties"
  add_foreign_key "properties", "agents"
  add_foreign_key "property_contacts", "contacts"
  add_foreign_key "property_contacts", "properties"
  add_foreign_key "property_requirements", "contacts"
  add_foreign_key "property_requirements", "districts"
  add_foreign_key "prospect_notification_emails", "contacts"
  add_foreign_key "prospect_notification_emails", "properties"
  add_foreign_key "prospects_properties_emails", "agents"
  add_foreign_key "raw_listing_enquiries", "accounts"
  add_foreign_key "states", "countries"
  add_foreign_key "views", "agents", column: "viewed_by_id"
end
