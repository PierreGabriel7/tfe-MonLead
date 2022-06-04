<!-- PROJECT LOGO -->

  <h3 align="center">MonLead</h3>

### Built With

This section list any major frameworks/libraries used to create my project. 

- [Ruby](https://www.ruby-lang.org/)
- [Ruby on Rails 6](https://rubyonrails.org/)
- [DynamoDB](https://aws.amazon.com/dynamodb/)
- [Hyperledger Fabric](https://www.hyperledger.org/use/fabric)
- [Yarn](https://classic.yarnpkg.com/en/)



<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->

## Getting Started

Here are the instructions to build this project.

### Prerequisites

This is an example of how to install all the things you need to use the software and how to install them.

1. Install Ruby (ruby 3.1.1).

  ```sh
  https://www.ruby-lang.org/fr/documentation/installation/#installers
  ```
  
2. Install Yarn.

  ```sh
  https://classic.yarnpkg.com/en/docs/install#windows-stable
  ```

 

### Installation

1. Clone the repo:
   ```sh
   git clone https://github.com/PierreGabriel7/MonLead-test.git
   ```
2. Install the GEMs:

   ```sh
   bundle install
   ```

3. Install figaro and create the env file (located in "config/application.yml"):

   ```sh
   bundle exec figaro install
   ```

4. Edit the application.yml file and add these lines to match your dynamoDB keys:

   ```sh
   AWS_ACCESS_KEY_ID: "YOUR_KEY_ID"
   AWS_SECRET_ACCESS_KEY: "YOUR_ACCESS_KEY"
   AWS_REGION: "YOUR_REGION"
   
   AWS_COGNITO_APP_CLIENT_ID: "YOUR_AWS_COGNITO_APP_CLIENT_ID"
   AWS_COGNITO_APP_CLIENT_SECRET: "YOUR_AWS_COGNITO_APP_CLIENT_SECRET"
   AWS_COGNITO_DOMAIN: "YOUR_AWS_COGNITO_DOMAIN"
   AWS_COGNITO_POOL_ID: "YOUR_AWS_COGNITO_POOL_ID"
   AWS_COGNITO_REGION: "YOUR_AWS_COGNITO_REGION"
   
   MAILGUN_SMTP_LOGIN: "YOUR_MAILGUN_SMTP_LOGIN"
   MAILGUN_SMTP_PASSWORD: "YOUR_MAILGUN_SMTP_PASSWORD"
   
   MAPBOX_ACCES_KEY: "YOUR_MAPBOX_ACCES_KEY"


   ```
   
5. Create public dependencies and manifest file with:

   ```sh
   bundle exec rails webpacker:install -a
   ```

6. Start local server with local https support with:

   ```sh
   rails s -b 'ssl://127.0.0.1:3000?key=localhost.key&cert=localhost.crt'
   ```
   
 !!WARNING!! To try the loggin system in a local environement you will have to change two values in the header partial to point at the 127.0.0.1:3000 domain instead of the Heroku server. 
 
  ```sh
   app/views/layouts
    <li class="dropdown pc-h-item">
            <%= image_tag'user-solid.svg',id:'no-default-link',alt: 'user-image', class: 'user-avtar cst-default-avatar'%>
            <a class="btn btn-primary  rounded-pill"
							href="https://userandsocials.auth.eu-west-3.amazoncognito.com/login?response_type=code&client_id=1vibkotm8fqugn9v086iltn8a5&redirect_uri=https://monlead.herokuapp.com/auth/sign_in"
							role="button"><%= t('header.sign_in').capitalize %></a>
          </li>
          <li class="dropdown pc-h-item">
            <a class="btn btn-link  rounded-pill"
							href="https://userandsocials.auth.eu-west-3.amazoncognito.com/signup?response_type=code&client_id=1vibkotm8fqugn9v086iltn8a5&redirect_uri=https://monlead.herokuapp.com/auth/sign_in"
							role="button"><%= t('header.sign_up').capitalize %></a>
          </li>
   ```
   
   to
   
   
  ```sh
   app/views/layouts
    <li class="dropdown pc-h-item">
            <%= image_tag'user-solid.svg',id:'no-default-link',alt: 'user-image', class: 'user-avtar cst-default-avatar'%>
            <a class="btn btn-primary  rounded-pill"
							href="https://userandsocials.auth.eu-west-3.amazoncognito.com/login?response_type=code&client_id=1vibkotm8fqugn9v086iltn8a5&redirect_uri=https://127.0.0.1:3000/auth/sign_in"
							role="button"><%= t('header.sign_in').capitalize %></a>
          </li>
          <li class="dropdown pc-h-item">
            <a class="btn btn-link  rounded-pill"
							href="https://userandsocials.auth.eu-west-3.amazoncognito.com/signup?response_type=code&client_id=1vibkotm8fqugn9v086iltn8a5&redirect_uri=https://127.0.0.1:3000/auth/sign_in"
							role="button"><%= t('header.sign_up').capitalize %></a>
          </li>
   ```

<p align="right">(<a href="#top">back to top</a>)</p>
