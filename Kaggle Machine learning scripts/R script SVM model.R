model$bestTune
mtry
2    3
> model$results
mtry  Accuracy     Kappa AccuracySD    KappaSD
1    2 0.9716088 0.9432177 0.01338372 0.02676745
2    3 0.9755521 0.9511041 0.01003779 0.02007559
3    4 0.9755521 0.9511041 0.01003779 0.02007559
> 
  > if(CLEAR_MEMORY) {
    +   rm(training_cv)
    + }
> View(voice)
> 