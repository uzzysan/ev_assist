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
            borderRadius: '1rem',
            padding: '1.5rem',
            boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)',
            width: '100%',
            marginBottom: '1rem'
        }}>
            {title && (
                <h3 style={{
                    marginBottom: '1rem',
                    fontSize: '1.125rem',
                    fontWeight: 600,
                    opacity: 0.9
                }}>
                    {title}
                </h3>
            )}
            {children}
        </div>
    );
};
