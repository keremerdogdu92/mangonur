# Mangonur API Credentials

This document defines the provider credentials used by Mangonur. Real credentials are local-only and must never be committed to GitHub.

## Local credential file

1. Copy the repository root file `.env.example` to `.env.local`.
2. Paste the real values into `.env.local`.
3. Keep `.env.local` on each machine that runs Mangonur.
4. Never paste real credentials into tracked files, documentation, issues, commits, or production metadata.

The repository `.gitignore` excludes `.env`, `.env.local`, and `.env.*.local` files.

## Recommended providers

### 1. Z.AI / BigModel

Purpose: CogVideoX video generation, including image-to-video and text-to-video workflows.

Environment variable:

```text
ZAI_API_KEY=
```

Key page:

```text
https://open.bigmodel.cn/usercenter/apikeys
```

### 2. Cloudflare Workers AI

Purpose: hosted image generation and Whisper transcription.

Environment variables:

```text
CLOUDFLARE_API_TOKEN=
CLOUDFLARE_ACCOUNT_ID=
```

Create a Workers AI API token from the Cloudflare dashboard under AI > Workers AI > Use REST API. The token should have the minimum Workers AI permissions required by the runtime.

### 3. ModelScope

Purpose: API Inference for image generation/editing and reference-aware workflows where supported.

Environment variable:

```text
MODELSCOPE_ACCESS_TOKEN=
```

Token page:

```text
https://modelscope.cn/my/myaccesstoken
```

### 4. NVIDIA NIM

Purpose: multimodal scene/video quality control and optional hosted AI services.

Environment variable:

```text
NVIDIA_API_KEY=
```

Key page:

```text
https://build.nvidia.com/settings/api-keys
```

## Optional language-model providers

Mangonur may also use these providers for script generation, planning, prompt compilation, or fallback routing:

```text
GROQ_API_KEY=
CEREBRAS_API_KEY=
OPENROUTER_API_KEY=
GOOGLE_GEMINI_API_KEY=
```

These are optional for the initial video-generation provider test and should only be configured when the corresponding integration is enabled.

## Security rules

- Use project-specific keys when the provider supports them.
- Grant the minimum permissions required by Mangonur.
- Rotate a key immediately if it is exposed in Git history, logs, screenshots, chat, or public documentation.
- Do not store API keys inside Remotion compositions, production archives, rendered metadata, or exported project bundles.
- Provider adapters must read credentials from environment variables rather than hard-coded strings.
