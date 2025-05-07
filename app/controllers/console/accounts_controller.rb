# frozen_string_literal: true

module Console
  class AccountsController < ConsoleController
    include SortableAttributes

    before_action :set_account, only: %i[show edit update destroy]

    def index
      @accounts = Account.all
      @accounts = @accounts.order(sort_ressource_params) if sort_params?
    end

    def show
    end

    def new
      # @account = Account.new
      @account = CreateAccountForm.new
    end

    def create
      @account = CreateAccountForm.new(CreateAccountForm.permitted_params(params))
      if @account.save
        redirect_to [:console, @account], notice: "#{@account.company_name} was saved."
      else
        # render [:new, :console, @account], alert: 'Cannot save account'
        render :new, status: :unprocessable_entity, alert: 'Cannot save account'
      end
    end

    def edit
    end

    def update
      respond_to do |format|
        if @account.update(account_params)
          format.html { redirect_to [:console, :account], notice: "#{@account.company_name} was successfully updated." }
          format.json { render :show, status: :ok, location: @account }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @account.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @account.destroy
      respond_to do |format|
        format.html { redirect_to [:console, :accounts], notice: "#{@account.company_name} was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    def account_params
      # TODO: Find a better way to drop in ews attributes
      params.require(:account)
            .permit(
              :company_name,
              :domain_name,
              :email,
              :ews_endpoint,
              :ews_synchronize,
              :fax,
              :legal_name,
              :pdf_logo,
              :phone,
              :primary_color,
              :secondary_color,
              :brochure_disclaimer
            )
    end
  end
end
