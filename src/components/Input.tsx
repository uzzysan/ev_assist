import React from 'react';

interface InputProps extends React.InputHTMLAttributes<HTMLInputElement> {
    label: string;
    suffix?: string;
    error?: string;
}

export const Input: React.FC<InputProps> = ({ label, suffix, error, style, ...props }) => {
    return (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem', width: '100%', ...style }}>
            <label style={{ fontSize: '0.875rem', fontWeight: 500, color: 'var(--text-color)', opacity: 0.8 }}>
                {label}
            </label>
            <div style={{ position: 'relative', display: 'flex', alignItems: 'center' }}>
                <input
                    {...props}
                    style={{
                        width: '100%',
                        padding: '0.75rem',
                        paddingRight: suffix ? '3rem' : '0.75rem',
                        borderRadius: '0.5rem',
                        border: `1px solid ${error ? '#ef4444' : 'var(--border-color)'}`,
                        backgroundColor: 'var(--input-bg)',
                        color: 'var(--text-color)',
                        fontSize: '1rem',
                        fontFamily: 'var(--font-mono)', // Technical feel for numbers
                        outline: 'none',
                    }}
                />
                {suffix && (
                    <span style={{
                        position: 'absolute',
                        right: '1rem',
                        fontSize: '0.875rem',
                        color: 'var(--text-color)',
                        opacity: 0.6,
                        pointerEvents: 'none'
                    }}>
                        {suffix}
                    </span>
                )}
            </div>
            {error && <span style={{ fontSize: '0.75rem', color: '#ef4444' }}>{error}</span>}
        </div>
    );
};
