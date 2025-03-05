# Little Shop - Mod 2 Group Project - BE Half

# README

### Collaborators

Shadeau Christensen
GitHub Profile: https://github.com/shadeauchristensen

Rig Freyr
GitHub Profile: https://github.com/ontruster74

Sebastian McKee
GitHub Profile: https://github.com/0nehundr3d

Coral Ruschak
GitHub Profile: https://github.com/Coralruschak

DTR Agreement Link: 

### Setup

* Ruby version

Ruby v. 3.2.2+ and Ruby on Rails v. 7.1.2+ is needed for this project.

* Setup instructions
  
Clone this repo down to your machine.
Clone the FE half of this project down to your machine in a different directory: https://github.com/ontruster74/little-shop-fe-group-starter

Run the following commands in your project directory to set up the database:

  $ bundle install
  $ rails db:{drop,create,migrate,seed}
  $ rails db:dump:schema

Run the following command in your project directory to start the rails server:

  $ rails s

You will also need to run the following in the FE half's folder:

  $ npm run dev

Once both the FE and BE halves of the project are running, open it in your browser at localhost:5173 to see the application in action.

* How to run the test suite

Run the following commands in your project directory to run the test suites:

  $ bundle exec rspec spec/requests/api/v1
  $ bundle exec rspec spec/models

