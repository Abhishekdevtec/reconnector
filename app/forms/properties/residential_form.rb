module Properties
  class ResidentialForm < PropertyForm
    private

    def create_new_record
      ResidentailProperty.new
    end
  end
end
