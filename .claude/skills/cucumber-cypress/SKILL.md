---
name: cucumber-cypress
description: Cucumber BDD integration with Cypress for E2E testing. Use when writing Gherkin scenarios with Cypress step definitions.
---

# Cucumber + Cypress Integration

BDD testing with Cypress and @badeball/cypress-cucumber-preprocessor.

## Setup

```bash
npm i -D cypress @badeball/cypress-cucumber-preprocessor
```

## Project Structure

```
cypress/
├── e2e/
│   ├── features/
│   │   ├── login.feature
│   │   └── checkout.feature
│   └── step_definitions/
│       ├── login.steps.ts
│       └── common.steps.ts
├── support/
│   ├── commands.ts
│   └── e2e.ts
cypress.config.ts
```

## Cypress Configuration

```typescript
// cypress.config.ts
import { defineConfig } from 'cypress';
import createBundler from '@bahmutov/cypress-esbuild-preprocessor';
import { addCucumberPreprocessorPlugin } from '@badeball/cypress-cucumber-preprocessor';
import { createEsbuildPlugin } from '@badeball/cypress-cucumber-preprocessor/esbuild';

export default defineConfig({
  e2e: {
    specPattern: 'cypress/e2e/features/**/*.feature',
    async setupNodeEvents(on, config) {
      await addCucumberPreprocessorPlugin(on, config);
      on(
        'file:preprocessor',
        createBundler({ plugins: [createEsbuildPlugin(config)] })
      );
      return config;
    },
  },
});
```

## Step Definitions Configuration

```json
// .cypress-cucumber-preprocessorrc.json
{
  "stepDefinitions": [
    "cypress/e2e/step_definitions/**/*.ts",
    "cypress/support/step_definitions/**/*.ts"
  ]
}
```

## Feature File (Gherkin)

```gherkin
# cypress/e2e/features/login.feature
Feature: User Login

  Scenario: Successful login
    Given I am on the login page
    When I enter "user@example.com" as email
    And I enter "password123" as password
    And I click the login button
    Then I should see the dashboard

  Scenario Outline: Login validation
    Given I am on the login page
    When I enter "<email>" as email
    And I enter "<password>" as password
    And I click the login button
    Then I should see "<message>"

    Examples:
      | email            | password  | message             |
      | user@example.com | valid123  | Welcome             |
      | user@example.com | wrong     | Invalid credentials |
      | invalid          | any       | Invalid email       |
```

## Step Definitions

```typescript
// cypress/e2e/step_definitions/login.steps.ts
import { Given, When, Then } from '@badeball/cypress-cucumber-preprocessor';

Given('I am on the login page', () => {
  cy.visit('/login');
});

When('I enter {string} as email', (email: string) => {
  cy.get('[data-testid="email-input"]').type(email);
});

When('I enter {string} as password', (password: string) => {
  cy.get('[data-testid="password-input"]').type(password);
});

When('I click the login button', () => {
  cy.get('[data-testid="login-button"]').click();
});

Then('I should see the dashboard', () => {
  cy.url().should('include', '/dashboard');
});

Then('I should see {string}', (message: string) => {
  cy.contains(message).should('be.visible');
});
```

## Hooks

```typescript
// cypress/e2e/step_definitions/hooks.ts
import { Before, After } from '@badeball/cypress-cucumber-preprocessor';

Before(() => {
  // Runs before each scenario
  cy.clearCookies();
  cy.clearLocalStorage();
});

Before({ tags: '@login' }, () => {
  // Runs only for scenarios tagged with @login
  cy.fixture('users').as('users');
});

After(() => {
  // Runs after each scenario
});
```

## Invoking Other Steps

```typescript
import { When, Step } from '@badeball/cypress-cucumber-preprocessor';

When('I fill in the entire form', function () {
  Step(this, 'I fill in "john.doe" for "Username"');
  Step(this, 'I fill in "password" for "Password"');
});
```

## Running Tests

```bash
npx cypress run
npx cypress run --spec "cypress/e2e/features/login.feature"
npx cypress open  # Interactive mode
```
