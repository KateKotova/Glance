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

// Построение проекций фокусов и эллипсоидов на координатные плоскости.
unit ProjectionImage_Unit;

interface

uses
  Graphics, ExtCtrls;

const
  // Высота образа прекции.
  ProjectionImageHeight = 90;
  // Ширина образа прекции.
  ProjectionImageWidth = 90;
  // Ширина отрезка оси, выходящего за пределы изображения.
  ProjectionAxisBorderWidth = 5;


  // Цвет фона проекции.
  ProjectionBackGroundColor = $00701B28;
  // Цвет отрицательных координатных полуосей.
  NegativeHalfAxisColor = $0000FF00;
  // Цвет положительных координатных полуосей.
  PositiveHalfAxisColor = $0000FFFF;
  // Цвет левого зрительного центра.
  LeftCentreColor = $0096FF96;
  // Цвет правого зрительного центра.
  RightCentreColor = $006FFFFF;
  // Цвет линий ограничения области между зрительными центрами.
  BetweenCentresAreaBorderLinesColor = $00808080;
  // Цвет точки фокуса исходного фокусного эллипсоида.
  SourceFocalEllipsoidFocusColor = $000000FF;
  // Цвет точки фокуса смещённого фокусного эллипсоида.
  DisplacedFocalEllipsoidFocusColor = $000080FF;

  // Цвет фронтальных, горизонтальных и вертикальных
  // линий каркаса предельного эллипсоида.
  LimitingEllipsoidVerticalFrameworkLinesColor = $009E3479;
  LimitingEllipsoidHorizontalFrameworkLinesColor = $00965271;
  LimitingEllipsoidFrontalFrameworkLinesColor = $00B77382;

  // Цвет фронтальных, горизонтальных и вертикальных
  // линий каркаса исходного фокусного эллипсоида.
  SourceFocalEllipsoidVerticalFrameworkLinesColor = $00FF2A3E;
  SourceFocalEllipsoidHorizontalFrameworkLinesColor = $00FF5C5E;
  SourceFocalEllipsoidFrontalFrameworkLinesColor = $00FF8E8E;

  // Цвет фронтальных, горизонтальных и вертикальных
  // линий каркаса эллипсоида смещённого фокуса.
  DisplacedFocalEllipsoidVerticalFrameworkLinesColor = $00AEAE00;
  DisplacedFocalEllipsoidHorizontalFrameworkLinesColor = $00DFDF00;
  DisplacedFocalEllipsoidFrontalFrameworkLinesColor = $00FFFF22;

var
  // Половина высоты образа проекции.
  ProjectionImageHalfHeight: Byte;
  // Половина ширины образа проекции.
  ProjectionImageHalfWidth: BYte;

  // Побитовое отображение фронтальной проекции.
  FrontalProjectionBitMap: TBitMap;
  // Побитовое отображение горизонтальной проекции.
  HorizontalProjectionBitMap: TBitMap;
  // Побитовое отображение вертикальной проекции.
  VerticalProjectionBitMap: TBitMap;

  // Коэффициент количества процентов области отображения пространтсва в пикселе.
  ScaleFactorPercentsInPixel: Single;
  // Половина межцентрового расстояние эллипсоида в пикселях.
  HalfBetweenDistanceInPixels: Byte;


// Фон проекций.
procedure DrawProjectionBitMapBackGrounds;
// Создание побитовых образов проекций.
procedure CreateProjectionBitMaps;
// Освобождение памяти от побитовых образов проекций.
procedure FreeProjectionBitMaps;
// Отрисовка координатных осей.
procedure DrawAxisProjection;
// Расчёт коэффициента количества процентов
// области отображения пространтсва в пикселе.
procedure SetScaleFactorPercentsInPixel(    LengthInPrecents: Single;
                                            LengthInPixels: Byte;
                                        var ScaleFactorPercentsInPixel: Single);
// Отрисовка зрительных центров и фокусов.
procedure DrawCentresProjection;{(HalfBetweenDistanceInPercents: Single);}
// Отрисовка линий ограничения области между зрительными центрами.
procedure DrawBetweenCentresAreaBorderLinesProjection;
// Отрисовка фокуса.
procedure DrawFocusProjection(XFocusInPixels,YFocusInPixels,ZFocusInPixels: SmallInt;
                              FocalEllipsoidFocusColor: TColor);
// Отрисовка проекций эллипсоида.
procedure DrawEllipsoidProjection(XRadiusInPixels,YRadiusInPixels,ZRadiusInPixels: SmallInt;
                                  EllipsoidFrontalFrameworkLinesColor,
                                  EllipsoidHorizontalFrameworkLinesColor,
                                  EllipsoidVerticalFrameworkLinesColor: TColor);

// Отрисовка проекций одного эллипсоида.
procedure DrawSingleEllipsoidProjection(    EllipsoidXRadiusInPercents,
                                            EllipsoidYRadiusInPercents,
                                            EllipsoidZRadiusInPercents,
                                            HalfBetweenDistanceInPercents,
                                            XFocusInPercents,
                                            YFocusInPercents,
                                            ZFocusInPercents: Single;
                                            EllipsoidName: String;

                                        var FrontalProjectionImage,
                                            HorizontalProjectionImage,
                                            VerticalProjectionImage: TImage);

// Отрисовка проекций фокусных эллипсоидов.
procedure DrawFocalEllipsoidsProjection(    SourceFocalEllipsoidXRadiusInPercents,
                                            SourceFocalEllipsoidYRadiusInPercents,
                                            SourceFocalEllipsoidZRadiusInPercents,

                                            DisplacedFocalEllipsoidXRadiusInPercents,
                                            DisplacedFocalEllipsoidYRadiusInPercents,
                                            DisplacedFocalEllipsoidZRadiusInPercents,

                                            HalfBetweenDistanceInPercents,

                                            XSourceFocusInPercents,
                                            YSourceFocusInPercents,
                                            ZSourceFocusInPercents,

                                            XDisplacedFocusInPercents,
                                            YDisplacedFocusInPercents,
                                            ZDisplacedFocusInPercents: Single;

                                        var FrontalProjectionImage,
                                            HorizontalProjectionImage,
                                            VerticalProjectionImage: TImage);

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

implementation

uses
  // Glance-модуль.
  Base_Unit;


// Фон проекций.
procedure DrawProjectionBitMapBackGrounds;

  // Фон проекции.
  procedure DrawProjectionBitMapBackGround(var ProjectionBitMap: TBitMap);
  begin  // DrawProjectionBitMapBackGround
    // Отсутствие линии.
    ProjectionBitMap.Canvas.Pen.Style:=psClear;
    // Сплошное заполнение.
    ProjectionBitMap.Canvas.Brush.Style:=bsSolid;
    // Цвет фона проекции.
    ProjectionBitMap.Canvas.Brush.Color:=ProjectionBackGroundColor;
    // Заполнение прямоугольной области всего побитового отображения.
    ProjectionBitMap.Canvas.FillRect(ProjectionBitMap.Canvas.ClipRect);
  end; // DrawProjectionBitMapBackGround

begin // DrawProjectionBitMapBackGrounds
  // Фон проекции.
  DrawProjectionBitMapBackGround(FrontalProjectionBitMap);
  DrawProjectionBitMapBackGround(HorizontalProjectionBitMap);
  DrawProjectionBitMapBackGround(VerticalProjectionBitMap);
end; // DrawProjectionBitMapBackGrounds

// Создание побитовых образов проекций.
procedure CreateProjectionBitMaps;

 // Выделение памяти под побитовый образ проекции.
  procedure CreateProjectionBitMap(var ProjectionBitMap: TBitMap);
  begin // CreateProjectionBitMap
    ProjectionBitMap:=TBitMap.Create;
    ProjectionBitMap.Width:=ProjectionImageWidth;
    ProjectionBitMap.Height:=ProjectionImageHeight;
  end; // CreateProjectionBitMap

begin // CreateProjectionBitMaps
  // Выделение памяти под побитовые образы проекций.
  CreateProjectionBitMap(FrontalProjectionBitMap);
  CreateProjectionBitMap(HorizontalProjectionBitMap);
  CreateProjectionBitMap(VerticalProjectionBitMap);
  // Фоны проекций.
  DrawProjectionBitMapBackGrounds;
  // Центр проекции.
  ProjectionImageHalfHeight:=Round(ProjectionImageHeight/2);
  ProjectionImageHalfWidth:=Round(ProjectionImageWidth/2);
end; // CreateProjectionBitMaps

// Освобождение памяти от побитовых образов проекций.
procedure FreeProjectionBitMaps;
begin // FreeProjectionBitMaps
  FrontalProjectionBitMap.Free;
  HorizontalProjectionBitMap.Free;
  VerticalProjectionBitMap.Free;
end; // FreeProjectionBitMaps

//******************************************************************************

// Отрисовка координатных осей.
procedure DrawAxisProjection;

  // Режим отображения отрицательных полуосей осей координат.
  procedure SetProjectionBitMapNegativeHalfAxisMode(var ProjectionBitMap: TBitMap);
  begin // SetProjectionBitMapNegativeHalfAxisMode
    with ProjectionBitMap.Canvas.Pen do
      begin //  with ProjectionBitMap.Canvas.Pen do
        // Сплошная линия линии.
        Style:=psSolid;
        // Установка ширины линий.
        Width:=EllipsoidVertexLineWidth;
        // Цвет отрицательных координатных полуосей.
        Color:=NegativeHalfAxisColor;
      end; //  with ProjectionBitMap.Canvas.Pen do
  end; // SetProjectionBitMapNegativeHalfAxisMode

begin // DrawAxisProjection
  // Режим отображения отрицательных полуосей осей координат.
  SetProjectionBitMapNegativeHalfAxisMode(FrontalProjectionBitMap);
  SetProjectionBitMapNegativeHalfAxisMode(HorizontalProjectionBitMap);
  SetProjectionBitMapNegativeHalfAxisMode(VerticalProjectionBitMap);

  with FrontalProjectionBitMap.Canvas do
    begin // with FrontalProjectionBitMap.Canvas do
      // Полуось -OZ.
      MoveTo(ProjectionImageHalfWidth,ProjectionImageHalfHeight);
      LineTo(ProjectionImageHalfWidth,FrontalProjectionBitMap.Height);
      // Полуось -OX.
      MoveTo(ProjectionImageHalfWidth,ProjectionImageHalfHeight);
      LineTo(0,ProjectionImageHalfHeight);
    end; // with FrontalProjectionBitMap.Canvas do

  with HorizontalProjectionBitMap.Canvas do
    begin // with HorizontalProjectionBitMap.Canvas do
      // Полуось -OX.
      MoveTo(ProjectionImageHalfWidth,ProjectionImageHalfHeight);
      LineTo(0,ProjectionImageHalfHeight);
    end; // with HorizontalProjectionBitMap.Canvas do

  with VerticalProjectionBitMap.Canvas do
    begin // with VerticalProjectionBitMap.Canvas do
      // Полуось -OZ.
      MoveTo(ProjectionImageHalfWidth,ProjectionImageHalfHeight);
      LineTo(ProjectionImageHalfWidth,VerticalProjectionBitMap.Height);
    end; // with VerticalProjectionBitMap.Canvas do

  // Цвет положительных координатных полуосей.
  FrontalProjectionBitMap.Canvas.Pen.Color:=PositiveHalfAxisColor;
  HorizontalProjectionBitMap.Canvas.Pen.Color:=PositiveHalfAxisColor;
  VerticalProjectionBitMap.Canvas.Pen.Color:=PositiveHalfAxisColor;

  with FrontalProjectionBitMap.Canvas do
    begin // with FrontalProjectionBitMap.Canvas do
      // Полуось +OZ.
      MoveTo(ProjectionImageHalfWidth,ProjectionImageHalfHeight);
      LineTo(ProjectionImageHalfWidth,0);
      // Полуось +OX.
      MoveTo(ProjectionImageHalfWidth,ProjectionImageHalfHeight);
      LineTo(FrontalProjectionBitMap.Width,ProjectionImageHalfHeight);
    end; // with FrontalProjectionBitMap.Canvas do

  with HorizontalProjectionBitMap.Canvas do
    begin // with HorizontalProjectionBitMap.Canvas do
      // Полуось +OX.
      MoveTo(ProjectionImageHalfWidth,ProjectionImageHalfHeight);
      LineTo(HorizontalProjectionBitMap.Width,ProjectionImageHalfHeight);
      // Полуось +OY
      MoveTo(ProjectionImageHalfWidth,ProjectionImageHalfHeight);
      LineTo(ProjectionImageHalfWidth,0);
    end; // with HorizontalProjectionBitMap.Canvas do

  with VerticalProjectionBitMap.Canvas do
    begin // with VerticalProjectionBitMap.Canvas do
      // Полуось +OZ.
      MoveTo(ProjectionImageHalfWidth,ProjectionImageHalfHeight);
      LineTo(ProjectionImageHalfWidth,0);
      // Полуось +OY
      MoveTo(ProjectionImageHalfWidth,ProjectionImageHalfHeight);
      LineTo(VerticalProjectionBitMap.Width,ProjectionImageHalfHeight);
    end; // with VerticalProjectionBitMap.Canvas do
end; // DrawAxisProjection

//******************************************************************************

// Расчёт коэффициента количества процентов
// области отображения пространтсва в пикселе.
procedure SetScaleFactorPercentsInPixel(    LengthInPrecents: Single;
                                            LengthInPixels: Byte;
                                        var ScaleFactorPercentsInPixel: Single);
begin // SetScaleFactorPercentsInPixel
  ScaleFactorPercentsInPixel:=LengthInPrecents/LengthInPixels;
end; // SetScaleFactorPercentsInPixel

// Отрисовка зрительных центров и фокусов.
procedure DrawCentresProjection;{(HalfBetweenDistanceInPercents: Single);}
// HalfBetweenDistanceInPercents - половина межцентрового расстояние эллипсоида в процентах.
var
  // Размер точек центров эллипсоида в проекции.
  ProjectionEllipsoidCentresPointSize: Byte;
  // Половина размера точек центров эллипсоида в проекции.
  HalfProjectionEllipsoidCentresPointSize: Byte;
  // Горизонтальная координата левого верхнего угла точки центра.
  LeftTopCentrePointX: Byte;
  // Вертикальная координата левого верхнего угла точки центра.
  LeftTopCentrePointY: Byte;

  // Режим отображения левого зрительного центра.
  procedure SetProjectionBitMapLeftCentresMode(var ProjectionBitMap: TBitMap);
  begin // SetProjectionBitMapLeftCentresMode
    // Отсутствие линии.
    ProjectionBitMap.Canvas.Pen.Style:=psClear;
    // Сплошное заполнение.
    ProjectionBitMap.Canvas.Brush.Style:=bsSolid;
    // Цвет левого зрительного центра.
    ProjectionBitMap.Canvas.Brush.Color:=LeftCentreColor;
  end; // SetProjectionBitMapLeftCentresMode

  // Отображение зрительного центра.
  procedure PutCentrePoint(var ProjectionBitMap: TBitMap);
  begin // PutCentrePoint
    ProjectionBitMap.Canvas.Ellipse(LeftTopCentrePointX,LeftTopCentrePointY,
      LeftTopCentrePointX+ProjectionEllipsoidCentresPointSize,
      LeftTopCentrePointY+ProjectionEllipsoidCentresPointSize);
  end; // PutCentrePoint

begin // DrawCentresProjection
  // Половина размера точек центров эллипсоида в проекции.
  HalfProjectionEllipsoidCentresPointSize:=(EllipsoidCentresPointSize div 2) + 1;
  // Размер точек центров эллипсоида в проекции.
  ProjectionEllipsoidCentresPointSize:=2*HalfProjectionEllipsoidCentresPointSize;

  // Режим отображения левого зрительного центра.
  SetProjectionBitMapLeftCentresMode(FrontalProjectionBitMap);
  SetProjectionBitMapLeftCentresMode(HorizontalProjectionBitMap);

  // Горизонтальная координата левого верхнего угла точки центра.
  LeftTopCentrePointX:=ProjectionImageHalfWidth-
                       HalfBetweenDistanceInPixels-
                       HalfProjectionEllipsoidCentresPointSize+1;
  // Вертикальная координата левого верхнего угла точки центра.
  LeftTopCentrePointY:=ProjectionImageHalfHeight-HalfProjectionEllipsoidCentresPointSize+1;

  // Точка левого зрительного центра.
  PutCentrePoint(FrontalProjectionBitMap);
  PutCentrePoint(HorizontalProjectionBitMap);

  // Цвет правого зрительного центра.
  FrontalProjectionBitMap.Canvas.Brush.Color:=RightCentreColor;
  HorizontalProjectionBitMap.Canvas.Brush.Color:=RightCentreColor;
  VerticalProjectionBitMap.Canvas.Brush.Color:=RightCentreColor;

  // Горизонтальная координата левого верхнего угла точки центра.
  LeftTopCentrePointX:=ProjectionImageHalfWidth+
                       HalfBetweenDistanceInPixels-
                       HalfProjectionEllipsoidCentresPointSize+1;

  // Точка правого зрительного центра.
  PutCentrePoint(FrontalProjectionBitMap);
  PutCentrePoint(HorizontalProjectionBitMap);

  // Горизонтальная координата левого верхнего угла точки центра.
  LeftTopCentrePointX:=ProjectionImageHalfWidth-
                       HalfProjectionEllipsoidCentresPointSize+1;
                       
  PutCentrePoint(VerticalProjectionBitMap);
end; // DrawCentresProjection

//******************************************************************************

// Отрисовка линий ограничения области между зрительными центрами.
procedure DrawBetweenCentresAreaBorderLinesProjection;

  // Режим отображения линий ограничения области между зрительными центрами.
  procedure SetProjectionBitMapBetweenCentresAreaBorderLinesMode(var ProjectionBitMap: TBitMap);
  begin // SetProjectionBitMapBetweenCentresAreaBorderLinesMode
    with ProjectionBitMap.Canvas.Pen do
      begin //  with ProjectionBitMap.Canvas.Pen do
        // Сплошная линия линии.
        Style:=psSolid;
        // Установка ширины линий.
        Width:=EllipsoidVertexLineWidth;
        // Цвет линий ограничения области между зрительными центрами.
        Color:=BetweenCentresAreaBorderLinesColor;
      end; //  with ProjectionBitMap.Canvas.Pen do
  end; // SetProjectionBitMapBetweenCentresAreaBorderLinesMode

begin // DrawBetweenCentresAreaBorderLinesProjection
  // Режим отображения линий ограничения области между зрительными центрами.
  SetProjectionBitMapBetweenCentresAreaBorderLinesMode(FrontalProjectionBitMap);
  SetProjectionBitMapBetweenCentresAreaBorderLinesMode(HorizontalProjectionBitMap);

  with FrontalProjectionBitMap.Canvas do
    begin // with FrontalProjectionBitMap.Canvas do
      // Левая линий ограничения.
      MoveTo(ProjectionImageHalfWidth-HalfBetweenDistanceInPixels,
             ProjectionAxisBorderWidth);
      LineTo(ProjectionImageHalfWidth-HalfBetweenDistanceInPixels,
             FrontalProjectionBitMap.Height-ProjectionAxisBorderWidth);
      // Правая линий ограничения.
      MoveTo(ProjectionImageHalfWidth+HalfBetweenDistanceInPixels,
             ProjectionAxisBorderWidth);
      LineTo(ProjectionImageHalfWidth+HalfBetweenDistanceInPixels,
             FrontalProjectionBitMap.Height-ProjectionAxisBorderWidth);
    end; // with FrontalProjectionBitMap.Canvas do

  with HorizontalProjectionBitMap.Canvas do
    begin // with HorizontalProjectionBitMap.Canvas do
      // Левая линий ограничения.
      MoveTo(ProjectionImageHalfWidth-HalfBetweenDistanceInPixels,
             ProjectionAxisBorderWidth);
      LineTo(ProjectionImageHalfWidth-HalfBetweenDistanceInPixels,
             ProjectionImageHalfHeight);
      // Правая линий ограничения.
      MoveTo(ProjectionImageHalfWidth+HalfBetweenDistanceInPixels,
             ProjectionAxisBorderWidth);
      LineTo(ProjectionImageHalfWidth+HalfBetweenDistanceInPixels,
             ProjectionImageHalfHeight);
    end; // with HorizontalProjectionBitMap.Canvas do
end; // DrawBetweenCentresAreaBorderLinesProjection

//******************************************************************************

// Отрисовка фокуса.
procedure DrawFocusProjection(XFocusInPixels,YFocusInPixels,ZFocusInPixels: SmallInt;
                              FocalEllipsoidFocusColor: TColor);
var
  // Половина размера точек центров эллипсоида в проекции.
  HalfProjectionFocusPointSize: Byte;
  // Hазмер точек центров эллипсоида в проекции.
  ProjectionFocusPointSize: Byte;


  // Режим отображения линий проекцирования точки фокуса на оси координат.
  procedure SetProjectionBitMapFocusPointAxisProjectingLinesMode(var ProjectionBitMap: TBitMap);
  begin // SetProjectionBitMapFocusPointAxisProjectingLinesMode
    with ProjectionBitMap.Canvas.Pen do
      begin //  with ProjectionBitMap.Canvas.Pen do
        // Сплошная линия линии.
        Style:=psSolid;
        // Установка ширины линий.
        Width:=EllipsoidVertexLineWidth;
        // Цвет линий ограничения области между зрительными центрами.
        Color:=FocalEllipsoidFocusColor;
      end; //  with ProjectionBitMap.Canvas.Pen do
  end; // SetProjectionBitMapFocusPointAxisProjectingLinesMode

  // Режим отображения точки фокуса.
  procedure SetProjectionBitMapFocusMode(var ProjectionBitMap: TBitMap);
  begin // SetProjectionBitMapFocusMode
    // Отсутствие линии.
    ProjectionBitMap.Canvas.Pen.Style:=psClear;
    // Сплошное заполнение.
    ProjectionBitMap.Canvas.Brush.Style:=bsSolid;
    // Цвет левого зрительного центра.
    ProjectionBitMap.Canvas.Brush.Color:=FocalEllipsoidFocusColor;
  end; // SetProjectionBitMapFocusMode

begin // DrawFocusProjection
  // Режим отображения линий проекцирования точки фокуса на оси координат.
  SetProjectionBitMapFocusPointAxisProjectingLinesMode(FrontalProjectionBitMap);
  SetProjectionBitMapFocusPointAxisProjectingLinesMode(HorizontalProjectionBitMap);
  SetProjectionBitMapFocusPointAxisProjectingLinesMode(VerticalProjectionBitMap);

  // Отображение линий проекцирования точки фокуса на оси координат.
  with FrontalProjectionBitMap.Canvas do
    begin // with FrontalProjectionBitMap.Canvas do
      // Линия проекцирования точки фокуса на ось OX.
      MoveTo(ProjectionImageHalfWidth+XFocusInPixels,ProjectionImageHalfHeight-ZFocusInPixels);
      LineTo(ProjectionImageHalfWidth+XFocusInPixels,ProjectionImageHalfHeight);
      // Линия проекцирования точки фокуса на ось OZ.
      MoveTo(ProjectionImageHalfWidth+XFocusInPixels,ProjectionImageHalfHeight-ZFocusInPixels);
      LineTo(ProjectionImageHalfWidth,ProjectionImageHalfHeight-ZFocusInPixels);
    end; // with FrontalProjectionBitMap.Canvas do

  with HorizontalProjectionBitMap.Canvas do
    begin // with HorizontalProjectionBitMap.Canvas do
      // Линия проекцирования точки фокуса на ось OX.
      MoveTo(ProjectionImageHalfWidth+XFocusInPixels,ProjectionImageHalfHeight-YFocusInPixels);
      LineTo(ProjectionImageHalfWidth+XFocusInPixels,ProjectionImageHalfHeight);
      // Линия проекцирования точки фокуса на ось OY.
      MoveTo(ProjectionImageHalfWidth+XFocusInPixels,ProjectionImageHalfHeight-YFocusInPixels);
      LineTo(ProjectionImageHalfWidth,ProjectionImageHalfHeight-YFocusInPixels);
    end; // with HorizontalProjectionBitMap.Canvas do

  with VerticalProjectionBitMap.Canvas do
    begin // with VerticalProjectionBitMap.Canvas do
      // Линия проекцирования точки фокуса на ось OY.
      MoveTo(ProjectionImageHalfWidth+YFocusInPixels,ProjectionImageHalfHeight-ZFocusInPixels);
      LineTo(ProjectionImageHalfWidth+YFocusInPixels,ProjectionImageHalfHeight);
      // Линия проекцирования точки фокуса на ось OZ.
      MoveTo(ProjectionImageHalfWidth+YFocusInPixels,ProjectionImageHalfHeight-ZFocusInPixels);
      LineTo(ProjectionImageHalfWidth,ProjectionImageHalfHeight-ZFocusInPixels);
    end; // with VerticalProjectionBitMap.Canvas do


  // Установка ширины линий радиус-вектора фокусного эллипсоида.
  FrontalProjectionBitMap.Canvas.Pen.Width:=FocusEllipsoidFocusRadiusVectorLineWidth-1;
  HorizontalProjectionBitMap.Canvas.Pen.Width:=FocusEllipsoidFocusRadiusVectorLineWidth-1;
  VerticalProjectionBitMap.Canvas.Pen.Width:=FocusEllipsoidFocusRadiusVectorLineWidth-1;

  // Отображение радиус-вектора фокусного эллипсоида.
  with FrontalProjectionBitMap.Canvas do
    begin // with FrontalProjectionBitMap.Canvas do
      MoveTo(ProjectionImageHalfWidth,ProjectionImageHalfHeight);
      LineTo(ProjectionImageHalfWidth+XFocusInPixels,ProjectionImageHalfHeight-ZFocusInPixels);
    end; // with FrontalProjectionBitMap.Canvas do

  with HorizontalProjectionBitMap.Canvas do
    begin // with HorizontalProjectionBitMap.Canvas do
      MoveTo(ProjectionImageHalfWidth,ProjectionImageHalfHeight);
      LineTo(ProjectionImageHalfWidth+XFocusInPixels,ProjectionImageHalfHeight-YFocusInPixels);
    end; // with HorizontalProjectionBitMap.Canvas do

  with VerticalProjectionBitMap.Canvas do
    begin // with VerticalProjectionBitMap.Canvas do
      MoveTo(ProjectionImageHalfWidth,ProjectionImageHalfHeight);
      LineTo(ProjectionImageHalfWidth+YFocusInPixels,ProjectionImageHalfHeight-ZFocusInPixels);
    end; // with VerticalProjectionBitMap.Canvas do


  // Половина размера точек центров эллипсоида в проекции.
  HalfProjectionFocusPointSize:=Round(FocusEllipsoidFocusPointSize/2) - 1;
  // Hазмер точек центров эллипсоида в проекции.
  ProjectionFocusPointSize:=2*HalfProjectionFocusPointSize;

  // Режим отображения точки фокуса.
  SetProjectionBitMapFocusMode(FrontalProjectionBitMap);
  SetProjectionBitMapFocusMode(HorizontalProjectionBitMap);
  SetProjectionBitMapFocusMode(VerticalProjectionBitMap);

  // Отображение точки фокуса.
  FrontalProjectionBitMap.Canvas.Ellipse(
    ProjectionImageHalfWidth+XFocusInPixels-HalfProjectionFocusPointSize,
    ProjectionImageHalfHeight-ZFocusInPixels-HalfProjectionFocusPointSize,
    ProjectionImageHalfWidth+XFocusInPixels+ProjectionFocusPointSize,
    ProjectionImageHalfHeight-ZFocusInPixels+ProjectionFocusPointSize);

  HorizontalProjectionBitMap.Canvas.Ellipse(
    ProjectionImageHalfWidth+XFocusInPixels-HalfProjectionFocusPointSize,
    ProjectionImageHalfHeight-YFocusInPixels-HalfProjectionFocusPointSize,
    ProjectionImageHalfWidth+XFocusInPixels+ProjectionFocusPointSize,
    ProjectionImageHalfHeight-YFocusInPixels+ProjectionFocusPointSize);

  VerticalProjectionBitMap.Canvas.Ellipse(
    ProjectionImageHalfWidth+YFocusInPixels-HalfProjectionFocusPointSize,
    ProjectionImageHalfHeight-ZFocusInPixels-HalfProjectionFocusPointSize,
    ProjectionImageHalfWidth+YFocusInPixels+ProjectionFocusPointSize,
    ProjectionImageHalfHeight-ZFocusInPixels+ProjectionFocusPointSize);
end; // DrawFocusProjection

//******************************************************************************

// Отрисовка проекций  эллипсоида.
procedure DrawEllipsoidProjection(XRadiusInPixels,YRadiusInPixels,ZRadiusInPixels: SmallInt;
                                  EllipsoidFrontalFrameworkLinesColor,
                                  EllipsoidHorizontalFrameworkLinesColor,
                                  EllipsoidVerticalFrameworkLinesColor: TColor);

  // Режим отображения линий проекций эллипсоида.
  procedure SetProjectionBitMapEllipsoidMode(var ProjectionBitMap: TBitMap;
    EllipsoidParallelFrameworkLinesColor: TColor);
  begin // SetProjectionBitMapEllipsoidMode
    with ProjectionBitMap.Canvas.Pen do
      begin //  with ProjectionBitMap.Canvas.Pen do
        // Сплошная линия линии.
        Style:=psSolid;
        // Установка ширины линий.
        Width:=2*EllipsoidVertexLineWidth;
        // Цвет линий ограничения области между зрительными центрами.
        Color:=EllipsoidParallelFrameworkLinesColor;
      end; //  with ProjectionBitMap.Canvas.Pen do
  end; // SetProjectionBitMapEllipsoidMode

begin // DrawEllipsoidProjection
  // Режим отображения линий проекций эллипсоида.
  SetProjectionBitMapEllipsoidMode(FrontalProjectionBitMap,
    EllipsoidFrontalFrameworkLinesColor);
  // Отображение проекций эллипсоида.
  FrontalProjectionBitMap.Canvas.Ellipse(
    ProjectionImageHalfWidth-XRadiusInPixels, ProjectionImageHalfHeight-ZRadiusInPixels,
    ProjectionImageHalfWidth+XRadiusInPixels, ProjectionImageHalfHeight+ZRadiusInPixels);


  // Режим отображения линий проекций эллипсоида.
  SetProjectionBitMapEllipsoidMode(HorizontalProjectionBitMap,
    EllipsoidHorizontalFrameworkLinesColor);

  HorizontalProjectionBitMap.Canvas.Arc(
    ProjectionImageHalfWidth-XRadiusInPixels, ProjectionImageHalfHeight-YRadiusInPixels,
    ProjectionImageHalfWidth+XRadiusInPixels, ProjectionImageHalfHeight+YRadiusInPixels,

    ProjectionImageHalfWidth+XRadiusInPixels, ProjectionImageHalfHeight,
    ProjectionImageHalfWidth-XRadiusInPixels, ProjectionImageHalfHeight);

    
  // Режим отображения линий проекций эллипсоида.
  SetProjectionBitMapEllipsoidMode(VerticalProjectionBitMap,
    EllipsoidVerticalFrameworkLinesColor);

  VerticalProjectionBitMap.Canvas.Arc(
    ProjectionImageHalfWidth-YRadiusInPixels, ProjectionImageHalfHeight-ZRadiusInPixels,
    ProjectionImageHalfWidth+YRadiusInPixels, ProjectionImageHalfHeight+ZRadiusInPixels,

    ProjectionImageHalfWidth, ProjectionImageHalfHeight+ZRadiusInPixels,
    ProjectionImageHalfWidth, ProjectionImageHalfHeight-ZRadiusInPixels);
end; // DrawEllipsoidProjection

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// Отрисовка проекций одного эллипсоида.
procedure DrawSingleEllipsoidProjection(    EllipsoidXRadiusInPercents,
                                            EllipsoidYRadiusInPercents,
                                            EllipsoidZRadiusInPercents,
                                            HalfBetweenDistanceInPercents,
                                            XFocusInPercents,
                                            YFocusInPercents,
                                            ZFocusInPercents: Single;
                                            EllipsoidName: String;

                                        var FrontalProjectionImage,
                                            HorizontalProjectionImage,
                                            VerticalProjectionImage: TImage);

// EllipsoidXRadiusInPercents - радиус эллипсоида по оси ОХ в прроцентах от облсти отображения.
// EllipsoidYRadiusInPercents - радиус эллипсоида по оси ОY в прроцентах от облсти отображения.
// EllipsoidZRadiusInPercents - радиус эллипсоида по оси ОZ в прроцентах от облсти отображения.
// HalfBetweenDistanceInPercents - половина межцентрового расстояния
//   в процентах от облсти отображения.
// XFocusInPercents, YFocusInPercents, ZFocusInPercents - координаты фокуса в процентах.
// EllipsoidName - название эллипсоида.
// FrontalProjectionImage, HorizontalProjectionImage, VerticalProjectionImage -образы проекций.


var
  // Радиус предельного эллипсоида по оси ОХ в пикселях.
  EllipsoidXRadiusInPixels: Byte;
  // Радиус предельного эллипсоида по оси ОY в пикселях.
  EllipsoidYRadiusInPixels: Byte;
  // Радиус предельного эллипсоида по оси ОZ в пикселях.
  EllipsoidZRadiusInPixels: Byte;
  // Цвета каркасных линий эллипсоида.
  EllipsoidFrontalFrameworkLinesColor,
  EllipsoidHorizontalFrameworkLinesColor,
  EllipsoidVerticalFrameworkLinesColor: TColor;
  // Цвет фокуса фокусного эллипсоида.
  FocalEllipsoidFocusColor: TColor;
  // Координаты фокуса в пикселях.
  XFocusInPixels,YFocusInPixels,ZFocusInPixels: SmallInt;

begin // DrawSingleEllipsoidProjection
  if EllipsoidName = 'LimitingEllipsoid'
    then begin // if EllipsoidName = 'LimitingEllipsoid' then
           EllipsoidFrontalFrameworkLinesColor:=LimitingEllipsoidFrontalFrameworkLinesColor;
           EllipsoidHorizontalFrameworkLinesColor:=LimitingEllipsoidHorizontalFrameworkLinesColor;
           EllipsoidVerticalFrameworkLinesColor:=LimitingEllipsoidVerticalFrameworkLinesColor;

           FocalEllipsoidFocusColor:=clBlack;
         end // if EllipsoidName = 'LimitingEllipsoid' then

    else if EllipsoidName = 'SourceFocalEllipsoid'
           then begin // if EllipsoidName = 'SourceFocalEllipsoid' then
                  EllipsoidFrontalFrameworkLinesColor:=SourceFocalEllipsoidFrontalFrameworkLinesColor;
                  EllipsoidHorizontalFrameworkLinesColor:=SourceFocalEllipsoidHorizontalFrameworkLinesColor;
                  EllipsoidVerticalFrameworkLinesColor:=SourceFocalEllipsoidVerticalFrameworkLinesColor;

                  FocalEllipsoidFocusColor:=SourceFocalEllipsoidFocusColor;
                end // if EllipsoidName = 'SourceFocalEllipsoid' then

           else begin // if EllipsoidName = 'SourceFocalEllipsoid' else
                  EllipsoidFrontalFrameworkLinesColor:=DisplacedFocalEllipsoidFrontalFrameworkLinesColor;
                  EllipsoidHorizontalFrameworkLinesColor:=DisplacedFocalEllipsoidHorizontalFrameworkLinesColor;
                  EllipsoidVerticalFrameworkLinesColor:=DisplacedFocalEllipsoidVerticalFrameworkLinesColor;

                  FocalEllipsoidFocusColor:=DisplacedFocalEllipsoidFocusColor;
                end; // if EllipsoidName = 'SourceFocalEllipsoid' else
  // Создание побитовых образов проекций.
  CreateProjectionBitMaps;

  EllipsoidXRadiusInPixels:=ProjectionImageHalfWidth-ProjectionAxisBorderWidth;
  // Расчёт коэффициента количества процентов
  // области отображения пространтсва в пикселе.
  SetScaleFactorPercentsInPixel(EllipsoidXRadiusInPercents,
                                EllipsoidXRadiusInPixels,
                                ScaleFactorPercentsInPixel);

  EllipsoidYRadiusInPixels:=Round(EllipsoidYRadiusInPercents/ScaleFactorPercentsInPixel);
  EllipsoidZRadiusInPixels:=Round(EllipsoidZRadiusInPercents/ScaleFactorPercentsInPixel);
  // Половина межцентрового расстояние эллипсоида в пикселях.
  HalfBetweenDistanceInPixels:=Round(HalfBetweenDistanceInPercents/
                                     ScaleFactorPercentsInPixel);
  // Отрисовка проекций эллипсоида.
  DrawEllipsoidProjection(EllipsoidXRadiusInPixels,
                          EllipsoidYRadiusInPixels,
                          EllipsoidZRadiusInPixels,
                          EllipsoidFrontalFrameworkLinesColor,
                          EllipsoidHorizontalFrameworkLinesColor,
                          EllipsoidVerticalFrameworkLinesColor);
  // Отрисовка линий ограничения области между зрительными центрами.
  DrawBetweenCentresAreaBorderLinesProjection;
  // Отрисовка координатных осей.
  DrawAxisProjection;

  // Если эллипсоид - фокусный эллипсоид, то отрисовывать фокус.
  if not(EllipsoidName = 'LimitingEllipsoid')
    then begin // if not(EllipsoidName = 'LimitingEllipsoid')
           // Координаты фокуса в пикселях.
           XFocusInPixels:=Round(XFocusInPercents/ScaleFactorPercentsInPixel);
           YFocusInPixels:=Round(YFocusInPercents/ScaleFactorPercentsInPixel);
           ZFocusInPixels:=Round(ZFocusInPercents/ScaleFactorPercentsInPixel);
           // Отрисовка фокуса.
           DrawFocusProjection(XFocusInPixels,YFocusInPixels,ZFocusInPixels,
                               FocalEllipsoidFocusColor);
         end; // if not(EllipsoidName = 'LimitingEllipsoid')

  // Отрисовка зрительных центров и фокусов.
  DrawCentresProjection;

  FrontalProjectionImage.Canvas.Draw(0,0,FrontalProjectionBitMap);
  HorizontalProjectionImage.Canvas.Draw(0,0,HorizontalProjectionBitMap);
  VerticalProjectionImage.Canvas.Draw(0,0,VerticalProjectionBitMap);

  // Освобождение памяти от побитовых образов проекций.
  FreeProjectionBitMaps;
end; // DrawSingleEllipsoidProjection

//******************************************************************************

// Отрисовка проекций фокусных эллипсоидов.
procedure DrawFocalEllipsoidsProjection(    SourceFocalEllipsoidXRadiusInPercents,
                                            SourceFocalEllipsoidYRadiusInPercents,
                                            SourceFocalEllipsoidZRadiusInPercents,

                                            DisplacedFocalEllipsoidXRadiusInPercents,
                                            DisplacedFocalEllipsoidYRadiusInPercents,
                                            DisplacedFocalEllipsoidZRadiusInPercents,

                                            HalfBetweenDistanceInPercents,

                                            XSourceFocusInPercents,
                                            YSourceFocusInPercents,
                                            ZSourceFocusInPercents,

                                            XDisplacedFocusInPercents,
                                            YDisplacedFocusInPercents,
                                            ZDisplacedFocusInPercents: Single;

                                        var FrontalProjectionImage,
                                            HorizontalProjectionImage,
                                            VerticalProjectionImage: TImage);

// SourceFocalEllipsoidXRadiusInPercents,
// SourceFocalEllipsoidYRadiusInPercents,
// SourceFocalEllipsoidZRadiusInPercents -
//   радиусы исходного эллипсоида в прроцентах от облсти отображения.
// DisplacedFocalEllipsoidXRadiusInPercents,
// DisplacedFocalEllipsoidYRadiusInPercents,
// DisplacedFocalEllipsoidZRadiusInPercents -
//   радиусы смещённого эллипсоида в прроцентах от облсти отображения.
// HalfBetweenDistanceInPercents - половина межцентрового расстояния
//   в процентах от облсти отображения.
// XSourceFocusInPercents, YSourceFocusInPercents, ZSourceFocusInPercents -
//   координаты исходного фокуса в процентах.
// XDisplacedFocusInPercents, YDisplacedFocusInPercents, ZDisplacedFocusInPercents -
//   координаты смещённого фокуса в процентах.
// FrontalProjectionImage, HorizontalProjectionImage, VerticalProjectionImage -образы проекций.


var
  // Радиусы исходного эллипсоида в пикселях.
  SourceFocalEllipsoidXRadiusInPixels,
  SourceFocalEllipsoidYRadiusInPixels,
  SourceFocalEllipsoidZRadiusInPixels: Byte;

  // Радиусы смещённого эллипсоида в пикселях.
  DisplacedFocalEllipsoidXRadiusInPixels,
  DisplacedFocalEllipsoidYRadiusInPixels,
  DisplacedFocalEllipsoidZRadiusInPixels: Byte;

  // Координаты фокуса исходного эллипсоида в пикселях.
  XSourceFocusInPixels,YSourceFocusInPixels,ZSourceFocusInPixels: SmallInt;
  // Координаты фокуса смещённого эллипсоида в пикселях.
  XDisplacedFocusInPixels,YDisplacedFocusInPixels,ZDisplacedFocusInPixels: SmallInt;
begin // DrawFocalEllipsoidsProjection
  // Создание побитовых образов проекций.
  CreateProjectionBitMaps;

  SourceFocalEllipsoidXRadiusInPixels:=ProjectionImageHalfWidth-ProjectionAxisBorderWidth;
  // Расчёт коэффициента количества процентов
  // области отображения пространтсва в пикселе.
  SetScaleFactorPercentsInPixel(SourceFocalEllipsoidXRadiusInPercents,
                                SourceFocalEllipsoidXRadiusInPixels,
                                ScaleFactorPercentsInPixel);

  SourceFocalEllipsoidYRadiusInPixels:=Round(SourceFocalEllipsoidYRadiusInPercents/
                                             ScaleFactorPercentsInPixel);
  SourceFocalEllipsoidZRadiusInPixels:=Round(SourceFocalEllipsoidZRadiusInPercents/
                                             ScaleFactorPercentsInPixel);

  DisplacedFocalEllipsoidXRadiusInPixels:=Round(DisplacedFocalEllipsoidXRadiusInPercents/
                                                ScaleFactorPercentsInPixel);
  DisplacedFocalEllipsoidYRadiusInPixels:=Round(DisplacedFocalEllipsoidYRadiusInPercents/
                                                ScaleFactorPercentsInPixel);
  DisplacedFocalEllipsoidZRadiusInPixels:=Round(DisplacedFocalEllipsoidZRadiusInPercents/
                                                ScaleFactorPercentsInPixel);

  // Половина межцентрового расстояние эллипсоида в пикселях.
  HalfBetweenDistanceInPixels:=Round(HalfBetweenDistanceInPercents/
                                     ScaleFactorPercentsInPixel);
  // Отрисовка проекций исходного эллипсоида.
  DrawEllipsoidProjection(SourceFocalEllipsoidXRadiusInPixels,
                          SourceFocalEllipsoidYRadiusInPixels,
                          SourceFocalEllipsoidZRadiusInPixels,
                          SourceFocalEllipsoidFrontalFrameworkLinesColor,
                          SourceFocalEllipsoidHorizontalFrameworkLinesColor,
                          SourceFocalEllipsoidVerticalFrameworkLinesColor);

  // Отрисовка проекций смещённого эллипсоида.
  DrawEllipsoidProjection(DisplacedFocalEllipsoidXRadiusInPixels,
                          DisplacedFocalEllipsoidYRadiusInPixels,
                          DisplacedFocalEllipsoidZRadiusInPixels,
                          DisplacedFocalEllipsoidFrontalFrameworkLinesColor,
                          DisplacedFocalEllipsoidHorizontalFrameworkLinesColor,
                          DisplacedFocalEllipsoidVerticalFrameworkLinesColor);

  // Отрисовка линий ограничения области между зрительными центрами.
  DrawBetweenCentresAreaBorderLinesProjection;
  // Отрисовка координатных осей.
  DrawAxisProjection;

  // Координаты исходного фокуса в пикселях.
  XSourceFocusInPixels:=Round(XSourceFocusInPercents/ScaleFactorPercentsInPixel);
  YSourceFocusInPixels:=Round(YSourceFocusInPercents/ScaleFactorPercentsInPixel);
  ZSourceFocusInPixels:=Round(ZSourceFocusInPercents/ScaleFactorPercentsInPixel);
  // Координаты смещённого фокуса в пикселях.
  XDisplacedFocusInPixels:=Round(XDisplacedFocusInPercents/ScaleFactorPercentsInPixel);
  YDisplacedFocusInPixels:=Round(YDisplacedFocusInPercents/ScaleFactorPercentsInPixel);
  ZDisplacedFocusInPixels:=Round(ZDisplacedFocusInPercents/ScaleFactorPercentsInPixel);

  // Отрисовка исходного фокуса.
  DrawFocusProjection(XSourceFocusInPixels,YSourceFocusInPixels,ZSourceFocusInPixels,
                      SourceFocalEllipsoidFocusColor);
  // Отрисовка смещённого фокуса.
  DrawFocusProjection(XDisplacedFocusInPixels,YDisplacedFocusInPixels,ZDisplacedFocusInPixels,
                      DisplacedFocalEllipsoidFocusColor);

  // Отрисовка зрительных центров и фокусов.
  DrawCentresProjection;

  FrontalProjectionImage.Canvas.Draw(0,0,FrontalProjectionBitMap);
  HorizontalProjectionImage.Canvas.Draw(0,0,HorizontalProjectionBitMap);
  VerticalProjectionImage.Canvas.Draw(0,0,VerticalProjectionBitMap);
  
  // Освобождение памяти от побитовых образов проекций.
  FreeProjectionBitMaps;
end; // DrawFocalEllipsoidsProjection


end.
