class Appointment < ActiveRecord::Base

  belongs_to :masseur, class_name: "User"
  belongs_to :customer, class_name: "User"

  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :masseur_id
  validates_presence_of :customer_id

  validate :start_time_after_current_datetime
  validate :start_time_before_end_time
  validate :masseur_does_not_have_conflicting_appointments
  validate :customer_does_not_have_conflicting_appointments

  private

  # TODO: if the appointment has already been created, can't validate against itself (it will fail
  # when the new appointment time and old appointment time overlap)
  def masseur_does_not_have_conflicting_appointments
    if Appointment.where(start_time: start_time..end_time, masseur_id: masseur_id).count > 0 ||
       Appointment.where(end_time: start_time..end_time, masseur_id: masseur_id).count > 0
      errors.add :masseur_id, "There is an appointment conflict."
    end
  end

  # TODO: if the appointment has already been created, can't validate against itself (it will fail
  # when the new appointment time and old appointment time overlap)
  def customer_does_not_have_conflicting_appointments
    if Appointment.where(start_time: start_time..end_time, customer_id: customer_id).count > 0 ||
       Appointment.where(end_time: start_time..end_time, customer_id: customer_id).count > 0
      errors.add :customer_id, "There is an appointment conflict."
    end
  end

  def start_time_after_current_datetime
    errors.add :start_time, "can't be before current time." if start_time < DateTime.now
  end

  def start_time_before_end_time
    errors.add :end_time, "can't be before start time." if start_time > end_time
  end

  def serializable_hash options
    options ||= {
      include: {
        masseur: {
          only: [:id],
          methods: [:name]
        },
        customer: {
          only: [:id],
          methods: [:name]
        }
      }
    }
    super options
  end
end
