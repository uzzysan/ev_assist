import React from 'react';
import { motion } from 'framer-motion';

interface FadeInProps {
  children: React.ReactNode;
  delay?: number;
  duration?: number;
  direction?: 'up' | 'down' | 'left' | 'right' | 'none';
  distance?: number;
  className?: string;
  style?: React.CSSProperties;
}

const getDirectionOffset = (direction: string, distance?: number) => {
  const defaultDistance = distance ?? 40;
  switch (direction) {
    case 'up': return { y: defaultDistance };
    case 'down': return { y: -defaultDistance };
    case 'left': return { x: defaultDistance };
    case 'right': return { x: -defaultDistance };
    default: return {};
  }
};

export const FadeIn: React.FC<FadeInProps> = ({
  children,
  delay = 0,
  duration = 0.5,
  direction = 'up',
  distance,
  className,
  style
}) => {
  const initialOffset = getDirectionOffset(direction, distance);

  return (
    <motion.div
      initial={{ opacity: 0, ...initialOffset }}
      animate={{ opacity: 1, x: 0, y: 0 }}
      transition={{
        duration,
        delay,
        ease: [0.22, 1, 0.36, 1]
      }}
      className={className}
      style={style}
    >
      {children}
    </motion.div>
  );
};

// Stagger Container for lists
interface StaggerContainerProps {
  children: React.ReactNode;
  staggerDelay?: number;
  className?: string;
  style?: React.CSSProperties;
}

export const StaggerContainer: React.FC<StaggerContainerProps> = ({
  children,
  staggerDelay = 0.1,
  className,
  style
}) => {
  return (
    <motion.div
      initial="hidden"
      animate="visible"
      variants={{
        hidden: { opacity: 0 },
        visible: {
          opacity: 1,
          transition: {
            staggerChildren: staggerDelay
          }
        }
      }}
      className={className}
      style={style}
    >
      {children}
    </motion.div>
  );
};

// Stagger Item
interface StaggerItemProps {
  children: React.ReactNode;
  className?: string;
  style?: React.CSSProperties;
}

export const StaggerItem: React.FC<StaggerItemProps> = ({
  children,
  className,
  style
}) => {
  return (
    <motion.div
      variants={{
        hidden: { opacity: 0, y: 20 },
        visible: {
          opacity: 1,
          y: 0,
          transition: {
            type: "spring",
            stiffness: 100,
            damping: 12
          }
        }
      }}
      className={className}
      style={style}
    >
      {children}
    </motion.div>
  );
};

// Scale On Hover wrapper
interface ScaleOnHoverProps {
  children: React.ReactNode;
  scale?: number;
  className?: string;
  style?: React.CSSProperties;
}

export const ScaleOnHover: React.FC<ScaleOnHoverProps> = ({
  children,
  scale = 1.02,
  className,
  style
}) => {
  return (
    <motion.div
      whileHover={{ scale }}
      whileTap={{ scale: 0.98 }}
      transition={{ duration: 0.2 }}
      className={className}
      style={style}
    >
      {children}
    </motion.div>
  );
};

// Glow Effect wrapper
interface GlowOnHoverProps {
  children: React.ReactNode;
  glowColor?: string;
  className?: string;
  style?: React.CSSProperties;
}

export const GlowOnHover: React.FC<GlowOnHoverProps> = ({
  children,
  glowColor = 'var(--primary-glow)',
  className,
  style
}) => {
  return (
    <motion.div
      whileHover={{
        boxShadow: `0 0 30px ${glowColor}`,
        y: -4
      }}
      transition={{ duration: 0.3 }}
      className={className}
      style={style}
    >
      {children}
    </motion.div>
  );
};
