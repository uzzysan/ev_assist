import React from 'react';
import { useI18n } from '../i18n';

export const Footer: React.FC = () => {
    const { t } = useI18n();

    return (
        <div style={{
            marginTop: '3rem',
            paddingBottom: '2rem',
            textAlign: 'center',
            borderTop: '1px solid var(--border-color)',
            paddingTop: '2rem'
        }}>
            <div style={{ maxWidth: '300px', margin: '0 auto' }}>
                <a href="https://suppi.pl/rafcio" target="_blank" rel="noopener noreferrer">
                    <img width="165" src="https://suppi.pl/api/widget/button.svg?fill=6457FF&textColor=ffffff" alt={t('supportAuthorButton')} />
                </a>
            </div>
            <p style={{ marginTop: '1rem', fontSize: '0.875rem', opacity: 0.6, color: 'var(--text-color)' }}>
                &copy; 2026 <a href="mailto:rafal.maculewicz@tuta.com" style={{ color: 'inherit', textDecoration: 'underline' }}>Rafał Maculewicz</a>. Wszelkie prawa zastrzeżone.
            </p>
        </div>
    );
};
