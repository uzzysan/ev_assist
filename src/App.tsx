import React from 'react';
import { I18nProvider } from './i18n';
import { Logo } from './components/Logo';
import { ThemeSwitcher } from './components/ThemeSwitcher';
import { LanguageSwitcher } from './components/LanguageSwitcher';
import { Calculator } from './components/Calculator';
import { Footer } from './components/Footer';
import { SponsorBox } from './components/SponsorBox';
import { InfoBanner } from './components/InfoBanner';

const Layout: React.FC = () => {
  return (
    <div className="min-h-screen flex flex-col" style={{ padding: '0.75rem' }}>
      <SponsorBox />
      
      {/* Top Bar - Language & Theme Switchers */}
      <div style={{
        display: 'flex',
        justifyContent: 'flex-end',
        alignItems: 'center',
        gap: '0.75rem',
        maxWidth: '800px',
        margin: '0 auto',
        width: '100%',
        paddingTop: '0.5rem',
        paddingBottom: '0.5rem',
      }}>
        <LanguageSwitcher />
        <ThemeSwitcher />
      </div>
      
      {/* Info Banner - nowoczesna ramka informacyjna */}
      <InfoBanner />
      
      <header style={{
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
        marginBottom: '0.75rem',
        maxWidth: '800px',
        margin: '0 auto 0.75rem auto',
        width: '100%',
      }}>
        <Logo />
      </header>

      <main style={{ flex: 1, width: '100%', maxWidth: '800px', margin: '0 auto' }}>
        <Calculator />
      </main>

      <footer style={{ width: '100%', maxWidth: '800px', margin: '0 auto' }}>
        <Footer />
      </footer>
    </div>
  );
};

function App() {
  return (
    <I18nProvider>
      <Layout />
    </I18nProvider>
  );
}

export default App;
