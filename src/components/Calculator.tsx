// No changes needed in Calculator.tsx directly regarding accessibility if Input component handles it correctly.
// I will inspect Input.tsx next.

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

    // Helper for radio buttons
    const RadioOption = ({ value, label }: { value: CapacityType; label: string }) => (
        <label style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', cursor: 'pointer', color: 'var(--text-color)' }}>
            <input
                type="radio"
                name="capacityType"
                value={value}
                checked={capacityType === value}
                onChange={() => setCapacityType(value)}
                style={{ accentColor: 'var(--primary-color)' }}
            />
            {label}
        </label>
    );

    return (
        <div style={{ maxWidth: '600px', width: '100%', margin: '0 auto', display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>

            {/* Consumption Section */}
            <Card title={t('averageConsumption')}>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
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
            <Card>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                    <Input
                        label={t('destinationDistanceHint')}
                        value={destinationDistance}
                        onChange={e => setDestinationDistance(e.target.value)}
                        type="number"
                        suffix="km"
                    />

                    <div style={{ height: '1px', background: 'var(--border-color)', margin: '0.5rem 0' }} />

                    <Input
                        label={t('totalBatteryCapacity')}
                        value={totalCapacity}
                        onChange={e => setTotalCapacity(e.target.value)}
                        type="number"
                        suffix="kWh"
                    />

                    <div style={{ display: 'flex', gap: '2rem', marginTop: '0.5rem' }}>
                        <RadioOption value="net" label={t('net')} />
                        <RadioOption value="gross" label={t('gross')} />
                    </div>
                </div>
            </Card>

            {/* Levels Section */}
            <Card title={t('batteryLevels')}>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
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
                    backgroundColor: result.isImpossible ? '#fee2e2' : result.isWarning ? '#fef3c7' : '#d1fae5',
                    color: result.isImpossible ? '#991b1b' : result.isWarning ? '#92400e' : '#065f46',
                    padding: '1rem',
                    borderRadius: '0.5rem',
                    border: `1px solid ${result.isImpossible ? '#f87171' : result.isWarning ? '#fbbf24' : '#34d399'}`,
                }}>
                    <h4 style={{ fontSize: '1.1rem', marginBottom: '0.5rem', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                        {/* Icons could be added here */}
                        {result.isImpossible || result.isWarning ? '⚠️ ' + t('warningTitle') : '✅ ' + t('resultTitle')}
                    </h4>
                    <p style={{ margin: 0 }}>
                        {result.isImpossible
                            ? t('destinationOutOfReach')
                            : result.isWarning
                                ? t('errorMessage', result.chargeNeeded.toFixed(2))
                                : t('chargeMessage', result.chargeNeeded.toFixed(2))
                        }
                    </p>
                </div>
            )}

            <Button onClick={handleCalculate} style={{ marginTop: '0.5rem' }}>
                {t('calculate')}
            </Button>

        </div>
    );
};
