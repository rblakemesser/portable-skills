# Asset Transform Evaluation Rubric

This reference defines how to judge whether an output asset matches a target asset after explicit transform instructions. Use it when the user wants a strict, explainable quality score rather than a loose opinion.

## Core principle

Judge against two truths at once:

- `Transform truth`: what the instructions require the output to change.
- `Reference truth`: what the target asset establishes as the source shape, identity, and fidelity baseline for everything the transform did not override.

The evaluator must never collapse those two truths into one.

- If the output copies the target but ignores the transform, it is a mismatch.
- If the output obeys the transform but abandons the target's identity where identity was meant to be preserved, it is a mismatch.
- High scores require both successful change and disciplined preservation.

## Required input decomposition

Before scoring, extract and write four lists:

### 1. Must change

These are the parts the output is supposed to alter.

Examples:

- replace one brand identity with another requested brand identity
- keep layout but rewrite the CTA copy
- preserve mascot pose but change character styling
- recreate the ad in a different aspect ratio
- keep composition but change the product shot from milk to bread

### 2. Must preserve

These are the parts that should stay faithful to the target.

Examples:

- preserve timing and transition order
- preserve hierarchy and layout
- preserve the original UI structure
- preserve the character pose and silhouette
- preserve the original playful flat-vector style

### 3. Allowed flex

These are differences the evaluator should not punish heavily if they stay within the spirit of the task.

Examples:

- small kerning drift if the exact font is unavailable
- slight lighting adaptation when changing background
- minor pose cleanup when removing artifacts
- subtle crop adjustments required by a new aspect ratio

### 4. Critical exact requirements

These are zero-ambiguity conditions that materially limit the maximum score when wrong.

Examples:

- exact legal copy
- exact brand name or logo
- exact language text requested by the transform
- exact aspect ratio or safe-area requirement
- exact mandatory subject swap
- exact count of required cards, icons, characters, or UI states

If a critical exact requirement is wrong or missing, call it out explicitly and apply the cap rules below.

## Applicability rules

Not every dimension applies to every asset. Use only the applicable ones.

### Always score these

- Transform Compliance
- Preservation Discipline
- Overall Identity Match
- Composition and Layout
- Element Inventory Completeness
- Stylistic Fidelity
- Detail Fidelity
- Artifact Cleanliness
- Production Readiness

### Score these when applicable

- Subject or Object Fidelity
  - use when the asset contains a recognizable character, mascot, product, prop, icon set, or object whose specific form matters
- Color and Tonal Accuracy
  - use when color is part of the target identity or the transform did not intentionally replace it
- Typography and Copy Fidelity
  - use when text exists, the transform changes text, or brand/type treatment matters
- Brand Correctness
  - use when logos, wordmarks, mascots, store badges, packaging, or brand conventions matter
- UI Plausibility and State Accuracy
  - use when the asset contains product UI, interaction states, controls, progress, badges, cards, forms, or overlays
- Texture and Material Treatment
  - use when surface treatment, gloss, grain, lighting, shadow behavior, or 2D-vs-3D material cues matter
- Background and Environmental Treatment
  - use when the background, scene, or environment is a meaningful part of the target identity
- Continuity and Consistency
  - use for multi-frame, multi-screen, or multi-state outputs
- Motion Fidelity
  - use for animated assets and video
- Audio Fidelity
  - use for video, voiceover, sound-design, or music-bearing outputs

Mark non-applicable dimensions `N/A`. Do not force a score just to fill space.

## Universal 1-10 scale

Use integers only.

- `10`: Exact or effectively exact. At intended viewing conditions and close inspection, the output behaves like the intended transformed target with no meaningful mismatch.
- `9`: Near-match. Differences exist but are tiny, non-disruptive, and would not materially change production use.
- `8`: Strong match. Clearly faithful, with a few visible differences that do not break the intended result.
- `7`: Good match. The output is recognizably correct, but several differences are visible and at least one dimension needs cleanup.
- `6`: Acceptable but off. Directionally right, yet materially imperfect. A reviewer would still request revisions.
- `5`: Mixed or partial match. Some important aspects are right, but the output clearly fails on several significant points.
- `4`: Weak match. It borrows some cues from the target or transform, but important requirements are wrong.
- `3`: Poor match. Major instruction failures or fidelity failures dominate.
- `2`: Very poor match. Only fragments of the intended result are present.
- `1`: Fundamentally wrong. The output does not meaningfully satisfy the target-plus-transform task.

Use the whole range. Do not cluster everything at `6-8`.

## Line-item scoring rules

Every applicable line item must include:

- the dimension name
- the score as `X/10`
- what the output got right
- what the output got wrong
- the main reason the score is not higher

Good explanation pattern:

`7/10. The layout hierarchy and green CTA treatment are preserved, but the app-store badges are undersized and the brand lockup spacing is looser than the target, so the frame reads close but not exact.`

Bad explanation pattern:

`7/10. Pretty close overall.`

## Dimensions

## 1. Transform Compliance

### What it measures

Whether the output performed the requested changes accurately and completely.

### Inspect

- did every required change happen
- did the output avoid prohibited carryovers from the original
- did it change only what the instructions allowed it to change
- did it satisfy any explicit exact requirements tied to the transform

### Score guidance

- `9-10`: Every required change is present and precise. No meaningful transform omission or accidental over-change remains.
- `7-8`: The major transform requirements are satisfied, but one or two secondary transform details are off.
- `5-6`: The output follows the transform directionally, but misses important requested changes or introduces notable unintended changes.
- `3-4`: Several key transform requirements are missing, misread, or contradicted.
- `1-2`: The output largely ignores or reverses the requested transform.

### Common failure patterns

- changed brand, but not all brand instances
- changed copy, but kept the wrong voice or hierarchy
- changed aspect ratio, but composition collapsed
- swapped subject, but preserved the wrong target-specific details

## 2. Preservation Discipline

### What it measures

Whether the output kept the parts of the target that were supposed to remain faithful.

### Inspect

- preserved layout, pose, timing, or hierarchy where requested
- preserved recognizable style cues and asset family identity
- preserved relationships between elements, not just individual pieces
- avoided needless drift outside the transform brief

### Score guidance

- `9-10`: All important non-transformed parts stay faithful to the target with disciplined restraint.
- `7-8`: The output preserves most important structure and feel, but a few preserved areas drift visibly.
- `5-6`: Some core target DNA remains, but too many uninstructed changes weaken fidelity.
- `3-4`: Important preserved aspects are lost or substantially altered.
- `1-2`: The output rebuilds the asset into something else rather than preserving the intended base.

### Common failure patterns

- matches the transform but loses target composition
- keeps subject type but changes pose, silhouette, or emotional tone
- preserves copy but changes the whole visual language

## 3. Overall Identity Match

### What it measures

Whether the output still feels like the target asset after the instructed changes.

### Inspect

- first-glance recognition
- same campaign or asset-family feel
- same essential communication object
- same emotional and functional role

### Score guidance

- `9-10`: The output reads as the same asset family with the intended transform applied.
- `7-8`: Strong family resemblance remains, but the output is visibly more like an imitation than a match.
- `5-6`: The concept is related, but the identity is diluted.
- `3-4`: The output may share a few cues, but it no longer feels like the same asset.
- `1-2`: The output is effectively a different asset or concept.

## 4. Composition and Layout

### What it measures

Whether the spatial organization matches the target or the instructed adaptation.

### Inspect

- framing and crop
- relative element placement
- scale relationships
- alignment and spacing
- hierarchy and negative space
- adaptation quality if the aspect ratio changed

### Score guidance

- `9-10`: Placement, framing, balance, and hierarchy are exact or intentionally adapted with high discipline.
- `7-8`: Layout is close, but spacing, scaling, or framing differences are noticeable.
- `5-6`: Layout direction is correct, but several structural relationships are off.
- `3-4`: Major placement or balance errors break the match.
- `1-2`: The layout is fundamentally different or collapsed.

## 5. Element Inventory Completeness

### What it measures

Whether every required visual or audible component is present in the right count and role.

### Inspect

- required objects, characters, UI pieces, text blocks, logos, badges, controls, props
- correct count of repeated elements
- no missing required layers
- no major extraneous elements that change the read

### Score guidance

- `9-10`: All required elements are present, complete, and correctly assigned.
- `7-8`: Nearly complete, with only minor missing or extra pieces.
- `5-6`: Several components are present, but one or more important elements are missing, simplified, or wrong.
- `3-4`: Multiple required elements are missing or replaced incorrectly.
- `1-2`: The output fails basic asset assembly.

## 6. Subject or Object Fidelity

### What it measures

How closely the main recognisable character, mascot, object, or prop matches the intended transformed target.

### Inspect

- silhouette
- pose or orientation
- proportions
- facial features or key recognisable details
- object construction
- expression or attitude if relevant

### Score guidance

- `9-10`: The subject or object is highly faithful and instantly recognisable in the correct form.
- `7-8`: Clearly the right subject, but with visible shape, pose, or feature drift.
- `5-6`: The subject is directionally correct, yet simplified or distorted enough to weaken fidelity.
- `3-4`: The subject is only loosely related to the target.
- `1-2`: The subject is wrong, unreadable, or materially different.

## 7. Stylistic Fidelity

### What it measures

Whether the visual language matches the target's style after the transform.

### Inspect

- flat vector vs. textured render
- 2D vs. 3D
- playful vs. formal
- line quality
- edge treatment
- level of simplification
- illustration system or UI system feel

### Score guidance

- `9-10`: The output uses the same visual language and design system behavior as the intended transformed target.
- `7-8`: The style is broadly right, but visible stylistic drift remains.
- `5-6`: The style direction is adjacent but not faithful.
- `3-4`: The output adopts the wrong visual language.
- `1-2`: Style is fundamentally incompatible with the target.

## 8. Color and Tonal Accuracy

### What it measures

Whether palette, contrast, saturation, and tonal emphasis match what should have been preserved or intentionally transformed.

### Inspect

- hue family
- brightness and contrast
- saturation level
- accent color placement
- background/foreground separation
- whether transformed colors were applied consistently

### Score guidance

- `9-10`: Color behavior is highly faithful or correctly transformed with no meaningful drift.
- `7-8`: Palette is close, but some tones or emphasis points are visibly off.
- `5-6`: The color direction is partly right, but several choices weaken the match.
- `3-4`: Color behavior is wrong enough to materially change the identity.
- `1-2`: Palette and tonal behavior are fundamentally off.

## 9. Typography and Copy Fidelity

### What it measures

Whether text content and type treatment match the target or the requested transformed version.

### Inspect

- exact wording
- casing
- type personality
- weight
- line breaks
- alignment
- leading and spacing
- emphasis and hierarchy
- whether any required replacement copy is correct

### Score guidance

- `9-10`: Copy and type treatment are exact or essentially exact for the intended transformed target.
- `7-8`: The message and type system are close, but spacing, font feel, or one text detail is off.
- `5-6`: Text is partly correct, but wording or hierarchy drift is meaningful.
- `3-4`: Major copy errors or wrong type treatment materially change the read.
- `1-2`: Text is missing, wrong, illegible, or incompatible with the target.

## 10. Brand Correctness

### What it measures

Whether brand-specific assets and conventions are accurate.

### Inspect

- logos and wordmarks
- mascot construction
- app-store or platform badges
- product naming
- brand-safe color and type behavior
- branded UI patterns
- whether the transform correctly swapped brand ownership where required

### Score guidance

- `9-10`: Brand execution is accurate and consistent with the intended transformed brand state.
- `7-8`: Brand execution is mostly right, with small but noticeable errors.
- `5-6`: Brand signals are mixed, partially wrong, or inconsistently applied.
- `3-4`: Brand usage is clearly incorrect or incomplete.
- `1-2`: Brand treatment is fundamentally wrong or contradictory.

## 11. UI Plausibility and State Accuracy

### What it measures

Whether any depicted UI looks coherent, believable, and faithful to the target state.

### Inspect

- control shapes and spacing
- interaction states
- selection states
- progress indicators
- button behavior and affordance
- information density
- whether the depicted state matches the intended moment in the target

### Score guidance

- `9-10`: UI structure and state are highly faithful and believable.
- `7-8`: UI is close, but spacing, state logic, or one control family is off.
- `5-6`: UI looks related, but several structural or state details do not hold up.
- `3-4`: UI plausibility or state fidelity is weak.
- `1-2`: UI is incoherent, broken, or not meaningfully faithful.

## 12. Texture and Material Treatment

### What it measures

Whether the output handles surface qualities the way the target does.

### Inspect

- flat fills vs. gradients
- gloss and shine
- grain
- shadow softness
- foam, paper, plastic, glass, or metallic cues
- whether materials remain intentionally simple or intentionally rendered

### Score guidance

- `9-10`: Material treatment matches the target or intended transform cleanly.
- `7-8`: Treatment is close, with small rendering or texture drift.
- `5-6`: Some treatment cues are right, but material behavior is inconsistent.
- `3-4`: Surface treatment materially changes the style or read.
- `1-2`: Material treatment is wrong for the asset.

## 13. Background and Environmental Treatment

### What it measures

Whether the background or environment supports the same composition and tone as the target.

### Inspect

- flat white vs. patterned background
- atmospheric treatment
- environment density
- scene depth
- background contrast relationship to foreground

### Score guidance

- `9-10`: Background treatment supports the same asset read and is faithful or correctly transformed.
- `7-8`: Background is close, with moderate differences in mood or separation.
- `5-6`: Background direction is related, but materially off.
- `3-4`: Background treatment conflicts with the intended result.
- `1-2`: Background breaks the asset completely.

## 14. Detail Fidelity

### What it measures

Whether close-inspection details match the target standard.

### Inspect

- border thickness
- icon details
- corner radii
- highlight shapes
- micro-alignment
- shadow geometry
- badge construction
- small text and symbol accuracy

### Score guidance

- `9-10`: Micro-details hold up under inspection and align with the intended transformed target.
- `7-8`: Small details are mostly right, with a few visible cleanup needs.
- `5-6`: Detail quality is uneven and clearly not final.
- `3-4`: Detail mismatches are frequent and undermine fidelity.
- `1-2`: Close inspection collapses the output.

## 15. Artifact Cleanliness

### What it measures

Whether the output is free of generation or compositing errors.

### Inspect

- warped anatomy
- broken glyphs
- malformed UI
- duplicate elements
- mushy edges
- inconsistent rendering passes
- compression or halo artifacts
- accidental extra limbs, fingers, icons, shadows, or letters

### Score guidance

- `9-10`: No meaningful artifacts. The output reads cleanly as a deliberate asset.
- `7-8`: Minor artifacts exist, but they do not materially damage the read.
- `5-6`: Artifacts are visible and cleanup would be required before use.
- `3-4`: Artifacts materially damage fidelity or professionalism.
- `1-2`: Artifacts dominate the output.

## 16. Continuity and Consistency

### What it measures

For multi-frame or multi-state outputs, whether elements stay coherent over time or across states.

### Inspect

- consistent character construction
- stable colors and proportions
- stable logo or text behavior
- stable UI scale and layout logic
- frame-to-frame continuity

### Score guidance

- `9-10`: Continuity is stable and production-grade.
- `7-8`: Mostly consistent, with a few noticeable drifts.
- `5-6`: Inconsistencies are visible and distracting.
- `3-4`: Drift is frequent and undermines trust.
- `1-2`: The asset does not stay coherent across states or frames.

## 17. Motion Fidelity

### What it measures

For animated outputs, whether movement matches the target or intended transformed target.

### Inspect

- shot order
- transition type
- pacing
- timing
- easing
- reveal logic
- scale or position animation
- whether the output hits the same moments at the same narrative weight

### Score guidance

- `9-10`: Motion grammar is highly faithful and intentional.
- `7-8`: Motion is recognisably close, with some pacing or transition drift.
- `5-6`: Motion direction is right, but several beats feel wrong.
- `3-4`: Motion does not meaningfully match the target behavior.
- `1-2`: Motion is absent, broken, or wholly wrong.

## 18. Audio Fidelity

### What it measures

For audio-bearing outputs, whether the sonic experience matches the target or intended transformed target.

### Inspect

- spoken content
- timing relative to picture
- voice character
- emphasis and cadence
- music bed type and emotional tone
- sound-effect timing and density
- whether transformed audio requirements were followed

### Score guidance

- `9-10`: Audio behavior is highly faithful and correctly transformed.
- `7-8`: Audio is close, but one or two notable sonic differences remain.
- `5-6`: Audio supports the right idea but is materially off.
- `3-4`: Audio mismatches are obvious and damaging.
- `1-2`: Audio is wrong, missing, or fundamentally incompatible.

## 19. Production Readiness

### What it measures

Whether the output could credibly ship or move into the next production step without major repair.

### Inspect

- would a designer or editor still need major reconstruction
- would a reviewer approve it as-is or with minor polish
- does it read as a finished asset rather than an approximate generation
- is the remaining work cleanup-level or rebuild-level

### Score guidance

- `9-10`: Ready to use or requires only negligible polish.
- `7-8`: Minor cleanup remains, but the asset is substantially usable.
- `5-6`: Medium cleanup is needed before use.
- `3-4`: Major repair is needed.
- `1-2`: The asset is not production-usable.

## Weighting model

Use these weights for the applicable dimensions only.

### Core dimensions

- Transform Compliance: `18`
- Preservation Discipline: `15`
- Overall Identity Match: `10`
- Composition and Layout: `8`
- Element Inventory Completeness: `8`
- Stylistic Fidelity: `8`
- Detail Fidelity: `6`
- Artifact Cleanliness: `6`
- Production Readiness: `6`

### Conditional dimensions

- Subject or Object Fidelity: `6`
- Color and Tonal Accuracy: `5`
- Typography and Copy Fidelity: `5`
- Brand Correctness: `5`
- UI Plausibility and State Accuracy: `5`
- Texture and Material Treatment: `4`
- Background and Environmental Treatment: `3`
- Continuity and Consistency: `4`
- Motion Fidelity: `5`
- Audio Fidelity: `5`

## Raw composite calculation

1. List every applicable dimension.
2. Assign each applicable dimension its rubric weight.
3. Multiply each dimension's integer score by its weight.
4. Sum those weighted values.
5. Sum the weights of all applicable dimensions.
6. Divide the weighted-score total by the applicable-weight total.
7. This produces the `Raw Weighted Composite`, which may be shown to one decimal place.

Formula:

`Raw Weighted Composite = sum(score x weight) / sum(applicable weights)`

Do not include `N/A` dimensions in the denominator.

## Composite cap rules

The raw average alone is not enough. High polish cannot rescue a fundamentally wrong asset.

After calculating the raw weighted composite, apply these caps in order:

### Cap 1. Transform failure cap

If `Transform Compliance` is `4` or lower:

- `Final Composite Score` cannot exceed `4`

### Cap 2. Preservation failure cap

If `Preservation Discipline` is `4` or lower:

- `Final Composite Score` cannot exceed `5`

### Cap 3. Identity failure cap

If `Overall Identity Match` is `4` or lower:

- `Final Composite Score` cannot exceed `5`

### Cap 4. Critical exact requirement cap

If any critical exact requirement is missing, wrong, or contradicted:

- `Final Composite Score` cannot exceed `4`

Examples:

- wrong brand name
- wrong required logo
- wrong mandatory text
- wrong aspect ratio when exact ratio was required
- missing required subject swap
- missing legal line

### Cap 5. Multi-core weakness cap

If two or more of the following score `5` or lower:

- Transform Compliance
- Preservation Discipline
- Overall Identity Match
- Element Inventory Completeness

Then:

- `Final Composite Score` cannot exceed `5`

### Cap 6. Technical failure cap

If either of these is `3` or lower:

- Artifact Cleanliness
- Production Readiness

Then:

- `Final Composite Score` cannot exceed `6`

## Final rounding rule

After computing the raw weighted composite and applying all applicable caps:

1. round the raw weighted composite to the nearest whole number using standard rounding
2. apply the lowest applicable cap
3. the resulting integer is the `Final Composite Score`

If you want transparency, report both:

- `Raw Weighted Composite: 7.6/10`
- `Final Composite Score: 7/10`

If no cap changed the result, say so plainly.

## Critical misses section

Include a `Critical Misses` section whenever any of the following is true:

- a critical exact requirement is wrong
- Transform Compliance is `4` or lower
- Preservation Discipline is `4` or lower
- Overall Identity Match is `4` or lower
- a required element is missing in a way that meaningfully changes the asset

Each critical miss should state:

- what was required
- what the output did instead
- which cap rule it triggered, if any

## Output template

Use this structure:

```md
## Evaluation Frame

- Intended transformed asset: ...
- Must change: ...
- Must preserve: ...
- Allowed flex: ...
- Critical exact requirements: ...

## Line-Item Scorecard

- Transform Compliance: X/10 — ...
- Preservation Discipline: X/10 — ...
- Overall Identity Match: X/10 — ...
- Composition and Layout: X/10 — ...
- Element Inventory Completeness: X/10 — ...
- Subject or Object Fidelity: X/10 — ... / N/A
- Stylistic Fidelity: X/10 — ...
- Color and Tonal Accuracy: X/10 — ... / N/A
- Typography and Copy Fidelity: X/10 — ... / N/A
- Brand Correctness: X/10 — ... / N/A
- UI Plausibility and State Accuracy: X/10 — ... / N/A
- Texture and Material Treatment: X/10 — ... / N/A
- Background and Environmental Treatment: X/10 — ... / N/A
- Detail Fidelity: X/10 — ...
- Artifact Cleanliness: X/10 — ...
- Continuity and Consistency: X/10 — ... / N/A
- Motion Fidelity: X/10 — ... / N/A
- Audio Fidelity: X/10 — ... / N/A
- Production Readiness: X/10 — ...

## Critical Misses

- ...

## Composite

- Raw Weighted Composite: X.X/10
- Applied Caps: ...
- Final Composite Score: X/10

## Verdict

One short paragraph that says whether this is an exact match, near match, workable partial, or clear miss, and why.
```

## Interpretation guardrails

- A score of `8-10` means the output is genuinely strong, not merely "pretty good for AI."
- A score of `5-7` means the output is directionally useful but still visibly off.
- A score of `1-4` means the output failed the task in a material way.
- Never inflate the score just because the output is aesthetically pleasing.
- Never deflate the score for changes that the transform explicitly required.
