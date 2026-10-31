      * QUARRYSTONE VALLEY CREDIT UNION - ENTIRELY FICTIONAL.
      * SYNTHETIC CODE AND DATA, WRITTEN FOR THE DIOCLE PROJECT.
      * NOT AFFILIATED WITH ANY REAL CREDIT UNION, BANK OR COMPANY.
      *----------------------------------------------------------------
      * QVLON030 - LOAN LATE-PAYMENT FEES
      * CHANGE LOG
      *   1998-09-14 RNA  INITIAL VERSION
      *   2011-02-28 RNA  MORTGAGE GRACE PERIOD 15 DAYS (OTHERS 10)
      *   2020-07-06 PJS  CARD MINIMUM 15.00, REPEAT SURCHARGE 10.00
      * TRAPS: GRACE BOUNDARY IS INCLUSIVE, FEE IS ROUNDED, MINIMUM
      *        APPLIES BEFORE THE SURCHARGE, CAP DEPENDS ON TYPE.
      *----------------------------------------------------------------
       IDENTIFICATION DIVISION.
       PROGRAM-ID. QVLON030.
       AUTHOR. R N ADEYEMI.
       DATE-WRITTEN. 1998-09-14.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT LOAN-FILE ASSIGN TO LOANIN
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT LATE-FILE ASSIGN TO LATEOUT
               ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  LOAN-FILE.
       COPY QVLOAN.
       FD  LATE-FILE.
       COPY QVLATE.
       WORKING-STORAGE SECTION.
       01  WS-EOF                      PIC X VALUE 'N'.
           88  END-OF-FILE             VALUE 'Y'.
       01  WS-GRACE                    PIC 9(3).
       01  WS-CAP                      PIC 9(3)V99.
       01  WS-FEE                      PIC 9(5)V99.
       PROCEDURE DIVISION.
       0000-MAIN.
           OPEN INPUT LOAN-FILE OUTPUT LATE-FILE
           PERFORM 8000-READ
           PERFORM 2000-ASSESS UNTIL END-OF-FILE
           CLOSE LOAN-FILE LATE-FILE
           STOP RUN.
       2000-ASSESS.
           MOVE ZERO TO WS-FEE
           IF QL-MORTGAGE
               MOVE 15 TO WS-GRACE
               MOVE 150.00 TO WS-CAP
           ELSE
               MOVE 10 TO WS-GRACE
               MOVE 40.00 TO WS-CAP
           END-IF
           IF QL-DAYS-LATE NOT > WS-GRACE
               MOVE 'Y' TO QT-GRACE
               MOVE 'GRCE' TO QT-CODE
           ELSE
               MOVE 'N' TO QT-GRACE
               MOVE 'LATE' TO QT-CODE
               COMPUTE WS-FEE ROUNDED = QL-PAYMENT-DUE * 0.05
               IF QL-CARD AND WS-FEE < 15.00
                   MOVE 15.00 TO WS-FEE
               END-IF
               IF QL-PRIOR-LATE >= 3
                   ADD 10.00 TO WS-FEE
                   MOVE 'REPT' TO QT-CODE
               END-IF
               IF WS-FEE > WS-CAP
                   MOVE WS-CAP TO WS-FEE
                   MOVE 'CAPD' TO QT-CODE
               END-IF
           END-IF
           MOVE QL-LOAN-ID TO QT-LOAN-ID
           MOVE WS-FEE TO QT-LATE-FEE
           WRITE QT-REC
           PERFORM 8000-READ.
       8000-READ.
           READ LOAN-FILE AT END SET END-OF-FILE TO TRUE END-READ.
