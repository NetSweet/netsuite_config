/**
 * @NApiVersion 2.x
 * @NScriptType restlet
*/

/*
## Upload Script
https://system.sandbox.netsuite.com/app/common/scripting/uploadScriptFile.nl
File Name: netsuite_features.js

## Create RESETLEt
Name: Feature Inspection
ID: _feature_inspection
Description: Dump features as JSON. Do not install in production.
Deployments > Title: Feature Inspection
Deployments > Status: Released
*/

define(['N/config'], function(config) {
 return {
  get: function() {
    var allConfigTypes = [
      config.Type.FEATURES,
      config.Type.COMPANY_INFORMATION,
      config.Type.COMPANY_PREFERENCES,
      config.Type.ACCOUNTING_PREFERENCES
    ];

    var features = {};

    for(var typeIndex in allConfigTypes) {
      var type = allConfigTypes[typeIndex];

      var featureInfo = config.load({
        type: type
      });

      features[type] = {};

      var featureList = featureInfo.getFields()

      for(var k in featureList) {
        features[type][featureList[k]] = featureInfo.getValue(featureList[k]);
      }
    }

    return features;
  }
 }
});

'debug';
