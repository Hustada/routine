class Workouts < ActiveRecord::Migration
	 def change
	  	create_table :Workouts do |t|
	  		t.string :name
	  		t.string :description
		
			t.timestamps
	  end
	end
end