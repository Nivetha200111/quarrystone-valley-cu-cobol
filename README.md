# Quarrystone Valley Credit Union: COBOL batch (FICTIONAL)

> **Entirely fictional.** Quarrystone Valley Credit Union is not a real credit union. All code, names, authors,
> change logs and data are synthetic, written on Nov 1, 2026 as test material for [Diocle](https://github.com/Nivetha200111/Diocle).
> Not affiliated with any real credit union, bank or company. No real personal data.

Mainframe-style nightly batch: copybooks in `copybook/`, COMP-3 working storage, `SIGN LEADING SEPARATE` records,
88-levels, EVALUATE, ROUNDED next to truncation.

| Program | What it does | Traps baked in |
|---|---|---|
| `QVINT010` | Daily share interest and overdraft interest | Credit interest ROUNDED, overdraft interest truncated; premium bonus starts at exactly 25,000.00 |
| `QVFEE020` | Overdraft and returned-item (NSF) fees | Boundary at exactly -10.00, 0.5% fee truncated, premium waiver first, student waiver up to two items, 87.00 cap |
| `QVLON030` | Loan late-payment fees | Inclusive grace period (15 days mortgage, 10 otherwise), 5% ROUNDED, card minimum 15.00 before the 10.00 repeat surcharge, cap by loan type |

## Run locally (GnuCOBOL 3.2)
```sh
cobc -x -std=ibm -I copybook -o QVFEE020 src/QVFEE020.cbl
cd data && ACCTIN=ACCTIN.dat FEEOUT=/tmp/FEEOUT ../QVFEE020 && cat /tmp/FEEOUT
```
DD names map to environment variables: `ACCTIN`, `INTOUT`, `FEEOUT`, `LOANIN`, `LATEOUT`.

License: CC0-1.0.
