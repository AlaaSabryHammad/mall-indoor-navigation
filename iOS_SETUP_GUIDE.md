# 📱 iOS Setup Guide - Code Signing

## ✅ Good News: Your Code is Perfect!

The app compiled successfully - we just need to configure iOS code signing to run on your iPhone.

**Xcode is now opening...** 🚀

---

## 🔐 Quick Setup (5 minutes)

### **Step 1: In Xcode (Now Open)**

1. **Wait for Xcode to fully load** the workspace
2. **Click on "Runner"** in the left sidebar (blue icon at top)
3. **Select "Runner" target** (under TARGETS, not PROJECTS)
4. **Click "Signing & Capabilities"** tab at the top

### **Step 2: Configure Signing**

You'll see a section that says **"Signing & Capabilities"**

**Option A: Automatic Signing (Easiest)**
1. ✅ **Check "Automatically manage signing"**
2. **Select your "Team"** from dropdown:
   - If you see teams listed → Select one
   - If empty → Click "Add an Account..." and sign in with your Apple ID
3. Xcode will automatically:
   - Create a development certificate
   - Generate a provisioning profile
   - Register your iPhone

**Option B: Manual Signing** (If automatic doesn't work)
1. ❌ **Uncheck "Automatically manage signing"**
2. Create certificates manually in Apple Developer portal
3. Download and install provisioning profile

### **Step 3: Verify Bundle ID**

Still in Signing & Capabilities:
- **Bundle Identifier**: Should show `com.example.mallIndoorNavigation`
- If you see a ⚠️ warning, change it to something unique:
  - Example: `com.yourname.mallIndoorNavigation`
  - Must be unique across all iOS apps

### **Step 4: Trust Certificate on iPhone**

**After first build**, on your iPhone:
1. Go to **Settings → General → VPN & Device Management**
2. Find your developer certificate
3. Tap it and tap **"Trust"**
4. Confirm

---

## 🚀 Then Run the App!

Once Xcode shows **"Signing configured successfully"** ✅

### **Option 1: Run from Xcode**
- Click the ▶️ **Play button** in Xcode
- Select your iPhone from device dropdown
- Wait for build (~2 minutes first time)

### **Option 2: Run from Terminal**
```bash
flutter run -d 00008030-000115311A01802E
```

---

## 📋 **What You Need**

### **Free Apple Developer Account** (No $99/year required for testing!)
- Just your Apple ID
- Can deploy to your own devices
- Certificates expire every 7 days (need to rebuild)

### **Paid Apple Developer Account** ($99/year)
- Certificates last 1 year
- Can publish to App Store
- Unlimited devices
- Not needed for development!

---

## ⚠️ **Common Issues**

### **"No Team Available"**
**Solution**:
1. In Xcode: Xcode → Settings → Accounts
2. Click **"+"** → Add Apple ID
3. Sign in
4. Close settings, go back to Signing & Capabilities
5. Select the team that now appears

### **"Failed to create provisioning profile"**
**Cause**: Bundle ID already used by another app

**Solution**:
1. Change Bundle Identifier to something unique
2. Example: `com.yourname.mallnav`
3. Try again

### **"Device not registered"**
**Solution**:
1. Xcode should register automatically
2. If not: Apple Developer Portal → Devices → Add Device
3. Enter your iPhone's UDID (shown in Xcode when device selected)

### **"Untrusted Developer" on iPhone**
**Solution**:
1. iPhone Settings → General → VPN & Device Management
2. Tap your certificate
3. Tap "Trust"

---

## 🎯 **Expected Timeline**

| Step | Time |
|------|------|
| Add Apple ID to Xcode | 1 min |
| Configure signing | 1 min |
| First build | 2-3 min |
| Trust certificate on device | 30 sec |
| **Total** | **~5 minutes** |

---

## 💡 **Alternative: Use Simulator**

Don't want to deal with code signing? Use iOS Simulator:

```bash
# List available simulators
flutter emulators

# Launch one (example)
open -a Simulator

# Run app
flutter run
```

**Simulator benefits**:
- ✅ No code signing needed
- ✅ Faster iteration
- ✅ Built-in debugging tools

**Simulator limitations**:
- ❌ No camera (barcode scanning won't work)
- ❌ No real GPS/positioning
- ❌ Slower than real device

---

## 🔄 **After Setup**

Once signing is configured, you can run your app anytime with:

```bash
flutter run -d 00008030-000115311A01802E
```

Or from Xcode:
- Press ▶️ Play button
- Xcode remembers your settings!

---

## 📊 **What's Happening Now**

```
✅ Code compiled successfully
✅ No errors in Dart/Flutter code
✅ All dependencies installed
✅ iPhone detected (00008030-000115311A01802E)
✅ Xcode workspace opened

⏳ Waiting for: Code signing configuration
```

**Once you configure signing in Xcode (now open), the app will run!**

---

## 🎉 **You're Almost There!**

Your professional indoor navigation app is **100% code-complete** and ready to run.

Just:
1. ✅ Sign in to Xcode with your Apple ID (if needed)
2. ✅ Select a development team
3. ✅ Click the Play button ▶️

**The app will launch on your iPhone!** 🚀

---

## 📱 **First Launch - What You'll See**

1. **Search bar** at the top
2. **Map placeholder** (add your store map image to `assets/maps/store_map.png`)
3. **Orange admin button** (bottom right) - Tap to add products
4. **Blue location button** (bottom right) - Recenter map

### **To Add Products**:
1. Tap orange admin button
2. Go to "Products" tab
3. Tap "Add Product"
4. Tap map to set location
5. Fill in details

### **To Generate Navigation Paths**:
1. Admin mode → "Paths" tab
2. Tap "Generate Path Grid"
3. Wait for confirmation

---

**Questions? Check the other guides:**
- [README.md](README.md) - Full architecture
- [QUICKSTART.md](QUICKSTART.md) - Usage guide
- [BUILD_STATUS.md](BUILD_STATUS.md) - What was fixed

**Happy coding!** 🎉
