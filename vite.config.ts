import {defineConfig} from 'vite'
import FullReload from "vite-plugin-full-reload"
import RubyPlugin from 'vite-plugin-ruby'
import StimulusHMR from 'vite-plugin-stimulus-hmr'
const path = require('path')

export default defineConfig({
      clearScreen: false,
      resolve: {
        alias: {
          '~bootstrap': path.resolve(__dirname, 'node_modules/bootstrap'),
        }
      },
      plugins: [
          RubyPlugin(), 
          StimulusHMR(), 
          FullReload(["config/routes.rb", "app/views/**/*"], {delay: 300}),
      ],

    }
)
