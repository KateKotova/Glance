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

// Базовые процедуры и функции.
unit Base_Unit;
                                      
interface

uses
  Mask, Forms, OpenGl;

type
  // Компоненты цвета: красный, зелёный и синий цвета
  // и прозрачность (альфа-канал).
  TColorComponents = record
    Red, Green, Blue, AlphaChannel: Single;
  end; // TColorComponents

  // Координаты точи в трёхмерном пространстве.
  TCoordinates = record
    X, Y, Z: Single;
  end; // TCoordinates
  
  // Координатная плоскость, вращаемая при обзоре.
  TStartRotationPlane = (XOYStartRotationPlane,
                         XOZStartRotationPlane,
                         YOZStartRotationPlane);

const
  // Ширина линий каркаса эллипсоида.
  EllipsoidVertexLineWidth = 1;
  // Размер точек центров эллипсоида.
  EllipsoidCentresPointSize = 5;
  // Ширина линии радиус-вектора фокусного эллипсоида.
  FocusEllipsoidFocusRadiusVectorLineWidth = 3;
  // Размер точки фокуса фокусного эллипсоида.
  FocusEllipsoidFocusPointSize = 5.5;
  // Ширина линии вектороа между центром и фокусом фокусного эллипсоида.
  FocusEllipsoidVectorCenterToFocusLineWidth = 2;
  // Ширина линий соединения точек поверхности
  // с точками соответствующих им центров эллипсоида.
  VectorCenterToSurfacePointLineWidth = 1;
  // Размер опорных точек поверхности.
  SurfacePointSize = 4;
  // Ширина линий каркаса поверхности.
  SurfaceVertexLineWidth = 2;
  // Минимальный масштаб в процентах.
  MinZoom = 10;
  // Максимальный масштаб в процентах.
  MaxZoom = 100;

  // Компоненты цвета фона.
  BackgroundColorComponents: TColorComponents =
    (Red:  21/255; Green:        0; Blue:  70/255; AlphaChannel: 1);

  // Компоненты цвета левого зрительного центра.
  LeftCentreColorComponents: TColorComponents =
    (Red:  150/255; Green: 255/255; Blue: 150/255; AlphaChannel: 1);
  // Компоненты цвета правого зрительного центра.
  RightCentreColorComponents: TColorComponents =
    (Red:  255/255; Green: 255/255; Blue: 111/255; AlphaChannel: 1);

  // Компоненты цвета отрицательных координатных полуосей.
  NegativeHalfAxisColorComponents: TColorComponents =
    (Red:    0/255; Green: 255/255; Blue:   0/255; AlphaChannel: 1);
  // Компоненты цвета положительных координатных полуосей.
  PositiveHalfAxisColorComponents: TColorComponents =
    (Red:  255/255; Green: 255/255; Blue:   0/255; AlphaChannel: 1);

  // Компоненты цвета
  // фронтальных, горизонтальных и вертикальных
  // линий каркаса предельного эллипсоида.
  LimitingEllipsoidVerticalFrameworkLinesColorComponents: TColorComponents =
    (Red:   64/255; Green:  28/255; Blue:  84/255; AlphaChannel: 1);
  LimitingEllipsoidHorizontalFrameworkLinesColorComponents: TColorComponents =
    (Red:   60/255; Green:  44/255; Blue:  80/255; AlphaChannel: 1);
  LimitingEllipsoidFrontalFrameworkLinesColorComponents: TColorComponents =
    (Red:   66/255; Green:  65/255; Blue:  98/255; AlphaChannel: 1);

  // Компоненты цвета
  // фронтальных, горизонтальных и вертикальных
  // линий каркаса исходного фокусного эллипсоида.
  SourceFocalEllipsoidVerticalFrameworkLinesColorComponents: TColorComponents =
    (Red:   62/255; Green:  42/255; Blue: 255/255; AlphaChannel: 1);
  SourceFocalEllipsoidHorizontalFrameworkLinesColorComponents: TColorComponents =
    (Red:   94/255; Green:  92/255; Blue: 255/255; AlphaChannel: 1);
  SourceFocalEllipsoidFrontalFrameworkLinesColorComponents: TColorComponents =
    (Red:  142/255; Green: 142/255; Blue: 255/255; AlphaChannel: 1);

  // Компоненты цвета
  // фронтальных, горизонтальных и вертикальных
  // линий каркаса эллипсоида смещённого фокуса.
  DisplacedFocalEllipsoidVerticalFrameworkLinesColorComponents: TColorComponents =
    (Red:    0/255; Green: 255/255; Blue: 255/255; AlphaChannel: 1);
  DisplacedFocalEllipsoidHorizontalFrameworkLinesColorComponents: TColorComponents =
    (Red:  100/255; Green: 255/255; Blue: 255/255; AlphaChannel: 1);
  DisplacedFocalEllipsoidFrontalFrameworkLinesColorComponents: TColorComponents =
    (Red:  200/255; Green: 255/255; Blue: 255/255; AlphaChannel: 1);

  // Компоненты цвета точки фокуса исходного фокусного эллипсоида.
  SourceFocalEllipsoidFocusColorComponents: TColorComponents =
    (Red:  255/255; Green:   0/255; Blue:   0/255; AlphaChannel: 1);
  // Компоненты цвета точки фокуса смещённого фокусного эллипсоида.
  DisplacedFocalEllipsoidFocusColorComponents: TColorComponents =
    (Red:  255/255; Green: 128/255; Blue:   0/255; AlphaChannel: 1);

  // Компоненты цвета точки исходной поверхности область левого центра.
  SourceSurfaceRightCenterAreaColorComponents: TColorComponents =
    (Red:   83/255; Green:  38/255; Blue:  28/255; AlphaChannel: 0);
    // Компоненты цвета точки исходной поверхности область правого центра.
  SourceSurfaceLeftCenterAreaColorComponents: TColorComponents =
    (Red:   11/255; Green:  58/255; Blue:  76/255; AlphaChannel: 0);
    // Компоненты цвета точки исходной поверхности область начала координат.
  SourceSurfaceOOOAreaColorComponents: TColorComponents =
    (Red:   70/255; Green:   0/255; Blue:  96/255; AlphaChannel: 0);

  // Компоненты цвета точки исходной поверхности в области левого центра.
  DisplacedSurfaceRightCenterAreaColorComponents: TColorComponents =
    (Red:  130/255; Green: 104/255; Blue:   0/255; AlphaChannel: 0);
    // Компоненты цвета точки исходной поверхности в области правого центра.
  DisplacedSurfaceLeftCenterAreaColorComponents: TColorComponents =
    (Red:    0/255; Green:  98/255; Blue:  68/255; AlphaChannel: 0);
    // Компоненты цвета точки исходной поверхности в области начала координат.
  DisplacedSurfaceOOOAreaColorComponents: TColorComponents =
    (Red:  168/255; Green:   2/255; Blue:  81/255; AlphaChannel: 0);

  // Строка полного пути к Help-файлу.
  HelpFileNameString: String = 'Help_Glance_2_2_1.chm';

var
  // Коэффициент количества процентов области отображения в миллиметре.
  ScaleFactorPercentsInMillimeter: Single;

  
// Расчёт коэффициента количества процентов
// области отображения в миллиметре
procedure SetScaleFactorPercentsInMillimeter(LimitInMillimeters: Word;
  var ScaleFactorPercentsInMillimeter: Single);

// Удаление пробелов в строке.
procedure DelStringGaps(var SourceString: String);
// Удаление пробелов в строке маскированого поля.
procedure DelMaskEditTextGaps(var MaskEdit: TMaskEdit);

// Размещение формы по центру рабочей области экрана.
procedure CentreScreenWorkAreaFormPosition(Form: TForm);
      

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

implementation

// Расчёт коэффициента количества процентов
// области отображения в миллиметре.
procedure SetScaleFactorPercentsInMillimeter(LimitInMillimeters: Word;
  var ScaleFactorPercentsInMillimeter: Single);
begin // SetScaleFactorPercentsInMillimeter
  ScaleFactorPercentsInMillimeter:=1/LimitInMillimeters;
end; // SetScaleFactorPercentsInMillimeter

//******************************************************************************

// Удаление пробелов в строке.
procedure DelStringGaps(var SourceString: String);
 // SourceString - строка-источник.
var
  i: 1..4;
  j: 0..4;
  // Строка-копия.
  TextString: String;
begin // DelStringGaps
  // Удаление пробелов в тексте.
  // Создание строки-копии.
  TextString:=SourceString;
  j:=0;
  for i:=1 to Length(SourceString) do
    begin
      j:=j+1;
      // Сравнение i-го символа строки-оригинала с пробелом.
      if SourceString[i]=' '
        then begin
               // Удаление соответствующего пробела
               // в строке-копии.
               Delete(TextString,j,1);
               // При удалении произошло смещение
               // непроверенных символов влево.
               j:=j-1;
             end;
    end;
  // Форматирование строки-оригинала.
  SourceString:=TextString;
end; // // DelStringGaps

// Удаление пробелов в строке маскированого поля.
procedure DelMaskEditTextGaps(var MaskEdit: TMaskEdit);
  // MaskEdit - поле строки-источника.
var
  // Строка-копия.
  TextString: String;
begin // DelEditTextGaps
  // Создание строки-копии.
  TextString:=MaskEdit.Text;
  // Удаление пробелов в строке.
  DelStringGaps(TextString);
  // Форматирование строки-оригинала.
  MaskEdit.Text:=TextString;
end; // DelEditTextGaps

//******************************************************************************

// Размещение формы по центру рабочей области экрана.
procedure CentreScreenWorkAreaFormPosition(Form: TForm);
begin // CentreScreenWorkAreaFormPosition
  with Form do
    begin // with Form do
      Top:=Round(Screen.WorkAreaHeight/2-Height/2);
      Left:=Round(Screen.WorkAreaWidth/2-Width/2);
    end; // with Form do
end; // CentreScreenWorkAreaFormPosition

end.
