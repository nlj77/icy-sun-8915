require 'rails_helper'

RSpec.describe "employee show page" do
    it "shows the employees name and department" do
        it = Department.create!(name:"IT", floor:"basement")
        customer_service= Department.create!(name:"Customer Service", floor:"first floor")
        nick = Employee.create!(name: "Nick", level:5, department_id:it.id)
        joe = Employee.create!(name: "Joe", level:6, department_id:customer_service.id)
        sally = Employee.create!(name: "Sally", level:8, department_id:it.id)

        visit "/employees/#{nick.id}"
        within "#employee" do
        expect(page).to have_content("Nick")
        expect(page).to have_content("department: IT")
        expect(page).to have_no_content("Joe")
        expect(page).to have_no_content("department: Customer Service")
        end
    end

    it "shows the employee's tickets, from oldest to youngest" do
        it = Department.create!(name:"IT", floor:"basement")
        nick = Employee.create!(name: "Nick", level:5, department_id:it.id)
        ticket1 = Ticket.create!(subject: "printer won't connect to wifi", age: 1)
        ticket2 = Ticket.create!(subject: "phone can't make outbound call", age: 2)
        ticket3 = Ticket.create!(subject: "computer won't backup to server", age: 3)

        EmployeeTicket.create!(employee_id: nick.id, ticket_id: ticket1.id)
        EmployeeTicket.create!(employee_id: nick.id, ticket_id: ticket2.id)
        EmployeeTicket.create!(employee_id: nick.id, ticket_id: ticket3.id)

        visit "/employees/#{nick.id}"
        within "#oldest-ticket" do
            expect(page).to have_content("Oldest Ticket: computer won't backup to server")
        end           
        # Story 2
        # Employee Show

        # As a user,
        # When I visit the Employee show page,
        # I see the employee's name, department
        # and a list of all of their tickets from oldest to youngest.
        # I also see the oldest ticket assigned to the employee listed separately
        end

        xit "does not show any tickets that aren't assigned to the employee" do
            it = Department.create!(name:"IT", floor:"basement")
            nick = Employee.create!(name: "Nick", level:5, department_id:it.id)
            ticket1 = Ticket.create!(subject: "printer won't connect to wifi", age: 1)
            ticket2 = Ticket.create!(subject: "phone can't make outbound call", age: 2)
            ticket3 = Ticket.create!(subject: "computer won't backup to server", age: 3)
    
            EmployeeTicket.create!(employee_id: nick.id, ticket_id: ticket1.id)
            EmployeeTicket.create!(employee_id: nick.id, ticket_id: ticket2.id)
            expect(page).to have_no_content("computer won't backup to server")
        end

        # Story 3

        # As a user,
        # When I visit the employee show page,
        # I do not see any tickets listed that are not assigned to the employee
        # and I see a form to add a ticket to this movie
        # When I fill in the form with the id of a ticket that already exists in the database
        # and I click submit
        # Then I am redirected back to that employees show page
        # and i see the ticket's subject now listed
        # (you do not have to test for sad path, for example if the id does not match an existing ticket
end


