unit Utils;

interface

uses
  Windows,
  Messages,
  Controls,
  Classes,
  SysUtils, Vcl.Forms;

type
  TUtils = class
  private
  public

  end;

procedure ArredondarCantos(Control: TWinControl);
procedure CriarFormularioShowModal(T: TFormClass; F: TForm; iTag: Integer);
procedure CriarFormularioShow(T: TFormClass; F: TForm; iTag: Integer);
procedure CriarFormulario(T: TFormClass; F: TForm);

implementation

{ TUtils }

procedure ArredondarCantos(Control: TWinControl);
var
  R: TRect;
  Rgn: HRGN;
begin
  with Control do
  begin
    R := ClientRect;
    Rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 15, 15);
    Perform(EM_GETRECT, 0, lParam(@R));
    InflateRect(R, -4, -4);
    Perform(EM_SETRECTNP, 0, lParam(@R));
    SetWindowRgn(Handle, Rgn, True);
    Invalidate;
  end;
end;

procedure CriarFormulario(T: TFormClass; F: TForm);
begin
  Application.CreateForm(T, F);
end;

procedure CriarFormularioShowModal(T: TFormClass; F: TForm; iTag: Integer);
begin
  Application.CreateForm(T, F);
  F.Tag := iTag;
  F.ShowModal;
end;

procedure CriarFormularioShow(T: TFormClass; F: TForm; iTag: Integer);
begin
  Application.CreateForm(T, F);
  F.Tag := iTag;
  F.Show;

end;

end.
