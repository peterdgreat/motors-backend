class Api::V1::ReservationsController < ApplicationController
  def index
    @reservation = Reservation.all
    render json: @reservation
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      MotorReservation.create(motor_id: params[:motor_id], reservation_id: @reservation.id)
      render json: @reservation, status: :created

    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:user_id, :city, :date, :motor_id)
  end
end
