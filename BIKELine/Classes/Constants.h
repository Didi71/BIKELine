//
//  Constants.h
//  BIKELine
//
//  Created by Christoph Lückler on 19.07.13.
//  Copyright (c) 2013 Christoph Lückler. All rights reserved.
//


// Bikebird Server
#define BIKEBIRD_DOMAIN @"http://www.bikebird.at"
#define BIKEBIRD_API_KEY @"motPFm2n8E3N5FdGIK4H"

#ifdef LIVE
    #define BIKEBIRD_API_BASE_URL @"http://www.bikebird.at/BIKElineCheckPoint/App-Scripts"
#else
    #define BIKEBIRD_API_BASE_URL @"http://www.bikebird.at/BIKElineCheckPoint/TestApp-Scripts"
#endif


// BIKEBIRD QR-Validation
#define BIKEBIRD_QRCODE_VERIFICATION_PREFIX @"http://www.bikebird.at/BIKElineCheckPoint/index.php"


// Crittercism
#define CRITTERCISM_APP_ID @"51e94ce7c463c21148000007"


// Google Analytics
#define GOOGLE_ANALYTICS_ID @"UA-42588248-1"
#define GOOGLE_ANALYTICS_DISPATCH 10