// To see this message, add the following to the `<head>` section in your
// views/layouts/application.html.erb
//
//    <%= vite_client_tag %>
//    <%= vite_javascript_tag 'application' %>
// Example: Load Rails libraries in Vite.
//
// import * as Turbo from '@hotwired/turbo'
// Turbo.start()
//
// import ActiveStorage from '@rails/activestorage'
// ActiveStorage.start()
//
// // Import all channels.
// const channels = import.meta.globEager('./**/*_channel.js')

// Example: Import a stylesheet in app/frontend/index.css
// import '~/index.css'

import { createApp } from 'vue';
import lux from 'lux-design-system';
import 'lux-design-system/dist/style.css';
import './application.scss';

console.warn('Vite ⚡️ Rails');

// If using a TypeScript entrypoint file:
//     <%= vite_typescript_tag 'application' %>
//
// If you want to use .jsx or .tsx, add the extension:
//     <%= vite_javascript_tag 'application.jsx' %>

console.warn(
  'Visit the guide for more information: ',
  'https://vite-ruby.netlify.app/guide/rails',
);

const app = createApp({});
const createMyApp = () => createApp(app);

document.addEventListener('DOMContentLoaded', () => {
  const elements = document.getElementsByClassName('lux');
  for (let i = 0; i < elements.length; i += 1) {
    createMyApp().use(lux).mount(elements[i]);
  }
});

/* eslint-disable no-console */
/* eslint-disable no-undef */
/* eslint-disable func-names */
window.log_plausible_cas_user_login = function () {
  console.log('log_plausible_cas_user_login event logged');
  plausible('Log in to CAS');
};

window.log_plausible_contact_us = function () {
  console.log('log_plausible_contact_us event logged');
  plausible('Contact Us');
};

window.log_plausible_faq = function (section) {
  console.log(`log_plausible_faq event: ${section} logged`);
  plausible('FAQ', { props: { section } });
};

window.log_plausible_connect_orcid = function () {
  console.log('log_plausible_connect_orcid event logged');
  plausible('Connect ORCID');
};
/* eslint-enable no-console */
/* eslint-enable no-undef */
/* eslint-enable func-names */
