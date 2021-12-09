class MyValidator < ActiveModel::Validator
  def validate(record)
    if Table.find_by(id: record.table_id).nil?
      record.errors.add :table_number, "is invalid"
    end
      
    if record.people_amount && record.table && record.table.customer_cap < record.people_amount
      record.errors.add :people_amount, "is invalid"
    end

    if record.people_amount && record.people_amount <= 0
      record.errors.add :people_amount, "can't be 0 or less than"
    end

    if record.start_time < DateTime.now 
      record.errors.add :start_time, "is invalid or in the past"
    end

    if !Table.find_by(id: record.table_id).nil? && Appointment.find_by(table_id: record.table.id, start_time: record.start_time)
      record.errors.add :start_time, "is canceled, this table is occupied"
    end
  end
end

class Appointment < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :user
  belongs_to :table

  attr_accessor :table_number

  # validates :table_number, presence: true
  validates :start_time, presence: true
  validates :people_amount, presence: true
  validates_with MyValidator

end
