import React from 'react';

export const Logo: React.FC<{ className?: string }> = ({ className }) => {
    return (
        <div className={`flex items-center gap-2 ${className || ''}`} style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
            <svg width="40" height="40" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
                <rect width="40" height="40" rx="8" fill="var(--primary-color)" />
                <path d="M20 8L23 18H28L18 32L19 22H14L20 8Z" fill="white" stroke="var(--bg-color)" strokeWidth="1.5" strokeLinejoin="round" />
            </svg>
            <span style={{
                fontFamily: 'var(--font-family)',
                fontWeight: 700,
                fontSize: '1.25rem',
                letterSpacing: '-0.03em',
                color: 'var(--text-color)'
            }}>
                EV ASSIST
            </span>
        </div>
    );
};
