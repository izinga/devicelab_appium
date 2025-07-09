# DeviceLab Appium Action

A GitHub Action that starts a DeviceLab test node service for Appium mobile testing in your CI/CD pipeline.

## Features

- 🚀 **Easy Setup**: One-step DeviceLab test node configuration
- 📱 **APK Support**: Automatically handles APK artifacts from build jobs
- 🔧 **Configurable**: Customizable ports, timeouts, and URLs
- 🛡️ **Robust**: Comprehensive error handling and debugging
- ✅ **Ready Detection**: Waits for test node to be fully operational

## Usage

### Basic Example

```yaml
name: Mobile Testing
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      # Your build steps here...
      
      - name: Upload APK
        uses: actions/upload-artifact@v4
        with:
          name: app-release
          path: path/to/your/app.apk

  test:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - uses: actions/checkout@v4
      
      - name: Start DeviceLab Appium
        uses: izinga/devicelab_appium@v1
        with:
          devicelab-url: 'https://app.devicelab.dev/node/your-node-id'
          apk-artifact-name: 'app-release'
      
      - name: Run Appium Tests
        run: |
          # Your tests connect to http://localhost:4723
          python -m pytest tests/
```

### Advanced Example

```yaml
- name: Start DeviceLab Appium
  id: testnode
  uses: izinga/devicelab_appium@v1
  with:
    devicelab-url: 'https://custom.devicelab.url/script'
    apk-artifact-name: 'my-app-build'
    test-node-port: '8080'
    wait-timeout: '600'

- name: Run Tests
  run: |
    echo "Test node running at: ${{ steps.testnode.outputs.test-node-url }}"
    pytest tests/ --appium-url="${{ steps.testnode.outputs.test-node-url }}"

- name: Cleanup
  if: always()
  run: |
    docker stop ${{ steps.testnode.outputs.container-name }} || true
```

## Inputs

| Input | Required | Default | Description |
|-------|----------|---------|-------------|
| `devicelab-url` | ✅ | - | DeviceLab script URL |
| `apk-artifact-name` | ✅ | - | Name of the artifact containing the APK |
| `apk-path` | ❌ | `app-release.apk` | Path to APK within artifact |
| `test-node-port` | ❌ | `4723` | Port for the test node server |
| `wait-timeout` | ❌ | `300` | Timeout in seconds |
| `registry` | ❌ | `ghcr.io` | Container registry |

## Outputs

| Output | Description |
|--------|-------------|
| `test-node-url` | URL of the running test node |
| `container-name` | Docker container name |

## Error Handling

This action provides detailed error messages for common issues:

- **Invalid DeviceLab URL**: Tests URL accessibility
- **Missing APK artifact**: Clear guidance on artifact setup
- **Test node startup failures**: Container logs and debugging info
- **Timeout issues**: Suggestions for resolution

## Requirements

- Linux runner (Ubuntu recommended)
- Docker available in the runner
- APK artifact from a previous job

## License

MIT License - see [LICENSE](LICENSE) file.

---

**Created by:** Om Narayan  
**Organization:** Izinga Software Private Limited