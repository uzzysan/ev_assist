import React, { useId } from 'react';

interface InputProps extends React.InputHTMLAttributes<HTMLInputElement> {
    label: string;
    suffix?: string;
    error?: string;
}

export const Input: React.FC<InputProps> = ({ label, suffix, error, style, id, ...props }) => {
    // Use React's built-in useId hook for stable, unique IDs
    const generatedId = useId();
    const inputId = id || `${generatedId}-${label.replace(/\s+/g, '-').toLowerCase()}`;

    return (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.375rem', width: '100%', ...style }}>
            <label
                htmlFor={inputId}
                style={{ 
                    fontSize: 'clamp(0.8rem, 3.5vw, 0.875rem)', 
                    fontWeight: 500, 
                    color: 'var(--text-muted)',
                }}
            >
                {label}
            </label>
            <div style={{ position: 'relative', display: 'flex', alignItems: 'center' }}>
                <input
                    id={inputId}
                    {...props}
                    style={{
                        width: '100%',
                        padding: 'clamp(0.875rem, 3.5vw, 1rem)',
                        paddingRight: suffix ? '3.5rem' : 'clamp(0.875rem, 3.5vw, 1rem)',
                        borderRadius: 'var(--radius-lg)',
                        border: `2px solid ${error ? 'var(--error-color)' : 'var(--border-color)'}`,
                        backgroundColor: 'var(--input-bg)',
                        color: 'var(--text-color)',
                        fontSize: 'clamp(1rem, 4vw, 1.125rem)',
                        fontFamily: 'var(--font-mono)',
                        fontWeight: 500,
                        outline: 'none',
                        transition: 'border-color var(--transition-fast), box-shadow var(--transition-fast)',
                        minHeight: '48px', // Minimum touch target size
                    }}
                    onFocus={(e) => {
                        e.currentTarget.style.borderColor = 'var(--input-focus-border)';
                        e.currentTarget.style.boxShadow = '0 0 0 3px var(--input-focus-shadow)';
                    }}
                    onBlur={(e) => {
                        e.currentTarget.style.borderColor = error ? 'var(--error-color)' : 'var(--border-color)';
                        e.currentTarget.style.boxShadow = 'none';
                    }}
                />
                {suffix && (
                    <span style={{
                        position: 'absolute',
                        right: '1rem',
                        fontSize: 'clamp(0.875rem, 3.5vw, 1rem)',
                        fontWeight: 600,
                        color: 'var(--text-muted)',
                        pointerEvents: 'none',
                        fontFamily: 'var(--font-mono)',
                    }}>
                        {suffix}
                    </span>
                )}
            </div>
            {error && <span style={{ fontSize: '0.75rem', color: 'var(--error-color)', fontWeight: 500 }}>{error}</span>}
        </div>
    );
};
