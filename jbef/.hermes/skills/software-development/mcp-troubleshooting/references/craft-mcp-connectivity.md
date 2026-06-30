# Craft MCP Connectivity Session

## Context
The user requested a check on the "Craft MCP" status. The configuration was found in `~/.hermes/config.yaml`.

## Configuration Found
```yaml
mcp_servers:
  Craft:
    url: https://mcp.craft.do/links/2VBSlEueddj/mcp
    enabled: true
```

## Diagnostic Steps & Results
1. **`mcp list`**: Failed (command not found/typer missing). Fixed by installing `mcp[cli]`.
2. **`mcp list` (retry)**: Failed (`No such command 'list'`). Checked `mcp --help` to understand available commands (`version`, `dev`, `run`, `install`).
3. **Search for config**: Located Craft configuration in `~/.hermes/config.yaml`.
4. **Connectivity Test (`curl -I`)**: Returned `HTTP/2 400`. This indicates the endpoint is reachable but rejected a simple HEAD request.
5. **Connectivity Test (`curl -L`)**: Returned `{"jsonrpc":"2.0","error":{"code":-32000,"message":"Method not allowed."},"id":null}`.

## Conclusion
The Craft MCP is an SSE server. The `"Method not allowed"` response via `curl` is expected behavior for a JSON-RPC endpoint that does not support plain `GET` requests without the proper handshake/headers. 

**Verification Path:** To confirm functionality, use the agent to attempt a tool call (e.g., "List my Craft docs") rather than manual CLI probing of the URL.
