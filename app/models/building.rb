class Building < ApplicationRecord
    belongs_to :customer, optional: true
    belongs_to :address, optional: true
    has_one :building_detail
    has_many :batteries

    def building_params
        params.require(:expense).permit(:address_building, :name_administrator_building, :email_administrator_building, :phone_administrator_building, :name_technical_building, :email_technical_building, :phone_technical_building, :service_technical_authority_name, :technical_authority_phone, :service_technical_authority_email, :customer_id)
    end
end
