---
name: mcp-troubleshooting
description: "Procedures for verifying and debugging Model Context Protocol (MCP) servers."
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  tags: [mcp, troubleshooting, debugging, sse, stdio]
---

# MCP Troubleshooting

This skill provides a structured approach to diagnosing issues with Model Context Protocol (MCP) servers, specifically distinguishing between local `stdio` servers and remote `SSE` (Server-Sent Events) servers.

## Diagnostic Workflow

### 1. Identify Transport Type
Before debugging, determine how the server is intended to communicate:
- **stdio**: Runs as a local subprocess. Requires a local executable or script path.
- **SSE**: Runs over HTTP/HTTPS. Requires a URL and typically uses `GET` for connection and `POST` for JSON-RPC messages.

### 2. Connectivity & Protocol Verification
If the server is remote (SSE):
- **Check Reachability**: Use `curl -I <URL>` to check if the endpoint responds.
- **Verify Method Support**: MCP SSE servers often return `405 Method Not Allowed` or `400 Bad Request` when accessed via a simple browser `GET` request because they expect specific JSON-RPC handshakes or headers. This does **not** necessarily mean the server is down.
- **Check for Redirects**: Use `curl -L <URL>` to follow any redirects that might be masking the true endpoint.

### 3. Common Pitfalls
- **`mcp run` limitations**: The `mcp run` CLI tool often expects a local file path as its primary argument. Passing a URL directly may result in a "File not found" error if the tool does not natively support remote SSE orchestration via that specific command.
- **Configuration Mismatch**: Ensure the `url` in `config.yaml` matches the expected protocol (e.g., `https://...`).

## Reference Logs
For specific session failures, refer to:
- [Craft MCP Connectivity Session](references/craft-mcp-connectivity.md)
