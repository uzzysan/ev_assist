import React from 'react';
import { motion } from 'framer-motion';
import type { LucideIcon } from 'lucide-react';

interface AnimatedIconProps {
  icon: LucideIcon;
  size?: number;
  color?: string;
  animation?: 'pulse' | 'bounce' | 'float' | 'shake' | 'spin' | 'glow' | 'none';
  hoverEffect?: 'scale' | 'rotate' | 'bounce' | 'glow' | 'none';
  className?: string;
}

const animations = {
  pulse: {
    scale: [1, 1.15, 1],
    transition: { duration: 2, repeat: Infinity, ease: "easeInOut" as const }
  },
  bounce: {
    y: [0, -8, 0],
    transition: { duration: 1.2, repeat: Infinity, ease: "easeInOut" as const }
  },
  float: {
    y: [0, -6, 0],
    x: [0, 3, 0],
    transition: { duration: 3, repeat: Infinity, ease: "easeInOut" as const }
  },
  shake: {
    x: [0, -3, 3, -3, 3, 0],
    transition: { duration: 0.5, repeat: Infinity, repeatDelay: 3, ease: "easeInOut" as const }
  },
  spin: {
    rotate: 360,
    transition: { duration: 8, repeat: Infinity, ease: "linear" as const }
  },
  glow: {
    filter: ['drop-shadow(0 0 2px currentColor)', 'drop-shadow(0 0 8px currentColor)', 'drop-shadow(0 0 2px currentColor)'],
    transition: { duration: 2, repeat: Infinity, ease: "easeInOut" as const }
  },
  none: {}
};

const hoverEffects = {
  scale: { scale: 1.2 },
  rotate: { rotate: 15 },
  bounce: { y: -5 },
  glow: { 
    filter: 'drop-shadow(0 0 10px currentColor)',
    scale: 1.1
  },
  none: {}
};

export const AnimatedIcon: React.FC<AnimatedIconProps> = ({ 
  icon: Icon, 
  size = 24, 
  color,
  animation = 'none',
  hoverEffect = 'scale',
  className 
}) => {
  return (
    <motion.div
      animate={animations[animation]}
      whileHover={hoverEffects[hoverEffect]}
      transition={{ duration: 0.2 }}
      className={className}
      style={{ display: 'inline-flex' }}
    >
      <Icon 
        size={size} 
        color={color}
        style={{ transition: 'color 0.2s ease' }}
      />
    </motion.div>
  );
};

// Icon Container with background
interface IconContainerProps {
  icon: LucideIcon;
  size?: number;
  bgColor?: string;
  iconColor?: string;
  animation?: 'pulse' | 'bounce' | 'float' | 'shake' | 'glow' | 'none';
  className?: string;
  glowOnHover?: boolean;
}

export const IconContainer: React.FC<IconContainerProps> = ({
  icon: Icon,
  size = 24,
  bgColor = 'var(--primary-glow)',
  iconColor = 'var(--primary-color)',
  animation = 'none',
  className,
  glowOnHover = true
}) => {
  const selectedAnimation = animations[animation];
  return (
    <motion.div
      animate={selectedAnimation}
      whileHover={glowOnHover ? {
        scale: 1.1,
        boxShadow: '0 0 20px var(--primary-glow)'
      } : { scale: 1.05 }}
      whileTap={{ scale: 0.95 }}
      className={className}
      style={{
        width: size * 2,
        height: size * 2,
        borderRadius: '50%',
        backgroundColor: bgColor,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        transition: 'box-shadow 0.3s ease'
      }}
    >
      <Icon size={size} color={iconColor} />
    </motion.div>
  );
};
