import React from 'react';
import { motion } from 'framer-motion';
import { Heart, Github, Mail } from 'lucide-react';
import { useI18n } from '../i18n';
import { FadeIn } from './animations';

export const Footer: React.FC = () => {
    const { t } = useI18n();
    const currentYear = new Date().getFullYear();

    return (
        <FadeIn delay={0.5} direction="up">
            <motion.div
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ delay: 0.5 }}
                style={{
                    marginTop: '3rem',
                    paddingBottom: '2rem',
                    textAlign: 'center',
                }}
            >
                {/* Decorative line */}
                <motion.div
                    initial={{ scaleX: 0 }}
                    animate={{ scaleX: 1 }}
                    transition={{ duration: 0.8, delay: 0.3 }}
                    style={{
                        height: '2px',
                        background: 'linear-gradient(90deg, transparent, var(--primary-color), transparent)',
                        marginBottom: '2rem',
                        opacity: 0.5
                    }}
                />

                {/* Support button */}
                <motion.div
                    whileHover={{ scale: 1.02 }}
                    whileTap={{ scale: 0.98 }}
                    style={{ maxWidth: '300px', margin: '0 auto 1.5rem' }}
                >
                    <a 
                        href="https://suppi.pl/rafcio" 
                        target="_blank" 
                        rel="noopener noreferrer"
                        style={{ display: 'block' }}
                    >
                        <img 
                            width="165" 
                            src="https://suppi.pl/api/widget/button.svg?fill=6457FF&textColor=ffffff" 
                            alt={t('supportAuthorButton')}
                            style={{ 
                                borderRadius: 'var(--radius-lg)',
                                boxShadow: '0 4px 15px rgba(100, 87, 255, 0.3)'
                            }}
                        />
                    </a>
                </motion.div>

                {/* Social links */}
                <motion.div
                    initial={{ opacity: 0, y: 10 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: 0.6 }}
                    style={{
                        display: 'flex',
                        justifyContent: 'center',
                        gap: '1rem',
                        marginBottom: '1.5rem'
                    }}
                >
                    {[
                        { icon: Github, href: 'https://github.com/uzzysan', label: 'GitHub' },
                        { icon: Mail, href: 'mailto:rafal.maculewicz@tuta.com', label: 'Email' }
                    ].map((link, index) => (
                        <motion.a
                            key={index}
                            href={link.href}
                            target={link.href.startsWith('http') ? '_blank' : undefined}
                            rel={link.href.startsWith('http') ? 'noopener noreferrer' : undefined}
                            whileHover={{ scale: 1.1, y: -2 }}
                            whileTap={{ scale: 0.95 }}
                            style={{
                                display: 'flex',
                                alignItems: 'center',
                                justifyContent: 'center',
                                width: '40px',
                                height: '40px',
                                borderRadius: '50%',
                                backgroundColor: 'var(--card-bg)',
                                border: '1px solid var(--border-color)',
                                color: 'var(--text-muted)',
                                transition: 'all 0.2s ease'
                            }}
                            aria-label={link.label}
                        >
                            <link.icon size={18} />
                        </motion.a>
                    ))}
                </motion.div>

                {/* Copyright */}
                <motion.p
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ delay: 0.7 }}
                    style={{ 
                        fontSize: '0.875rem', 
                        color: 'var(--text-muted)',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        gap: '0.5rem',
                        flexWrap: 'wrap'
                    }}
                >
                    &copy; {currentYear}{' '}
                    <motion.a 
                        href="mailto:rafal.maculewicz@tuta.com" 
                        style={{ 
                            color: 'var(--primary-color)', 
                            textDecoration: 'none',
                            fontWeight: 600
                        }}
                        whileHover={{ textDecoration: 'underline' }}
                    >
                        Rafał Maculewicz
                    </motion.a>
                    <motion.span
                        animate={{ scale: [1, 1.2, 1] }}
                        transition={{ duration: 1, repeat: Infinity, repeatDelay: 2 }}
                    >
                        <Heart size={14} fill="var(--error-color)" color="var(--error-color)" />
                    </motion.span>
                </motion.p>
            </motion.div>
        </FadeIn>
    );
};
