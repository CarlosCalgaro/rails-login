# Ruby Login

Implementation of a simple login system using the Ruby on Rails framework.

## Dependencies
This project was made using Ruby version 2.7.2p137 and Rails.

## Installation

Run bundler to install rails/ruby dependencies

```bash
bundle install
```

Run yarn to install javascript dependencies

```bash
yarn
```

Create the database and run the migrations

```bash
rails db:create
rails db:migrate
```
## Usage

Run rails console

```Bash
rails console

```
Create a new user using the console

```Ruby
User.create(username: "ExampleUsername",
            password:"<YourPassword>", 
            password_confirmation: "<YourPassword>)

```

Run the server 
```Bash
rails server

```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)