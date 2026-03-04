import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Battery, Rocket, Wifi, Car, ChevronDown, Zap } from 'lucide-react';
import { useI18n } from '../i18n';
import { AnimatedIcon, IconContainer } from './animations';

export const InfoBanner: React.FC = () => {
    const { t } = useI18n();
    const [isExpanded, setIsExpanded] = useState(true);

    const features = [
        { icon: Rocket, text: t('infoBannerFeature1') },
        { icon: Wifi, text: t('infoBannerFeature2') },
        { icon: Car, text: t('infoBannerFeature3') }
    ];

    return (
        <motion.div
            initial={{ opacity: 0, y: -20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
            style={{
                width: '100%',
                maxWidth: '800px',
                margin: '0 auto 1rem auto',
                position: 'relative',
            }}
        >
            <motion.div
                animate={{
                    boxShadow: [
                        '0 8px 32px var(--info-banner-shadow)',
                        '0 12px 40px var(--info-banner-shadow)',
                        '0 8px 32px var(--info-banner-shadow)'
                    ]
                }}
                transition={{ duration: 3, repeat: Infinity, ease: "easeInOut" }}
                style={{
                    background: 'linear-gradient(135deg, var(--info-banner-gradient-start) 0%, var(--info-banner-gradient-mid) 50%, var(--info-banner-gradient-end) 100%)',
                    borderRadius: 'var(--radius-2xl)',
                    padding: isExpanded ? '1.5rem' : '1rem 1.5rem',
                    border: '1px solid var(--info-banner-border)',
                    position: 'relative',
                    overflow: 'hidden',
                }}
            >
                {/* Animated background decoration */}
                <motion.div
                    animate={{
                        scale: [1, 1.2, 1],
                        opacity: [0.3, 0.5, 0.3],
                    }}
                    transition={{ duration: 4, repeat: Infinity, ease: "easeInOut" }}
                    style={{
                        position: 'absolute',
                        top: '-50%',
                        right: '-10%',
                        width: '250px',
                        height: '250px',
                        background: 'radial-gradient(circle, var(--info-banner-glow) 0%, transparent 70%)',
                        pointerEvents: 'none',
                    }}
                />

                {/* Electric particles effect */}
                {[...Array(3)].map((_, i) => (
                    <motion.div
                        key={i}
                        animate={{
                            y: [0, -30, 0],
                            opacity: [0.1, 0.3, 0.1],
                            x: [0, (i - 1) * 20, 0]
                        }}
                        transition={{
                            duration: 3 + i,
                            repeat: Infinity,
                            delay: i * 0.5,
                            ease: "easeInOut"
                        }}
                        style={{
                            position: 'absolute',
                            bottom: '10px',
                            right: `${20 + i * 30}px`,
                            fontSize: '1.5rem',
                            color: 'var(--info-banner-glow)',
                            pointerEvents: 'none',
                        }}
                    >
                        <Zap size={16} />
                    </motion.div>
                ))}

                {/* Header with toggle */}
                <motion.div
                    onClick={() => setIsExpanded(!isExpanded)}
                    style={{
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'space-between',
                        cursor: 'pointer',
                        position: 'relative',
                        zIndex: 1,
                    }}
                    whileHover={{ scale: 1.005 }}
                    whileTap={{ scale: 0.995 }}
                >
                    <div style={{
                        display: 'flex',
                        alignItems: 'center',
                        gap: '1rem',
                    }}>
                        <motion.div
                            animate={{ rotate: isExpanded ? 0 : 360 }}
                            transition={{ duration: 0.5 }}
                        >
                            <IconContainer
                                icon={Battery}
                                size={22}
                                bgColor="var(--info-banner-icon-bg)"
                                iconColor="var(--info-banner-gradient-end)"
                                animation="pulse"
                            />
                        </motion.div>
                        <h2 style={{
                            margin: 0,
                            fontSize: 'clamp(1rem, 4vw, 1.15rem)',
                            fontWeight: 800,
                            color: 'var(--info-banner-title)',
                            lineHeight: 1.3,
                            textShadow: '0 2px 4px rgba(0,0,0,0.1)'
                        }}>
                            {t('infoBannerTitle')}
                        </h2>
                    </div>
                    <motion.button
                        aria-label={isExpanded ? t('collapse') : t('expand')}
                        aria-expanded={isExpanded}
                        animate={{ rotate: isExpanded ? 180 : 0 }}
                        whileHover={{ scale: 1.1 }}
                        whileTap={{ scale: 0.9 }}
                        style={{
                            background: 'rgba(255,255,255,0.15)',
                            border: '1px solid rgba(255,255,255,0.25)',
                            borderRadius: '50%',
                            width: '36px',
                            height: '36px',
                            color: 'var(--info-banner-title)',
                            cursor: 'pointer',
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'center',
                            backdropFilter: 'blur(10px)'
                        }}
                    >
                        <ChevronDown size={20} />
                    </motion.button>
                </motion.div>

                {/* Expandable content */}
                <AnimatePresence>
                    {isExpanded && (
                        <motion.div
                            initial={{ height: 0, opacity: 0 }}
                            animate={{ height: 'auto', opacity: 1 }}
                            exit={{ height: 0, opacity: 0 }}
                            transition={{ duration: 0.3, ease: [0.22, 1, 0.36, 1] }}
                            style={{
                                overflow: 'hidden',
                                marginTop: '1.25rem',
                                position: 'relative',
                                zIndex: 1,
                            }}
                        >
                            <motion.p
                                initial={{ y: 10, opacity: 0 }}
                                animate={{ y: 0, opacity: 1 }}
                                transition={{ delay: 0.1 }}
                                style={{
                                    margin: '0 0 1.25rem 0',
                                    fontSize: 'clamp(0.9rem, 3.5vw, 1rem)',
                                    lineHeight: 1.7,
                                    color: 'var(--info-banner-text)',
                                }}
                            >
                                {t('infoBannerText')}
                            </motion.p>

                            {/* Feature badges */}
                            <div style={{
                                display: 'flex',
                                flexWrap: 'wrap',
                                gap: '0.75rem',
                            }}>
                                {features.map((feature, index) => (
                                    <motion.span
                                        key={index}
                                        initial={{ scale: 0.8, opacity: 0 }}
                                        animate={{ scale: 1, opacity: 1 }}
                                        transition={{ delay: 0.2 + index * 0.1 }}
                                        whileHover={{ 
                                            scale: 1.05,
                                            backgroundColor: 'rgba(255,255,255,0.25)'
                                        }}
                                        style={{
                                            display: 'inline-flex',
                                            alignItems: 'center',
                                            gap: '0.5rem',
                                            padding: '0.5rem 1rem',
                                            background: 'var(--info-banner-badge-bg)',
                                            borderRadius: 'var(--radius-full)',
                                            fontSize: '0.8rem',
                                            fontWeight: 700,
                                            color: 'var(--info-banner-badge-text)',
                                            border: '1px solid var(--info-banner-badge-border)',
                                            cursor: 'default',
                                            backdropFilter: 'blur(10px)'
                                        }}
                                    >
                                        <AnimatedIcon
                                            icon={feature.icon}
                                            size={14}
                                            animation="bounce"
                                            hoverEffect="rotate"
                                        />
                                        {feature.text}
                                    </motion.span>
                                ))}
                            </div>
                        </motion.div>
                    )}
                </AnimatePresence>
            </motion.div>
        </motion.div>
    );
};
