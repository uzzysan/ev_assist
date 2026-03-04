import React from 'react';
import { motion } from 'framer-motion';

export const Logo: React.FC<{ className?: string }> = ({ className }) => {
    return (
        <motion.div 
            className={`flex items-center gap-3 ${className || ''}`}
            initial={{ opacity: 0, scale: 0.8 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ 
                type: "spring",
                stiffness: 200,
                damping: 15
            }}
            style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}
        >
            <motion.div
                whileHover={{ scale: 1.1, rotate: 5 }}
                whileTap={{ scale: 0.95 }}
                animate={{
                    filter: [
                        'drop-shadow(0 0 0px var(--primary-color))',
                        'drop-shadow(0 0 10px var(--primary-color))',
                        'drop-shadow(0 0 0px var(--primary-color))'
                    ]
                }}
                transition={{
                    filter: { duration: 2, repeat: Infinity, ease: "easeInOut" }
                }}
            >
                <svg width="44" height="44" viewBox="0 0 44 44" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <linearGradient id="logoGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" stopColor="var(--primary-color)" />
                            <stop offset="100%" stopColor="var(--secondary-color)" />
                        </linearGradient>
                        <filter id="glow">
                            <feGaussianBlur stdDeviation="2" result="coloredBlur"/>
                            <feMerge>
                                <feMergeNode in="coloredBlur"/>
                                <feMergeNode in="SourceGraphic"/>
                            </feMerge>
                        </filter>
                    </defs>
                    <rect width="44" height="44" rx="12" fill="url(#logoGradient)" />
                    <motion.path 
                        d="M22 8L25.5 19H32L20 34L21.5 22H14L22 8Z" 
                        fill="white"
                        initial={{ pathLength: 0, opacity: 0 }}
                        animate={{ pathLength: 1, opacity: 1 }}
                        transition={{ duration: 0.8, delay: 0.2 }}
                        stroke="white"
                        strokeWidth="1.5"
                        strokeLinejoin="round"
                        filter="url(#glow)"
                    />
                </svg>
            </motion.div>
            <motion.span
                style={{
                    fontFamily: 'var(--font-family)',
                    fontWeight: 800,
                    fontSize: '1.5rem',
                    letterSpacing: '-0.03em',
                    color: 'var(--text-color)',
                    background: 'linear-gradient(135deg, var(--text-color) 0%, var(--primary-color) 100%)',
                    WebkitBackgroundClip: 'text',
                    WebkitTextFillColor: 'transparent',
                    backgroundClip: 'text'
                }}
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ delay: 0.3, duration: 0.5 }}
            >
                EV ASSIST
            </motion.span>
        </motion.div>
    );
};
