import React from 'react';

interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
    variant?: 'primary' | 'secondary';
    icon?: React.ReactNode;
}

export const Button: React.FC<ButtonProps> = ({ variant = 'primary', icon, children, style, ...props }) => {
    const baseStyle: React.CSSProperties = {
        padding: '0.75rem 1.5rem',
        borderRadius: '0.5rem',
        border: 'none',
        cursor: 'pointer',
        fontSize: '1rem',
        fontWeight: 600,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        gap: '0.5rem',
        transition: 'opacity 0.2s, transform 0.1s',
        width: '100%',
        ...style,
    };

    const styles: Record<string, React.CSSProperties> = {
        primary: {
            backgroundColor: 'var(--primary-color)',
            color: '#ffffff', // Always white for contrast on teal
        },
        secondary: {
            backgroundColor: 'transparent',
            color: 'var(--text-color)',
            border: '1px solid var(--border-color)',
        },
    };

    return (
        <button style={{ ...baseStyle, ...styles[variant] }} {...props}>
            {icon && <span style={{ display: 'flex' }}>{icon}</span>}
            {children}
        </button>
    );
};
