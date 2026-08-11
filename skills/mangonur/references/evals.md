# Mangonur Evaluation Cases

Use these examples when testing or refining the skill.

## Trigger tests

### Should trigger

User:
"Hadi Mangonur yapalım."

Expected:
- Activate Mangonur.
- Research recent viral topics.
- Return topic shortlist.
- Do not write full script yet.

### Should trigger

User:
"@mangonur"

Expected:
- Start `TOPIC_DISCOVERY`.

### Should trigger as continuation

Context:
An active Mangonur script is waiting for approval.

User:
"Hook güzel ama sonunu daha komik yap."

Expected:
- Revise script ending.
- Remain at `SCRIPT_APPROVAL`.
- Do not create image prompts.

### Should not trigger implicitly

User:
"Bana Premiere Pro'da renk ayarı anlat."

Expected:
- Do not use Mangonur unless explicitly requested.

---

## Gate tests

### Topic gate

Context:
Mangonur just started.

Expected:
- Present topics.
- Wait for selection.
- No full script.

### Script gate

Context:
User selected a topic.

Expected:
- Research.
- Draft script.
- Wait for approval.
- No scene prompts.

### Revision gate

Context:
Script presented.

User:
"Biraz kısalt."

Expected:
- Shorten script.
- Wait again.
- No shot breakdown.

### Approval transition

Context:
Revised script presented.

User:
"Tamam bu iyi, devam."

Expected:
- Treat as approval.
- Create shot breakdown.
- Create image prompts.

---

## Focus-lock tests

Context:
Topic is locked to the Anglo-Zanzibar War.

User:
"İkinci sahnede Zanzibar bayrağı yanlış olmuş."

Expected:
- Correct the relevant visual specification.
- Keep the selected topic.
- Do not offer new viral topics.
- Do not rewrite the whole script unless needed.

Context:
Script is approved.

User:
"3. kare fazla kalabalık."

Expected:
- Revise Scene 3 visual prompt/breakdown.
- Preserve approved narration.

---

## Accuracy tests

Topic:
A viral historical claim with disputed numbers.

Expected:
- Research the disagreement.
- Use qualified wording.
- Do not choose the most dramatic number merely because it is more viral.

Topic:
A current viral event.

Expected:
- Verify current status and event date.
- Do not rely solely on remembered facts.

---

## Visual continuity test

Recurring character appears in five scenes.

Expected:
- Each standalone prompt repeats the important identity and costume traits.
- Prompts do not depend only on "same character as before."

---

## Completion test

Expected final state:
- selected topic;
- approved script;
- scene breakdown;
- complete image prompts;
- compact completion summary.

Only then mark the Mangonur workflow complete.
