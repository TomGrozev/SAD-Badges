module.exports = {
    plugins: [
        require('postcss-import'),
        require('postcss-simple-vars'),
        require('postcss-nested'),
        require("stylelint"),
        require("tailwindcss"),
        process.env.NODE_ENV === 'production' ? require('autoprefixer') : null,
        require('cssnano')({ preset: 'default' })
    ]
}
