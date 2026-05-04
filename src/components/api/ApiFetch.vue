<script>
/**
 * Executes a fetch request and parses a JSON response.
 *
 * @returns {Promise<any>}
 *  - On success (2xx): returns the parsed response body.
 *
 * @throws {Object}
 *  - On failure (non‑2xx): throws an object containing:
 *      - `status`: HTTP status code.
 *      - `message`: error message provided by the backend (or null if not present).
 */
export async function apiFetch(url, options = {}) {
    const response = await fetch(url, {
        credentials: 'include',
        headers: {
            'Content-Type': 'application/json',
            ...options.headers,
        },
        ...options,
    });

    const contentType = response.headers.get('content-type');
    const body = contentType?.includes('application/json')
        ? await response.json()
        : null;

    if (!response.ok) {
        throw {
            status: response.status,
            message: body?.message ?? null,
        };
    }

    return body?.data ?? body;
}
</script>
