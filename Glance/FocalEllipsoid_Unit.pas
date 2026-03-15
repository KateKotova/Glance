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

// Построение фокусного эллипсоида.
unit FocalEllipsoid_Unit;

interface

uses
  // Glance-модули.
  Base_Unit, Ellipsoid_Unit,
  // Стандартные модули.
  OpenGL, Math;

type
  // Углы между радиус-вектором и координатными осями.
  TAngles = record
    FOX, FOY, FOZ,
    FOXInDegrees, FOYInDegrees, FOZInDegrees: Single;
  end; // TAngles

  // Фокус фокусного эллипсоида.
  TFocus = record
    // Координаты фокуса фокусного эллипсоида в процентах.
    Coordinates: TCoordinates;
    // Координаты фокуса фокусного эллипсоида в миллиметрах.
    XFocusInMillimeters,
    YFocusInMillimeters,
    ZFocusInMillimeters: Smallint;
    // Длина радиус-вектора фокусного эллипсоида в процентах.
    RadiusVector: Single;
    // Длина радиус-вектора фокусного эллипсоида в миллиметрах.
    RadiusVectorInMillimeters: Word;
    // Углы между радиус-вектором и координатными осями фокусного эллипсоида.
    Angles: TAngles;
    // Компоненты цвета точки фокуса фокусного эллипсоида.
    FocusColorComponents: TColorComponents;
    // Признак отрисовки линий соединения точек центров с фокусом.
    bFocusLines: Boolean;
  end; // TFocus

  // Координата точки фокуса,
  // определяющая изменения параметров фокусного эллипсоида.
  TFocusCoordinateDeterminator = (XFocusCoordinateDeterminator,
                                  YFocusCoordinateDeterminator,
                                  ZFocusCoordinateDeterminator);

  // Угол между радиус-вектором фокуса и координатными осями,
  // определяющий изменения параметров фокусного эллипсоида.
  TFocusAngleDeterminator = (FOXFocusAngleDeterminator,
                             FOYFocusAngleDeterminator,
                             FOZFocusAngleDeterminator);

  // Фокусный эллипсоид.
  TFocalEllipsoid = class(TEllipsoid)
    public
      // Фокус фокусного эллипсоида.
      Focus: TFocus;

      // Конструктор: создание нового эллипсоида.
      constructor Create(BetweenDistanceInMillimeters: Word;
                         RadiusDeterminator: TRadiusDeterminator;
                         RadiusInMillimeters: Word;

                         NumberFrontalFrameworkLinesIn1Octant,
                         NumberHorizontalFrameworkLinesIn1Octant,
                         NumberVerticalFrameworkLinesIn1Octant: ShortInt;

                         bFrontalFrameworkLinesDraw,
                         bHorizontalFrameworkLinesDraw,
                         bVerticalFrameworkLinesDraw: Boolean;

                         AngleFOXInDegrees,
                         AngleFOYInDegrees: Single);
      // Расчёт радиусов фокусного эллипсоида
      // по координатам фокуса через биквадратное уравнение.
      procedure SetRadiusesByFocusCoordinates;
      // Расчёт длины радиус-вектора фокусного эллипсоида по координатам фокуса.
      procedure SetFocusRadiusVectorByFocusCoordinates;
      // Расчёт длины радиус-вектора фокусного эллипсоида
      // по его радиусам и углам между радиус-вектором и координатными осями.
      procedure SetFocusRadiusVectorByRadiusesAndFocusAngies;
      // Расчёт координат фокуса фокусного эллипкоида
      // по длине радиус-вектора и углам между радиус-вектором и координатными осями.
      procedure SetFocusCoordinates;
      // Расчёт углов между радиус-вектором и координатными осями фокусного эллипсоида
      // по его координатам фокуса и длине радиус-вектора.
      procedure SetFocusAngles;
      // Изменение масштаба всех параметров фокусного эллипсоида
      // из-за изменившегося масштабного коэффициента.
      procedure ReScaleAllParameters;
      // Перерасчёт параметров центров фокусного эллипсоида.
      procedure ReSetCentres(NewBetweenDistanceInMillimeters: Word);
      // Перерасчёт параметров радиусов фокусного эллипсоида.
      procedure ReSetRadiuses(NewRadiusInMillimeters: Word;
                              NewRadiusDeterminator: TRadiusDeterminator);
      // Перерасчёт координат фокуса фокусного эллипсоида.
      procedure ReSetFocusCoordinates(NewFocusCoordinateInMillimeters: Word;
                                      NewFocusCoordinateDeterminator: TFocusCoordinateDeterminator);
      // Перерасчёт длины радиус-вектора фокуса фокусного эллипсоида.
      procedure ReSetFocusRadiusVector(NewFocusRadiusVectorInMillimeters: Word);
      // Перерасчёт углов между радиус-вектором и координатными осями.
      procedure ReSetFocusAngle(NewFocusAngleInDegrees: Single;
                                NewFocusAngleDeterminator: TFocusAngleDeterminator);
      // Перерасчёт всех углов между радиус-вектором и координатными осями.
      procedure ReSetAllFocusAngles(NewAngleFOXInDegrees,
                                    NewAngleFOYInDegrees,
                                    NewAngleFOZInDegrees: Single);
      // Отрисовка линий соединения точек центров эллипсоида с фокусом.
      procedure DrawFocalLines(LeftCentreColorComponents,
                               RightCentreColorComponents: TColorComponents;

                               FocusEllipsoidVectorCenterToFocusLineWidth,
                               FocusEllipsoidFocusRadiusVectorLineWidth: Single);

    protected
    private
  end; // TFocalEllipsoid

// Отождествление всех параметров с другим эллипсоидом
// при ориентации на его конкретный радиус.
procedure AssignOtherEllipsoidAllParameters(var GivenEllipsoid: TFocalEllipsoid;
                                                StandardEllipsoid: TFocalEllipsoid);

// Отождествление всех фокусных углов смещённого эллипсоида
// с фокусными углами исходного эллипсоида.
procedure AssignOtherEllipsoidAngles(var GivenEllipsoid: TFocalEllipsoid;
                                         StandardEllipsoid: TFocalEllipsoid);


//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                                                                                         

implementation

// Расчёт радиусов фокусного эллипсоида
// по координатам фокуса через биквадратное уравнение.
procedure TFocalEllipsoid.SetRadiusesByFocusCoordinates;
var
  // Дискриминант биквадратного уравнения.
  Discriminant: Single;
  // Второй коэффициент в биквадратном уравнении
  // при неизвестном во второй степени.
  SecondCoefficient: Single;
begin // TFocalEllipsoid.SetRadiusesByFocusCoordinates
  // Параметры биквадратного уравнения.
  SecondCoefficient:=DefiningParameters.Centres.RightCoordinates.X *
                     DefiningParameters.Centres.RightCoordinates.X -
                     Focus.Coordinates.X * Focus.Coordinates.X -
                     Focus.Coordinates.Y * Focus.Coordinates.Y -
                     Focus.Coordinates.Z * Focus.Coordinates.Z;

  Discriminant:=SecondCoefficient * SecondCoefficient + 4 *
                DefiningParameters.Centres.RightCoordinates.X *
                DefiningParameters.Centres.RightCoordinates.X *(
                Focus.Coordinates.Y * Focus.Coordinates.Y +
                Focus.Coordinates.Z * Focus.Coordinates.Z );

  // Вычисление радиусов фокусного эллипсоида.
  with DefiningParameters do
    begin
      Radiuses.YRadius:=Sqrt((-SecondCoefficient+Sqrt(Discriminant))/2);
      Radiuses.ZRadius:=Radiuses.YRadius;

      Radiuses.XRadius:=Sqrt( Radiuses.YRadius*Radiuses.YRadius +
                              Centres.RightCoordinates.X *
                              Centres.RightCoordinates.X );
    end;
  // Перевод радиусов фокусного эллипсоида из процентов в миллиметры.
  with DefiningParameters.Radiuses do
    begin
      XRadiusInMillimeters:=Round(XRadius/ScaleFactorPercentsInMillimeter);
      YRadiusInMillimeters:=Round(YRadius/ScaleFactorPercentsInMillimeter);
      ZRadiusInMillimeters:=Round(ZRadius/ScaleFactorPercentsInMillimeter);
    end;

  if (DefiningParameters.Radiuses.XRadiusInMillimeters=0) and
     (DefiningParameters.Centres.BetweenDistanceInMillimeters<>0)
    then begin // if (DefiningParameters.Radiuses.XRadiusInMillimeters=0)
           // Радиусы фокусного эллипсоида.
           with DefiningParameters do
             begin
               Radiuses.XRadius:=Centres.RightCoordinates.X;
               Radiuses.YRadius:=0;
               Radiuses.ZRadius:=0;
             end;
           // Перевод радиусов фокусного эллипсоида из процентов в миллиметры.
           with DefiningParameters.Radiuses do
             begin
               XRadiusInMillimeters:=Round(XRadius/ScaleFactorPercentsInMillimeter);
               YRadiusInMillimeters:=0;
               ZRadiusInMillimeters:=0;
             end;
         end; // if (DefiningParameters.Radiuses.XRadiusInMillimeters=0)
end; // TFocalEllipsoid.SetRadiusesByFocusCoordinates

// Расчёт длины радиус-вектора фокусного эллипсоида по координатам фокуса.
procedure TFocalEllipsoid.SetFocusRadiusVectorByFocusCoordinates;
begin // TFocalEllipsoid.SetFocusRadiusVectorByFocusCoordinates
  with Focus do
    begin
      RadiusVector:=Sqrt(Coordinates.X*Coordinates.X+
                         Coordinates.Y*Coordinates.Y+
                         Coordinates.Z*Coordinates.Z);
      // Перевод из процентов в миллиметры.
      RadiusVectorInMillimeters:=Round(RadiusVector/ScaleFactorPercentsInMillimeter);
    end;
end; // TFocalEllipsoid.SetFocusRadiusVectorByFocusCoordinates

// Расчёт длины радиус-вектора фокусного эллипсоида
// по его радиусам и углам между радиус-вектором и координатными осями.
procedure TFocalEllipsoid.SetFocusRadiusVectorByRadiusesAndFocusAngies;
begin // TFocalEllipsoid.SetFocusRadiusVectorByRadiusesAndFocusAngies
  Focus.RadiusVector:=1 / Sqrt( Cos(Focus.Angles.FOX) * Cos(Focus.Angles.FOX) /
                                DefiningParameters.Radiuses.XRadius /
                                DefiningParameters.Radiuses.XRadius +
                                ( Cos(Focus.Angles.FOY) * Cos(Focus.Angles.FOY) +
                                  Cos(Focus.Angles.FOZ) * Cos(Focus.Angles.FOZ) ) /
                                  DefiningParameters.Radiuses.YRadius /
                                  DefiningParameters.Radiuses.YRadius );
  // Перевод из процентов в миллиметры.
  with Focus do
    RadiusVectorInMillimeters:=Round(RadiusVector/ScaleFactorPercentsInMillimeter);
end; // TFocalEllipsoid.SetFocusRadiusVectorByRadiusesAndFocusAngies

// Расчёт координат фокуса фокусного эллипкоида
// по длине радиус-вектора и углам между радиус-вектором и координатными осями.
procedure TFocalEllipsoid.SetFocusCoordinates;
begin // TFocalEllipsoid.SetFocusCoordinates
  with Focus do
    begin
      Coordinates.X:=RadiusVector*Cos(Angles.FOX);
      Coordinates.Y:=RadiusVector*Cos(Angles.FOY);
      Coordinates.Z:=RadiusVector*Cos(Angles.FOZ);
      // Перевод из процентов в миллиметры.
      XFocusInMillimeters:=Round(Coordinates.X/ScaleFactorPercentsInMillimeter);
      YFocusInMillimeters:=Round(Coordinates.Y/ScaleFactorPercentsInMillimeter);
      ZFocusInMillimeters:=Round(Coordinates.Z/ScaleFactorPercentsInMillimeter);
    end;
end; // TFocalEllipsoid.SetFocusCoordinates

// Расчёт углов между радиус-вектором и координатными осями фокусного эллипсоида
// по его координатам фокуса и длине радиус-вектора.
procedure TFocalEllipsoid.SetFocusAngles;
begin // TFocalEllipsoid.SetFocusAngles
  with Focus do
    begin
      // При нудевом радиус-векторе во избежвние деления на нуль.
      if RadiusVector=0
        then begin
               Angles.FOX:=Pi/2;
               Angles.FOY:=0;
               Angles.FOZ:=Pi/2;
             end
        else begin
               Angles.FOX:=ArcCos(Coordinates.X/RadiusVector);
               Angles.FOY:=ArcCos(Coordinates.Y/RadiusVector);
               Angles.FOZ:=ArcCos(Coordinates.Z/RadiusVector);
             end;

      with Angles do
        begin
          FOXInDegrees:=FOX*180/Pi;
          FOYInDegrees:=FOY*180/Pi;
          FOZInDegrees:=FOZ*180/Pi;
        end; // with Angles
    end; // with Focus
end; // TFocalEllipsoid.SetFocusAngles

// Коструктор.
constructor TFocalEllipsoid.Create(BetweenDistanceInMillimeters: Word;
                                   RadiusDeterminator: TRadiusDeterminator;
                                   RadiusInMillimeters: Word;

                                   NumberFrontalFrameworkLinesIn1Octant,
                                   NumberHorizontalFrameworkLinesIn1Octant,
                                   NumberVerticalFrameworkLinesIn1Octant: ShortInt;

                                   bFrontalFrameworkLinesDraw,
                                   bHorizontalFrameworkLinesDraw,
                                   bVerticalFrameworkLinesDraw: Boolean;

                                   AngleFOXInDegrees,
                                   AngleFOYInDegrees: Single);

begin // Create
  // Вызов метода родительского класса TEllipsoid.
  inherited Create(BetweenDistanceInMillimeters,
                   RadiusDeterminator,
                   RadiusInMillimeters,

                   NumberFrontalFrameworkLinesIn1Octant,
                   NumberHorizontalFrameworkLinesIn1Octant,
                   NumberVerticalFrameworkLinesIn1Octant,

                   bFrontalFrameworkLinesDraw,
                   bHorizontalFrameworkLinesDraw,
                   bVerticalFrameworkLinesDraw);
  // Углы между радиус-вектором и координатными осями фокусного эллипсоида.
  with Focus.Angles do
    begin
      FOXInDegrees:=AngleFOXInDegrees;
      FOYInDegrees:=AngleFOYInDegrees;

      FOX:=FOXInDegrees*Pi/180;
      FOY:=FOYInDegrees*Pi/180;

      if (Abs(FOXInDegrees) = 90) or (Abs(FOYInDegrees) = 90) then
        begin
          FOZInDegrees:=90;
          FOZ:=Pi/2;
        end
      else
        begin
          FOZ:=ArcCos( Sqrt(1 - Cos(FOX)*Cos(FOX) - Cos(FOY)*Cos(FOY)) );
          FOZInDegrees:=FOZ*180/Pi;
        end;
    end;
  // Расчёт длины радиус-вектора фокусного эллипсоида
  // по его радиусам и углам между радиус-вектором и координатными осями.
  SetFocusRadiusVectorByRadiusesAndFocusAngies;
  // Расчёт координат фокуса фокусного эллипкоида
  // по длине радиус-вектора и углам между радиус-вектором и координатными осями.
  SetFocusCoordinates;
end; // Create

// Изменение масштаба всех параметров фокусного
// из-за изменившегося масштабного коэффициента.
procedure TFocalEllipsoid.ReScaleAllParameters;
begin // TFocalEllipsoid.ReScaleAllParameters
  // Вызов наследуемого метода ReScaleAllParameters,
  // совпадающего по имени с менем данного метода
  // (откуда вызывается метод родительского класса).
  inherited;
  // Расчёт длины радиус-вектора фокусного эллипсоида
  // по его радиусам и углам между радиус-вектором и координатными осями.
  SetFocusRadiusVectorByRadiusesAndFocusAngies;
  // Расчёт координат фокуса фокусного эллипкоида
  // по длине радиус-вектора и углам между радиус-вектором и координатными осями.
  SetFocusCoordinates;
end; // TFocalEllipsoid.ReScaleAllParameters

// Перерасчёт параметров центров фокусного эллипсоида.
procedure TFocalEllipsoid.ReSetCentres(NewBetweenDistanceInMillimeters: Word);
begin // TFocalEllipsoid.ReSetCentres
  // Вызов метода родительского класса TEllipsoid.
  inherited ReSetCentres(NewBetweenDistanceInMillimeters);
  // Расчёт длины радиус-вектора фокусного эллипсоида
  // по его радиусам и углам между радиус-вектором и координатными осями.
  SetFocusRadiusVectorByRadiusesAndFocusAngies;
  // Расчёт координат фокуса фокусного эллипкоида
  // по длине радиус-вектора и углам между радиус-вектором и координатными осями.
  SetFocusCoordinates;
end; // TFocalEllipsoid.ReSetCentres

// Перерасчёт параметров радиусов фокусного эллипсоида.
procedure TFocalEllipsoid.ReSetRadiuses(NewRadiusInMillimeters: Word;
                                        NewRadiusDeterminator: TRadiusDeterminator);
begin // TFocalEllipsoid.ReSetRadiuses
  // Вызов метода родительского класса TEllipsoid.
  inherited ReSetRadiuses(NewRadiusInMillimeters,NewRadiusDeterminator);
  // Расчёт длины радиус-вектора фокусного эллипсоида
  // по его радиусам и углам между радиус-вектором и координатными осями.
  SetFocusRadiusVectorByRadiusesAndFocusAngies;
  // Расчёт координат фокуса фокусного эллипкоида
  // по длине радиус-вектора и углам между радиус-вектором и координатными осями.
  SetFocusCoordinates;
end; // TFocalEllipsoid.ReSetRadiuses

// Перерасчёт координат фокуса фокусного эллипсоида.
procedure TFocalEllipsoid.ReSetFocusCoordinates(
  NewFocusCoordinateInMillimeters: Word;
  NewFocusCoordinateDeterminator: TFocusCoordinateDeterminator);
begin // TFocalEllipsoid.ReSetFocusCoordinates
  // Изменение заданной координаты.
  with Focus do
    case NewFocusCoordinateDeterminator of
      XFocusCoordinateDeterminator:
        begin // XFocusCoordinateDeterminator
          XFocusInMillimeters:=NewFocusCoordinateInMillimeters;
          Coordinates.X:=XFocusInMillimeters*ScaleFactorPercentsInMillimeter;
        end; // XFocusCoordinateDeterminator

      YFocusCoordinateDeterminator:
        begin // YFocusCoordinateDeterminator
          YFocusInMillimeters:=NewFocusCoordinateInMillimeters;
          Coordinates.Y:=YFocusInMillimeters*ScaleFactorPercentsInMillimeter;
        end; // YFocusCoordinateDeterminator

      ZFocusCoordinateDeterminator:
        begin // ZFocusCoordinateDeterminator
          ZFocusInMillimeters:=NewFocusCoordinateInMillimeters;
          Coordinates.Z:=ZFocusInMillimeters*ScaleFactorPercentsInMillimeter;
        end; // ZFocusCoordinateDeterminator
    end; // case

  // Расчёт радиусов фокусного эллипсоида
  // по координатам фокуса через биквадратное уравнение.
  SetFocusRadiusVectorByFocusCoordinates;
  // Расчёт радиусов фокусного эллипсоида
  // по координатам фокуса через биквадратное уравнение.
  SetRadiusesByFocusCoordinates;
  // Расчёт углов между радиус-вектором и координатными осями фокусного эллипсоида
  // по его координатам фокуса и длине радиус-вектора.
  SetFocusAngles;
{  // Расчёт линий нового каркаса эллипсоида в первом октанте.
  SetFrameworkLinesIn1Octant;}
end; // TFocalEllipsoid.ReSetFocusCoordinates

// Перерасчёт длины радиус-вектора фокуса фокусного эллипсоида.
procedure TFocalEllipsoid.ReSetFocusRadiusVector(NewFocusRadiusVectorInMillimeters: Word);
begin // TFocalEllipsoid.ReSetFocusRadiusVector
  // Длина фокусного радиус-вектора.
  with Focus do
    begin
      RadiusVectorInMillimeters:=NewFocusRadiusVectorInMillimeters;
      RadiusVector:=RadiusVectorInMillimeters*ScaleFactorPercentsInMillimeter;
    end;
  // Расчёт координат фокуса фокусного эллипкоида
  // по длине радиус-вектора и углам между радиус-вектором и координатными осями.
  SetFocusCoordinates;
  // Расчёт радиусов фокусного эллипсоида
  // по координатам фокуса через биквадратное уравнение.
  SetRadiusesByFocusCoordinates;
  // Расчёт линий нового каркаса эллипсоида в первом октанте.
  SetFrameworkLinesIn1Octant;
end; // TFocalEllipsoid.ReSetFocusRadiusVector

// Перерасчёт углов между радиус-вектором и координатными осями.
procedure TFocalEllipsoid.ReSetFocusAngle(
  NewFocusAngleInDegrees: Single;
  NewFocusAngleDeterminator: TFocusAngleDeterminator);
// NewFocusAngleInDegrees - значение нового угла в градусах.
// NewFocusAngleDeterminator - название изменяемого угла.

  // Ввод значения первого угла и расчёт значения третьего,
  // удовлетворяющего соотношению вместе с двумя первыми.
  procedure BalanceAngles(var FirstAngleInDegrees,
                              SecondAngleInDegrees,
                              ThirdAngleInDegrees,

                              FirstAngle, SecondAngle, ThirdAngle: Single);
  // FirstAngleInDegrees, SecondAngleInDegrees, ThirdAngleInDegrees -
  //   первый. второй и третий углы в градусах.
  // FirstAngle, SecondAngle, ThirdAngle -
  //   первый. второй и третий углы в радианах.
  var
    // Подкоренное выражение.
    UnderRootExpression: Single;

  begin // BalanceAngles
    FirstAngleInDegrees:=NewFocusAngleInDegrees;
    FirstAngle:=FirstAngleInDegrees*Pi/180;

    SecondAngle:=SecondAngleInDegrees*Pi/180;

    UnderRootExpression:=1 - Cos(FirstAngle)*Cos(FirstAngle) -
                             Cos(SecondAngle)*Cos(SecondAngle);
    if UnderRootExpression<0
      then UnderRootExpression:=0;

    ThirdAngle:=ArcCos( Sqrt(UnderRootExpression) );
    ThirdAngleInDegrees:=ThirdAngle*180/Pi;
  end; // BalanceAngles

begin // TFocalEllipsoid.ReSetFocusAngle
  // Изменение заданного угла.
  with Focus.Angles do
    case NewFocusAngleDeterminator of
      FOXFocusAngleDeterminator:
        BalanceAngles(FOXInDegrees, FOZInDegrees, FOYInDegrees,
                      FOX,          FOZ,          FOY);

      FOYFocusAngleDeterminator:
        BalanceAngles(FOYInDegrees, FOXInDegrees, FOZInDegrees,
                      FOY,          FOX,          FOZ);

      FOZFocusAngleDeterminator:
        BalanceAngles(FOZInDegrees, FOYInDegrees, FOXInDegrees,
                      FOZ,          FOY,          FOX);
    end; // case

  // Расчёт длины радиус-вектора фокусного эллипсоида
  // по его радиусам и углам между радиус-вектором и координатными осями.
  SetFocusRadiusVectorByRadiusesAndFocusAngies;
  // Расчёт координат фокуса фокусного эллипкоида
  // по длине радиус-вектора и углам между радиус-вектором и координатными осями.
  SetFocusCoordinates;
end; // TFocalEllipsoid.ReSetFocusAngle

// Перерасчёт всех углов между радиус-вектором и координатными осями.
procedure TFocalEllipsoid.ReSetAllFocusAngles(NewAngleFOXInDegrees,
                                              NewAngleFOYInDegrees,
                                              NewAngleFOZInDegrees: Single);
begin // TFocalEllipsoid.ReSetAllFocusAngles
  // Изменение заданного угла.
  with Focus.Angles do
   begin
     FOXInDegrees:=NewAngleFOXInDegrees;
     FOYInDegrees:=NewAngleFOYInDegrees;
     FOZInDegrees:=NewAngleFOZInDegrees;

     FOX:=FOXInDegrees*Pi/180;
     FOY:=FOYInDegrees*Pi/180;
     FOZ:=FOZInDegrees*Pi/180;
   end;
  // Расчёт длины радиус-вектора фокусного эллипсоида
  // по его радиусам и углам между радиус-вектором и координатными осями.
  SetFocusRadiusVectorByRadiusesAndFocusAngies;
  // Расчёт координат фокуса фокусного эллипкоида
  // по длине радиус-вектора и углам между радиус-вектором и координатными осями.
  SetFocusCoordinates;
end; // TFocalEllipsoid.ReSetAllFocusAngles

// Отрисовка линий соединения точек центров эллипсоида с фокусом.
procedure TFocalEllipsoid.DrawFocalLines(
  LeftCentreColorComponents,
  RightCentreColorComponents: TColorComponents;

  FocusEllipsoidVectorCenterToFocusLineWidth,
  FocusEllipsoidFocusRadiusVectorLineWidth: Single);
// FocalEllipsoidFocusColorComponents - компоненты цвета точки фокуса.
// LeftCentreColorComponents, RightCentreColorComponents - компоненты цветов
//   левого и правого центров.
// FocusEllipsoidVectorCenterToFocusLineWidth - ширина линии вектороа
//   между центром и фокусом фокусного эллипсоида.
// FocusEllipsoidFocusRadiusVectorLineWidth - ширина линии радиус-вектора.

begin // TFocalEllipsoid.DrawFocalLines
  // Признак отрисовки линий соединения точек центров с фокусом.
  if Focus.bFocusLines=True
    then begin
           // Отрезки, соединяющие центры и фокусы.
           // Установка ширины линий.
           glLineWidth(FocusEllipsoidVectorCenterToFocusLineWidth);
           // Каждая пара точек рассматривается как независимый отрезок.
           glBegin(GL_LINES);
             // Левый зрительный центр.
             with LeftCentreColorComponents do
               glColor4f(Red, Green, Blue, AlphaChannel);
             with DefiningParameters.Centres.LeftCoordinates do
               glVertex3f(-X,Y,Z);
             // Фокус.
             with Focus.FocusColorComponents do
               glColor4f(Red, Green, Blue, AlphaChannel);
             with Focus.Coordinates do
               glVertex3f(-X,Y,Z);

             // Правый зрительный центр.
             with RightCentreColorComponents do
               glColor4f(Red, Green, Blue, AlphaChannel);
             with DefiningParameters.Centres.RightCoordinates do
               glVertex3f(-X,Y,Z);
             // Фокус.
             with Focus.FocusColorComponents do
               glColor4f(Red, Green, Blue, AlphaChannel);
             with Focus.Coordinates do
               glVertex3f(-X,Y,Z);
           glEnd();

           // Отрезок от начала координат до фокуса.
           // Установка ширины линий.
           glLineWidth(FocusEllipsoidFocusRadiusVectorLineWidth);
           // Каждая пара точек рассматривается как независимый отрезок.
           glBegin(GL_LINES);
             // Растяжка цвета до фокуса.
             with Focus.FocusColorComponents do
               glColor4f(Red*2, Green*2, Blue*2, AlphaChannel);
             glVertex3f(0,0,0);

             with Focus.FocusColorComponents do
               glColor4f(Red, Green, Blue, AlphaChannel);
             with Focus.Coordinates do
               glVertex3f(-X,Y,Z);
           glEnd();
         end; // if Focus.bFocusLines=True
end; // TFocalEllipsoid.DrawFocalLines

//******************************************************************************

// Отождествление всех параметров с другим эллипсоидом
// при ориентации на его конкретный радиус.
procedure AssignOtherEllipsoidAllParameters(var GivenEllipsoid: TFocalEllipsoid;
                                                StandardEllipsoid: TFocalEllipsoid);
// GivenEllipsoid - эллипсоид, параметры которого изменяются.
// StandardEllipsoid - эллипсоид-эталон, на который ориентированы изменения.

begin // AssignOtherEllipsoidAllParameters
  case StandardEllipsoid.DefiningParameters.Radiuses.Determinator of
    XRadiusDeterminator:
      GivenEllipsoid.ReSetRadiuses(
        StandardEllipsoid.DefiningParameters.Radiuses.XRadiusInMillimeters,
        XRadiusDeterminator);
    YRadiusDeterminator:
      GivenEllipsoid.ReSetRadiuses(
        StandardEllipsoid.DefiningParameters.Radiuses.YRadiusInMillimeters,
        YRadiusDeterminator);
    ZRadiusDeterminator:
      GivenEllipsoid.ReSetRadiuses(
        StandardEllipsoid.DefiningParameters.Radiuses.ZRadiusInMillimeters,
        ZRadiusDeterminator);
  end; // case
end; // AssignOtherEllipsoidAllParameters

// Отождествление всех фокусных углов смещённого эллипсоида
// с фокусными углами исходного эллипсоида.
procedure AssignOtherEllipsoidAngles(var GivenEllipsoid: TFocalEllipsoid;
                                         StandardEllipsoid: TFocalEllipsoid);
// GivenEllipsoid - эллипсоид, фокусные углы которого изменяются.
// StandardEllipsoid - эллипсоид-эталон, на который ориентированы изменения.

begin // AssignOtherEllipsoidAngles
  if (StandardEllipsoid.Focus.Angles.FOXInDegrees<>
      GivenEllipsoid.Focus.Angles.FOXInDegrees ) or
     (StandardEllipsoid.Focus.Angles.FOYInDegrees<>
      GivenEllipsoid.Focus.Angles.FOYInDegrees ) or
     (StandardEllipsoid.Focus.Angles.FOZInDegrees<>
      GivenEllipsoid.Focus.Angles.FOZInDegrees )

    then GivenEllipsoid.ReSetAllFocusAngles(
           StandardEllipsoid.Focus.Angles.FOXInDegrees,
           StandardEllipsoid.Focus.Angles.FOYInDegrees,
           StandardEllipsoid.Focus.Angles.FOZInDegrees );
end; // AssignOtherEllipsoidAngles

end.
