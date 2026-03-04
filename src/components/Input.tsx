import React, { useId, useState } from 'react';
import { motion } from 'framer-motion';

interface InputProps extends React.InputHTMLAttributes<HTMLInputElement> {
    label: string;
    suffix?: string;
    error?: string;
    icon?: React.ReactNode;
}

export const Input: React.FC<InputProps> = ({ label, suffix, error, icon, style, id, ...props }) => {
    const generatedId = useId();
    const inputId = id || `${generatedId}-${label.replace(/\s+/g, '-').toLowerCase()}`;
    const [isFocused, setIsFocused] = useState(false);

    return (
        <motion.div 
            style={{ 
                display: 'flex', 
                flexDirection: 'column', 
                gap: '0.5rem', 
                width: '100%', 
                ...style 
            }}
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.3 }}
        >
            <label
                htmlFor={inputId}
                style={{ 
                    fontSize: 'clamp(0.8rem, 3.5vw, 0.875rem)', 
                    fontWeight: 600, 
                    color: 'var(--text-muted)',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '0.375rem'
                }}
            >
                {icon && (
                    <motion.span
                        animate={isFocused ? { color: 'var(--primary-color)', scale: 1.1 } : {}}
                        style={{ display: 'flex', color: 'var(--text-muted)' }}
                    >
                        {icon}
                    </motion.span>
                )}
                {label}
            </label>
            <motion.div 
                style={{ position: 'relative', display: 'flex', alignItems: 'center' }}
                animate={isFocused ? { scale: 1.01 } : { scale: 1 }}
                transition={{ duration: 0.2 }}
            >
                <input
                    id={inputId}
                    {...props}
                    style={{
                        width: '100%',
                        padding: 'clamp(0.875rem, 3.5vw, 1rem)',
                        paddingRight: suffix ? '3.5rem' : 'clamp(0.875rem, 3.5vw, 1rem)',
                        borderRadius: 'var(--radius-xl)',
                        border: `2px solid ${error ? 'var(--error-color)' : isFocused ? 'var(--primary-color)' : 'var(--border-color)'}`,
                        backgroundColor: isFocused ? 'var(--input-bg-hover)' : 'var(--input-bg)',
                        color: 'var(--text-color)',
                        fontSize: 'clamp(1rem, 4vw, 1.125rem)',
                        fontFamily: 'var(--font-mono)',
                        fontWeight: 600,
                        outline: 'none',
                        transition: 'all var(--transition-fast)',
                        minHeight: '52px',
                        boxShadow: isFocused ? '0 0 0 4px var(--input-focus-shadow)' : 'none'
                    }}
                    onFocus={(e) => {
                        setIsFocused(true);
                        props.onFocus?.(e);
                    }}
                    onBlur={(e) => {
                        setIsFocused(false);
                        props.onBlur?.(e);
                    }}
                />
                {suffix && (
                    <motion.span 
                        animate={isFocused ? { color: 'var(--primary-color)' } : {}}
                        style={{
                            position: 'absolute',
                            right: '1rem',
                            fontSize: 'clamp(0.875rem, 3.5vw, 1rem)',
                            fontWeight: 700,
                            color: 'var(--text-muted)',
                            pointerEvents: 'none',
                            fontFamily: 'var(--font-mono)',
                        }}
                    >
                        {suffix}
                    </motion.span>
                )}
            </motion.div>
            {error && (
                <motion.span 
                    initial={{ opacity: 0, y: -10 }}
                    animate={{ opacity: 1, y: 0 }}
                    style={{ 
                        fontSize: '0.75rem', 
                        color: 'var(--error-color)', 
                        fontWeight: 600,
                        display: 'flex',
                        alignItems: 'center',
                        gap: '0.25rem'
                    }}
                >
                    {error}
                </motion.span>
            )}
        </motion.div>
    );
};
