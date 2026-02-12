import React from 'react';
import { useI18n } from '../i18n';
import type { Locale } from '../translations';

export const LanguageSwitcher: React.FC = () => {
    const { locale, setLocale, t } = useI18n();

    const handleChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
        setLocale(e.target.value as Locale);
    };

    return (
        <div style={{ display: 'flex', alignItems: 'center' }}>
            <select
                value={locale}
                onChange={handleChange}
                style={{
                    background: 'transparent',
                    color: 'var(--text-color)',
                    border: '1px solid var(--border-color)',
                    borderRadius: '0.5rem',
                    padding: '0.5rem',
                    cursor: 'pointer',
                    fontFamily: 'var(--font-family)',
                    fontSize: '0.875rem',
                    backgroundColor: 'var(--card-bg)', // Ensure dropdown has background
                }}
                aria-label={t('language')}
            >
                <option value="en">EN</option>
                <option value="pl">PL</option>
                <option value="de">DE</option>
                <option value="fr">FR</option>
                <option value="es">ES</option>
                <option value="it">IT</option>
            </select>
        </div>
    );
};
