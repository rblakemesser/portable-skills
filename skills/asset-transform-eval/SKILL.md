---
name: asset-transform-eval
description: "Evaluate how closely an output asset matches a target reference after stated transform instructions, with exhaustive 1-10 line-item scoring, preservation-vs-change reasoning, and a composite score that reflects both fidelity and instruction compliance."
---

# Asset Transform Evaluation

Use this skill when the job is to judge match quality between a target asset and an output asset after explicit transformation instructions, not to generate the asset or give generic design critique.

## Install

```bash
git clone git@github.com:rblakemesser/portable-skills.git && cd portable-skills && make install SKILL=asset-transform-eval
```

## When to use

- The user wants a scorecard for how closely a generated asset matches a reference while applying specified changes.
- The user wants an ad recreation, frame recreation, UI recreation, illustration recreation, or brand adaptation judged against both sameness and instructed differences.
- The user wants multiple candidate outputs graded against the same target and transform instructions using one stable rubric.
- The user wants a detailed evaluator that names exactly where a recreation drifted from the target, the transform, or both.

## When not to use

- The user wants the asset generated, edited, composited, or rebuilt rather than judged.
- The user wants generic creative critique, taste feedback, or concept exploration without a target reference plus transform instructions.
- The user wants product QA, code review, or functional testing rather than asset-match evaluation.
- The target asset, output asset, or transform instructions are missing and cannot be inferred safely.

## Non-negotiables

- Treat the transform instructions as the authority for what must change.
- Treat the target asset as the authority for what must stay the same unless the transform explicitly overrides it.
- Separate `must change`, `must preserve`, `allowed variation`, and `critical exact requirements` before scoring.
- Score only applicable dimensions. Mark non-applicable dimensions `N/A` and exclude them from the composite denominator.
- Every scored dimension must receive:
  - one integer score from 1 to 10
  - a short explanation grounded in visible or audible evidence
  - the main reason the score is not higher
- Do not let surface polish hide instruction failure. If the output is beautiful but wrong, score it as wrong.
- Do not penalize outputs for differences that were explicitly required by the transform instructions.
- If a mandatory exact requirement is missing or wrong, call it out as a critical miss and apply the composite-cap rules from `references/scoring-rubric.md`.
- If the inputs are incomplete or ambiguous, stop and state exactly what is missing instead of inventing evaluation criteria.

## First move

1. Confirm the three inputs:
   - target asset
   - output asset
   - transform instructions
2. Extract four lists from the transform instructions:
   - `must change`
   - `must preserve`
   - `allowed flex`
   - `critical exact requirements`
3. Classify the asset type:
   - static visual asset
   - UI or product screen
   - illustration or character asset
   - branded marketing asset
   - video or animated asset
   - audio-bearing asset
4. Read `references/scoring-rubric.md` and use only the applicable dimensions.

## Workflow

1. Build the evaluation frame before judging:
   - restate the intended transformed end state
   - identify what would count as faithful preservation
   - identify what would count as successful transformation
2. Score the output dimension by dimension using the rubric:
   - instruction fidelity first
   - then structural and stylistic fidelity
   - then technical and media-specific quality
3. For each dimension, explain:
   - what the output got right
   - what is off
   - why that matters to the match judgment
4. Compute the raw weighted composite exactly as specified in the rubric.
5. Apply any mandatory caps caused by critical misses or failed core dimensions.
6. Return the final scorecard with both:
   - the raw weighted composite
   - the final capped 1-10 composite

## Output expectations

- Start with a short `Evaluation Frame` that states:
  - the intended transformed asset
  - the critical must-change items
  - the critical must-preserve items
- Then provide a `Line-Item Scorecard` with one line per applicable dimension.
- Each line item must include:
  - the dimension name
  - the score as `X/10`
  - a concise explanation with concrete evidence
- After the line items, provide:
  - `Critical Misses`, if any
  - `Raw Weighted Composite`
  - `Final Composite Score`
  - `Verdict` in one short paragraph
- If multiple outputs are being compared, score each output independently first and only then provide ranking or comparison.

## Reference map

- `references/scoring-rubric.md` - exhaustive dimension definitions, scoring anchors, applicability rules, weighting, cap rules, and output format.
