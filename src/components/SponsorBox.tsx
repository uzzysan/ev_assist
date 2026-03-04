import React from 'react';
import { motion } from 'framer-motion';
import { Gem, Sparkles } from 'lucide-react';
import { useI18n } from '../i18n';
import { AnimatedIcon, FadeIn } from './animations';

export const SponsorBox: React.FC = () => {
    const { t } = useI18n();
    
    return (
        <FadeIn delay={0.2} direction="down">
            <div style={{
                display: 'flex',
                justifyContent: 'center',
                marginBottom: '2rem',
                width: '100%',
                padding: '0 1rem'
            }}>
                <motion.div
                    whileHover={{ 
                        scale: 1.02,
                        borderColor: 'var(--primary-color)'
                    }}
                    transition={{ duration: 0.3 }}
                    style={{
                        border: '2px dashed var(--border-color)',
                        borderRadius: 'var(--radius-2xl)',
                        backgroundColor: 'var(--primary-glow)',
                        padding: '2rem',
                        textAlign: 'center',
                        maxWidth: '500px',
                        width: '100%',
                        display: 'flex',
                        flexDirection: 'column',
                        alignItems: 'center',
                        gap: '1rem',
                        position: 'relative',
                        overflow: 'hidden'
                    }}
                >
                    {/* Animated background glow */}
                    <motion.div
                        animate={{
                            scale: [1, 1.2, 1],
                            opacity: [0.1, 0.2, 0.1]
                        }}
                        transition={{ duration: 4, repeat: Infinity }}
                        style={{
                            position: 'absolute',
                            top: '-50%',
                            left: '50%',
                            transform: 'translateX(-50%)',
                            width: '200px',
                            height: '200px',
                            background: 'radial-gradient(circle, var(--primary-color) 0%, transparent 70%)',
                            pointerEvents: 'none'
                        }}
                    />
                    
                    {/* Sparkles decoration */}
                    {[...Array(3)].map((_, i) => (
                        <motion.div
                            key={i}
                            animate={{
                                y: [0, -10, 0],
                                opacity: [0.3, 0.7, 0.3],
                                rotate: [0, 180, 360]
                            }}
                            transition={{
                                duration: 3 + i,
                                repeat: Infinity,
                                delay: i * 0.5
                            }}
                            style={{
                                position: 'absolute',
                                top: `${20 + i * 20}%`,
                                left: `${10 + i * 30}%`,
                                pointerEvents: 'none',
                                color: 'var(--primary-color)'
                            }}
                        >
                            <Sparkles size={16} />
                        </motion.div>
                    ))}
                    
                    <motion.div
                        whileHover={{ rotate: 10, scale: 1.1 }}
                        animate={{
                            boxShadow: [
                                '0 0 0 rgba(0, 217, 192, 0)',
                                '0 0 20px rgba(0, 217, 192, 0.3)',
                                '0 0 0 rgba(0, 217, 192, 0)'
                            ]
                        }}
                        transition={{
                            boxShadow: { duration: 2, repeat: Infinity },
                            rotate: { duration: 0.3 }
                        }}
                        style={{
                            backgroundColor: 'var(--card-bg)',
                            borderRadius: '50%',
                            padding: '1rem',
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'center',
                            width: '72px',
                            height: '72px',
                            position: 'relative',
                            zIndex: 1
                        }}
                    >
                        <AnimatedIcon
                            icon={Gem}
                            size={32}
                            color="var(--primary-color)"
                            animation="pulse"
                            hoverEffect="rotate"
                        />
                    </motion.div>
                    
                    <div style={{ position: 'relative', zIndex: 1 }}>
                        <h3 style={{ 
                            margin: '0 0 0.5rem 0', 
                            fontSize: '1.25rem',
                            fontWeight: 700,
                            color: 'var(--text-color)'
                        }}>
                            {t('sponsorTitle')}
                        </h3>
                        <p style={{ 
                            margin: 0, 
                            opacity: 0.8,
                            lineHeight: 1.6,
                            color: 'var(--text-secondary)'
                        }}>
                            {t('sponsorText1')}<br />
                            {t('sponsorText2')}<br />
                            <motion.span 
                                style={{ 
                                    color: 'var(--primary-color)', 
                                    fontWeight: 800,
                                    display: 'inline-block'
                                }}
                                whileHover={{ scale: 1.05 }}
                            >
                                {t('sponsorBadge')}
                            </motion.span>
                        </p>
                    </div>
                </motion.div>
            </div>
        </FadeIn>
    );
};
