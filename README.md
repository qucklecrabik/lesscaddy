# lesscaddy

lesscaddy is a small Docker Compose project that simplifies setting up self-SNI for VLESS using Caddy.

## Requirements

- Docker
- Docker Compose
- A domain name pointed at your server
- A VLESS server or upstream configured for your use case

## Quick start

1. Clone this repository and open its directory:

	```bash
	git clone <repository-url>
	cd lesscaddy
	```

2. Create the environment file from the example, if one is provided:

	```bash
	cp .env.example .env
	```

3. Edit `.env` and set the required domain, upstream, and connection values.

4. Start the services:

	```bash
	docker compose up -d
	```

5. Check the service logs if needed:

	```bash
	docker compose logs -f
	```

Before starting Caddy, ensure that port 8443 is available and your DNS record points to the server.

## Stopping

```bash
docker compose down
```

## Configuration

Configuration is supplied through `.env`. Do not commit secrets or private credentials to version control. Refer to the Docker Compose file and any accompanying example environment file for the available variables.

## License

This project is licensed under the MIT License — see [LICENSE](LICENSE).
