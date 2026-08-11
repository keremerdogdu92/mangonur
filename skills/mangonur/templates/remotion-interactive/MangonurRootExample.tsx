// Path: templates/remotion-interactive/MangonurRootExample.tsx
// Summary: Demonstrates inline Remotion composition props that surface common Mangonur finishing controls in Studio.
import React from 'react';
import {Composition} from 'remotion';

const ExampleVideo: React.FC<{
  narrationVolume: number;
  musicVolume: number;
  sfxVolume: number;
  captionsEnabled: boolean;
  transition: 'cut' | 'fade' | 'slide-left' | 'slide-up' | 'zoom';
  transitionFrames: number;
  visualEffect: 'none' | 'soft-zoom' | 'soft-pan' | 'micro-shake';
}> = () => null;

export const RemotionRoot: React.FC = () => (
  <Composition
    id="MangonurVideo"
    component={ExampleVideo}
    width={1080}
    height={1920}
    fps={30}
    durationInFrames={1800}
    defaultProps={{
      narrationVolume: 1,
      musicVolume: 0.18,
      sfxVolume: 0.7,
      captionsEnabled: true,
      transition: 'fade',
      transitionFrames: 8,
      visualEffect: 'soft-zoom',
    }}
  />
);
