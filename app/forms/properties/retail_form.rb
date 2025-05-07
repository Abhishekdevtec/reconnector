module Properties
  class RetailForm < PropertyForm
    private

    def create_new_record
      RetailProperty.new
    end
  end
end
