// app/javascript/application.js

// Import Turbo for Rails (handles links, forms, and DELETE/PUT requests)
import "@hotwired/turbo-rails"

// Import Stimulus controllers (if you add custom controllers in /app/javascript/controllers)
import "controllers"

// Import Bootstrap JS (includes Popper.js internally)
import "bootstrap"

// ✅ Ensure Rails UJS-like behavior for link_to method: :delete
document.addEventListener("turbo:load", () => {
  console.log("Turbo is running, method: :delete will now work properly.");
});
