// Feature 5.5 - Cypress E2E Tests for Sign Up and Login
// Tests cover happy path and unhappy paths

describe('Authentication - Sign Up and Login', () => {

  // ── SIGN UP TESTS ──────────────────────────────────────

  describe('Sign Up', () => {

    // Happy Path - successful signup
    it('Happy Path: allows a new user to sign up successfully', () => {
      cy.visit('http://localhost:3000/users/sign_up')

      cy.get('input[name="user[name]"]').type('Test User')
      cy.get('input[name="user[email]"]').type(`testuser${Date.now()}@example.com`)
      cy.get('input[name="user[password]"]').type('password123')
      cy.get('input[name="user[password_confirmation]"]').type('password123')
      cy.get('input[type="submit"]').click()

      // Should redirect to home page after signup
      cy.url().should('eq', 'http://localhost:3000/')
    })

    // Unhappy Path - missing name
    it('Unhappy Path: shows error when name is blank', () => {
      cy.visit('http://localhost:3000/users/sign_up')

      cy.get('input[name="user[name]"]').type('A')
      cy.get('input[name="user[email]"]').type(`noname${Date.now()}@example.com`)
      cy.get('input[name="user[password]"]').type('password123')
      cy.get('input[name="user[password_confirmation]"]').type('password123')

      // Clear name to bypass HTML5 required
      cy.get('input[name="user[name]"]').clear()

      // Submit bypassing HTML5 validation
      cy.get('form').invoke('submit')

      // Should show validation error
      cy.get('.alert-danger').should('be.visible')
    })

    // Unhappy Path - email already taken
    it('Unhappy Path: shows error when email is already taken', () => {
      cy.visit('http://localhost:3000/users/sign_up')

      cy.get('input[name="user[name]"]').type('Admin User')
      cy.get('input[name="user[email]"]').type('admin@wpgcomfort.com')
      cy.get('input[name="user[password]"]').type('password123')
      cy.get('input[name="user[password_confirmation]"]').type('password123')
      cy.get('input[type="submit"]').click()

      // Should show email taken error
      cy.get('.alert-danger').should('be.visible')
      cy.get('.alert-danger').should('contain', 'Email has already been taken')
    })

    // Unhappy Path - password too short
    it('Unhappy Path: shows error when password is too short', () => {
      cy.visit('http://localhost:3000/users/sign_up')

      cy.get('input[name="user[name]"]').type('Test User')
      cy.get('input[name="user[email]"]').type(`shortpass${Date.now()}@example.com`)
      cy.get('input[name="user[password]"]').type('abc')
      cy.get('input[name="user[password_confirmation]"]').type('abc')
      cy.get('input[type="submit"]').click()

      // Should show password too short error
      cy.get('.alert-danger').should('be.visible')
    })

    // Unhappy Path - password confirmation mismatch
    it('Unhappy Path: shows error when passwords do not match', () => {
      cy.visit('http://localhost:3000/users/sign_up')

      cy.get('input[name="user[name]"]').type('Test User')
      cy.get('input[name="user[email]"]').type(`mismatch${Date.now()}@example.com`)
      cy.get('input[name="user[password]"]').type('password123')
      cy.get('input[name="user[password_confirmation]"]').type('differentpassword')
      cy.get('input[type="submit"]').click()

      // Should show password mismatch error
      cy.get('.alert-danger').should('be.visible')
    })
  })

  // ── LOGIN TESTS ────────────────────────────────────────

  describe('Login', () => {

    // Happy Path - successful login
    it('Happy Path: allows existing user to login successfully', () => {
      cy.visit('http://localhost:3000/users/sign_in')

      cy.get('input[name="user[email]"]').type('admin@wpgcomfort.com')
      cy.get('input[name="user[password]"]').type('password123')
      cy.get('input[type="submit"]').click()

      // Should redirect to home after login
      cy.url().should('eq', 'http://localhost:3000/')
    })

    // Unhappy Path - wrong password
    it('Unhappy Path: shows error when password is incorrect', () => {
      cy.visit('http://localhost:3000/users/sign_in')

      cy.get('input[name="user[email]"]').type('admin@wpgcomfort.com')
      cy.get('input[name="user[password]"]').type('wrongpassword')
      cy.get('input[type="submit"]').click()

      // Should show invalid credentials error
      cy.get('.alert-danger').should('be.visible')
      cy.get('.alert-danger').should('contain', 'Invalid')
    })

    // Unhappy Path - wrong email
    it('Unhappy Path: shows error when email does not exist', () => {
      cy.visit('http://localhost:3000/users/sign_in')

      cy.get('input[name="user[email]"]').type('notexist@example.com')
      cy.get('input[name="user[password]"]').type('password123')
      cy.get('input[type="submit"]').click()

      // Should show invalid credentials error
      cy.get('.alert-danger').should('be.visible')
    })

    // Unhappy Path - wrong credentials
    it('Unhappy Path: shows error when credentials are wrong', () => {
      cy.visit('http://localhost:3000/users/sign_in')

      cy.get('input[name="user[email]"]').type('wrong@wrong.com')
      cy.get('input[name="user[password]"]').type('wrongpassword')
      cy.get('input[type="submit"]').click()

      // Should show error
      cy.get('.alert-danger').should('be.visible')
    })
  })
})