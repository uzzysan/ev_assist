import React, { createContext, useContext, useState } from 'react';
import { translations } from './translations';
import type { Locale } from './translations';

interface I18nContextType {
    locale: Locale;
    setLocale: (locale: Locale) => void;
    t: (key: string, ...args: string[]) => string;
}

const I18nContext = createContext<I18nContextType | undefined>(undefined);

const getInitialLocale = (): Locale => {
    if (typeof window === 'undefined') return 'en';
    const saved = localStorage.getItem('locale') as Locale;
    if (saved && translations[saved]) {
        return saved;
    }
    // detect browser language
    const browserLang = navigator.language.split('-')[0] as Locale;
    if (translations[browserLang]) {
        return browserLang;
    }
    return 'en';
};

export const I18nProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
    const [locale, setLocale] = useState<Locale>(getInitialLocale);

    const changeLocale = (l: Locale) => {
        setLocale(l);
        localStorage.setItem('locale', l);
    };

    const t = (key: string, ...args: string[]) => {
        const text = translations[locale][key] || translations['en'][key] || key;
        if (args.length > 0) {
            return text.replace(/{(\d+)}/g, (match, number) => {
                return typeof args[number] !== 'undefined' ? args[number] : match;
            });
        }
        return text;
    };

    return (
        <I18nContext.Provider value={{ locale, setLocale: changeLocale, t }}>
            {children}
        </I18nContext.Provider>
    );
};

// eslint-disable-next-line react-refresh/only-export-components
export const useI18n = () => {
    const context = useContext(I18nContext);
    if (!context) {
        throw new Error('useI18n must be used within an I18nProvider');
    }
    return context;
};
