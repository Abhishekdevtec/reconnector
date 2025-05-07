class Console::InboundWebhooksController < ConsoleController
  # GET /console/inbound_webhooks or /console/inbound_webhooks.json
  def index
    @inbound_webhooks = @account.inbound_webhooks.all.order(updated_at: :desc)
  end

  # GET /console/accounts/:account_id/inbound_webhooks/:id(.:format)
  def show
    @inbound_webhook = @account.inbound_webhooks.find(params[:id])
  end

  # GET /console/accounts/:account_id/inbound_webhooks/:id/replay(.:format)
  def replay
    inbound_webhook = @account.inbound_webhooks.find(params[:id])
    inbound_webhook.process_now
    redirect_to [:console, @account, :inbound_webhooks], notice: 'Inbound webhook replayed.'
  rescue ActiveRecord::RecordNotFound
    Rails.logger.error "[#{self.class}] InboundWebhook #{params[:id]} not found for Account #{params[:account_id]}"
    redirect_to [:console, @account, :inbound_webhooks], error: 'Cannot find this inbound webhook record.'
  end
end
