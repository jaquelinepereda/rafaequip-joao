class Contract < ApplicationRecord
  validates :number, :request_number, :customer, :address, :contact, :deadline,
            :start_date, :end_date, :price, presence: true
  has_many :rented_equipment
  has_many :equipment, through: :rented_equipment
  has_one :receipt
  has_one :received_receipt

  def equipment_list_names
    list = ''

    equipment.each do |eq|
      list << "#{eq.serial_number} / #{eq.name}, "
    end
    list
  end

  def period_format
    "#{I18n.l(start_date)} a #{I18n.l(end_date)}"
  end

  def amount_paid
    price - discount
  end

  def status?
    status ? 'Aberto' : 'Fechado'
  end
end
