require "test_helper"

class IndividualsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @agent = agents(:bill)
    @individual = @agent.individuals.first
  end

  test 'should get index' do
    get individuals_url
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get individuals_url
    assert_response :success
    assert_select 'h1', 'Contacts'
    sign_out :agent
  end

  test 'should get new' do
    get new_individual_url
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get new_individual_url
    assert_response :success
    assert_select 'h1', 'New individual'
    sign_out :agent
  end

  test 'should create individual' do
    post individuals_url, params: { individual: { account_id: @individual.account_id, agent_id: @individual.agent_id, business_name: @individual.business_name, email: @individual.email, fax: @individual.fax, first_name: @individual.first_name, job_title: @individual.job_title, last_name: @individual.last_name, legal_name: @individual.legal_name, mobile: @individual.mobile, notes: @individual.notes, phone: @individual.phone, registration: @individual.registration, share: @individual.share, type: @individual.type, url: @individual.url } }
    assert_redirected_to new_agent_session_path

    sign_in @agent
    assert_difference('Individual.count') do
      post individuals_url, params: { individual: { account_id: @individual.account_id, agent_id: @individual.agent_id, business_name: @individual.business_name, email: @individual.email, fax: @individual.fax, first_name: @individual.first_name, job_title: @individual.job_title, last_name: @individual.last_name, legal_name: @individual.legal_name, mobile: @individual.mobile, notes: @individual.notes, phone: @individual.phone, registration: @individual.registration, share: @individual.share, type: @individual.type, url: @individual.url } }
    end
    individual = Individual.last
    assert_redirected_to individual_path(individual)
    follow_redirect!
    assert_select 'h1', individual.name
    sign_out :agent
  end

  test 'the account id from the agent is used when creating an individual' do
    a_different_account = Account.create!(company_name: 'company', legal_name: 'legal name', domain_name: 'domain.com')
    new_individual_params = { individual: { first_name: 'John', agent: @agent, account: a_different_account } }

    sign_in @agent
    assert_difference('Individual.count') do
      post individuals_url, params: new_individual_params
    end
    individual = Individual.last
    assert_equal @agent.account_id, individual.account_id
    assert_redirected_to individual_url(individual)
    follow_redirect!
    assert_select 'h1', individual.name
    sign_out :agent
  end

  test 'should create individual with classifications' do
    params_without_classifications = { individual: { account_id: @individual.account_id, agent_id: @individual.agent_id, business_name: @individual.business_name, email: @individual.email, fax: @individual.fax, first_name: @individual.first_name, job_title: @individual.job_title, last_name: @individual.last_name, legal_name: @individual.legal_name, mobile: @individual.mobile, notes: @individual.notes, phone: @individual.phone, registration: @individual.registration, share: @individual.share, type: @individual.type, url: @individual.url } }
    params_with_classifications = { individual: { account_id: @individual.account_id, agent_id: @individual.agent_id, business_name: @individual.business_name, email: @individual.email, fax: @individual.fax, first_name: @individual.first_name, job_title: @individual.job_title, last_name: @individual.last_name, legal_name: @individual.legal_name, mobile: @individual.mobile, notes: @individual.notes, phone: @individual.phone, registration: @individual.registration, share: @individual.share, type: @individual.type, url: @individual.url, classifications: ['one', 'two'] } }
    post individuals_url, params: params_without_classifications
    assert_redirected_to new_agent_session_path

    sign_in @agent
    assert_difference('Individual.count') do
      post individuals_url, params: params_without_classifications
    end
    assert_redirected_to individual_path(Individual.last)

    assert_difference('Individual.count') do
      post individuals_url, params: params_with_classifications
    end
    assert_redirected_to individual_path(Individual.last)
    sign_out :agent
  end

  test 'should show contact' do
    get individual_url(@individual)
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get individual_url(@individual)
    assert_response :success
    assert_select 'h1', @individual.name
    sign_out :agent
  end

  test 'should get edit' do
    get edit_individual_url(@individual)
    assert_redirected_to new_agent_session_path

    sign_in @agent
    get edit_individual_url(@individual)
    assert_response :success
    sign_out :agent
  end

  test 'should update contact' do
    params = {
      individual: {
       share: true,
       first_name: 'updated_first_name',
       last_name: 'updated_last_name',
       business_name: 'updated_business_name',
       job_title: 'updated_job_title',
       email: 'updated_email',
       phone: 'updated_phone',
       mobile: 'updated_mobile',
       fax: 'updated_fax',
       url: 'updated_url',
       registration: 'updated_registration',
       notes: 'updated_notes'
      }
    }
    individual = contacts(:unshared_individual)
    patch individual_url(individual), params: params
    assert_redirected_to new_agent_session_path

    sign_in @agent
    patch individual_url(individual), params: params
    assert_redirected_to individual_url(individual)
    sign_out :agent

    individual.reload
    assert_equal 'updated_first_name', individual.first_name
    assert_equal 'updated_last_name', individual.last_name
    assert_equal 'updated_business_name', individual.business_name
    assert_equal 'updated_job_title', individual.job_title
    assert_equal 'updated_email', individual.email
    assert_equal 'updated_phone', individual.phone
    assert_equal 'updated_mobile', individual.mobile
    assert_equal 'updated_fax', individual.fax
    assert_equal 'updated_url', individual.url
    assert_equal 'updated_registration', individual.registration
    assert_equal 'updated_notes', individual.notes.to_plain_text
    assert_equal true, individual.share
  end

  test 'should destroy contact' do
    delete individual_url(@individual)
    assert_redirected_to new_agent_session_path

    sign_in @agent
    assert_difference('Individual.count', -1) do
      delete individual_url(@individual)
    end
    assert_redirected_to contacts_url
    sign_out :agent
  end
end
