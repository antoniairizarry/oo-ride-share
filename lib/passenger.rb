require 'time'

require_relative 'csv_record'

module RideShare
  class Passenger < CsvRecord
    attr_reader :name, :phone_number, :trips

    def initialize(id:, name:, phone_number:, trips: nil)
      super(id)

      @name = name
      @phone_number = phone_number
      @trips = trips || [] 
    end

    def add_trip(trip)
      @trips << trip
    end

    def net_expenditures
      total_money = 0
      @trips.each do |trip|
        if trip == nil
          return 0
        else
          total_money += trip.cost
        end
      end
      return total_money
    end


    def total_time_spent
      if @trips.empty? == true
        return 0
      else
        time_duration = (@trips).map do |trip|
          trip.time_difference
        end

        return time_duration.sum
      end
    end

    private

    def self.from_csv(record)
      return new(
        id: record[:id],
        name: record[:name],
        phone_number: record[:phone_num]
      )
    end
  end
end
