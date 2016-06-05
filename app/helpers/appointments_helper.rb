module AppointmentsHelper
  def date_and_time(appointment)
    l(appointment.date_at, format: '%d. %B, ') + l(appointment.start_time_at, format: '%H:%M')
  end
end
