module.exports = {
    purge: [
        "../**/*.html.eex",
        "../**/*.html.leex",
        "../**/views/**/*.ex",
        "../**/live/**/*.ex",
        "./js/**/*.js",
    ],
    theme: {
        extend: {
            colors: {
                'brand-light': '#f3855a',
                'brand': '#ff3403',
                'brand-dark': '#7a240e',

                'cta-light': '#73f5b6',
                'cta': '#03d595',
                'cta-dark': '#227755',

                'info-light': '#e7f0f2',
                'info': '#9ec3cd',
                'info-dark': '#4d5d61',

                'warning-light': '#ffefca',
                'warning': '#ffc100',
                'warning-dark': '#795c16',

                'success-light': '#e5f5cf',
                'success': '#8bd336',
                'success-dark': '#466422',

                'danger-light': '#fa9481',
                'danger': '#ff333a',
                'danger-dark': '#7a2420',
            },
        },
    },
    variants: {},
    plugins: [],
}
