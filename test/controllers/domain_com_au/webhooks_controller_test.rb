require 'test_helper'

class DomainComAu::WebhooksControllerTest < ActionDispatch::IntegrationTest
  test 'should get response 404 not_found with invalid verification code' do
    account = Account.first
    get(accounts_domain_com_au_webhook_verify_path(account))
    assert_response :not_found

    get(accounts_domain_com_au_webhook_verify_path(account), params: { verification: 'vfy_invalid_code' })
    assert_response :not_found

    get(accounts_domain_com_au_webhook_verify_path(account), params: { verification: 'vfy_123456789' })
    assert_response :not_found
  end

  test 'should get response 204 no_content with a valid verification code' do
    account = Account.first
    get(accounts_domain_com_au_webhook_verify_path(account), params: { verification: account.domain_com_au_webhooks_verification_code })
    assert_response :no_content
  end

  test 'should be response 404 not_found without correct X-Domain-Signature' do
    post accounts_domain_com_au_webhook_verify_path(Account.first.id)
    assert_response :not_found
  end
end
