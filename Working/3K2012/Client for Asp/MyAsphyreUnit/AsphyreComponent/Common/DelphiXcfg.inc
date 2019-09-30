{$B-,J+,Q-,R-,T-,X+}

{$IFDEF VER100}
  // Delphi 3
  {$DEFINE DelphiX_Delphi3}
{$ENDIF}

{$IFDEF VER120}
  // Delphi 4
  {$DEFINE DelphiX_Delphi4}
{$ENDIF}

{$IFDEF VER140}
  // Delphi 6
  {$DEFINE DelphiX_Delphi5}
{$ENDIF}

{$IFDEF VER150}
  // Delphi 7
  {$DEFINE DelphiX_Delphi5}
{$ELSE}
  {$DEFINE DelphiX_Delphi5}
{$ENDIF}

{$IFDEF DelphiX_Delphi3}
  {$DEFINE DelphiX_Spt3}
{$ENDIF}

{$IFDEF DelphiX_Delphi4}
  {$DEFINE DelphiX_Spt3}
  {$DEFINE DelphiX_Spt4}
{$ENDIF}

{$IFDEF DelphiX_Delphi5}
  {$DEFINE DelphiX_Spt3}
  {$DEFINE DelphiX_Spt4}
  {$DEFINE DelphiX_Spt5}
{$ENDIF}

