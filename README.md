# @codingturtle/react-native-idfa-idfv-gaid

Get **IDFA**, **IDFV** (iOS) and **Google Advertising ID / GAID** (Android) in React Native.

## Installation

```bash
npm install @codingturtle/react-native-idfa-idfv-gaid
```

### iOS Setup

```bash
cd ios && pod install
```

Add to your `Info.plist`:
```xml
<key>NSUserTrackingUsageDescription</key>
<string>This identifier will be used to deliver personalized ads to you.</string>
```

### Android Setup

Add to your `AndroidManifest.xml`:
```xml
<uses-permission android:name="com.google.android.gms.permission.AD_ID"/>
```

Register the package in `MainApplication.kt`:
```kotlin
import com.idfaidfvgaid.IdfaIdfvGaidPackage

override fun getPackages(): List<ReactPackage> = listOf(
    ...,
    IdfaIdfvGaidPackage()
)
```

## Usage

```js
import { getIDFA, getIDFV, getGAID, getAllIds } from '@codingturtle/react-native-idfa-idfv-gaid';

// iOS only - requires ATT permission first
const idfa = await getIDFA();

// iOS only - no permission needed
const idfv = await getIDFV();

// Android only
const gaid = await getGAID();

// Get all IDs for current platform
const ids = await getAllIds();
// iOS:     { idfa: '...', idfv: '...' }
// Android: { gaid: '...' }
```

## Notes

- On iOS 14.5+, you must request ATT permission before calling `getIDFA()`, otherwise it returns `00000000-0000-0000-0000-000000000000`
- `getIDFV()` does not require any permission
- On Android, if user has opted out of ad tracking, `getGAID()` returns `00000000-0000-0000-0000-000000000000`

## License

MIT
