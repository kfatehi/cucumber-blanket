(function (){
  /* ADAPTER
   *
   * This blanket.js adapter is designed to autostart coverage
   * immediately. The other side of this is handled from Cucumber
   *
   * Required blanket commands:
   * blanket.setupCoverage(); // Do it ASAP
   * blanket.onTestStart(); // Do it ASAP
   * blanket.onTestDone(); // After Scenario Hook
   * blanket.onTestsDone(); // After Scenario Hook
   */

  blanket.beforeStartTestRunner({
    callback: function() {
      blanket.setupCoverage();
      blanket.onTestStart();
    }
  });


  /* REPORTER
   *
   * Blanket.js docs speak of blanket.customReporter but
   * that doesn't actually work so we'll override defaultReporter
   */
  blanket.defaultReporter = function(coverage_results){
    window.COVERAGE_RESULTS = coverage_results; // We'll grab this on selenium side
  };
})();
