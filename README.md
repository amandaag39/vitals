# Vitals
Vitals is a user-centric web application designed to streamline the tracking of vital signs and dietary habits, enabling users and healthcare professionals to uncover correlations between diet and health outcomes. This application aims to support individuals managing chronic conditions, such as diabetes, by providing insights into how food intake affects their health. The current iteration features tools for logging numerical, image-based, and text-based health markers, as well as OpenAI API integration for analyzing user health logs and providing correlation and improvement analysis.

## Table of Contents
* Main Features
* Technologies Used
* Installation

## Main Features


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
  
## Installation

Current Main Branch: rails 7 + esbuild

Rails 6 + webpacker: https://github.com/mkhairi/rails-daisyui-starter/tree/rails6


```sh
bundle install
yarn install
rails db:migrate
bin/dev
```

