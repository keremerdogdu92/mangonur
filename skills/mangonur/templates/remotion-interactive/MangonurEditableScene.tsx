// Path: templates/remotion-interactive/MangonurEditableScene.tsx
// Summary: Provides a reusable Remotion scene with Studio-editable visual, caption, effect, transition and safe master-volume controls.
import React from 'react';
import {AbsoluteFill, Easing, Interactive, interpolate, useCurrentFrame, useVideoConfig} from 'remotion';

type TransitionPreset = 'cut' | 'fade' | 'slide-left' | 'slide-up' | 'zoom';
type VisualEffectPreset = 'none' | 'soft-zoom' | 'soft-pan' | 'micro-shake';

type MangonurEditableSceneProps = {
  visual: React.ReactNode;
  caption: React.ReactNode;
  captionsEnabled?: boolean;
  transition?: TransitionPreset;
  transitionFrames?: number;
  visualEffect?: VisualEffectPreset;
};

export const MangonurEditableScene: React.FC<MangonurEditableSceneProps> = ({
  visual,
  caption,
  captionsEnabled = true,
  transition = 'fade',
  transitionFrames = 8,
  visualEffect = 'soft-zoom',
}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const safeTransitionFrames = Math.max(1, Math.min(30, transitionFrames));

  const transitionOpacity = transition === 'cut' ? 1 : interpolate(frame, [0, safeTransitionFrames], [0, 1], {
    extrapolateLeft: 'clamp',
    extrapolateRight: 'clamp',
    easing: Easing.bezier(0.16, 1, 0.3, 1),
  });

  const transitionTranslate = transition === 'slide-left'
    ? interpolate(frame, [0, safeTransitionFrames], ['120px 0px', '0px 0px'], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'})
    : transition === 'slide-up'
      ? interpolate(frame, [0, safeTransitionFrames], ['0px 120px', '0px 0px'], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'})
      : '0px 0px';

  const baseScale = visualEffect === 'soft-zoom'
    ? interpolate(frame, [0, 2 * fps], [1.04, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp', output: 'perceptual-scale'})
    : transition === 'zoom'
      ? interpolate(frame, [0, safeTransitionFrames], [1.08, 1], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp', output: 'perceptual-scale'})
      : 1;

  const effectTranslate = visualEffect === 'soft-pan'
    ? interpolate(frame, [0, 3 * fps], ['-20px 0px', '20px 0px'], {extrapolateLeft: 'clamp', extrapolateRight: 'clamp'})
    : visualEffect === 'micro-shake'
      ? `${Math.sin(frame * 1.7) * 2}px ${Math.cos(frame * 1.3) * 2}px`
      : '0px 0px';

  return (
    <AbsoluteFill name="Mangonur scene" style={{backgroundColor: 'black', overflow: 'hidden', opacity: transitionOpacity}}>
      <Interactive.Div
        name="Scene visual"
        style={{
          position: 'absolute',
          inset: 0,
          scale: baseScale,
          translate: transition !== 'cut' && transition !== 'fade' && visualEffect === 'none' ? transitionTranslate : effectTranslate,
          rotate: '0deg',
        }}
      >
        {visual}
      </Interactive.Div>

      {captionsEnabled ? (
        <Interactive.Div
          name="Caption layer"
          style={{
            position: 'absolute',
            top: 260,
            left: 100,
            width: 880,
            minHeight: 120,
            fontSize: 64,
            lineHeight: 1.08,
            textAlign: 'center',
            scale: 1,
            translate: '0px 0px',
            rotate: '0deg',
            opacity: interpolate(frame, [0, 8], [0, 1], {
              easing: Easing.bezier(0.16, 1, 0.3, 1),
              extrapolateLeft: 'clamp',
              extrapolateRight: 'clamp',
            }),
          }}
        >
          {caption}
        </Interactive.Div>
      ) : null}
    </AbsoluteFill>
  );
};
