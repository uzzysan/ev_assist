import React, { useState } from 'react';
import { useI18n } from '../i18n';

export const InfoBanner: React.FC = () => {
    const { t } = useI18n();
    const [isExpanded, setIsExpanded] = useState(true);

    return (
        <div style={{
            width: '100%',
            maxWidth: '800px',
            margin: '0 auto 1rem auto',
            position: 'relative',
        }}>
            <div style={{
                background: 'linear-gradient(135deg, var(--info-banner-gradient-start) 0%, var(--info-banner-gradient-end) 100%)',
                borderRadius: '1rem',
                padding: isExpanded ? '1.25rem' : '0.75rem 1.25rem',
                boxShadow: '0 8px 32px var(--info-banner-shadow)',
                border: '1px solid var(--info-banner-border)',
                position: 'relative',
                overflow: 'hidden',
                transition: 'all 0.3s ease',
            }}>
                {/* Animated background decoration */}
                <div style={{
                    position: 'absolute',
                    top: '-50%',
                    right: '-10%',
                    width: '200px',
                    height: '200px',
                    background: 'radial-gradient(circle, var(--info-banner-glow) 0%, transparent 70%)',
                    opacity: 0.5,
                    animation: 'pulse 4s ease-in-out infinite',
                }} />
                
                {/* Electric bolt icon decoration */}
                <div style={{
                    position: 'absolute',
                    bottom: '-10px',
                    right: '10px',
                    fontSize: '4rem',
                    opacity: 0.08,
                    transform: 'rotate(-15deg)',
                    userSelect: 'none',
                }}>
                    ⚡
                </div>

                {/* Header with toggle */}
                <div 
                    onClick={() => setIsExpanded(!isExpanded)}
                    style={{
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'space-between',
                        cursor: 'pointer',
                        position: 'relative',
                        zIndex: 1,
                    }}
                >
                    <div style={{
                        display: 'flex',
                        alignItems: 'center',
                        gap: '0.75rem',
                    }}>
                        <div style={{
                            width: '40px',
                            height: '40px',
                            borderRadius: '50%',
                            background: 'var(--info-banner-icon-bg)',
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'center',
                            fontSize: '1.25rem',
                            boxShadow: '0 4px 12px var(--info-banner-icon-shadow)',
                            flexShrink: 0,
                        }}>
                            🔋
                        </div>
                        <h2 style={{
                            margin: 0,
                            fontSize: 'clamp(0.95rem, 4vw, 1.1rem)',
                            fontWeight: 700,
                            color: 'var(--info-banner-title)',
                            lineHeight: 1.3,
                        }}>
                            {t('infoBannerTitle')}
                        </h2>
                    </div>
                    <button
                        aria-label={isExpanded ? t('collapse') : t('expand')}
                        aria-expanded={isExpanded}
                        onKeyDown={(e) => {
                            if (e.key === 'Enter' || e.key === ' ') {
                                e.preventDefault();
                                setIsExpanded(!isExpanded);
                            }
                        }}
                        style={{
                            background: 'transparent',
                            border: 'none',
                            color: 'var(--info-banner-title)',
                            fontSize: '1.25rem',
                            cursor: 'pointer',
                            padding: '0.25rem',
                            transform: isExpanded ? 'rotate(180deg)' : 'rotate(0deg)',
                            transition: 'transform 0.3s ease',
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'center',
                        }}
                    >
                        ▼
                    </button>
                </div>

                {/* Expandable content */}
                <div style={{
                    maxHeight: isExpanded ? '300px' : '0',
                    overflow: 'hidden',
                    transition: 'max-height 0.3s ease, opacity 0.3s ease, margin-top 0.3s ease',
                    opacity: isExpanded ? 1 : 0,
                    marginTop: isExpanded ? '1rem' : '0',
                    position: 'relative',
                    zIndex: 1,
                }}>
                    <p style={{
                        margin: '0 0 1rem 0',
                        fontSize: 'clamp(0.875rem, 3.5vw, 0.95rem)',
                        lineHeight: 1.6,
                        color: 'var(--info-banner-text)',
                    }}>
                        {t('infoBannerText')}
                    </p>
                    
                    {/* Feature badges */}
                    <div style={{
                        display: 'flex',
                        flexWrap: 'wrap',
                        gap: '0.5rem',
                    }}>
                        {[t('infoBannerFeature1'), t('infoBannerFeature2'), t('infoBannerFeature3')].map((feature, index) => (
                            <span
                                key={index}
                                style={{
                                    display: 'inline-flex',
                                    alignItems: 'center',
                                    gap: '0.25rem',
                                    padding: '0.35rem 0.75rem',
                                    background: 'var(--info-banner-badge-bg)',
                                    borderRadius: '2rem',
                                    fontSize: '0.75rem',
                                    fontWeight: 600,
                                    color: 'var(--info-banner-badge-text)',
                                    border: '1px solid var(--info-banner-badge-border)',
                                }}
                            >
                                <span style={{ fontSize: '0.7rem' }}>
                                    {['🚀', '📡', '🚗'][index]}
                                </span>
                                {feature}
                            </span>
                        ))}
                    </div>
                </div>
            </div>

            {/* CSS for animation */}
            <style>{`
                @keyframes pulse {
                    0%, 100% { transform: scale(1); opacity: 0.5; }
                    50% { transform: scale(1.1); opacity: 0.3; }
                }
            `}</style>
        </div>
    );
};
