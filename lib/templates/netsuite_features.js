require(['N/config'],
 function(config) {
     function getFeatures() {
        var featureInfo = config.load({
          type: config.Type.FEATURES
        });

        var features = {};
        var featureList = featureInfo.getFields()

        for(var k in featureList) {
          features[featureList[k]] = featureInfo.getValue(featureList[k]);
        }
        
        JSON.stringify(features)
    }

    return getFeatures();
});


'debug';
