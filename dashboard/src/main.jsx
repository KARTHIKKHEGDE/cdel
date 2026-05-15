import React from 'react'
import ReactDOM from 'react-dom/client'
import './index.css'
import App from './App'

class ErrorBoundary extends React.Component {
    constructor(props) {
        super(props)
        this.state = { error: null }
    }

    static getDerivedStateFromError(error) {
        return { error }
    }

    render() {
        if (this.state.error) {
            return (
                <div style={{ padding: 24, fontFamily: 'JetBrains Mono, monospace', color: '#e5e7eb' }}>
                    <div style={{ fontSize: 18, marginBottom: 8 }}>UI crashed</div>
                    <div style={{ color: '#f78166', whiteSpace: 'pre-wrap' }}>
                        {String(this.state.error)}
                    </div>
                    <div style={{ marginTop: 8, color: '#8b949e' }}>
                        Open DevTools console for the full stack trace.
                    </div>
                </div>
            )
        }
        return this.props.children
    }
}

ReactDOM.createRoot(document.getElementById('root')).render(
    <React.StrictMode>
        <ErrorBoundary>
            <App />
        </ErrorBoundary>
    </React.StrictMode>
)
