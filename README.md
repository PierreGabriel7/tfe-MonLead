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


<p align="right">(<a href="#top">back to top</a>)</p>
