import React from 'react';
import { useI18n } from '../i18n';
import { Button } from './Button';

export const Footer: React.FC = () => {
    const { t } = useI18n();

    const handleSupport = () => {
        window.open('https://suppi.pl/rafcio', '_blank');
    };

    return (
        <div style={{
            marginTop: '3rem',
            paddingBottom: '2rem',
            textAlign: 'center',
            borderTop: '1px solid var(--border-color)',
            paddingTop: '2rem'
        }}>
            <div style={{ maxWidth: '300px', margin: '0 auto' }}>
                <Button variant="secondary" onClick={handleSupport} icon={<span>❤️</span>}>
                    {t('supportAuthorButton')}
                </Button>
            </div>
            <p style={{ marginTop: '1rem', fontSize: '0.875rem', opacity: 0.6, color: 'var(--text-color)' }}>
                &copy; 2026 <a href="mailto:rafal.maculewicz@tuta.com" style={{ color: 'inherit', textDecoration: 'underline' }}>Rafał Maculewicz</a>. Wszelkie prawa zastrzeżone.
            </p>
        </div>
    );
};
