import React from 'react';
import { motion } from 'framer-motion';
import { IconContainer } from './animations';
import { Zap, Car, Battery, Gauge, Settings, Info } from 'lucide-react';

interface CardProps {
    title?: string;
    children: React.ReactNode;
    className?: string;
    icon?: 'zap' | 'car' | 'battery' | 'gauge' | 'settings' | 'info';
    delay?: number;
}

const iconMap = {
    zap: Zap,
    car: Car,
    battery: Battery,
    gauge: Gauge,
    settings: Settings,
    info: Info
};

export const Card: React.FC<CardProps> = ({ title, children, icon, delay = 0 }) => {
    const IconComponent = icon ? iconMap[icon] : null;
    
    return (
        <motion.div
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{
                duration: 0.5,
                delay,
                ease: [0.22, 1, 0.36, 1]
            }}
            whileHover={{
                y: -4,
                boxShadow: 'var(--shadow-colored)',
                borderColor: 'var(--card-border-hover)'
            }}
            style={{
                backgroundColor: 'var(--card-bg)',
                borderRadius: 'var(--radius-2xl)',
                padding: 'clamp(1.25rem, 4vw, 1.75rem)',
                boxShadow: 'var(--card-shadow)',
                border: '1px solid var(--card-border)',
                width: '100%',
                marginBottom: '1rem',
                transition: 'background-color 0.3s ease, border-color 0.3s ease',
                position: 'relative',
                overflow: 'hidden'
            }}
        >
            {/* Decorative gradient background */}
            <motion.div
                initial={{ opacity: 0 }}
                animate={{ opacity: 0.03 }}
                style={{
                    position: 'absolute',
                    top: '-50%',
                    right: '-20%',
                    width: '300px',
                    height: '300px',
                    background: 'radial-gradient(circle, var(--primary-color) 0%, transparent 70%)',
                    pointerEvents: 'none'
                }}
            />
            
            {title && (
                <motion.h3
                    initial={{ opacity: 0, x: -10 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ delay: delay + 0.1 }}
                    style={{
                        marginTop: 0,
                        marginBottom: '1.25rem',
                        fontSize: 'clamp(1rem, 4vw, 1.125rem)',
                        fontWeight: 700,
                        color: 'var(--text-color)',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '0.75rem',
                        position: 'relative',
                        zIndex: 1
                    }}
                >
                    {IconComponent && (
                        <IconContainer
                            icon={IconComponent}
                            size={20}
                            bgColor="var(--primary-glow)"
                            iconColor="var(--primary-color)"
                            animation="pulse"
                        />
                    )}
                    <span style={{
                        background: 'linear-gradient(135deg, var(--text-color) 0%, var(--text-secondary) 100%)',
                        WebkitBackgroundClip: 'text',
                        WebkitTextFillColor: 'transparent',
                        backgroundClip: 'text'
                    }}>
                        {title}
                    </span>
                </motion.h3>
            )}
            <div style={{ position: 'relative', zIndex: 1 }}>
                {children}
            </div>
        </motion.div>
    );
};
