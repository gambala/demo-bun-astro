fu: frontend-update
frontend-update:
	bunx --bun npm-check-updates -i

fuu: frontend-upgrade
frontend-upgrade:
	bun update
