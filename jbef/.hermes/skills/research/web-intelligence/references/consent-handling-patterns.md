# Consent Handling Patterns

This document tracks common patterns for interacting with consent and privacy dialogs encountered during web research to ensure uninterrupted data retrieval.

## Common Selectors & Strategies

| Site/Provider | Typical Button Text (English) | Strategy |
| :--- | :--- | :--- |
| **Google** | "Accept all", "I agree" | Look for `button` elements within a `form` or `dialog`. Often uses `ref` IDs like `@e11` in snapshots. |
| **Yahoo** | "Aceptar todo", "Accept all" | Frequently presents in Spanish/other languages depending on IP. Check snapshot for localized text. |
| **General EU/GDPR** | "Allow all", "Reject all", "Manage settings" | Look for `dialog` elements. If a single click doesn't work, use `browser_snapshot` to find the specific button ID. |

## Workflow for Bypassing Walls

1.  **Detect:** After `browser_navigate`, immediately run `browser_snapshot`.
2.  **Identify:** Search snapshot for keywords: `privacy`, `cookies`, `consent`, `accept`, `agree`.
3.  **Execute:** 
    - If a clear "Accept all" button exists, use `browser_click(ref='@ID')`.
    - If the dialog is complex, use `browser_vision` to identify the visual location of the primary action button.
4.  **Verify:** Re-run `browser_snapshot` to ensure the modal has been dismissed and the target content is accessible.

## Troubleshooting Bot Detection

If encountering "Before you continue" or CAPTCHA screens:
- **Change Locale:** Append `?hl=en&gl=US` to the URL.
- **Switch Source:** If Google Finance is blocked, pivot to Yahoo Finance or Bloomberg.
- **Avoid Loops:** Do not repeatedly navigate to the exact same URL if a consent wall persists; it signals bot behavior.
