module.exports = {
  'env': {
    'browser': true,
    'es2021': true,
    'node': true,
  },

  'extends': 'eslint:recommended',

  'parserOptions': {
    'ecmaVersion': 12,
  },

  'rules': {
    'comma-dangle': [
      'error',
      'always-multiline',
    ],

    'indent': [
      'error',
      2,
    ],

    'linebreak-style': [
      'error',
      'unix',
    ],

    'quotes': [
      'error',
      'single',
    ],

    'semi': [
      'error',
      'never',
    ],
  },
}
