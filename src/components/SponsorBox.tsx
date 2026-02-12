import React from 'react';
import { useI18n } from '../i18n';

export const SponsorBox: React.FC = () => {
    const { t } = useI18n();
    return (
        <div style={{
            display: 'flex',
            justifyContent: 'center',
            marginBottom: '2rem',
            width: '100%',
            padding: '0 1rem'
        }}>
            <div style={{
                border: '1px dashed var(--primary-color)',
                borderRadius: '1rem',
                backgroundColor: 'rgba(0, 191, 165, 0.05)',
                padding: '2rem',
                textAlign: 'center',
                maxWidth: '500px',
                width: '100%',
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                gap: '1rem'
            }}>
                <div style={{
                    backgroundColor: 'rgba(0, 191, 165, 0.15)',
                    borderRadius: '50%',
                    padding: '1rem',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    width: '64px',
                    height: '64px'
                }}>
                    <svg width="32" height="32" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M6 3L3 9L12 21L21 9L18 3H6Z" stroke="var(--primary-color)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                        <path d="M12 21L8 9" stroke="var(--primary-color)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                        <path d="M12 21L16 9" stroke="var(--primary-color)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                        <path d="M3 9H21" stroke="var(--primary-color)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                        <path d="M12 3L8 9" stroke="var(--primary-color)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                        <path d="M12 3L16 9" stroke="var(--primary-color)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                    </svg>
                </div>
                
                <div>
                    <h3 style={{ 
                        margin: '0 0 0.5rem 0', 
                        fontSize: '1.25rem',
                        fontWeight: 600
                    }}>
                        {t('sponsorTitle')}
                    </h3>
                    <p style={{ 
                        margin: 0, 
                        opacity: 0.8,
                        lineHeight: 1.5
                    }}>
                        {t('sponsorText1')}<br />
                        {t('sponsorText2')}<br />
                        <span style={{ color: 'var(--primary-color)', fontWeight: 700 }}>{t('sponsorBadge')}</span>.
                    </p>
                </div>
            </div>
        </div>
    );
};
