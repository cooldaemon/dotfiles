---
name: cucumber-playwright
description: Cucumber BDD integration with Playwright for E2E testing. Use when writing Gherkin scenarios with Playwright step definitions.
---

# Cucumber + Playwright Integration

BDD testing with Cucumber and Playwright.

## Setup

```bash
npm i -D @cucumber/cucumber @playwright/test
```

## Project Structure

```
features/
├── login.feature
├── checkout.feature
step_definitions/
├── login.steps.ts
├── common.steps.ts
support/
├── hooks.ts          # Browser setup/teardown
├── world.ts          # Shared context with page
cucumber.js           # Cucumber config
```

## World Object with Playwright Page

```typescript
// support/world.ts
import { setWorldConstructor, World } from '@cucumber/cucumber';
import { Browser, BrowserContext, Page, chromium } from '@playwright/test';

export class PlaywrightWorld extends World {
  browser!: Browser;
  context!: BrowserContext;
  page!: Page;
}

setWorldConstructor(PlaywrightWorld);
```

## Hooks for Browser Lifecycle

```typescript
// support/hooks.ts
import { Before, After, BeforeAll, AfterAll } from '@cucumber/cucumber';
import { chromium, Browser } from '@playwright/test';
import { PlaywrightWorld } from './world';

let browser: Browser;

BeforeAll(async function () {
  browser = await chromium.launch();
});

AfterAll(async function () {
  await browser.close();
});

Before(async function (this: PlaywrightWorld) {
  this.context = await browser.newContext();
  this.page = await this.context.newPage();
});

After(async function (this: PlaywrightWorld) {
  await this.context.close();
});
```

## Feature File (Gherkin)

```gherkin
# features/login.feature
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
// step_definitions/login.steps.ts
import { Given, When, Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { PlaywrightWorld } from '../support/world';

Given('I am on the login page', async function (this: PlaywrightWorld) {
  await this.page.goto('/login');
});

When('I enter {string} as email', async function (this: PlaywrightWorld, email: string) {
  await this.page.getByTestId('email-input').fill(email);
});

When('I enter {string} as password', async function (this: PlaywrightWorld, password: string) {
  await this.page.getByTestId('password-input').fill(password);
});

When('I click the login button', async function (this: PlaywrightWorld) {
  await this.page.getByRole('button', { name: 'Login' }).click();
});

Then('I should see the dashboard', async function (this: PlaywrightWorld) {
  await expect(this.page).toHaveURL('/dashboard');
});

Then('I should see {string}', async function (this: PlaywrightWorld, message: string) {
  await expect(this.page.getByText(message)).toBeVisible();
});
```

## Cucumber Configuration

```javascript
// cucumber.js
module.exports = {
  default: {
    require: ['step_definitions/**/*.ts', 'support/**/*.ts'],
    requireModule: ['ts-node/register'],
    format: ['progress', 'html:reports/cucumber-report.html'],
    publishQuiet: true,
  },
};
```

## Running Tests

```bash
npx cucumber-js
npx cucumber-js --tags "@smoke"
npx cucumber-js features/login.feature
```
