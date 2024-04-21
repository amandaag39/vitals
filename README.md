# Vitals
Vitals is a user-centric web application designed to streamline the tracking of vital signs and dietary habits, enabling users and healthcare professionals to uncover correlations between diet and health outcomes. This application aims to support individuals managing chronic conditions, such as diabetes, by providing insights into how food intake affects their health. The current iteration features tools for logging numerical, image-based, and text-based health markers, as well as OpenAI API integration for analyzing user health logs and providing correlation and improvement analysis.

## Table of Contents
* Main Features
* Technologies Used
* Installation

## Main Features
### Custom vital tracking

### Calendar Paginated Logs

### Image Logging with AWS

### Analysis with Open AI API
<div>
    <a href="https://www.loom.com/share/921a238ae50542e08536748e5f8339e7">
      <p>Exploring a Technical Issue with Screen Sharing - Watch Video</p>
    </a>
    <a href="https://www.loom.com/share/921a238ae50542e08536748e5f8339e7">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/921a238ae50542e08536748e5f8339e7-1713738102411-with-play.gif">
    </a>
  </div>



## Technologies Used
* Rails 7
* Tailwind
* Daisy UI

## Services Used
* AWS S3
* Open AI API

## Configuration

To configure your application to use AWS S3 and OpenAI API services, follow these detailed steps:

### 1. Generate a Master Key
If you do not already have a `master.key` file, you can generate one by running:
```bash
EDITOR="code --wait" rails credentials:edit
```

This command will open the credentials file in Visual Studio Code (replace "code --wait" with your preferred editor), and a new master.key file will be generated automatically if it does not exist.

### 2. Add Service API Tokens
Inside the opened credentials file, add your API tokens and other sensitive configuration variables in a structured format. For example:

```yaml
aws:
  access_key_id: YOUR_AWS_ACCESS_KEY_ID
  secret_access_key: YOUR_AWS_SECRET_ACCESS_KEY

openai:
  api_key: YOUR_OPENAI_API_KEY
```

Save and close the file. The changes will be encrypted and saved securely, accessible only via the master.key.

### 3. Ensure the Security of the Master Key
Never commit your master.key or the credentials file to version control. Add the master.key to your .gitignore file to prevent it from being accidentally pushed to your repository:
```bash
echo 'config/master.key' >> .gitignore
```
## Installation

### Current Main Branch: rails 7 + esbuild
* clone the repository and switch to the main branch
* run the following commands

```sh
bundle install
yarn install
rails db:migrate
rake sample_data
bin/dev
```
### Rails 6 + Webpacker
* For the Rails 6 version, visit: https://github.com/mkhairi/rails-daisyui-starter/tree/rails6


