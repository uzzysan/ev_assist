export type CapacityType = 'net' | 'gross';

export interface CalculationInput {
    avgConsumption: number;
    avgConsumptionDistance: number;
    destinationDistance: number;
    totalCapacity: number;
    currentLevel: number; // percentage 0-100
    desiredLevel: number; // percentage 0-100
    capacityType: CapacityType;
}

export interface CalculationResult {
    chargeNeeded: number; // kWh
    isWarning: boolean;
    isImpossible: boolean;
}

export const calculateCharge = (input: CalculationInput): CalculationResult => {
    const {
        avgConsumption,
        avgConsumptionDistance,
        destinationDistance,
        totalCapacity,
        currentLevel,
        desiredLevel,
        capacityType
    } = input;

    // capacity logic
    // if gross, substract buffer (4.0 kWh used in original app)
    const cap = capacityType === 'gross' ? totalCapacity - 4.0 : totalCapacity;

    // current energy in kWh
    const curr = cap * (currentLevel / 100.0);

    // average consumption standardized to per 1 km?
    // Original: (avgConsumption * 100.0) / avgConsumptionDistance if distance != 100
    // Wait, original was:
    // final double avg = (avgConsumptionDistance == 100.0) ? avgConsumption : (avgConsumption * 100.0) / avgConsumptionDistance;
    // This calculates consumption per 100km normalized? 
    // No, if I consume 20kWh per 200km, then avgConsumption=20, dist=200.
    // avg = (20 * 100) / 200 = 10 kWh/100km.
    // So 'avg' is consumption per 100km.

    const avg = (avgConsumptionDistance === 100.0)
        ? avgConsumption
        : (avgConsumption * 100.0) / avgConsumptionDistance;

    // dest is distance in "units of 100km" because:
    // final double dest = destinationDistance / 100.0;
    // final double chrg = (((avg * dest) + res) - curr) + (avg * 0.2);
    // avg * dest = (kWh/100km) * (km/100) = kWh needed for trip. Correct.

    const dest = destinationDistance / 100.0;

    // reserve energy needed at destination
    const res = cap * (desiredLevel / 100.0);

    // Buffer: (avg * 0.2) -> 20% of 100km consumption? 
    // Original: + (avg * 0.2)
    // This adds a fixed buffer equivalent to 20km of driving (0.2 * 100km).

    const buffer = avg * 0.2;

    // Energy needed = (Trip Energy + Desired Reserve - Current Energy) + Buffer
    const chrg = (((avg * dest) + res) - curr) + buffer;

    const isImpossible = (chrg + curr) > cap; // If needed charge + current > total capacity, it implies you can't reach it even with full charge?
    // Wait, chrg is "how much to add".
    // If chrg > cap, it means you need to add more than the battery can hold total? No.
    // Original logic:
    // if (chrg > cap) { warning ... }
    // else if (chrg + curr > cap) { destinationOutOfReach ... }
    // chrg > cap -> You need to charge more than the total capacity of the car. Implies starting from empty + more.
    // chrg + curr > cap -> The total energy needed (Trip + Reserve + Buffer) exceeds Total Capacity.
    // because chrg + curr = (Trip + Res + Buffer).

    return {
        chargeNeeded: chrg,
        isWarning: chrg > cap,
        isImpossible: (chrg + curr) > cap
    };
};
