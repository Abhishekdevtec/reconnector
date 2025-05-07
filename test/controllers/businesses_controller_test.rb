require "test_helper"

class BusinessesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @agent = agents(:bill)
    @business = @agent.businesses.first
  end

  test 'should get index' do
    get businesses_url
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get businesses_url
    assert_response :success
    assert_select 'h1', 'Contacts'
    sign_out :agent
  end

  test 'should get new business page' do
    get new_business_url
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get new_business_url
    assert_response :success
    assert_select 'h1', 'New business'
    sign_out :agent
  end

  test 'should create business' do
    post businesses_url, params: { business: { account_id: @business.account_id, agent_id: @business.agent_id, business_name: @business.business_name, email: @business.email, fax: @business.fax, first_name: @business.first_name, job_title: @business.job_title, last_name: @business.last_name, legal_name: @business.legal_name, mobile: @business.mobile, notes: @business.notes, phone: @business.phone, registration: @business.registration, share: @business.share, type: @business.type, url: @business.url } }
    assert_redirected_to new_agent_session_path

    sign_in @agent
    assert_difference('Business.count') do
      post businesses_url, params: { business: { account_id: @business.account_id, agent_id: @business.agent_id, business_name: @business.business_name, email: @business.email, fax: @business.fax, first_name: @business.first_name, job_title: @business.job_title, last_name: @business.last_name, legal_name: @business.legal_name, mobile: @business.mobile, notes: @business.notes, phone: @business.phone, registration: @business.registration, share: @business.share, type: @business.type, url: @business.url } }
    end
    business = Business.last
    assert_redirected_to business_url(business)
    follow_redirect!
    assert_select 'h1', business.name
    sign_out :agent
  end

  test 'the account id from the agent is used when creating a business' do
    a_different_account = Account.create!(company_name: 'company', legal_name: 'legal name', domain_name: 'domain.com')
    new_business_params = { business: { business_name: 'biz bee', agent: @agent, account: a_different_account } }

    sign_in @agent
    assert_difference('Business.count') do
      post businesses_url, params: new_business_params
    end
    business = Business.last
    assert_equal @agent.account_id, business.account_id
    assert_redirected_to business_url(business)
    follow_redirect!
    assert_select 'h1', business.name
    sign_out :agent
  end

  test 'should create business with classifications' do
    params_without_classifications = { business: { account_id: @business.account_id, agent_id: @business.agent_id, business_name: @business.business_name, email: @business.email, fax: @business.fax, first_name: @business.first_name, job_title: @business.job_title, last_name: @business.last_name, legal_name: @business.legal_name, mobile: @business.mobile, notes: @business.notes, phone: @business.phone, registration: @business.registration, share: @business.share, type: @business.type, url: @business.url } }
    params_with_classifications = { business: { account_id: @business.account_id, agent_id: @business.agent_id, business_name: @business.business_name, email: @business.email, fax: @business.fax, first_name: @business.first_name, job_title: @business.job_title, last_name: @business.last_name, legal_name: @business.legal_name, mobile: @business.mobile, notes: @business.notes, phone: @business.phone, registration: @business.registration, share: @business.share, type: @business.type, url: @business.url, classifications: ['one', 'two'] } }
    post businesses_url, params: params_without_classifications
    assert_redirected_to new_agent_session_path

    sign_in @agent
    assert_difference('Business.count') do
      post businesses_url, params: params_without_classifications
    end
    business = Business.last
    assert_redirected_to business_url(business)
    follow_redirect!
    assert_select 'h1', business.name

    assert_difference('Business.count') do
      post businesses_url, params: params_with_classifications
    end
    business = Business.last
    assert_redirected_to business_url(business)
    follow_redirect!
    assert_select 'h1', business.name

    sign_out :agent
  end

  test 'should show business' do
    get business_url(@business)
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get business_url(@business)
    assert_response :success
    assert_select 'h1', @business.name
    sign_out :agent
  end

  test 'should get edit' do
    get edit_business_url(@business)
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get edit_business_url(@business)
    assert_response :success
    sign_out :agent
  end

  test 'should update contact' do
    params = {
      business: {
        business_name: 'updated business_name',
        legal_name: 'updated legal_name',
        email: 'updated email',
        phone: 'updated phone',
        mobile: 'updated mobile',
        fax: 'updated fax',
        url: 'updated url',
        registration: 'updated registration',
        notes: 'updated notes',
        share: true
      }
    }
    business = contacts(:unshared_business)
    patch business_url(business), params: params
    assert_redirected_to new_agent_session_path

    sign_in @agent
    patch business_url(business), params: params
    assert_redirected_to business_url(business)
    sign_out :agent

    business.reload
    assert_equal 'updated business_name', business.business_name
    assert_equal 'updated legal_name', business.legal_name
    assert_equal 'updated email', business.email
    assert_equal 'updated phone', business.phone
    assert_equal 'updated mobile', business.mobile
    assert_equal 'updated fax', business.fax
    assert_equal 'updated url', business.url
    assert_equal 'updated registration', business.registration
    assert_equal 'updated notes', business.notes.to_plain_text
    assert_equal true, business.share
  end

  test 'should destroy contact' do
    delete business_url(@business)
    assert_redirected_to new_agent_session_path

    sign_in @agent
    assert_difference('Business.count', -1) do
      delete business_url(@business)
    end
    assert_redirected_to contacts_url
    sign_out :agent
  end
end
