(function (){
  /* ADAPTER
   *
   * This blanket.js adapter is designed to autostart coverage
   * immediately. The other side of this is handled from Cucumber
   *
   * Required blanket commands:
   * blanket.setupCoverage(); // Do it ASAP
   * blanket.onTestStart(); // Do it ASAP
   * blanket.onTestDone(); // After Scenario Hook (Not necessary)
   * blanket.onTestsDone(); // After Scenario Hook
   */

  blanket.beforeStartTestRunner({
    callback: function() {
      blanket.setupCoverage();
      blanket.onTestStart();
      window.CUCUMBER_BLANKET = {
        files: {},
        sources: {},
        done: false,
        is_setup: true
      };
    }
  });


  /* REPORTER
   *
   * Blanket.js docs speak of blanket.customReporter but
   * that doesn't actually work so we'll override defaultReporter
   */
  blanket.defaultReporter = function(coverage_results){
    window.CUCUMBER_BLANKET.files = coverage_results.files;
    // Strangely enough it looks like we need to iterate in order to grab the `source`
    // data which is necessary to know which lines of code are being reported on.
    var files = Object.keys(coverage_results.files);
    for (var i = 0, l = files.length; i < l; i ++) {
      var file = files[i];
      window.CUCUMBER_BLANKET.sources[file] = window.CUCUMBER_BLANKET.files[file].source;
    }
    window.CUCUMBER_BLANKET.done = true;
    // Now we can grab all this on the selenium side through window.CUCUMBER_BLANKET
  };
})();

