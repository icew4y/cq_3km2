{*******************************************************************************

  WinHTTP v3.1

  Copyright (c) 1999-2004 UtilMind Solutions
  All rights reserved.
  E-Mail: info@utilmind.com
  WWW: http://www.utilmind.com, http://www.appcontrols.com

  The entire contents of this file is protected by International Copyright
Laws. Unauthorized reproduction, reverse-engineering, and distribution of all
or any portion of the code contained in this file is strictly prohibited and
may result in severe civil and criminal penalties and will be prosecuted to
the maximum extent possible under the law.

*******************************************************************************}
{$I WinHTTPDefines.inc}

unit _WinHTTPReg;

interface

procedure Register;

implementation

uses Windows, Classes, Controls, Forms,
     {$IFDEF D6}
     DesignIntf, DesignEditors,
     {$ELSE}
     DsgnIntf,
     {$ENDIF}
     WinHTTP, WinThread {$IFNDEF USEMINIMUM}, WinHTTPProxyEditor {$ENDIF};

{$IFNDEF USEMINIMUM}     
type
{*******************************************************************************
  Proxy structure PROPERTY editor for CustomWinHTTP
*******************************************************************************}
 { TWinHTTPProxyProperty }
  TWinHTTPProxyProperty = class(TClassProperty)
  public
    function GetValue: String; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

{ TWinHTTPProxyProperty Editor }
function TWinHTTPProxyProperty.GetValue: String;
begin
  Result := '(Proxy settings)';
end;

function TWinHTTPProxyProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog];
end;

procedure TWinHTTPProxyProperty.Edit;
var
  Component: TPersistent;
begin
  Component := GetComponent(0);
  ShowHTTPProxyDesigner(Designer, TCustomWinHTTP(Component).Proxy)
end;
{$ENDIF}

procedure Register;
begin
  RegisterComponents('UtilMind', [TWinHTTP, TWinThread]);
{$IFNDEF USEMINIMUM}
  RegisterPropertyEditor(TypeInfo(TWinHTTPProxy), TCustomWinHTTP, 'Proxy', TWinHTTPProxyProperty);
{$ENDIF}
end;

end.
