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

// Основная программа.
program Glance;

uses
  Forms,
  MainForm_Unit in 'MainForm_Unit.pas' {MainForm},
  Ellipsoid_Unit in 'Ellipsoid_Unit.pas' {TEllipsoid},
  FocalEllipsoid_Unit in 'FocalEllipsoid_Unit.pas' {TFocalEllipsoid},
  Surface_Unit in 'Surface_Unit.pas' {TSurface},
  ProjectionImage_Unit in 'ProjectionImage_Unit.pas' {Отображение проекций},
  GridsForm_Unit in 'GridsForm_Unit.pas' {GridsForm},
  Base_Unit in 'Base_Unit.pas',
  Files_Unit in 'Files_Unit.pas',
  Integration_Unit in 'Integration_Unit.pas',
  AboutGlanceForm_Unit in 'AboutGlanceForm_Unit.pas' {AboutGlanceForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'NIJANUS  G l a n c e  2.2.1';
  // Application.HelpFile := 'Help_Glance_2_2_1.chm';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutGlanceForm, AboutGlanceForm);
  Application.Run;
end.
