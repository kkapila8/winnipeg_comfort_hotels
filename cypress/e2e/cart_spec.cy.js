// Feature 5.5 - Cypress E2E Tests for Cart and Checkout
// Tests cover happy path and unhappy paths

describe('Cart and Checkout', () => {

  // Helper to login before cart tests
  beforeEach(() => {
    cy.visit('http://localhost:3000/users/sign_in')
    cy.get('input[name="user[email]"]').type('admin@wpgcomfort.com')
    cy.get('input[name="user[password]"]').type('password123')
    cy.get('input[type="submit"]').click()
    cy.url().should('eq', 'http://localhost:3000/')
  })

  // ── CART TESTS ─────────────────────────────────────────

  describe('Shopping Cart', () => {

    // Happy Path - add item to cart
    it('Happy Path: allows user to add a room to the cart', () => {
      cy.visit('http://localhost:3000')
      
      // Click first room
      cy.get('.card').first().find('a').contains('View Room').click()
      
      // Add to cart
      cy.get('input[type="submit"]').click()
      
      // Should show success flash message
      cy.get('.alert-success').should('be.visible')
      
      // Cart count should increase
      cy.get('.badge').should('contain', '1')
    })

    // Happy Path - update cart quantity
    it('Happy Path: allows user to update quantity in cart', () => {
      // Add item first
      cy.visit('http://localhost:3000')
      cy.get('.card').first().find('a').contains('View Room').click()
      cy.get('input[type="submit"]').click()
      
      // Go to cart
      cy.visit('http://localhost:3000/cart')
      
      // Update quantity
      cy.get('input[type="number"]').clear().type('3')
      cy.get('input[value="Update"]').click()
      
      // Should show success message
      cy.get('.alert-success').should('be.visible')
      cy.get('.alert-success').should('contain', 'Cart updated')
    })

    // Happy Path - remove item from cart
    it('Happy Path: allows user to remove item from cart', () => {
      // Add item first
      cy.visit('http://localhost:3000')
      cy.get('.card').first().find('a').contains('View Room').click()
      cy.get('input[type="submit"]').click()
      
      // Go to cart
      cy.visit('http://localhost:3000/cart')
      
      // Remove item
      cy.get('button').contains('Remove').click()
      
      // Should show empty cart message
      cy.get('.alert-success').should('be.visible')
      cy.contains('Your cart is empty').should('be.visible')
    })

    // Unhappy Path - checkout with empty cart
    it('Unhappy Path: redirects to rooms page when cart is empty', () => {
      // Make sure cart is empty
      cy.visit('http://localhost:3000/cart')
      
      // Try to go to checkout with empty cart
      cy.visit('http://localhost:3000/checkout')
      
      // Should redirect to rooms with error
      cy.url().should('include', '/rooms')
      cy.get('.alert-danger').should('be.visible')
    })
  })

  // ── CHECKOUT TESTS ─────────────────────────────────────

  describe('Checkout', () => {

    // Happy Path - complete checkout
    it('Happy Path: allows user to complete checkout with address and province', () => {
      // Add item to cart
      cy.visit('http://localhost:3000')
      cy.get('.card').first().find('a').contains('View Room').click()
      cy.get('input[type="submit"]').click()
      
      // Go to checkout
      cy.visit('http://localhost:3000/checkout')
      
      // Fill in address
      cy.get('input[name="address"]').clear().type('123 Main Street')
      cy.get('input[name="city"]').clear().type('Winnipeg')
      cy.get('input[name="postal_code"]').clear().type('R3C1A3')
      
      // Select province
      cy.get('select[name="province_id"]').select('Manitoba')
      
      // Should show taxes
      cy.contains('GST').should('be.visible')
      cy.contains('PST').should('be.visible')
    })

    // Unhappy Path - checkout without being logged in
    it('Unhappy Path: redirects to login when not authenticated', () => {
      // Sign out first
      cy.visit('http://localhost:3000/users/sign_out')
      
      // Try to access checkout
      cy.visit('http://localhost:3000/checkout')
      
      // Should redirect to login
      cy.url().should('include', '/users/sign_in')
    })
  })
})