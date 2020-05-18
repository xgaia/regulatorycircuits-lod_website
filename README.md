# Regulatory circtuits LOD website

Regulatory circtuits LOD website, build with [Nikola](https://getnikola.com/)


## Installation

### Install dependencies

```bash
# Debian/Ubuntu
sudo apt install -y git make python3 python3-venv
# Fedora
sudo dnf install -y git make python3 python3-virtualenv
```

### Download and install website

```bash
git clone https://github.com/xgaia/regulatorycircuits-lod_website.git
cd regulatorycircuits-lod_website
make install
```

## Deployment

```bash
make build
```

Generated html are in the `output` directory


## Developement

### Serve website locally

```bash
make serve
```

### Create a page

```bash
make page
```

The new page will be created in the `pages` directory
