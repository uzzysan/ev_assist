import React from 'react';

interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
    variant?: 'primary' | 'secondary';
    icon?: React.ReactNode;
}

export const Button: React.FC<ButtonProps> = ({ variant = 'primary', icon, children, style, ...props }) => {
    const [isPressed, setIsPressed] = React.useState(false);
    
    const baseStyle: React.CSSProperties = {
        padding: 'clamp(0.875rem, 3.5vw, 1rem) 1.5rem',
        borderRadius: 'var(--radius-lg)',
        border: 'none',
        cursor: 'pointer',
        fontSize: 'clamp(1rem, 4vw, 1.125rem)',
        fontWeight: 600,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        gap: '0.5rem',
        transition: 'all var(--transition-fast)',
        width: '100%',
        minHeight: '52px', // Good touch target size
        position: 'relative',
        overflow: 'hidden',
        ...style,
    };

    const styles: Record<string, React.CSSProperties> = {
        primary: {
            background: 'linear-gradient(135deg, var(--primary-color) 0%, var(--primary-hover) 100%)',
            color: '#ffffff',
            boxShadow: '0 4px 14px var(--primary-glow)',
            transform: isPressed ? 'translateY(2px) scale(0.98)' : 'translateY(0) scale(1)',
        },
        secondary: {
            backgroundColor: 'transparent',
            color: 'var(--text-color)',
            border: '2px solid var(--border-color)',
            transform: isPressed ? 'translateY(1px)' : 'translateY(0)',
        },
    };

    const handleMouseDown = () => setIsPressed(true);
    const handleMouseUp = () => setIsPressed(false);
    const handleMouseLeave = () => setIsPressed(false);
    const handleTouchStart = () => setIsPressed(true);
    const handleTouchEnd = () => setIsPressed(false);

    return (
        <button 
            style={{ ...baseStyle, ...styles[variant] }} 
            onMouseDown={handleMouseDown}
            onMouseUp={handleMouseUp}
            onMouseLeave={handleMouseLeave}
            onTouchStart={handleTouchStart}
            onTouchEnd={handleTouchEnd}
            {...props}
        >
            {icon && <span style={{ display: 'flex', fontSize: '1.125rem' }}>{icon}</span>}
            {children}
        </button>
    );
};
