# Rails Project Setup Guide

This document outlines the steps taken to set up a new Rails project with authentication (using Devise), PostgreSQL as the database, and an Admin dashboard for authenticated users. It also includes customizations to the sign-in page and controller logic.

## Prerequisites

Before starting the project, ensure you have the following tools installed on your Windows machine:

- **Git**
- **Node.js**
- **Yarn**
- **Ruby+Devkit** (Ruby version: 3.3.5)
- **Rails Installer for Windows** (railsinstaller-4.0.0.exe)

### Installation Instructions

1.  **Download and Install Git:**

    - [Download Git](https://git-scm.com/download/win) and install it on your machine.

2.  **Download and Install Node.js:**

    - Download Node.js and install it.

3.  **Download and Install Yarn:**

    - Download Yarn and install it.

4.  **Download and Install Ruby+Devkit:**

    - Download the latest version of Ruby+Devkit from [RubyInstaller](https://rubyinstaller.org/downloads/). For example, `Ruby+Devkit 3.3.5-1 (x64)`.
    - Install Ruby with Devkit support.

5.  **Install Rails Globally:**

    - Open `cmd` and run the following command to install Rails globally:

    ```bash
      gem install rails
    ```

---

## Project Setup

1.  **Create a New Rails Project:**

    - Navigate to the desired directory using `cmd` and create a new Rails project with PostgreSQL as the database (without tests) by running:

    ```bash
      rails new your-project-name -T -d postgresql
    ```

2.  **Install Missing Gems:**

    - If you encounter the error `"An error occurred while installing psych"`, resolve it by running:

    ```bash
      gem install psych bundle install --gemfile E:/rails-project/Gemfile
    ```

3.  **Start the Rails Server:**

    - To start the Rails server and see your project in action, run:

    ```bash
      rails s
    ```

4.  **Update Database Configuration:**

    - Modify the `config/database.yml` file to match your PostgreSQL configuration.

5.  **Create the Database:**

    - Run the following command to create the database:

    ```bash
      rails db:create --trace
    ```

---

## Authentication with Devise

### Add Devise Gem

1.  **Add Devise for User Authentication:**

    - To integrate user authentication, run the following command to install the Devise gem:

    ```bash
      bundle add devise bundle install
    ```

2.  **Configure Mailer for Devise:**

    - Open `config/environments/development.rb` and add the following line for mailer configuration:

    ```ruby
    config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
    ```

3.  **Generate Devise Views:**

    - To customize the Devise views (login, registration, etc.), run:

    ```bash
    rails g devise:views
    ```

4.  **Generate the User Model:**

    - Create the `User` model with Devise by running:

    ```bash
    rails generate devise User
    ```

5.  **Add Additional Fields to User Model:**

    - Update `app/controllers/application_controller.rb` to allow extra parameters (`name` and `role`) during sign-up and account updates:

    ```ruby
    class ApplicationController < ActionController::Base
        before_action :configure_permitted_parameters, if: :devise_controller?

        protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
            devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role])
        end
    end
    ```

6.  **Migrate the Database:**

    - Run the following command to apply the database migrations:

    ```bash
    rails db:migrate
    ```

---

## Admin Dashboard

### Set Up Admin Dashboard

1.  **Generate Admin Dashboard Controller:**

    - Create a controller for the Admin dashboard to be accessible by authenticated users only:

    ```bash
    rails generate controller Admin::Dashboard index
    ```

2.  **Restrict Access to Authenticated Users:**

    - You can restrict access to the `Admin::Dashboard` controller by using Devise's authentication method.

---

## Customizing Views and Controllers

1.  **Change Sign-in Page Design:**

    - You can customize the design of the sign-in page by editing `app/views/devise/sessions/new.html.erb`.

2.  **Modify Routes:**

    - Update the `config/routes.rb` file to set the root path to `home#index`:

    ```ruby
      Rails.application.routes.draw do   root "home#index"  # Sets the root path to home#index end`
    ```

3.  **Generate Home Controller:**

    - Generate a controller for the homepage:

    ```bash
      rails generate controller home index
    ```

4.  **Update Global Layout:**

    - Update the layout in `app/views/layouts/application.html.erb` to include Tailwind CSS (via CDN) and display notices and alerts:

    ```ruby
     <head>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css" rel="stylesheet">
     </head>
     <body>
        <p class="notice"><%= notice %></p>
        <p class="alert"><%= alert %></p>
     </body>
    ```

5.  **Add Global CSS:**

    - You can add your custom CSS in `app/assets/stylesheets/application.css`.

---

## Additional Setup for Tailwind CSS

1.  **Install Tailwind CSS:**

    - Add Tailwind CSS via CDN in the file `app/views/layouts/application.html.erb`

    ```html
    <link
      href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css"
      rel="stylesheet"
    />
    ```

2.  **Configure Tailwind in CSS:**

    - Tailwind classes can be used directly in your `.html.erb` files after including the CDN.

---

## Troubleshooting

- **Error Installing `psych`:**

  - If you encounter an error when installing gems, run:

    ```bash
    gem install psych
    ```

- **Database Issues:**

  - If you face issues while creating or migrating the database, ensure that your PostgreSQL is correctly configured and the database is running.
