import {defineConfig} from 'vite'
import FullReload from "vite-plugin-full-reload"
import RubyPlugin from 'vite-plugin-ruby'
import StimulusHMR from 'vite-plugin-stimulus-hmr'
import vue from '@vitejs/plugin-vue'
import inject from "@rollup/plugin-inject"

const path = require('path')

  export default ({ command, mode }) => {
    let minifySetting;

    if (mode === "development") {
      minifySetting = false;
    } else {
      minifySetting = "esbuild";
    }
    return {
      clearScreen: false,
      build: {
        minify: minifySetting
      },
      resolve: {
        alias: {
          '~bootstrap': path.resolve(__dirname, 'node_modules/bootstrap'),
          'vue': 'vue/dist/vue.esm-bundler',
        }
      },
      plugins: [
        inject({
          $: 'jquery',
          jQuery: 'jquery',
        }),
          RubyPlugin(), 
          StimulusHMR(), 
          FullReload(["config/routes.rb", "app/views/**/*"], {delay: 300}),
          vue()
      ],

    }
}
