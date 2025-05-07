module Properties
  class IndustrialForm < PropertyForm
    private

    def create_new_record
      IndustrialProperty.new
    end
  end
end
