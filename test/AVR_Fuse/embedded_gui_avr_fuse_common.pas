unit Embedded_GUI_AVR_Fuse_Common;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  FileUtil;

type

  { TFuseCheckBox }

  TFuseCheckBox = class(TCheckBox)
  private
    fMask: byte;
    function GetMask: byte;
  public
    property Mask: byte read GetMask write fMask;
  end;

  { TFuseComboBox }

  TFuseComboBox = class(TComboBox)
  private
    fMask: byte;
    fMasks: array of byte;
  public
    constructor Create(TheOwner: TComponent); override;
    property Mask: byte write fMask;
    procedure Add(const s: string; AMask: byte);
  end;

implementation

{ TFuseComboBox }

constructor TFuseComboBox.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  SetLength(fMasks, 0);
end;

procedure TFuseComboBox.Add(const s: string; AMask: byte);
var
  l: integer;
begin
  Items.Add(s);
  l := Length(fMasks);
  SetLength(fMasks, l + 1);
  fMasks[l] := AMask;
end;

{ TFuseCheckBox }

function TFuseCheckBox.GetMask: byte;
begin
  if Checked then begin
    Result := fMask;
  end else begin
    Result := 0;
  end;
end;

end.
