# kizzycode/chirpstack

A monolithic chirpstack stack with:
- Postgres (required for persistent data)
- Redis (required for temporary data)
- Mosquitto (required for IPC between the gateway bridge and the main application)
- ChirpStack Gateway Bridge (to tranlate vendor specific gateway messages into an agnostic format)
- ChirpStack (the main application)
