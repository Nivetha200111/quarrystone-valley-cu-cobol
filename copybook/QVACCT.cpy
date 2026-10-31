      * QUARRYSTONE VALLEY CREDIT UNION - ENTIRELY FICTIONAL.
      * SYNTHETIC CODE AND DATA, WRITTEN FOR THE DIOCLE PROJECT.
      * NOT AFFILIATED WITH ANY REAL CREDIT UNION, BANK OR COMPANY.
      * MEMBER ACCOUNT EXTRACT (33 BYTES, LINE SEQUENTIAL)
       01  QA-REC.
           05  QA-ACCT-ID              PIC X(10).
           05  QA-BALANCE              PIC S9(9)V99
                                       SIGN LEADING SEPARATE.
           05  QA-RATE                 PIC 9V9(4).
           05  QA-DAYS                 PIC 9(3).
           05  QA-TIER                 PIC X.
               88  QA-TIER-PREMIUM     VALUE 'P'.
               88  QA-TIER-STUDENT     VALUE 'S'.
           05  QA-NSF-COUNT            PIC 9(2).
