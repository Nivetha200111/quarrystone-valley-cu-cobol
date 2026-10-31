      * QUARRYSTONE VALLEY CREDIT UNION - ENTIRELY FICTIONAL.
      * SYNTHETIC CODE AND DATA, WRITTEN FOR THE DIOCLE PROJECT.
      * NOT AFFILIATED WITH ANY REAL CREDIT UNION, BANK OR COMPANY.
      * LOAN PAYMENT STATUS (25 BYTES)
       01  QL-REC.
           05  QL-LOAN-ID              PIC X(10).
           05  QL-PAYMENT-DUE          PIC 9(7)V99.
           05  QL-DAYS-LATE            PIC 9(3).
           05  QL-PRIOR-LATE           PIC 9(2).
           05  QL-TYPE                 PIC X.
               88  QL-MORTGAGE         VALUE 'M'.
               88  QL-CARD             VALUE 'C'.
