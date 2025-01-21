import globals from 'globals';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import js from '@eslint/js';
import { FlatCompat } from '@eslint/eslintrc';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const compat = new FlatCompat({
  baseDirectory: __dirname,
  recommendedConfig: js.configs.recommended,
  allConfig: js.configs.all,
});

export default [
  {
    ignores: [
      'app/javascript/entrypoints/vendor/**/*',
      'app/javascript/**/*.css',
      'app/javascript/**/*.scss',
      'app/javascript/images/*',
      'app/javascript/fonts/*',
    ],
  },
  ...compat.extends('airbnb-base'),
  {
    languageOptions: {
      globals: {
        ...globals.browser,
        $: 'readonly',
        isOrcid: 'readonly',
      },

      ecmaVersion: 'latest',
      sourceType: 'module',
    },

    rules: {
      'no-console': [
        'error',
        {
          allow: ['warn', 'error'],
        },
      ],
    },
  },
];
