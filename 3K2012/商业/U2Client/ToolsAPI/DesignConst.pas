{ ********************************************************************** }
{                                                                        }
{ Delphi Open-Tools API                                                  }
{                                                                        }
{ Copyright (C) 2000, 2001 Borland Software Corporation                  }
{                                                                        }
{ ********************************************************************** }
unit DesignConst;

interface

resourcestring
  srNone = '(None)';
  srLine = 'line';
  srLines = 'lines';

  SInvalidFormat = 'Invalid graphic format';
  
  SUnableToFindComponent = 'Unable to locate form/component, ''%s''';
  SCantFindProperty = 'Unable to locate property ''%s'' on component ''%s''';
  SStringsPropertyInvalid = 'Property ''%s'' has not been initialized on component ''%s''';

  SLoadPictureTitle = 'Load Picture';
  SSavePictureTitle = 'Save Picture As';
  
  SAboutVerb = 'About...';
  SNoPropertyPageAvailable = 'No property pages are available for this control';
  SNoAboutBoxAvailable = 'An About Box is not available for this control';
  SNull = '(Null)';
  SUnassigned = '(Unassigned)';
  SUnknown = '(Unknown)';
  SString = 'String';

  SUnknownType = 'Unknown Type';

  SCannotCreateName = 'Cannot create a method for an unnamed component';

  SColEditCaption = 'Editing %s%s%s';

  SCantDeleteAncestor = 'Selection contains a component introduced in an ancestor form which cannot be deleted';
  SCantAddToFrame = 'New components cannot be added to frame instances.';

{$IFDEF LINUX}
  SAllFiles = 'All Files (*)|*';
{$ENDIF}
{$IFDEF MSWINDOWS}
  SAllFiles = 'All Files (*.*)|*.*';
{$ENDIF}

const
  SIniEditorsName = 'Property Editors';

implementation

end.
