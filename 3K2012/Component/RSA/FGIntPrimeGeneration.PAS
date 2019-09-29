{License, info, etc
 ------------------

This implementation is made by Walied Othman, to contact me
mail to Walied.Othman@Student.KULeuven.ac.be or
Triade@ace.Ulyssis.Student.KULeuven.ac.be,
always mention wether it 's about the FGInt for Delphi or for
FreePascal, or wether it 's about the 6xs, preferably in the subject line.
If you 're going to use these implementations, at least mention my
name or something and notify me so I may even put a link on my page.
This implementation is freeware and according to the coderpunks'
manifesto it should remain so, so don 't use these implementations
in commercial software.  Encryption, as a tool to ensure privacy
should be free and accessible for anyone.  If you plan to use these
implementations in a commercial application, contact me before
doing so, that way you can license the software to use it in commercial
Software.  If any algorithm is patented in your country, you should
acquire a license before using this software.  Modified versions of this
software must contain an acknowledgement of the original author (=me).
This implementaion is available at
http://ace.ulyssis.student.kuleuven.ac.be/~triade/

copyright 2000, Walied Othman
This header may not be removed.
}

Unit FGIntPrimeGeneration;

Interface

Uses Windows, SysUtils, Controls, FGInt;

Procedure PrimeSearch(Var GInt : TFGInt);

Implementation


{$H+}


// Does an incremental search for primes starting from GInt,
// when one is found, it is stored in GInt

Procedure PrimeSearch(Var GInt : TFGInt);
Var
   temp, two : TFGInt;
   ok : Boolean;
Begin
   If (GInt.Number[1] Mod 2) = 0 Then GInt.Number[1] := GInt.Number[1] + 1;
   Base10StringToFGInt('2', two);
   ok := false;
   While Not ok Do
   Begin
      FGIntAdd(GInt, two, temp);
      FGIntCopy(temp, GInt);
      FGIntPrimeTest(GInt, 4, ok);
   End;
   FGIntDestroy(two);
End;

End.
