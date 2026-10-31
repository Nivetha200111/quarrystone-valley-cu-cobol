      * QUARRYSTONE VALLEY CREDIT UNION - ENTIRELY FICTIONAL.
      * SYNTHETIC CODE AND DATA, WRITTEN FOR THE DIOCLE PROJECT.
      * NOT AFFILIATED WITH ANY REAL CREDIT UNION, BANK OR COMPANY.
      *----------------------------------------------------------------
      * QVINT010 - DAILY SHARE INTEREST AND OVERDRAFT INTEREST
      * CHANGE LOG
      *   1991-06-03 LKO  INITIAL VERSION
      *   2007-11-20 LKO  PREMIUM BONUS RATE AT 25,000.00 AND OVER
      *   2019-04-02 DMV  OVERDRAFT INTEREST 18 PCT, TRUNCATED
      * TRAPS: CREDIT INTEREST IS ROUNDED, OVERDRAFT INTEREST IS NOT;
      *        BONUS STARTS AT EXACTLY 25,000.00.
      *----------------------------------------------------------------
       IDENTIFICATION DIVISION.
       PROGRAM-ID. QVINT010.
       AUTHOR. L K OSEI.
       DATE-WRITTEN. 1991-06-03.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ACCT-FILE ASSIGN TO ACCTIN
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT INT-FILE ASSIGN TO INTOUT
               ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  ACCT-FILE.
       COPY QVACCT.
       FD  INT-FILE.
       COPY QVINTO.
       WORKING-STORAGE SECTION.
       01  WS-EOF                      PIC X VALUE 'N'.
           88  END-OF-FILE             VALUE 'Y'.
       01  WS-RATE                     PIC S9V9(6) COMP-3.
       01  WS-OD-RATE                  PIC S9V9(4) COMP-3 VALUE 0.1800.
       01  WS-BONUS                    PIC S9V9(4) COMP-3 VALUE 0.0025.
       01  WS-INT                      PIC S9(7)V99 COMP-3.
       PROCEDURE DIVISION.
       0000-MAIN.
           OPEN INPUT ACCT-FILE OUTPUT INT-FILE
           PERFORM 8000-READ
           PERFORM 2000-ACCRUE UNTIL END-OF-FILE
           CLOSE ACCT-FILE INT-FILE
           STOP RUN.
       2000-ACCRUE.
           MOVE ZERO TO WS-INT
           EVALUATE TRUE
               WHEN QA-BALANCE > ZERO
                   MOVE QA-RATE TO WS-RATE
                   IF QA-TIER-PREMIUM AND QA-BALANCE NOT < 25000.00
                       ADD WS-BONUS TO WS-RATE
                   END-IF
                   COMPUTE WS-INT ROUNDED =
                       QA-BALANCE * WS-RATE * QA-DAYS / 365
                   MOVE 'CR' TO QI-FLAG
               WHEN QA-BALANCE < ZERO
                   COMPUTE WS-INT =
                       QA-BALANCE * WS-OD-RATE * QA-DAYS / 365
                   MOVE 'OD' TO QI-FLAG
               WHEN OTHER
                   MOVE 'ZR' TO QI-FLAG
           END-EVALUATE
           MOVE QA-ACCT-ID TO QI-ACCT-ID
           MOVE WS-INT TO QI-INTEREST
           COMPUTE QI-NEW-BAL = QA-BALANCE + WS-INT
           WRITE QI-REC
           PERFORM 8000-READ.
       8000-READ.
           READ ACCT-FILE AT END SET END-OF-FILE TO TRUE END-READ.
