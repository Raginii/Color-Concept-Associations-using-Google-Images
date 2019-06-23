function contingency = ContingencyTable(GroundTruth, TestOutcome)

% true positives
tp = TestOutcome(GroundTruth == 1);
tp = length(tp(tp == 1));

% false positives
fp = TestOutcome(GroundTruth == 0);
fp = length(fp(fp == 1));

% false negatives
fn = TestOutcome(GroundTruth == 1);
fn = length(fn(fn == 0));

% true negatives
tn = TestOutcome(GroundTruth == 0);
tn = length(tn(tn == 0));

% sensitivity
sens = tp / (tp + fn);
if isnan(sens)
  sens = 0;
end

% specificity
spec = tn / (fp + tn);
if isnan(spec)
  spec = 0;
end

% positive predictive value
ppv = tp / (tp + fp);
if isnan(ppv)
  ppv = 0;
end

% negative predictive value
npv = tn / (fn + tn);
if isnan(npv)
  npv = 0;
end

contingency.sens = sens;
contingency.spec = spec;
contingency.ppv = ppv;
contingency.npv = npv;
contingency.tp = tp;
contingency.fp = fp;
contingency.fn = fn;
contingency.tn = tn;

end
