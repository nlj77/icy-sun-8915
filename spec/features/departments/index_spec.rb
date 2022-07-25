require 'rails_helper'

RSpec.describe "department index page" do
    it "shows the department's name and floor" do 
        it = Department.create!(name:"IT", floor:"basement")
        visit "/departments"
        expect(page).to have_content("name of department: IT")
        expect(page).to have_content("floor: basement")
    end

    it "shows the names of all employees below the department" do
        it = Department.create!(name:"IT", floor:"basement")
        customer_service= Department.create!(name:"Customer Service", floor:"first floor")
        nick = Employee.create!(name: "Nick", level:5, department_id:it.id)
        joe = Employee.create!(name: "Joe", level:6, department_id:customer_service.id)
        sally = Employee.create!(name: "Sally", level:8, department_id:it.id)

        visit "/departments"

        within "#departments-#{it.id}" do
            expect(page).to have_content("Nick, level:5")   
            expect(page).to have_content("Sally, level:8")
            expect(page).to have_no_content("Joe, level:6")

        end

    end
end

# Story 1
# Department Index

# As a user,
# When I visit the Department index page,
# I see each department's name and floor
# And underneath each department, I can see the names of all of its employees