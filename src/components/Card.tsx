import React from 'react';

interface CardProps {
    title?: string;
    children: React.ReactNode;
    className?: string; // keeping for future if classes needed, but generally using styles
}

export const Card: React.FC<CardProps> = ({ title, children }) => {
    return (
        <div style={{
            backgroundColor: 'var(--card-bg)',
            borderRadius: 'var(--radius-xl)',
            padding: 'clamp(1rem, 4vw, 1.5rem)',
            boxShadow: 'var(--shadow-md)',
            border: '1px solid var(--card-border)',
            width: '100%',
            marginBottom: '1rem',
            transition: 'transform var(--transition-base), box-shadow var(--transition-base)',
        }}>
            {title && (
                <h3 style={{
                    marginTop: 0,
                    marginBottom: '1rem',
                    fontSize: 'clamp(1rem, 4vw, 1.125rem)',
                    fontWeight: 600,
                    color: 'var(--text-color)',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '0.5rem',
                }}>
                    {title}
                </h3>
            )}
            {children}
        </div>
    );
};
