class ObservationsTypo < ActiveRecord::Migration[5.0]
  def change
    change_table :observations do |t|
      t.rename :preasure, :pressure
    end
  end
end
