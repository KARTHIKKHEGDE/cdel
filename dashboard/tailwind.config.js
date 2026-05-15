/** @type {import('tailwindcss').Config} */
export default {
    content: ["./index.html", "./src/**/*.{js,jsx}"],
    theme: {
        extend: {
            fontFamily: {
                mono: ['"JetBrains Mono"', 'monospace'],
                sans: ['"IBM Plex Sans"', 'sans-serif'],
            },
            colors: {
                bg: '#0d1117',
                surface: '#161b22',
                border: '#30363d',
                accent: '#58a6ff',
                hot: '#f78166',
                warm: '#e3b341',
                cool: '#3fb950',
                muted: '#8b949e',
            },
        },
    },
    plugins: [],
}
