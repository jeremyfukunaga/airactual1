<template>
  <div>
    <!-- Navigation Bar -->
    <nav class="bg-gray-900 p-4 fixed w-full z-20">
      <ul class="flex space-x-4 text-white justify-center">
        <li>
          <nuxt-link to="/" class="hover:underline">Home</nuxt-link>
        </li>
        <li>
          <nuxt-link to="/construction" class="hover:underline">Construction</nuxt-link>
        </li>
        <li>
          <nuxt-link to="/work" class="hover:underline">Work</nuxt-link>
        </li>
        <li>
          <nuxt-link to="/about" class="hover:underline">About</nuxt-link>
        </li>
        <li>
          <nuxt-link to="/contact" class="hover:underline">Contact</nuxt-link>
        </li>
      </ul>
    </nav>

    <main><slot /></main>

    <!-- Footer -->
    <footer class="bg-gray-900 p-6 text-white mt-12 relative z-10">
      <div class="flex justify-between items-center">
        <!-- Copyright on the left -->
        <p class="m-0">&copy; 2024 Air Actual. All rights reserved.</p>

        <!-- Social media links on the right -->
        <div>
          <span>Follow us on: </span>
          <a href="https://facebook.com" class="hover:underline">Facebook</a> | 
          <a href="https://twitter.com" class="hover:underline">Twitter</a> | 
          <a href="https://instagram.com" class="hover:underline">Instagram</a>
        </div>
      </div>
    </footer>
  </div>
</template>