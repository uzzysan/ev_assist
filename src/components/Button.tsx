import React from 'react';
import { motion } from 'framer-motion';
import { Loader2 } from 'lucide-react';

interface ButtonProps {
    variant?: 'primary' | 'secondary' | 'gradient';
    icon?: React.ReactNode;
    isLoading?: boolean;
    glowEffect?: boolean;
    children: React.ReactNode;
    onClick?: React.MouseEventHandler<HTMLButtonElement>;
    disabled?: boolean;
    type?: 'button' | 'submit' | 'reset';
    style?: React.CSSProperties;
    className?: string;
    ariaLabel?: string;
}

export const Button: React.FC<ButtonProps> = ({ 
    variant = 'primary', 
    icon, 
    children, 
    isLoading,
    glowEffect = true,
    style, 
    disabled,
    onClick,
    type = 'button',
    className,
    ariaLabel
}) => {
    const baseStyle: React.CSSProperties = {
        padding: 'clamp(1rem, 3.5vw, 1.125rem) 2rem',
        borderRadius: 'var(--radius-xl)',
        border: 'none',
        cursor: disabled || isLoading ? 'not-allowed' : 'pointer',
        fontSize: 'clamp(1rem, 4vw, 1.125rem)',
        fontWeight: 700,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        gap: '0.75rem',
        width: '100%',
        minHeight: '56px',
        position: 'relative',
        overflow: 'hidden',
        opacity: disabled || isLoading ? 0.7 : 1,
        ...style,
    };

    const variants: Record<string, React.CSSProperties> = {
        primary: {
            background: 'linear-gradient(135deg, var(--primary-color) 0%, var(--primary-hover) 100%)',
            color: '#ffffff',
            boxShadow: glowEffect ? '0 4px 20px var(--primary-glow)' : 'var(--shadow-md)',
        },
        secondary: {
            backgroundColor: 'transparent',
            color: 'var(--text-color)',
            border: '2px solid var(--border-color)',
        },
        gradient: {
            background: 'linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 50%, var(--accent-color) 100%)',
            color: '#ffffff',
            boxShadow: glowEffect ? '0 4px 25px var(--primary-glow)' : 'var(--shadow-md)',
        }
    };
    
    return (
        <motion.button 
            type={type}
            className={className}
            aria-label={ariaLabel}
            style={{ ...baseStyle, ...variants[variant] }}
            whileHover={disabled || isLoading ? undefined : {
                scale: 1.02,
                boxShadow: glowEffect ? '0 8px 30px var(--primary-glow)' : 'var(--shadow-lg)'
            }}
            whileTap={disabled || isLoading ? undefined : { scale: 0.98 }}
            transition={{ duration: 0.2 }}
            disabled={disabled || isLoading}
            onClick={onClick}
        >
            {/* Shimmer effect overlay */}
            {!disabled && !isLoading && variant !== 'secondary' && (
                <motion.div
                    initial={{ x: '-100%' }}
                    animate={{ x: '200%' }}
                    transition={{
                        duration: 2,
                        repeat: Infinity,
                        repeatDelay: 3,
                        ease: "linear"
                    }}
                    style={{
                        position: 'absolute',
                        top: 0,
                        left: 0,
                        width: '50%',
                        height: '100%',
                        background: 'linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent)',
                        pointerEvents: 'none'
                    }}
                />
            )}
            
            {isLoading ? (
                <motion.div
                    animate={{ rotate: 360 }}
                    transition={{ duration: 1, repeat: Infinity, ease: "linear" }}
                >
                    <Loader2 size={22} />
                </motion.div>
            ) : icon && (
                <motion.span 
                    style={{ display: 'flex' }}
                    whileHover={{ rotate: 10, scale: 1.1 }}
                >
                    {icon}
                </motion.span>
            )}
            <span style={{ position: 'relative', zIndex: 1 }}>{children}</span>
        </motion.button>
    );
};
