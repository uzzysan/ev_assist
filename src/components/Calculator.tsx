import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Zap, Car, Battery, Gauge, AlertTriangle, CheckCircle2, Info } from 'lucide-react';
import { useI18n } from '../i18n';
import { calculateCharge, type CalculationResult, type CapacityType } from '../logic/calculate';
import { Card } from './Card';
import { Input } from './Input';
import { Button } from './Button';
import { IconContainer, FadeIn, StaggerContainer, StaggerItem } from './animations';

export const Calculator: React.FC = () => {
    const { t } = useI18n();

    const [avgConsumption, setAvgConsumption] = useState('');
    const [avgConsumptionDistance, setAvgConsumptionDistance] = useState('100');
    const [destinationDistance, setDestinationDistance] = useState('');
    const [totalCapacity, setTotalCapacity] = useState('');
    const [currentLevel, setCurrentLevel] = useState('');
    const [desiredLevel, setDesiredLevel] = useState('');
    const [capacityType, setCapacityType] = useState<CapacityType>('net');
    const [result, setResult] = useState<CalculationResult | null>(null);

    const handleCalculate = () => {
        const inputData = {
            avgConsumption: parseFloat(avgConsumption) || 0,
            avgConsumptionDistance: parseFloat(avgConsumptionDistance) || 100,
            destinationDistance: parseFloat(destinationDistance) || 0,
            totalCapacity: parseFloat(totalCapacity) || 0,
            currentLevel: parseFloat(currentLevel) || 0,
            desiredLevel: parseFloat(desiredLevel) || 0,
            capacityType
        };

        const res = calculateCharge(inputData);
        setResult(res);
    };

    return (
        <StaggerContainer 
            staggerDelay={0.1}
            style={{ 
                maxWidth: '600px', 
                width: '100%', 
                margin: '0 auto', 
                display: 'flex', 
                flexDirection: 'column', 
                gap: 'clamp(1rem, 4vw, 1.5rem)' 
            }}
        >
            {/* Consumption Section */}
            <StaggerItem>
                <Card title={t('averageConsumption')} icon="zap" delay={0}>
                    <div style={{ 
                        display: 'grid', 
                        gridTemplateColumns: 'repeat(auto-fit, minmax(140px, 1fr))', 
                        gap: 'clamp(0.75rem, 3vw, 1rem)' 
                    }}>
                        <Input
                            label={t('consumptionHint')}
                            value={avgConsumption}
                            onChange={e => setAvgConsumption(e.target.value)}
                            type="number"
                            placeholder="18.5"
                            icon={<Gauge size={18} />}
                        />
                        <Input
                            label={t('distanceHint')}
                            value={avgConsumptionDistance}
                            onChange={e => setAvgConsumptionDistance(e.target.value)}
                            type="number"
                            suffix="km"
                            icon={<Car size={18} />}
                        />
                    </div>
                </Card>
            </StaggerItem>

            {/* Trip & Battery Section */}
            <StaggerItem>
                <Card title={t('destinationDistanceHint')} icon="car" delay={0.1}>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: 'clamp(0.75rem, 3vw, 1rem)' }}>
                        <Input
                            label={t('destinationDistanceHint')}
                            value={destinationDistance}
                            onChange={e => setDestinationDistance(e.target.value)}
                            type="number"
                            suffix="km"
                            icon={<Car size={18} />}
                        />

                        <motion.div 
                            style={{ 
                                height: '2px', 
                                background: 'linear-gradient(90deg, transparent, var(--primary-color), transparent)',
                                margin: '0.25rem 0',
                                opacity: 0.5
                            }}
                            animate={{
                                opacity: [0.3, 0.8, 0.3],
                            }}
                            transition={{
                                duration: 2,
                                repeat: Infinity,
                                ease: "easeInOut"
                            }}
                        />

                        <Input
                            label={t('totalBatteryCapacity')}
                            value={totalCapacity}
                            onChange={e => setTotalCapacity(e.target.value)}
                            type="number"
                            suffix="kWh"
                            icon={<Battery size={18} />}
                        />

                        <div style={{ 
                            display: 'flex', 
                            gap: 'clamp(1rem, 4vw, 2rem)', 
                            marginTop: '0.5rem', 
                            flexWrap: 'wrap' 
                        }}>
                            <motion.label 
                                style={{ 
                                    display: 'flex', 
                                    alignItems: 'center', 
                                    gap: '0.5rem', 
                                    cursor: 'pointer', 
                                    color: 'var(--text-color)', 
                                    fontSize: 'clamp(0.9rem, 3.5vw, 1rem)',
                                    fontWeight: 500
                                }}
                                whileHover={{ scale: 1.02 }}
                                whileTap={{ scale: 0.98 }}
                            >
                                <input
                                    type="radio"
                                    name="capacityType"
                                    value="net"
                                    checked={capacityType === 'net'}
                                    onChange={() => setCapacityType('net')}
                                    style={{ 
                                        accentColor: 'var(--primary-color)', 
                                        width: '20px', 
                                        height: '20px',
                                        cursor: 'pointer'
                                    }}
                                />
                                {t('net')}
                            </motion.label>
                            <motion.label 
                                style={{ 
                                    display: 'flex', 
                                    alignItems: 'center', 
                                    gap: '0.5rem', 
                                    cursor: 'pointer', 
                                    color: 'var(--text-color)', 
                                    fontSize: 'clamp(0.9rem, 3.5vw, 1rem)',
                                    fontWeight: 500
                                }}
                                whileHover={{ scale: 1.02 }}
                                whileTap={{ scale: 0.98 }}
                            >
                                <input
                                    type="radio"
                                    name="capacityType"
                                    value="gross"
                                    checked={capacityType === 'gross'}
                                    onChange={() => setCapacityType('gross')}
                                    style={{ 
                                        accentColor: 'var(--primary-color)', 
                                        width: '20px', 
                                        height: '20px',
                                        cursor: 'pointer'
                                    }}
                                />
                                {t('gross')}
                            </motion.label>
                        </div>
                    </div>
                </Card>
            </StaggerItem>

            {/* Levels Section */}
            <StaggerItem>
                <Card title={t('batteryLevels')} icon="battery" delay={0.2}>
                    <div style={{ 
                        display: 'grid', 
                        gridTemplateColumns: 'repeat(auto-fit, minmax(140px, 1fr))', 
                        gap: 'clamp(0.75rem, 3vw, 1rem)' 
                    }}>
                        <Input
                            label={t('currentBatteryLevel')}
                            value={currentLevel}
                            onChange={e => setCurrentLevel(e.target.value)}
                            type="number"
                            suffix="%"
                            icon={<Battery size={18} />}
                        />
                        <Input
                            label={t('desiredArrivalLevel')}
                            value={desiredLevel}
                            onChange={e => setDesiredLevel(e.target.value)}
                            type="number"
                            suffix="%"
                            icon={<Zap size={18} />}
                        />
                    </div>
                </Card>
            </StaggerItem>

            {/* Result Section */}
            <AnimatePresence mode="wait">
                {result && (
                    <motion.div
                        key={result.isImpossible ? 'impossible' : result.isWarning ? 'warning' : 'success'}
                        initial={{ opacity: 0, y: 20, scale: 0.95 }}
                        animate={{ opacity: 1, y: 0, scale: 1 }}
                        exit={{ opacity: 0, y: -20, scale: 0.95 }}
                        transition={{ duration: 0.4, ease: [0.22, 1, 0.36, 1] }}
                        style={{
                            background: result.isImpossible 
                                ? 'linear-gradient(135deg, var(--error-bg) 0%, var(--error-bg-light) 100%)' 
                                : result.isWarning 
                                    ? 'linear-gradient(135deg, var(--warning-bg) 0%, var(--warning-bg-light) 100%)' 
                                    : 'linear-gradient(135deg, var(--success-bg) 0%, var(--success-bg-light) 100%)',
                            color: result.isImpossible ? 'var(--error-color)' : result.isWarning ? 'var(--warning-color)' : 'var(--success-color)',
                            padding: 'clamp(1.25rem, 4vw, 1.5rem)',
                            borderRadius: 'var(--radius-2xl)',
                            border: `2px solid ${result.isImpossible ? 'var(--error-border)' : result.isWarning ? 'var(--warning-border)' : 'var(--success-border)'}`,
                            boxShadow: result.isImpossible 
                                ? '0 8px 30px var(--error-glow)' 
                                : result.isWarning 
                                    ? '0 8px 30px var(--warning-glow)' 
                                    : '0 8px 30px var(--success-glow)',
                            position: 'relative',
                            overflow: 'hidden'
                        }}
                    >
                        {/* Animated background glow */}
                        <motion.div
                            animate={{
                                opacity: [0.1, 0.2, 0.1],
                                scale: [1, 1.1, 1]
                            }}
                            transition={{ duration: 3, repeat: Infinity }}
                            style={{
                                position: 'absolute',
                                top: '-50%',
                                right: '-20%',
                                width: '200px',
                                height: '200px',
                                background: `radial-gradient(circle, currentColor 0%, transparent 70%)`,
                                pointerEvents: 'none'
                            }}
                        />
                        
                        <motion.h4 
                            initial={{ opacity: 0, x: -10 }}
                            animate={{ opacity: 1, x: 0 }}
                            transition={{ delay: 0.1 }}
                            style={{ 
                                fontSize: 'clamp(1.1rem, 4vw, 1.25rem)', 
                                marginTop: 0,
                                marginBottom: '0.75rem', 
                                display: 'flex', 
                                alignItems: 'center', 
                                gap: '0.75rem',
                                fontWeight: 700,
                                position: 'relative',
                                zIndex: 1
                            }}
                        >
                            <IconContainer
                                icon={result.isImpossible ? AlertTriangle : result.isWarning ? Info : CheckCircle2}
                                size={24}
                                bgColor={result.isImpossible 
                                    ? 'rgba(239, 68, 68, 0.2)' 
                                    : result.isWarning 
                                        ? 'rgba(245, 158, 11, 0.2)' 
                                        : 'rgba(16, 185, 129, 0.2)'
                                }
                                iconColor={result.isImpossible ? 'var(--error-color)' : result.isWarning ? 'var(--warning-color)' : 'var(--success-color)'}
                                animation={result.isImpossible ? 'shake' : 'pulse'}
                            />
                            {result.isImpossible || result.isWarning ? t('warningTitle') : t('resultTitle')}
                        </motion.h4>
                        <motion.p 
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            transition={{ delay: 0.2 }}
                            style={{ 
                                margin: 0, 
                                fontSize: 'clamp(1rem, 4vw, 1.1rem)',
                                fontWeight: 600,
                                lineHeight: 1.6,
                                position: 'relative',
                                zIndex: 1
                            }}
                        >
                            {result.isImpossible
                                ? t('destinationOutOfReach')
                                : result.isWarning
                                    ? t('errorMessage', result.chargeNeeded.toFixed(2))
                                    : t('chargeMessage', result.chargeNeeded.toFixed(2))
                            }
                        </motion.p>
                    </motion.div>
                )}
            </AnimatePresence>

            <StaggerItem>
                <FadeIn delay={0.4}>
                    <Button 
                        onClick={handleCalculate} 
                        icon={<Zap size={22} />}
                        glowEffect
                    >
                        {t('calculate')}
                    </Button>
                </FadeIn>
            </StaggerItem>
        </StaggerContainer>
    );
};
