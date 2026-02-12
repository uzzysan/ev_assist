import React, { useState } from 'react';
import { useI18n } from '../i18n';
import { calculateCharge, type CalculationResult, type CapacityType } from '../logic/calculate';
import { Card } from './Card';
import { Input } from './Input';
import { Button } from './Button';

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
        // Basic validation
        if (!avgConsumption || !avgConsumptionDistance || !destinationDistance || !totalCapacity || !currentLevel || !desiredLevel) {
            // In a real app, show errors. Here we just return or could show a toast.
            // For now, let's assume valid numbers.
        }

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
        <div style={{ maxWidth: '600px', width: '100%', margin: '0 auto', display: 'flex', flexDirection: 'column', gap: 'clamp(1rem, 4vw, 1.5rem)' }}>

            {/* Consumption Section */}
            <Card title={`🔌 ${t('averageConsumption')}`}>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(140px, 1fr))', gap: 'clamp(0.75rem, 3vw, 1rem)' }}>
                    <Input
                        label={t('consumptionHint')}
                        value={avgConsumption}
                        onChange={e => setAvgConsumption(e.target.value)}
                        type="number"
                        placeholder="18.5"
                    />
                    <Input
                        label={t('distanceHint')}
                        value={avgConsumptionDistance}
                        onChange={e => setAvgConsumptionDistance(e.target.value)}
                        type="number"
                        suffix="km"
                    />
                </div>
            </Card>

            {/* Trip & Battery Section */}
            <Card title={`🚗 ${t('destinationDistanceHint')}`}>
                <div style={{ display: 'flex', flexDirection: 'column', gap: 'clamp(0.75rem, 3vw, 1rem)' }}>
                    <Input
                        label={t('destinationDistanceHint')}
                        value={destinationDistance}
                        onChange={e => setDestinationDistance(e.target.value)}
                        type="number"
                        suffix="km"
                    />

                    <div style={{ height: '2px', background: 'linear-gradient(90deg, transparent, var(--border-color), transparent)', margin: '0.25rem 0' }} />

                    <Input
                        label={t('totalBatteryCapacity')}
                        value={totalCapacity}
                        onChange={e => setTotalCapacity(e.target.value)}
                        type="number"
                        suffix="kWh"
                    />

                    <div style={{ display: 'flex', gap: 'clamp(1rem, 4vw, 2rem)', marginTop: '0.5rem', flexWrap: 'wrap' }}>
                        <label style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', cursor: 'pointer', color: 'var(--text-color)', fontSize: 'clamp(0.9rem, 3.5vw, 1rem)' }}>
                            <input
                                type="radio"
                                name="capacityType"
                                value="net"
                                checked={capacityType === 'net'}
                                onChange={() => setCapacityType('net')}
                                style={{ accentColor: 'var(--primary-color)', width: '18px', height: '18px' }}
                            />
                            {t('net')}
                        </label>
                        <label style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', cursor: 'pointer', color: 'var(--text-color)', fontSize: 'clamp(0.9rem, 3.5vw, 1rem)' }}>
                            <input
                                type="radio"
                                name="capacityType"
                                value="gross"
                                checked={capacityType === 'gross'}
                                onChange={() => setCapacityType('gross')}
                                style={{ accentColor: 'var(--primary-color)', width: '18px', height: '18px' }}
                            />
                            {t('gross')}
                        </label>
                    </div>
                </div>
            </Card>

            {/* Levels Section */}
            <Card title={`🔋 ${t('batteryLevels')}`}>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(140px, 1fr))', gap: 'clamp(0.75rem, 3vw, 1rem)' }}>
                    <Input
                        label={t('currentBatteryLevel')}
                        value={currentLevel}
                        onChange={e => setCurrentLevel(e.target.value)}
                        type="number"
                        suffix="%"
                    />
                    <Input
                        label={t('desiredArrivalLevel')}
                        value={desiredLevel}
                        onChange={e => setDesiredLevel(e.target.value)}
                        type="number"
                        suffix="%"
                    />
                </div>
            </Card>

            {/* Result Section */}
            {result && (
                <div style={{
                    background: result.isImpossible 
                        ? 'linear-gradient(135deg, var(--error-bg) 0%, #fecaca 100%)' 
                        : result.isWarning 
                            ? 'linear-gradient(135deg, var(--warning-bg) 0%, #fde68a 100%)' 
                            : 'linear-gradient(135deg, var(--success-bg) 0%, #a7f3d0 100%)',
                    color: result.isImpossible ? 'var(--error-color)' : result.isWarning ? 'var(--warning-color)' : 'var(--success-color)',
                    padding: 'clamp(1rem, 4vw, 1.25rem)',
                    borderRadius: 'var(--radius-xl)',
                    border: `2px solid ${result.isImpossible ? 'var(--error-border)' : result.isWarning ? 'var(--warning-border)' : 'var(--success-border)'}`,
                    boxShadow: 'var(--shadow-md)',
                    animation: 'slideInUp 0.3s ease-out',
                }}>
                    <h4 style={{ 
                        fontSize: 'clamp(1rem, 4vw, 1.15rem)', 
                        marginTop: 0,
                        marginBottom: '0.5rem', 
                        display: 'flex', 
                        alignItems: 'center', 
                        gap: '0.5rem',
                        fontWeight: 700,
                    }}>
                        {result.isImpossible ? '🚫' : result.isWarning ? '⚠️' : '✅'}
                        {result.isImpossible || result.isWarning ? t('warningTitle') : t('resultTitle')}
                    </h4>
                    <p style={{ 
                        margin: 0, 
                        fontSize: 'clamp(0.95rem, 4vw, 1.05rem)',
                        fontWeight: 500,
                        lineHeight: 1.5,
                    }}>
                        {result.isImpossible
                            ? t('destinationOutOfReach')
                            : result.isWarning
                                ? t('errorMessage', result.chargeNeeded.toFixed(2))
                                : t('chargeMessage', result.chargeNeeded.toFixed(2))
                        }
                    </p>
                </div>
            )}
            <style>{`
                @keyframes slideInUp {
                    from {
                        opacity: 0;
                        transform: translateY(10px);
                    }
                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }
            `}</style>

            <Button onClick={handleCalculate} style={{ marginTop: '0.25rem' }} icon="⚡">
                {t('calculate')}
            </Button>

        </div>
    );
};
