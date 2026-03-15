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

// Обощающие процедуры и функции.
unit Integration_Unit;

interface

uses
  // Glance-модули.
  Base_Unit, Ellipsoid_Unit, FocalEllipsoid_Unit, Surface_Unit,
  // Стандартные модули.
  OpenGL, SysUtils, Buttons, Menus, StdCtrls, ComCtrls, Mask;

var
  // Цвет тумана.
  FogColor: array[1..4] of GLFloat;

  // Смещение курсора мыши при вращении объекта в трёхмерном пространстве.
  XPositionMouseButtonLeft, YPositionMouseButtonLeft: Single;
  // Угол вращения объекта в трёхмерном пространстве.
  XAngleMouseButtonLeft, YAngleMouseButtonLeft, ZAngleMouseButtonLeft: Single;
  // Угол поворота осей до начала вращения.
  XStartAngle, YStartAngle, ZStartAngle: Single;
  // Координатная плоскость, вращаемая при обзоре .
  StartRotationPlane: TStartRotationPlane;
  // Признак процесса вращения.
  bRotate: Boolean;


  // Масштаб (Удаление/приближение объекта в трёхмерном пространстве).
  Zoom: Word;
  // Признак отрисовки осей.
  bAxis: Boolean;

  // Предельный эллипсоид.
  LimitingEllipsoid: TEllipsoid;
  // Исходный фокусный эллипсоид.
  SourceFocalEllipsoid: TFocalEllipsoid;
  // Эллипсоид смещённого фокуса.
  DisplacedFocalEllipsoid: TFocalEllipsoid;

  // Пирзнак отрисовки хоть каких-нибудь центрофокусных линий.
  bAnyFocalLines: Boolean;

  // Исходная поверхность.
  SourceSurface: TSurface;
  // Смещённая поверхность.
  DisplacedSurface: TSurface;


// Отрисовка координатных осей.
procedure DrawAxis;
// Отрисовка центрофокусных линий эллипсоидов -
// линий соединения точек центров эллипсоидов с фокусомами.
procedure DrawFocalLines;
// Отрисовка зрительных центров и фокусов.
procedure DrawCentresAndFocuses;
// Установка принадлежности точек поверхностей зрительным областям.
procedure SetSurfacesPointsAreas;
// Установка цветов для объектов модели БМП.
procedure SetHalfSpaceColors;
// Сделать доступной и активизировать кнопку и связанный с ней пункт меню.
procedure EnbleAndActiveSpeedButtonAndManuItem(var SpeedButton: TSpeedButton;
                                               var MenuItem: TMenuItem);
// Доступная и отжатая кнопка и доступный и
// выбранный противоположно связанный с ней пункт меню.
procedure EnableAndUpSpeedButtonAndEnableAndCheckedManuItem(
  var HideSpeedButton: TSpeedButton;
  var ShowMenuItem: TMenuItem);

// Изменение неотображения поверхности:
// будучи неотображённым, он проявится, а, отображённый, он будут сокрыт.
procedure ChangeHidingSurface(
  var bSurfaceAnyDraw: Boolean;
  var HideSurfaceSpeedButton: TSpeedButton;
  var DrawSurfaceMenuItem: TMenuItem;

  var FloodedSurfaceSpeedButton,
      SurfaceFrameworkSpeedButton,
      SurfaceVertexSpeedButton: TSpeedButton;

  var FloodedSurfaceMenuItem,
      SurfaceFrameworkMenuItem,
      SurfaceVertexMenuItem: TMenuItem);

// Изменение неотображения линий каркаса эллипсоида:
// будучи неотображёнными, они проявятся, а, отображённые, они будут сокрыты.
procedure ChangeHidingEllipsoidFrameworkLines(
  var bEllipsoidAnyFrameworkLinesDraw: Boolean;
  var HideFrameworkSpeedButton: TSpeedButton;
  var FrameworkMenuItem: TMenuItem;

  var FrontalFrameworkSpeedButton,
      HorizontalFrameworkSpeedButton,
      VerticalFrameworkSpeedButton: TSpeedButton;

  var FrontalFrameworkMenuItem,
      HorizontalFrameworkMenuItem,
      VerticalFrameworkMenuItem: TMenuItem;

  var FrontalFrameworkEdit,
      HorizontalFrameworkEdit,
      VerticalFrameworkEdit: TEdit;

  var FrontalFrameworkUpDown,
      HorizontalFrameworkUpDown,
      VerticalFrameworkUpDown: TUpDown);

// Изменение отображения центрофокусных линий эллипсоида:
// будучи отображёнными, они сокроются, а, скрытые, они будут отображены.
procedure ChangeViewingEllipsoidFocalLines(
  var bAnyFocalLines,
      bFocalEllipsoidFocusLines: Boolean;
  var ThisFocalLinesSpeedButton,
      OtherFocalLinesSpeedButton: TSpeedButton;
  var DrawThisFocalLinesMenuItem,
      DrawFocalLinesMenuItem: TMenuItem;
  var HideFocalLinesSpeedButton: TSpeedButton);

// Изменение отображения пареллельных линий каркаса эллипсоида:
// будучи отображёнными, они сокроются, а, скрытые, они будут отображены.
procedure ChangeViewingEllipsoidParallelFrameworkLines(
  var bEllipsoidAnyFrameworkLinesDraw,
      bEllipsoidParallelFrameworkLinesDraw: Boolean;
  var ThisParallelFrameworkSpeedButton,
      FirstOtherParallelFrameworkSpeedButton,
      SecondOtherParallelFrameworkSpeedButton: TSpeedButton;
  var ParallelFrameworkMenuItem,
      FrameworkMenuItem: TMenuItem;
  var HideFrameworkSpeedButton: TSpeedButton;
  var ParallelFrameworkEdit: TEdit;
  var ParallelFrameworkUpDown: TUpDown);

// Изменение отображения элемента поверхности:
// будучи отображённым, он сокроется, а, скрытый, он будет отображён.
procedure ChangeViewingSurface(
  var bSurfaceAnyDraw,
      bSign: Boolean;
  var ThisSignSpeedButton,
      FirstOtherSignSpeedButton,
      SecondOtherSignSpeedButton: TSpeedButton;
  var SignMenuItem,
      DrawSurfaceMenuItem: TMenuItem;
  var HideSurfaceSpeedButton: TSpeedButton);

// Связывание действий объектов, отвечающих за конкретный признак:
// кнопки истинности признака, кнопки ложности признака и
// пункта меню истинности признака.
procedure Connect_SignButton_NotSignButton_SignMenuItem(
  var SignSpeedButton,
      NotSignSpeedButton: TSpeedButton;
  var SignMenuItem: TMenuItem;
  var bSign: Boolean);

// Преобразование угла наклона радиус-вектора фокуса к оси в диапазон (-180; 180].
procedure SetFocalEllipsoidFocusAngleInDegreesToRange(
  var FocusAngleMaskEdit: TMaskEdit;
  var NewFocusAngleInDegrees: Single);


  
implementation

uses
  // Glance-модуль.
  MainForm_Unit;


// Отрисовка координатных осей.
procedure DrawAxis;
begin // DrawAxis
  if bAxis=True
    then begin // if bAxis=True
           // Установка ширины линий.
           glLineWidth(EllipsoidVertexLineWidth);
           // Каждая пара точек рассматривается как независимый отрезок.
           glBegin(GL_LINES);
             // Отрицательные полуоси.
             with NegativeHalfAxisColorComponents do
               glColor4f(Red, Green, Blue, AlphaChannel);
             glVertex3f( 1,0, 0);
             glVertex3f( 0,0, 0);
             glVertex3f( 0,0,-1);
             glVertex3f( 0,0, 0);

             // Положительные полуоси.
             with PositiveHalfAxisColorComponents do
               glColor4f(Red, Green, Blue, AlphaChannel);
             glVertex3f( 0,0,0);
             glVertex3f( 0,1,0);
             glVertex3f( 0,0,0);
             glVertex3f(-1,0,0);
             glVertex3f( 0,0,0);
             glVertex3f( 0,0,1);
           glEnd();
         end; // if bAxis=True
end; // DrawAxis

// Отрисовка центрофокусных линий эллипсоидов -
// линий соединения точек центров эллипсоидов с фокусомами.
procedure DrawFocalLines;
begin // DrawFocalLines
  if bAnyFocalLines=True
    then begin // if bAnyFocalLines=True
           SourceFocalEllipsoid.DrawFocalLines(
             LeftCentreColorComponents,
             RightCentreColorComponents,
             FocusEllipsoidVectorCenterToFocusLineWidth,
             FocusEllipsoidFocusRadiusVectorLineWidth);

           DisplacedFocalEllipsoid.DrawFocalLines(
             LeftCentreColorComponents,
             RightCentreColorComponents,
             FocusEllipsoidVectorCenterToFocusLineWidth,
             FocusEllipsoidFocusRadiusVectorLineWidth);
         end; // if bAnyFocalLines=True
end; // DrawFocalLines

// Отрисовка зрительных центров и фокусов.
procedure DrawCentresAndFocuses;
begin // DrawCentresAndFocuses
  // Установка размера точек.
  glPointSize(EllipsoidCentresPointSize);
  // Каждая вершина рассматривается как отдельная точка.
  glBegin(GL_POINTS);
    // Левый зрительный центр.
    with LeftCentreColorComponents do
      glColor4f(Red, Green, Blue, AlphaChannel);
    with LimitingEllipsoid.DefiningParameters.Centres.LeftCoordinates do
      glVertex3f(-X,Y,Z);

    // Правый зрительный центр.
    with RightCentreColorComponents do
      glColor4f(Red, Green, Blue, AlphaChannel);
    with LimitingEllipsoid.DefiningParameters.Centres.RightCoordinates do
       glVertex3f(-X,Y,Z);
  glEnd();

  // Установка размера точек.
  glPointSize(FocusEllipsoidFocusPointSize);
  // Каждая вершина рассматривается как отдельная точка.
  glBegin(GL_POINTS);
    // Точка исходного фокуса.
    with SourceFocalEllipsoidFocusColorComponents do
      glColor4f(Red, Green, Blue, AlphaChannel);
    with SourceFocalEllipsoid.Focus.Coordinates do
      glVertex3f(-X,Y,Z);

    // Точка смещённого фокуса.
    with DisplacedFocalEllipsoidFocusColorComponents do
      glColor4f(Red, Green, Blue, AlphaChannel);
    with DisplacedFocalEllipsoid.Focus.Coordinates do
      glVertex3f(-X,Y,Z);
  glEnd();
end; // DrawCentresAndFocuses

// Установка принадлежности точек поверхностей зрительным областям.
procedure SetSurfacesPointsAreas;
var
// Параметры циклов.
  i, j: Byte;
begin // SetSurfacesPointsAreas
  for i:=1 to SourceSurface.NumberPointsRows do
    for j:=1 to SourceSurface.NumberPointsColumns do
      begin //  for j
        // Установка принадлежности точки конкретной зрительной области.
        SourceSurface.SetColoredPointArea(
          SourceSurface.GridColoredPoints[i]^[j]^,
          SourceFocalEllipsoid);

        DisplacedSurface.GridColoredPoints[i]^[j]^.Area:=
          SourceSurface.GridColoredPoints[i]^[j]^.Area;

        if SourceSurface.GridColoredPoints[i]^[j]^.Area=RightCenterArea
          // Если точка находится в области правого зрительного центра.
          then begin
                 SourceSurface.GridColoredPoints[i]^[j]^.ColorComponents:=
                   SourceSurfaceRightCenterAreaColorComponents;
                 DisplacedSurface.GridColoredPoints[i]^[j]^.ColorComponents:=
                   DisplacedSurfaceRightCenterAreaColorComponents;
               end // if then

          // Если точка находится в области левого зрительного центра.
          else if SourceSurface.GridColoredPoints[i]^[j]^.Area=LeftCenterArea
                  then begin
                         SourceSurface.GridColoredPoints[i]^[j]^.ColorComponents:=
                           SourceSurfaceLeftCenterAreaColorComponents;
                         DisplacedSurface.GridColoredPoints[i]^[j]^.ColorComponents:=
                           DisplacedSurfaceLeftCenterAreaColorComponents;
                       end  // else if then

                  // Если точка находится в области начала координат.
                  else begin
                         SourceSurface.GridColoredPoints[i]^[j]^.ColorComponents:=
                           SourceSurfaceOOOAreaColorComponents;
                         DisplacedSurface.GridColoredPoints[i]^[j]^.ColorComponents:=
                           DisplacedSurfaceOOOAreaColorComponents;
                       end; // else if else
      end; //  for j
end; // SetSurfacesPointsAreas

// Установка цветов для объектов модели БМП.
procedure SetHalfSpaceColors;
begin // SetHalfSpaceColors
  // Задание компонент цвета
  // фронтальных, горизонтальных и вертикальных
  // линий каркаса предельного эллипсоида.
  LimitingEllipsoid.FrameworkLinesIn1Octant.Frontal.VertexColorComponents:=
    LimitingEllipsoidFrontalFrameworkLinesColorComponents;
  LimitingEllipsoid.FrameworkLinesIn1Octant.Vertical.VertexColorComponents:=
    LimitingEllipsoidVerticalFrameworkLinesColorComponents;
  LimitingEllipsoid.FrameworkLinesIn1Octant.Horizontal.VertexColorComponents:=
    LimitingEllipsoidHorizontalFrameworkLinesColorComponents;

  // Задание компонент цвета
  // фронтальных, горизонтальных и вертикальных
  // линий каркаса исходного фокусного эллипсоида.
  SourceFocalEllipsoid.FrameworkLinesIn1Octant.Frontal.VertexColorComponents:=
    SourceFocalEllipsoidFrontalFrameworkLinesColorComponents;
  SourceFocalEllipsoid.FrameworkLinesIn1Octant.Vertical.VertexColorComponents:=
    SourceFocalEllipsoidVerticalFrameworkLinesColorComponents;
  SourceFocalEllipsoid.FrameworkLinesIn1Octant.Horizontal.VertexColorComponents:=
    SourceFocalEllipsoidHorizontalFrameworkLinesColorComponents;

  // Задание компонент цвета
  // фронтальных, горизонтальных и вертикальных
  // линий каркаса эллипсоида смещённого фокуса.
  DisplacedFocalEllipsoid.FrameworkLinesIn1Octant.Frontal.VertexColorComponents:=
    DisplacedFocalEllipsoidFrontalFrameworkLinesColorComponents;
  DisplacedFocalEllipsoid.FrameworkLinesIn1Octant.Vertical.VertexColorComponents:=
    DisplacedFocalEllipsoidVerticalFrameworkLinesColorComponents;
  DisplacedFocalEllipsoid.FrameworkLinesIn1Octant.Horizontal.VertexColorComponents:=
    DisplacedFocalEllipsoidHorizontalFrameworkLinesColorComponents;

  // Задание компонент цвета точки фокуса исходного фокусного эллипсоида.
  SourceFocalEllipsoid.Focus.FocusColorComponents:=
    SourceFocalEllipsoidFocusColorComponents;
  // Задание компонент цвета точки фокуса смещённого фокусного эллипсоида.
  DisplacedFocalEllipsoid.Focus.FocusColorComponents:=
    DisplacedFocalEllipsoidFocusColorComponents;
end; // SetHalfSpaceColors

// Сделать доступной и активизировать кнопку и связанный с ней пункт меню.
procedure EnbleAndActiveSpeedButtonAndManuItem(var SpeedButton: TSpeedButton;
                                               var MenuItem: TMenuItem);
begin // ActuateSpeedButtonAndManuItem
  SpeedButton.Enabled:=True;
  MenuItem.Enabled:=True;

  SpeedButton.Down:=True;
  MenuItem.Checked:=True;
end; // ActuateSpeedButtonAndManuItem

// Доступная и отжатая кнопка и доступный и
// выбранный противоположно связанный с ней пункт меню.
procedure EnableAndUpSpeedButtonAndEnableAndCheckedManuItem(
  var HideSpeedButton: TSpeedButton;
  var ShowMenuItem: TMenuItem);

begin // ActuateSpeedButtonAndManuItem
  HideSpeedButton.Enabled:=True;
  ShowMenuItem.Enabled:=True;

  HideSpeedButton.Down:=False;
  ShowMenuItem.Checked:=True;
end; // ActuateSpeedButtonAndManuItem


// Изменение неотображения поверхности:
// будучи неотображённым, он проявится, а, отображённый, он будут сокрыт.
procedure ChangeHidingSurface(
  var bSurfaceAnyDraw: Boolean;
  var HideSurfaceSpeedButton: TSpeedButton;
  var DrawSurfaceMenuItem: TMenuItem;

  var FloodedSurfaceSpeedButton,
      SurfaceFrameworkSpeedButton,
      SurfaceVertexSpeedButton: TSpeedButton;

  var FloodedSurfaceMenuItem,
      SurfaceFrameworkMenuItem,
      SurfaceVertexMenuItem: TMenuItem);

  // bSurfaceAnyDraw - признак отрисовки поверхности.
  // HideSurfaceSpeedButton - кнопка, управляющая сокрытием поверхности.
  // DrawSurfaceMenuItem - пункт меню, управляющий отображением поверхности.

  // FloodedSurfaceSpeedButton - кнопка, управляющая отображением сплошной заливки поверхности.
  // SurfaceFrameworkSpeedButton - кнопка, управляющая отображением линий каркаса поверхности.
  // SurfaceVertexSpeedButton - кнопка, управляющая отображением вершин поверхности.

  // FloodedSurfaceSpeedButton - пункт меню, управляющий отображением сплошной заливки поверхности.
  // SurfaceFrameworkSpeedButton - пункт меню, управляющий отображением линий каркаса поверхности.
  // SurfaceVertexSpeedButton - пункт меню, управляющий отображением вершин поверхности.

begin // ChangeHidingSurface
  // Разрешения на отображение поверхности
  // у кнопки и пункта меню противоположные.
  DrawSurfaceMenuItem.Checked:=not DrawSurfaceMenuItem.Checked;
  if DrawSurfaceMenuItem.Checked=True
    then HideSurfaceSpeedButton.Down:=False
    else HideSurfaceSpeedButton.Down:=True;

  if HideSurfaceSpeedButton.Down=True
    then begin
           bSurfaceAnyDraw:=False;

           FloodedSurfaceSpeedButton.Enabled:=False;
           SurfaceFrameworkSpeedButton.Enabled:=False;
           SurfaceVertexSpeedButton.Enabled:=False;

           FloodedSurfaceMenuItem.Enabled:=False;
           SurfaceFrameworkMenuItem.Enabled:=False;
           SurfaceVertexMenuItem.Enabled:=False;
         end // if HideFrameworkSpeedButton.Down=True then

    else begin
           bSurfaceAnyDraw:=True;
           FloodedSurfaceSpeedButton.Enabled:=True;
           SurfaceFrameworkSpeedButton.Enabled:=True;
           SurfaceVertexSpeedButton.Enabled:=True;

           FloodedSurfaceMenuItem.Enabled:=True;
           SurfaceFrameworkMenuItem.Enabled:=True;
           SurfaceVertexMenuItem.Enabled:=True;
         end;  // if HideFrameworkSpeedButton.Down=True else

  MainForm.Repaint;
end; // ChangeHidingSurface

// Изменение неотображения линий каркаса эллипсоида:
// будучи неотображёнными, они проявятся, а, отображённые, они будут сокрыты.
procedure ChangeHidingEllipsoidFrameworkLines(
  var bEllipsoidAnyFrameworkLinesDraw: Boolean;
  var HideFrameworkSpeedButton: TSpeedButton;
  var FrameworkMenuItem: TMenuItem;

  var FrontalFrameworkSpeedButton,
      HorizontalFrameworkSpeedButton,
      VerticalFrameworkSpeedButton: TSpeedButton;

  var FrontalFrameworkMenuItem,
      HorizontalFrameworkMenuItem,
      VerticalFrameworkMenuItem: TMenuItem;

  var FrontalFrameworkEdit,
      HorizontalFrameworkEdit,
      VerticalFrameworkEdit: TEdit;

  var FrontalFrameworkUpDown,
      HorizontalFrameworkUpDown,
      VerticalFrameworkUpDown: TUpDown);

  // bEllipsoidAnyFrameworkLinesDraw - признак отображения линий каркаса эллипсоида.
  // HideFrameworkSpeedButton - кнопка, управляющая неотображением линий каркаса эллипсоида.
  // FrameworkMenuItem - пункт меню, управляющий отображением линий каркаса эллипсоида.

  // FrontalFrameworkSpeedButton - кнопка, управляющая отображением фронтальных линий каркаса эллипсоида.
  // HorizontalFrameworkSpeedButton - кнопка, управляющая отображением горизонтальных линий каркаса эллипсоида.
  // VerticalFrameworkSpeedButton - кнопка, управляющая отображением вертикальных линий каркаса эллипсоида.

  // FrontalFrameworkMenuItem - пункт меню, управляющий отображением фронтальных линий каркаса эллипсоида.
  // HorizontalFrameworkMenuItem - пункт меню, управляющий отображением горизонтальных линий каркаса эллипсоида.
  // VerticalFrameworkMenuItem - пункт меню, управляющий отображением вертикальных линий каркаса эллипсоида.

  // FrontalFrameworkEdit - поле, редактирующее количество фронтальных линий каркаса эллипсоида.
  // HorizontalFrameworkEdit - поле, редактирующее количество горизонтальных линий каркаса эллипсоида.
  // VerticalFrameworkEdit - поле, редактирующее количество вертикальных линий каркаса эллипсоида.

  // FrontalFrameworkUpDown - кнопки, редактирующие количество фронтальных линий каркаса эллипсоида.
  // HorizontalFrameworkUpDown - кнопки, редактирующие количество горизонтальных линий каркаса эллипсоида.
  // VerticalFrameworkUpDown - кнопки, редактирующие количество вертикальных линий каркаса эллипсоида.

begin // ChangeHidingEllipsoidFrameworkLines
  // Разрешения на отображение каркаса
  // у кнопки и пункта меню противоположные.
  FrameworkMenuItem.Checked:=not FrameworkMenuItem.Checked;
  if FrameworkMenuItem.Checked=True
    then HideFrameworkSpeedButton.Down:=False
    else HideFrameworkSpeedButton.Down:=True;

  if HideFrameworkSpeedButton.Down=True
    then begin
           bEllipsoidAnyFrameworkLinesDraw:=False;

           FrontalFrameworkSpeedButton.Enabled:=False;
           HorizontalFrameworkSpeedButton.Enabled:=False;
           VerticalFrameworkSpeedButton.Enabled:=False;

           FrontalFrameworkMenuItem.Enabled:=False;
           HorizontalFrameworkMenuItem.Enabled:=False;
           VerticalFrameworkMenuItem.Enabled:=False;

           FrontalFrameworkEdit.Enabled:=False;
           HorizontalFrameworkEdit.Enabled:=False;
           VerticalFrameworkEdit.Enabled:=False;

           FrontalFrameworkUpDown.Enabled:=False;
           HorizontalFrameworkUpDown.Enabled:=False;
           VerticalFrameworkUpDown.Enabled:=False;
         end // if HideFrameworkSpeedButton.Down=True then
    else begin
           bEllipsoidAnyFrameworkLinesDraw:=True;
           FrontalFrameworkSpeedButton.Enabled:=True;
           HorizontalFrameworkSpeedButton.Enabled:=True;
           VerticalFrameworkSpeedButton.Enabled:=True;

           FrontalFrameworkMenuItem.Enabled:=True;
           HorizontalFrameworkMenuItem.Enabled:=True;
           VerticalFrameworkMenuItem.Enabled:=True;

           if FrontalFrameworkSpeedButton.Down = True
             then begin
                    FrontalFrameworkEdit.Enabled:=True;
                    FrontalFrameworkUpDown.Enabled:=True;
                  end;

           if HorizontalFrameworkSpeedButton.Down = True
             then begin
                    HorizontalFrameworkEdit.Enabled:=True;
                    HorizontalFrameworkUpDown.Enabled:=True;
                  end;

           if VerticalFrameworkSpeedButton.Down = True
             then begin
                    VerticalFrameworkEdit.Enabled:=True;
                    VerticalFrameworkUpDown.Enabled:=True;
                  end;
         end;  // if HideFrameworkSpeedButton.Down=True else

  MainForm.Repaint;
end; // ChangeHidingEllipsoidFrameworkLines

// Изменение отображения центрофокусных линий эллипсоида:
// будучи отображёнными, они сокроются, а, скрытые, они будут отображены.
procedure ChangeViewingEllipsoidFocalLines(
  var bAnyFocalLines,
      bFocalEllipsoidFocusLines: Boolean;
  var ThisFocalLinesSpeedButton,
      OtherFocalLinesSpeedButton: TSpeedButton;
  var DrawThisFocalLinesMenuItem,
      DrawFocalLinesMenuItem: TMenuItem;
  var HideFocalLinesSpeedButton: TSpeedButton);

  // bAnyFocalLines - признак отображения центрофокусных линий.
  // bFocalEllipsoidFocusLines - признак отображения центрофокусных линий данного эллипсоида.
  // ThisFocalLinesSpeedButton - кнопка, управляющая отображением центрофокусных линий данного эллипсоида.
  // OtherFocalLinesSpeedButton - кнопка, управляющая отображением центрофокусных линий другого эллипсоида.
  // DrawThisFocalLinesMenuItem - пункт меню, управляющий отображением центрофокусных линий данного эллипсоида.
  // DrawFocalLinesMenuItem - пункт меню, управляющий отображением центрофокусных линий.
  // HideFocalLinesSpeedButton - кнопка, управляющая сокрытием центрофокусных линий.

begin // ChangeViewingEllipsoidFocalLines
  DrawThisFocalLinesMenuItem.Checked:=not DrawThisFocalLinesMenuItem.Checked;
  if DrawThisFocalLinesMenuItem.Checked=True
    then ThisFocalLinesSpeedButton.Down:=True
    else ThisFocalLinesSpeedButton.Down:=False;

  if ThisFocalLinesSpeedButton.Down=True
    then begin
           bFocalEllipsoidFocusLines:=True;
           if (OtherFocalLinesSpeedButton.Down=False)
             then begin
                    bAnyFocalLines:=True;
                    DrawFocalLinesMenuItem.Enabled:=True;
                    HideFocalLinesSpeedButton.Enabled:=True;
                  end;
         end // than
    else begin
           bFocalEllipsoidFocusLines:=False;
           if (OtherFocalLinesSpeedButton.Down=False)
             then begin
                    bAnyFocalLines:=False;
                    DrawFocalLinesMenuItem.Enabled:=False;
                    HideFocalLinesSpeedButton.Enabled:=False;
                  end;
         end; // else

  MainForm.Repaint;
end; // ChangeViewingEllipsoidFocalLines

// Изменение отображения пареллельных линий каркаса эллипсоида:
// будучи отображёнными, они сокроются, а, скрытые, они будут отображены.
procedure ChangeViewingEllipsoidParallelFrameworkLines(
  var bEllipsoidAnyFrameworkLinesDraw,
      bEllipsoidParallelFrameworkLinesDraw: Boolean;
  var ThisParallelFrameworkSpeedButton,
      FirstOtherParallelFrameworkSpeedButton,
      SecondOtherParallelFrameworkSpeedButton: TSpeedButton;
  var ParallelFrameworkMenuItem,
      FrameworkMenuItem: TMenuItem;
  var HideFrameworkSpeedButton: TSpeedButton;
  var ParallelFrameworkEdit: TEdit;
  var ParallelFrameworkUpDown: TUpDown);

  // bEllipsoidAnyFrameworkLinesDraw - признак отображения линий каркаса эллипсоида.
  // bEllipsoidParallelFrameworkLinesDraw - признак отображения параллельных линий каркаса эллипсоида.
  // ThisParallelFrameworkSpeedButton - кнопка, управляющая отображением данных параллельных линий каркаса эллипсоида.
  // FirstOtherParallelFrameworkSpeedButton - кнопка, управляющая отображением других параллельных линий каркаса эллипсоида.
  // SecondOtherParallelFrameworkSpeedButton - кнопка, управляющая отображением других параллельных линий каркаса эллипсоида.
  // ParallelFrameworkMenuItem - пункт меню, управляющий отображением данных параллельных линий каркаса эллипсоида.
  // FrameworkMenuItem - пункт меню, управляющий отображением линий каркаса эллипсоида.
  // HideFrameworkSpeedButton - кнопка, управляющая сокрытием линий каркаса эллипсоида.
  // ParallelFrameworkEdit - поле, редактирующее количество параллельных линий каркаса эллипсоида.
  // ParallelFrameworkUpDown - кнопки, редактирующие количество параллельных линий каркаса эллипсоида.

begin // ChangeViewingEllipsoidParallelFrameworkLines
  ParallelFrameworkMenuItem.Checked:=not ParallelFrameworkMenuItem.Checked;
  if ParallelFrameworkMenuItem.Checked=True
    then ThisParallelFrameworkSpeedButton.Down:=True
    else ThisParallelFrameworkSpeedButton.Down:=False;

  if ThisParallelFrameworkSpeedButton.Down=True
    then begin
           bEllipsoidParallelFrameworkLinesDraw:=True;
           if (FirstOtherParallelFrameworkSpeedButton.Down=False) and
                (SecondOtherParallelFrameworkSpeedButton.Down=False)
             then begin
                    bEllipsoidAnyFrameworkLinesDraw:=True;
                    FrameworkMenuItem.Enabled:=True;
                    HideFrameworkSpeedButton.Enabled:=True;
                  end;
            ParallelFrameworkEdit.Enabled:=True;
            ParallelFrameworkUpDown.Enabled:=True;
         end // than
    else begin
           bEllipsoidParallelFrameworkLinesDraw:=False;
           if (FirstOtherParallelFrameworkSpeedButton.Down=False) and
                (SecondOtherParallelFrameworkSpeedButton.Down=False)
             then begin
                    bEllipsoidAnyFrameworkLinesDraw:=False;
                    FrameworkMenuItem.Enabled:=False;
                    HideFrameworkSpeedButton.Enabled:=False;
                  end;
           ParallelFrameworkEdit.Enabled:=False;
           ParallelFrameworkUpDown.Enabled:=False;
         end; // else

  MainForm.Repaint;
end; // ChangeViewingEllipsoidParallelFrameworkLines

// Изменение отображения элемента поверхности:
// будучи отображённым, он сокроется, а, скрытый, он будет отображён.
procedure ChangeViewingSurface(
  var bSurfaceAnyDraw,
      bSign: Boolean;
  var ThisSignSpeedButton,
      FirstOtherSignSpeedButton,
      SecondOtherSignSpeedButton: TSpeedButton;
  var SignMenuItem,
      DrawSurfaceMenuItem: TMenuItem;
  var HideSurfaceSpeedButton: TSpeedButton);

  // bSurfaceAnyDraw - признак отрисовки поверхности.
  // ThisSignSpeedButton - кнопка, управляющая отображением данного элемента поверхности.
  // FirstOtherSignSpeedButton - кнопка, управляющая отображением другого элемента поверхности.
  // SecondOtherSignSpeedButton - кнопка, управляющая отображением другого элемента поверхности.
  // SignMenuItem - пункт меню, управляющий отображением данного элемента поверхности.
  // DrawSurfaceMenuItem - пункт меню, управляющий отображением поверхности.
  // HideSurfaceSpeedButton - кнопка, управляющая сокрытием поверхности.

begin // ChangeViewingSurface
  SignMenuItem.Checked:=not SignMenuItem.Checked;
  if SignMenuItem.Checked=True
    then ThisSignSpeedButton.Down:=True
    else ThisSignSpeedButton.Down:=False;

  if ThisSignSpeedButton.Down=True
    then begin
           bSign:=True;
           if (FirstOtherSignSpeedButton.Down=False) and
                (SecondOtherSignSpeedButton.Down=False)
             then begin
                    bSurfaceAnyDraw:=True;
                    DrawSurfaceMenuItem.Enabled:=True;
                    HideSurfaceSpeedButton.Enabled:=True;
                  end;
         end // than
    else begin
           bSign:=False;
           if (FirstOtherSignSpeedButton.Down=False) and
                (SecondOtherSignSpeedButton.Down=False)
             then begin
                    bSurfaceAnyDraw:=False;
                    DrawSurfaceMenuItem.Enabled:=False;
                    HideSurfaceSpeedButton.Enabled:=False;
                  end;
         end; // else

  MainForm.Repaint;
end; // ChangeViewingSurface

// Связывание действий объектов, отвечающих за конкретный признак:
// кнопки истинности признака, кнопки ложности признака и
// пункта меню истинности признака.
procedure Connect_SignButton_NotSignButton_SignMenuItem(
  var SignSpeedButton,
      NotSignSpeedButton: TSpeedButton;
  var SignMenuItem: TMenuItem;
  var bSign: Boolean);
// SignSpeedButton - кнопка истинности признака.
// NotSignSpeedButton - кнопка ложности признака.
// SignMenuItem - пункт меню истинности признака.
// bSign - конкретный признак.

begin // Connect_SignButton_NotSignButton_SignMenuItem
  SignMenuItem.Checked:=not SignMenuItem.Checked;
  if SignMenuItem.Checked=True
    then begin
           SignSpeedButton.Down:=True;
           NotSignSpeedButton.Down:=False;
         end
    else begin
           SignSpeedButton.Down:=False;
           NotSignSpeedButton.Down:=True;
         end;

  if SignSpeedButton.Down=True
    then bSign:=True
    else bSign:=False;

  MainForm.Repaint;
end; // Connect_SignButton_NotSignButton_SignMenuItem

// Преобразование угла наклона радиус-вектора фокуса к оси в диапазон (-180; 180].
procedure SetFocalEllipsoidFocusAngleInDegreesToRange(
  var FocusAngleMaskEdit: TMaskEdit;
  var NewFocusAngleInDegrees: Single);
// FocusAngleMaskEdit - поле ввода значения угла наклона радиус-вектора фокуса к оси.
// NewFocusAngleInDegrees - новое значение угла наклона радиус-вектора фокуса к оси.

begin // SetFocalEllipsoidFocusAngleInDegreesToRange
  // Удаление пробелов в тексте.
  DelMaskEditTextGaps(FocusAngleMaskEdit);
  NewFocusAngleInDegrees:=StrToFloat(FocusAngleMaskEdit.Text);

  NewFocusAngleInDegrees:=(Trunc(NewFocusAngleInDegrees*100) mod 36000)/100;

  if NewFocusAngleInDegrees<=-180
    then NewFocusAngleInDegrees:=NewFocusAngleInDegrees+360;
  if NewFocusAngleInDegrees>180
    then NewFocusAngleInDegrees:=NewFocusAngleInDegrees-360;
end; // SetFocalEllipsoidFocusAngleInDegreesToRange

end.
