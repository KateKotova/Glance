// NIJANUS  G l a n c e  2.2 : ... свой взгляд на мир ...
// Программа,
// написанная на языке программирования Delphi 6
// с использованием ресурсов OpenGL,
// моделирующая искажения трёхмерного пространства при сохранении всех значений параметров поверхности,
// параллельно переносимой относительно радиус-вектора фокуса
// в направлении начала координат
// в бицентрическом монофокусном полупространстве.
// Компания NIJANUS.
// Е.Котова, гр.443 РГРТУ, Рязань 2007.

// Форма информации о версии программы.
unit AboutGlanceForm_Unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TAboutGlanceForm = class(TForm)
    AuthorImage: TImage;
    StaticText1: TStaticText;
    StaticText3: TStaticText;
    StaticText2: TStaticText;
    StaticText4: TStaticText;
    SpeedButton1: TSpeedButton;
    StaticText5: TStaticText;
    Bevel1: TBevel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutGlanceForm: TAboutGlanceForm;

implementation

uses
  // Glance-модуль.
  Base_Unit;

{$R *.dfm}

procedure TAboutGlanceForm.FormCreate(Sender: TObject);
var
  BitMap: TBitMap;
begin
  BitMap:=TBitMap.Create;
  BitMap.LoadFromFile('AboutGlance.bmp');

  AuthorImage.Width:=BitMap.Width;
  AuthorImage.Height:=BitMap.Height;

  AuthorImage.Picture.Bitmap:=BitMap;
  BitMap.Free;

  // Размещение формы по центру рабочей области экрана.
  CentreScreenWorkAreaFormPosition(AboutGlanceForm);
end;

procedure TAboutGlanceForm.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

end.
