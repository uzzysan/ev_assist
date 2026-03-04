import React from 'react';
import { motion } from 'framer-motion';
import { Globe } from 'lucide-react';
import { useI18n } from '../i18n';
import type { Locale } from '../translations';
import { AnimatedIcon } from './animations';

const languages: { code: Locale; flag: string; name: string }[] = [
    { code: 'en', flag: '🇬🇧', name: 'English' },
    { code: 'pl', flag: '🇵🇱', name: 'Polski' },
    { code: 'de', flag: '🇩🇪', name: 'Deutsch' },
    { code: 'fr', flag: '🇫🇷', name: 'Français' },
    { code: 'es', flag: '🇪🇸', name: 'Español' },
    { code: 'it', flag: '🇮🇹', name: 'Italiano' },
];

export const LanguageSwitcher: React.FC = () => {
    const { locale, setLocale, t } = useI18n();
    

    const handleChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
        setLocale(e.target.value as Locale);
    };

    return (
        <motion.div 
            style={{ 
                display: 'flex', 
                alignItems: 'center',
                gap: '0.5rem',
                background: 'var(--card-bg)',
                border: '2px solid var(--border-color)',
                borderRadius: 'var(--radius-xl)',
                padding: '0.5rem 0.75rem'
            }}
            whileHover={{ borderColor: 'var(--primary-color)' }}
            transition={{ duration: 0.2 }}
        >
            <AnimatedIcon 
                icon={Globe} 
                size={18} 
                color="var(--text-muted)"
                hoverEffect="rotate"
            />
            <select
                value={locale}
                onChange={handleChange}
                style={{
                    background: 'transparent',
                    color: 'var(--text-color)',
                    border: 'none',
                    cursor: 'pointer',
                    fontFamily: 'var(--font-family)',
                    fontSize: '0.875rem',
                    fontWeight: 600,
                    outline: 'none',
                    paddingRight: '0.5rem'
                }}
                aria-label={t('language')}
            >
                {languages.map(lang => (
                    <option key={lang.code} value={lang.code}>
                        {lang.flag} {lang.code.toUpperCase()}
                    </option>
                ))}
            </select>
        </motion.div>
    );
};
