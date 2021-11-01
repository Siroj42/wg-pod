# wg-pod

A tool to quickly join your [podman](https://podman.io/) container/pod into a WireGuard network.

## Explanation

wg-pod wires up the tools **ip**,**route**,[wg](https://git.zx2c4.com/wireguard) and podman.
It creates a WireGuard interface inside of the containers network namespace and routes all traffic defined as `AllowedIPs` through the WireGuard interface.

Existing interfaces in the namespace are not deleted and a route that is more specific than the default route in the namespace will still match.
This means that the container will be able to talk over both the WireGuard network and the original network that was created for it by podman.

# Commands

## join

### Parameters

- `container_name (required)`: specify the name of the container that should get connected into the network
- `config_path (required)`: absolute path to the [wireguard config](./docs/wireguard-config)

### Flags

- `port-remapping (optional)`: comma separated list of ports to remap from the interface to the container


# Dependencies

- Linux
- write permissions to `/run/containers`
- permissions to change the network `CAP_NET_ADMIN`
- nftables
- ip
- wireguard

## Cool automation

Use `wg-pod` inside the `ExecStartPost` lifecycle of SystemD unit files to spawn containers into a network directly after creation.
Check out [quadlet](https://github.com/containers/quadlet) for a convenient way of creating those unit files.

# Security considerations

- Make sure that no user (not even root) can edit around network configurations inside your container. (`CAP_NET_ADMIN` must not be given)
- The Host network that was set up during container creation is still reachable with routing rules more specific than the default route to the WireGuard VPN
