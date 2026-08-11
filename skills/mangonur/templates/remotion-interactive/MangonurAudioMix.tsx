// Path: templates/remotion-interactive/MangonurAudioMix.tsx
// Summary: Provides reusable narration, music and SFX audio layers with bounded master-volume controls for Remotion compositions.
import React from 'react';
import {staticFile} from 'remotion';
import {Audio} from '@remotion/media';

type MangonurAudioMixProps = {
  narration?: string;
  music?: string;
  sfx?: string[];
  narrationVolume?: number;
  musicVolume?: number;
  sfxVolume?: number;
};

const bounded = (value: number) => Math.max(0, Math.min(2, value));

export const MangonurAudioMix: React.FC<MangonurAudioMixProps> = ({
  narration,
  music,
  sfx = [],
  narrationVolume = 1,
  musicVolume = 0.18,
  sfxVolume = 0.7,
}) => (
  <>
    {narration ? <Audio src={staticFile(narration)} volume={bounded(narrationVolume)} /> : null}
    {music ? <Audio src={staticFile(music)} volume={bounded(musicVolume)} /> : null}
    {sfx.map((src, index) => (
      <Audio key={`${src}-${index}`} src={staticFile(src)} volume={bounded(sfxVolume)} />
    ))}
  </>
);
