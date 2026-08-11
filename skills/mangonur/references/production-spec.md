# Mangonur Production Spec v1.5

- Canvas: 1080x1920 (9:16), 30 fps default.
- Voice: one locked final take whenever practical; WAV preferred for user recordings.
- Timeline authority: final voice.
- Visual beats: usually 3-5 s, but narration meaning controls cuts.
- UI safety: top 0-10% no captions or critical storytelling content.
- Caption band: 12-24% from top.
- Captions: 3-4 words/card, max 2 lines, active word yellow, frame-driven.
- Motion: subtle pan/zoom only when useful; do not fake activity with constant motion.
- SFX: approval-based A/B/C audition workflow.
- Music: approval-based audition workflow; duck below narration.
- Review gate before final render.
- Preserve a manifest of selected assets and their source/license metadata.

- Shared workspace: reusable assets, approved project assets, manifests, review renders, and finals.
- Local workspace: Remotion application, `node_modules`, caches, temp files, proxies, and disposable intermediates.
- Final render naming: versioned; do not silently overwrite prior finals.
