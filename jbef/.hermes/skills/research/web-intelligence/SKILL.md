---
name: web-intelligence
description: High-fidelity web research and real-time data retrieval. Handles complex queries, bypasses consent walls, and synthesizes information from dynamic/interactive sites.
tags: [web, research, finance, news, real-time]
---

# Web Intelligence

Use this skill when a task requires more than simple keyword searching—specifically when it involves navigating interactive web elements, handling authentication/consent flows, or extracting data from highly dynamic single-page applications (SPAs).

## Triggers

- **Real-time Data:** Stock prices, weather, sports scores, current news.
- **Interactive Navigation:** Sites requiring clicks, form fills, or scrolling to reveal content (e.g., Google Finance, Yahoo Finance, social media).
- **Complex Fact-Checking:** Verifying claims that require cross-referencing multiple sources or navigating through "consent/cookie" walls.
- **Dynamic Content Extraction:** Scraping data from sites where the DOM is heavily modified by JavaScript after initial load.

## Workflow

1.  **Initial Probe:** Use `browser_navigate` to reach the target URL.
2.  **Consent Handling:** If a consent/cookie dialog appears (e.g., Google, Yahoo), use `browser_snapshot` and `browser_click` to accept or manage settings immediately. Do not proceed with research while a modal is blocking the view.
3.  **Verification of State:** After interacting with a page, use `browser_snapshot` or `browser_vision` to ensure the intended content (e.g., the stock price) is actually visible and not obscured by another overlay.
4.  **Deep Extraction:** If data is buried in nested elements, use `browser_console` to run JavaScript expressions for precise extraction rather than relying on text-based snapshots alone.
5.  **Synthesis:** Combine findings from multiple sources (e.g., Wikipedia for background + Google Finance for real-time) into a single coherent response.

## Pitfalls & Lessons Learned

### The "Consent Wall" Trap
Many high-value financial and news sites (Google, Yahoo, etc.) present mandatory consent dialogs. 
- **Failure Mode:** Attempting to read data while the modal is active results in empty or irrelevant snapshots.
- **Fix:** Always check for `dialog` or `form` elements in the snapshot immediately after navigation. Use `browser_click` on "Accept all" (or equivalent) before attempting further research.

### The "Private Company" Assumption
When researching companies, do not assume they are private based on general knowledge. 
- **Failure Mode:** Refusing to look for a stock price because the company is "known to be private."
- **Fix:** Always perform a targeted web search (e.g., `is [Company] publicly traded?`) to verify current status before concluding data is unavailable.

### Browser Session Stalling
Repeatedly navigating to the same URL after a failure can trigger bot detection (e.g., Google's "Before you continue" page).
- **Fix:** If blocked, try changing the query parameters (e.g., adding `?hl=en` or `&gl=US`) or switching to an alternative source (e.g., moving from Google Finance to Yahoo Finance) to reset the session context.

## References

- `references/consent-handling-patterns.md`: Common button selectors and patterns for bypassing major site consent walls.
