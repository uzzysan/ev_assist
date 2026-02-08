import React, { createContext, useContext, useState, useEffect } from 'react';

// Simple translation maps
// In a real app, strict typing or library like i18next is better, but for this scope custom is fine.

export type Locale = 'en' | 'pl' | 'de' | 'fr' | 'es' | 'it';

type Translations = Record<string, string>;

const translations: Record<Locale, Translations> = {
    en: {
        appTitle: 'EV Assist',
        averageConsumption: 'Average Consumption',
        consumptionHint: 'Consumption (kWh)',
        distanceHint: 'from last km',
        destinationDistanceHint: 'Distance to destination',
        totalBatteryCapacity: 'Total Battery Capacity',
        net: 'Net',
        gross: 'Gross',
        currentBatteryLevel: 'Current Level',
        desiredArrivalLevel: 'Desired Arrival Level',
        calculate: 'Calculate',
        supportAuthorButton: 'Support me',
        warningTitle: 'Warning',
        resultTitle: 'Result', // "Charge needed"
        chargeMessage: 'You need to charge: {0} kWh',
        errorMessage: 'You need {0} kWh, which is more than battery capacity!',
        destinationOutOfReach: 'Destination out of reach even with full charge!',
        settings: 'Settings',
        language: 'Language',
        theme: 'Theme'
    },
    pl: {
        appTitle: 'EV Assist',
        averageConsumption: 'Średnie zużycie',
        consumptionHint: 'Zużycie (kWh)',
        distanceHint: 'z ostatnich km',
        destinationDistanceHint: 'Odległość do celu',
        totalBatteryCapacity: 'Pojemność baterii',
        net: 'Netto',
        gross: 'Brutto',
        currentBatteryLevel: 'Obecny poziom',
        desiredArrivalLevel: 'Poziom u celu',
        calculate: 'Oblicz',
        supportAuthorButton: 'Wspieram to co robisz',
        warningTitle: 'Uwaga',
        resultTitle: 'Wynik',
        chargeMessage: 'Musisz naładować: {0} kWh',
        errorMessage: 'Potrzebujesz {0} kWh, to więcej niż pojemność baterii!',
        destinationOutOfReach: 'Cel poza zasięgiem nawet przy pełnej baterii!',
        settings: 'Ustawienia',
        language: 'Język',
        theme: 'Motyw'
    },
    de: { // Minimal placeholders
        appTitle: 'EV Assist',
        averageConsumption: 'Durchschnittsverbrauch',
        consumptionHint: 'Verbrauch (kWh)',
        distanceHint: 'auf letzten km',
        destinationDistanceHint: 'Entfernung zum Ziel',
        totalBatteryCapacity: 'Batteriekapazität',
        net: 'Netto',
        gross: 'Brutto',
        currentBatteryLevel: 'Aktueller Stand',
        desiredArrivalLevel: 'Gewünschter Stand',
        calculate: 'Berechnen',
        supportAuthorButton: 'Unterstütze mich',
        warningTitle: 'Warnung',
        resultTitle: 'Ergebnis',
        chargeMessage: 'Sie müssen laden: {0} kWh',
        errorMessage: 'Sie benötigen {0} kWh, mehr als die Kapazität!',
        destinationOutOfReach: 'Ziel außerhalb der Reichweite!',
        settings: 'Einstellungen',
        language: 'Sprache',
        theme: 'Thema'
    },
    fr: {
        appTitle: 'EV Assist',
        averageConsumption: 'Consommation moyenne',
        consumptionHint: 'Consom. (kWh)',
        distanceHint: 'from last km',
        destinationDistanceHint: 'Distance à destination',
        totalBatteryCapacity: 'Capacité batterie',
        net: 'Net',
        gross: 'Brut',
        currentBatteryLevel: 'Niveau actuel',
        desiredArrivalLevel: 'Niveau souhaité',
        calculate: 'Calculer',
        supportAuthorButton: 'Soutenez-moi',
        warningTitle: 'Attention',
        resultTitle: 'Résultat',
        chargeMessage: 'Vous devez charger : {0} kWh',
        errorMessage: 'Vous avez besoin de {0} kWh, plus que la capacité !',
        destinationOutOfReach: 'Destination hors de portée !',
        settings: 'Paramètres',
        language: 'Langue',
        theme: 'Thème'
    },
    es: {
        appTitle: 'EV Assist',
        averageConsumption: 'Consumo medio',
        consumptionHint: 'Consumo (kWh)',
        distanceHint: 'de últimos km',
        destinationDistanceHint: 'Distancia al destino',
        totalBatteryCapacity: 'Capacidad batería',
        net: 'Neto',
        gross: 'Bruto',
        currentBatteryLevel: 'Nivel actual',
        desiredArrivalLevel: 'Nivel deseado',
        calculate: 'Calcular',
        supportAuthorButton: 'Apóyame',
        warningTitle: 'Advertencia',
        resultTitle: 'Resultado',
        chargeMessage: 'Necesitas cargar: {0} kWh',
        errorMessage: 'Necesitas {0} kWh, ¡más que la capacidad!',
        destinationOutOfReach: '¡Destino fuera de alcance!',
        settings: 'Ajustes',
        language: 'Idioma',
        theme: 'Tema'
    },
    it: {
        appTitle: 'EV Assist',
        averageConsumption: 'Consumo medio',
        consumptionHint: 'Consumo (kWh)',
        distanceHint: 'dagli ultimi km',
        destinationDistanceHint: 'Distanza dalla destinazione',
        totalBatteryCapacity: 'Capacità batteria',
        net: 'Netto',
        gross: 'Lordo',
        currentBatteryLevel: 'Livello attuale',
        desiredArrivalLevel: 'Livello desiderato',
        calculate: 'Calcola',
        supportAuthorButton: 'Supportami',
        warningTitle: 'Attenzione',
        resultTitle: 'Risultato',
        chargeMessage: 'Devi caricare: {0} kWh',
        errorMessage: 'Hai bisogno di {0} kWh, più della capacità!',
        destinationOutOfReach: 'Destinazione fuori portata!',
        settings: 'Impostazioni',
        language: 'Lingua',
        theme: 'Tema'
    }
};

interface I18nContextType {
    locale: Locale;
    setLocale: (locale: Locale) => void;
    t: (key: string, ...args: string[]) => string;
}

const I18nContext = createContext<I18nContextType | undefined>(undefined);

export const I18nProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
    const [locale, setLocale] = useState<Locale>('en');

    useEffect(() => {
        const saved = localStorage.getItem('locale') as Locale;
        if (saved && translations[saved]) {
            setLocale(saved);
        } else {
            // detect browser language
            const browserLang = navigator.language.split('-')[0] as Locale;
            if (translations[browserLang]) {
                setLocale(browserLang);
            }
        }
    }, []);

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

export const useI18n = () => {
    const context = useContext(I18nContext);
    if (!context) {
        throw new Error('useI18n must be used within an I18nProvider');
    }
    return context;
};
