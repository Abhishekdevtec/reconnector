class Console::ClassifiersController < ConsoleController
  before_action :set_classifier, only: %i[show edit update destroy]

  # GET /console/classifiers or /console/classifiers.json
  def index
    @classifiers = @account.classifiers.all
  end

  # GET /console/classifiers/1 or /console/classifiers/1.json
  def show
  end

  # GET /console/classifiers/new
  def new
    @classifier = @account.classifiers.new
  end

  # GET /console/classifiers/1/edit
  def edit
  end

  # POST /console/classifiers or /console/classifiers.json
  def create
    @classifier = @account.classifiers.new(classifier_params)

    respond_to do |format|
      if @classifier.save
        format.html { redirect_to [:console, @account, @classifier], notice: "Classifier was successfully created." }
        format.json { render :show, status: :created, location: @classifier }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @classifier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /console/classifiers/1 or /console/classifiers/1.json
  def update
    respond_to do |format|
      if @classifier.update(classifier_params)
        format.html { redirect_to [:console, @account, @classifier], notice: "Classifier was successfully updated." }
        format.json { render :show, status: :ok, location: @classifier }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @classifier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /console/classifiers/1 or /console/classifiers/1.json
  def destroy
    @classifier.destroy
    respond_to do |format|
      format.html { redirect_to [:console, @account, :classifiers], notice: "Classifier was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classifier
      @classifier = @account.classifiers.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def classifier_params
      params.require(:classifier).permit(:account_id, :name)
    end
end
