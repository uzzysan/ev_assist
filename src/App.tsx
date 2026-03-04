import React from 'react';
import { motion } from 'framer-motion';
import { I18nProvider } from './i18n';
import { Logo } from './components/Logo';
import { ThemeSwitcher } from './components/ThemeSwitcher';
import { LanguageSwitcher } from './components/LanguageSwitcher';
import { Calculator } from './components/Calculator';
import { Footer } from './components/Footer';
import { SponsorBox } from './components/SponsorBox';
import { InfoBanner } from './components/InfoBanner';
import { FadeIn } from './components/animations';

const Layout: React.FC = () => {
  return (
    <motion.div 
      className="min-h-screen flex flex-col"
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{ duration: 0.5 }}
      style={{ 
        padding: '0.75rem',
        minHeight: '100vh',
        display: 'flex',
        flexDirection: 'column'
      }}
    >
      <SponsorBox />
      
      {/* Top Bar - Language & Theme Switchers */}
      <FadeIn delay={0.1} direction="down">
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
      </FadeIn>
      
      {/* Info Banner */}
      <InfoBanner />
      
      {/* Header with Logo */}
      <FadeIn delay={0.2}>
        <header style={{
          display: 'flex',
          justifyContent: 'center',
          alignItems: 'center',
          marginBottom: '1rem',
          maxWidth: '800px',
          marginLeft: 'auto',
          marginRight: 'auto',
          width: '100%',
        }}>
          <Logo />
        </header>
      </FadeIn>

      {/* Main Calculator */}
      <main style={{ 
        flex: 1, 
        width: '100%', 
        maxWidth: '800px', 
        margin: '0 auto' 
      }}>
        <Calculator />
      </main>

      {/* Footer */}
      <footer style={{ 
        width: '100%', 
        maxWidth: '800px', 
        margin: '0 auto' 
      }}>
        <Footer />
      </footer>
    </motion.div>
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
