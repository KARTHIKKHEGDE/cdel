import useReportStore from '../store/useReportStore'

/**
 * Renders a function/symbol name with optional demangling.
 * Shows demangled name as primary, with mangled name in smaller text below.
 *
 * Props:
 *  - name: the mangled symbol name
 *  - className: extra classes for the wrapper
 *  - showMangled: if true, show the original mangled name below (default: true)
 *  - inline: if true, show mangled name inline in parens instead of below
 */
export default function DemangledName({ name, className = '', showMangled = false, inline = false }) {
    const displayName = useReportStore(s => s.displayName)
    const demangleEnabled = useReportStore(s => s.demangleEnabled)

    const display = displayName(name)
    const isDemangled = demangleEnabled && display !== name

    if (!isDemangled) {
        return <span className={className} title={name}>{name}</span>
    }

    if (inline) {
        return (
            <span className={className} title={name}>
                {display}{' '}
                {showMangled && (
                    <span className="text-muted text-[10px] opacity-70">({name})</span>
                )}
            </span>
        )
    }

    return (
        <span className={`${className} inline-flex flex-col`} title={name}>
            <span>{display}</span>
            {showMangled && (
                <span className="text-muted text-[10px] opacity-70 font-normal leading-tight">{name}</span>
            )}
        </span>
    )
}
