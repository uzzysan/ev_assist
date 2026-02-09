# AGENTS.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

EV Assist is an electric vehicle charging calculator web app. It helps users calculate how much they need to charge their EV battery to reach a destination with a desired battery level remaining.

## Development Commands

```bash
npm run dev      # Start Vite dev server with HMR
npm run build    # TypeScript compile + Vite production build
npm run lint     # Run ESLint on all .ts/.tsx files
npm run preview  # Preview production build locally
```

No test framework is currently configured.

## Architecture

### Entry Flow
`main.tsx` → `App.tsx` (wraps in `I18nProvider`) → `Layout` → `Calculator`

### Key Directories
- `src/components/` - React UI components
- `src/logic/` - Pure business logic functions
- `src/styles/` - CSS variables for theming

### Core Logic (`src/logic/calculate.ts`)
The `calculateCharge()` function takes consumption data, trip distance, battery capacity, and current/desired levels to compute charging needs. Key behaviors:
- Gross capacity mode subtracts 4.0 kWh buffer from total
- Adds 20km equivalent buffer to the calculation
- Returns `isWarning` if charge needed exceeds capacity
- Returns `isImpossible` if destination unreachable even at 100%

### Internationalization (`src/i18n.tsx`)
Custom React Context-based i18n supporting 6 locales: `en`, `pl`, `de`, `fr`, `es`, `it`.
- `useI18n()` hook provides `t()` function and `locale`/`setLocale`
- Translation strings use `{0}`, `{1}` placeholders for interpolation
- Locale persisted to localStorage

### Theming
CSS custom properties in `src/styles/variables.css`. Components reference `var(--primary-color)`, `var(--text-color)`, `var(--border-color)`, etc. Theme switching handled by `ThemeSwitcher` component.

## Project-Specific Patterns

- Inline styles used throughout components (no CSS modules or Tailwind classes)
- All form inputs managed with React `useState` as strings, parsed to numbers on calculate
- Results displayed conditionally with color-coded feedback (green/yellow/red)
