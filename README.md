# Vitals
Vitals is a user-centric web application designed to streamline the tracking of vital signs and dietary habits, enabling users and healthcare professionals to uncover correlations between diet and health outcomes. This application aims to support individuals managing chronic conditions, such as diabetes, by providing insights into how food intake affects their health. The current iteration features tools for logging numerical, image-based, and text-based health markers, as well as OpenAI API integration for analyzing user health logs and providing correlation and improvement analysis.

## Table of Contents
- [Main Features](#main-features)
- [Technologies Used](#technologies-used)
- [Services Used](#services-used)
- [Installation](#installation)
- [Contribution Guidelines](#contribution-guidelines)
- [FAQ](#faq)

## Main Features
### Custom vital tracking
Users can create their own custom vitals to track. These can be numeric, image, and text based. The most useful way to use these vitals is to create one named 'Meals' and track anything against that Vital. 

https://github.com/amandaag39/vitals/assets/71214594/5ebf5c53-0fed-4c8e-9b03-8cf9eff011aa

### Daily Average Charts for Numeric Vitals
For numeric vitals, such as blood glucose, Vitals comes with Charts that track daily Vital averages for a quick reference point for facilitating correlation identication. 

https://github.com/amandaag39/vitals/assets/71214594/c109d27a-5261-4399-aead-2eabb85ac2bd

### Calendar Paginated Logs
Best used in conjunction with numeric vital charts, the calendar paginated logs allow the user to target peak and low dates and troubleshoot which foods may be the cause of these fluctuations.

https://github.com/amandaag39/vitals/assets/71214594/2090d88d-eeba-42b3-b7c2-27b45291a0f0

### Image Logging with AWS
As scaffolding for Image support, users can log meals as image values to facilitate intuitive and quick logging. 
[![Watch the video](https://img.youtube.com/vi/4y9W_lasucI/0.jpg)](https://youtube.com/shorts/4y9W_lasucI?feature=share)

### Analysis with Open AI API
Currently working with two vital types, users can gauge correlations from a birds eye perspective, using Open AI to search for correlations and provide meal improvements and recommendations. 

https://github.com/amandaag39/vitals/assets/71214594/fe66f59e-f899-483a-aae7-cc7f50da1305

## Technologies Used
* Rails 7
* Tailwind
* Daisy UI

## Services Used
* AWS S3
* Open AI API

### Configuration

To configure your application to use AWS S3 and OpenAI API services, follow these detailed steps:

#### 1. Generate a Master Key
If you do not already have a `master.key` file, you can generate one by running:
```bash
EDITOR="code --wait" rails credentials:edit
```

This command will open the credentials file in Visual Studio Code (replace "code --wait" with your preferred editor), and a new master.key file will be generated automatically if it does not exist.

#### 2. Add Service API Tokens
Inside the opened credentials file, add your API tokens and other sensitive configuration variables in a structured format. For example:

```yaml
aws:
  access_key_id: YOUR_AWS_ACCESS_KEY_ID
  secret_access_key: YOUR_AWS_SECRET_ACCESS_KEY

openai:
  api_key: YOUR_OPENAI_API_KEY
```

Save and close the file. The changes will be encrypted and saved securely, accessible only via the master.key.

#### 3. Ensure the Security of the Master Key
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

After running the above commands one user with about 6 months of numeric and text data will be generated. Sign in with
``alice@example.com`` and password: ``password``

### Entity Relationship Diagram
![Screenshot 2024-03-20 at 4 30 33 PM](https://github.com/amandaag39/vitals/assets/71214594/25f5eeec-3e9a-4cae-a87d-dab81ea7640c)

## Contribution Guidelines

### Introduction
Thank you for your interest in contributing to [Vitals]. This document provides guidelines and instructions on how to contribute to the project.

### How to Contribute
1. **Setup your environment**: Follow the installation instructions above.
2. **Find an issue to work on**: In the Projects tab, check out our issues, at times I may have some issues labeled "good first issue".

### Coding Conventions
We adhere to the Ruby community style guide, and we expect all contributors to follow suit. Here are key conventions specific to our project:

- **Code Style**: Follow the [Ruby Style Guide](https://rubystyle.guide/), which provides detailed guidelines on the coding style preferred by the Ruby community.
- **Naming Conventions**:
  - Use `snake_case` for variables, methods, and file names.
  - Use `PascalCase` for class and module names.
  - Reflect domain concepts accurately in naming. For instance, if you are working within a medical application, prefer names like `patient_record` over vague terms like `data_entry`.

- **Design Principles**: Focus on Domain-Driven Design (DDD):
  - Organize code to reflect the domain model clearly.
  - Use service objects, decorators, and other design patterns that help isolate domain logic from application logic.

- **Testing Conventions**:
  - Write tests for all new features and bug fixes.
  - Use RSpec for testing, adhering to the [RSpec Style Guide](https://rspec.rubystyle.guide/).
  - Ensure test names clearly describe their purpose, reflecting domain-specific terminology.

### Comments and Documentation
- **Comment your code** where necessary to explain "why" something is done, not "what" is done—source code should be self-explanatory regarding the "what".
- **Document methods and classes** thoroughly, focusing on their roles within the domain model, especially for public APIs.

### Version Control Practices
- Commit messages should be clear and follow best practices, such as those outlined in [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/).
- Keep commits focused on a single issue to simplify future maintenance and troubleshooting.

### Branch Naming Conventions
Please use the following naming conventions for your branches:
- Features: `feature/<feature-name>`
- Bug Fixes: `bugfix/<bug-description>`
- Refactoring: `refactor/<refactor-subject>`

### Pull Request Process
1. **Creating a Pull Request**: Provide a detailed PR description, referencing the issue it addresses.
2. **Review Process**: PRs require review from at least one maintainer.

### Community and Communication
Join our [Discord/Slack/Forum] to communicate with other contributors and maintainers.

### Acknowledgment of Contributors
Contributors who make significant contributions will be listed in our [README/CONTRIBUTORS] file.

Thank you for contributing to [Vitals]!


## FAQ
