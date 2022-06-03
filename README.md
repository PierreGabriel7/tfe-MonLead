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

1. Install Ruby.

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
   ```
   
5. Create public dependencies and manifest file with:

   ```sh
   bundle exec rails webpacker:install -a
   ```

6. Start local server with:

   ```sh
   rails s
   ```


<p align="right">(<a href="#top">back to top</a>)</p>
