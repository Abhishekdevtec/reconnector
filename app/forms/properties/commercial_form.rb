module Properties
  class CommercialForm < PropertyForm
    private

    def create_new_record
      CommercialProperty.new
    end
  end
end
