import React from 'react';
import { I18nProvider } from './i18n';
import { Logo } from './components/Logo';
import { ThemeSwitcher } from './components/ThemeSwitcher';
import { LanguageSwitcher } from './components/LanguageSwitcher';
import { Calculator } from './components/Calculator';
import { Footer } from './components/Footer';
import { SponsorBox } from './components/SponsorBox';

const Layout: React.FC = () => {
  return (
    <div className="min-h-screen flex flex-col" style={{ padding: '1rem' }}>
      <SponsorBox />
      <header style={{
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        marginBottom: '2rem',
        maxWidth: '800px',
        margin: '0 auto 2rem auto',
        width: '100%',
        paddingTop: '1rem'
      }}>
        <Logo />
        <div style={{ display: 'flex', gap: '1rem' }}>
          <LanguageSwitcher />
          <ThemeSwitcher />
        </div>
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
