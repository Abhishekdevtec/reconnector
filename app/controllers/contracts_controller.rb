class ContractsController < ApplicationController
  before_action :authenticate_agent!
  before_action :set_property
  before_action :set_active_nav_menu_option

  # GET /contracts/1 or /contracts/1.json
  def show
    @contract = @property.contract
    @current_property_tab = :contract
  end

  # GET /contracts/new
  def new
    @contract = @property.build_contract
  end

  # GET /contracts/1/edit
  def edit
    @contract = @property.contract
  end

  # POST /contracts or /contracts.json
  def create
    @contract = @property.build_contract(contract_params)

    respond_to do |format|
      if @contract.save
        format.html { redirect_to @property, notice: "Contract was successfully created." }
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1 or /contracts/1.json
  def update
    respond_to do |format|
      if @property.contract? && @property.contract.update(contract_params)
        format.html { redirect_to @property, notice: "Contract was successfully updated." }
        format.json { render :show, status: :ok, location: @contract }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1 or /contracts/1.json
  def destroy
    if @property.contract? && @property.contract.destroy
      respond_to do |format|
        format.html { redirect_to @property, notice: "Contract was successfully destroyed.", status: :see_other }
        format.json { head :no_content, status: :see_other }
      end
    else
      format.html { redirect_to @property, status: :unprocessable_entity }
      format.json { render json: @contract.errors, status: :unprocessable_entity }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_property
    @property = Current.account.properties.with_archived.find(params[:property_id])
  end

  # Only allow a list of trusted parameters through.
  def contract_params
    params
      .require(:contract)
      .permit(
        :property_id,
        :for_sale,
        :for_lease,
        :sale_price,
        :sale_price_from,
        :sale_price_to,
        :sale_auction_venue,
        :sale_inspection_on,
        :sale_reserve_price,
        :sale_actual_sale_price,
        :private_treaty_minimum_price,
        :private_treaty_target_price,
        :eoi_close_on,
        :eoi_inspection_on,
        :eoi_minimum_price,
        :eoi_target_price,
        :lease_net_rent,
        :lease_outgoings,
        :lease_gross_rent,
        :lease_cleaning,
        :lease_covered_parking_space,
        :lease_on_grade_parking_space,
        :lease_other_rental_costs,
        :lease_commencement_on,
        :lease_expires_on,
        :lease_term,
        :lease_rent_review_on,
        :lease_escalation_rate,
        :lease_escalation_formulae
      )
  end

  def set_active_nav_menu_option
    set_nav_menu_option(:properties)
  end
end
