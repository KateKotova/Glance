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

// Построение эллипсоида.
unit Ellipsoid_Unit;

interface

uses
  // Glance-модуль.
  Base_Unit,
  // Стандартный модуль.
  OpenGL;

const
  // Минимальное количество параллельных
  // линии каркаса эллипсоида в одном октанте.
  MinNumEllipsoidParallelFrameworkLinesInOctant=4;
  // Максимальное количество параллельных
  // линии каркаса эллипсоида в одном октанте.
  MaxNumEllipsoidParallelFrameworkLinesInOctant=14;
  // Максимальное межцентровое расстояние в миллиметрах.
  MaxEllipsoidBetweenDistanceInMillimeters=800;
  // Максимальный радиус эллипсоида в миллиметрах.
  MaxEllipsoidRadiusInMillimeters=20000;

type              
  // Указатель на точу в трёхмерном пространстве.
  PCoordinates = ^TCoordinates;

  // Массив указателей точек линии в трёхмерном пространстве.
  TLinePoints = array[1..9*MaxNumEllipsoidParallelFrameworkLinesInOctant+1] of PCoordinates;
  // Указатель на массив указателей точек линии в трёхмерном пространстве.
  PLinePoints = ^TLinePoints;
  // Массив указателей на массивы указателей точек линий каркаса
  // в трёхмерном пространстве.
  TFrameworkLines = array[1..MaxNumEllipsoidParallelFrameworkLinesInOctant] of PLinePoints;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  // Параллельные линии каркаса в первом октанте.
  TParallelFrameworkLinesIn1Octant = record
    // Количество параллельных линий каркаса в первом октанте.
    Number: Byte;
    // Массив указателей на массивы указателей точек
    // параллельных линий каркаса
    // в первом октанте трёхмерного пространства.
    FrameworkLines: TFrameworkLines;
    // Компоненты текущего цвета вершин эллипсоида.
    VertexColorComponents: TColorComponents;
    // Признак отрисовки параллельных линий каркаса.
    bDraw: Boolean;
  end; // TDirectedFrameworkLinesIn1Octantъ

  // Параметры центров эллипсоида.
  TCentres = record
    // Координаты левого центра эллипсоида.
    LeftCoordinates: TCoordinates;
    // Координаты правого центра эллипсоида.
    RightCoordinates: TCoordinates;
    // Межцентровое расстояние эллипсоида.
    BetweenDistance: Single;
    // Межцентровое расстояние эллипсоида в миллиметрах.
    BetweenDistanceInMillimeters: Word;
  end; // TCentres

  // Параметр, определяющий все радиусы эллипсоида.
  TRadiusDeterminator = (XRadiusDeterminator,
                         YRadiusDeterminator,
                         ZRadiusDeterminator);

  // Радиусы эллипсоида.
  TRadiuses = record
    // Параметр, определяющий
    // все радиусы эллипсоида.
    Determinator: TRadiusDeterminator;

    // Радиусы эллипсоида по координатным осям.
    XRadius, YRadius, ZRadius: Single;
    // Радиусы эллипсоида по координатным осям в миллиметрах.
    XRadiusInMillimeters,
    YRadiusInMillimeters,
    ZRadiusInMillimeters: Word;
  end; // TRadiuses

  // Определяющие параметры эллипсоида.
  TDefiningParameters = record
    // Параметры центров эллипсоида.
    Centres: TCentres;
    // Радиусы эллипсоида.
    Radiuses: TRadiuses;
  end; // TDefiningParameters

  // Линии каркаса эллипсоида в первом октанте.
  TFrameworkLinesIn1Octant = record
    // Вертикальные линии каркаса эллипсоида в первом октанте.
    Vertical: TParallelFrameworkLinesIn1Octant;
    // Горизонтальные линии каркаса эллипсоида в первом октанте.
    Horizontal: TParallelFrameworkLinesIn1Octant;
    // Фронтальные линии каркаса эллипсоида в первом октанте.
    Frontal: TParallelFrameworkLinesIn1Octant;
    // Количество точек для построения
    // линии каркаса эллипсоида в первом октанте.
    NumFrameworkLinePoints: LongInt;
    // Признак отрисовки хотя бы каких-нибудь
    // параллельных линий каркаса.
    bAnyLinesDraw: Boolean;
  end; // TFrameworkLinesIn1Octant

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  // Эллипсоид.
  TEllipsoid = class(TObject)
    public
      DefiningParameters: TDefiningParameters;
      FrameworkLinesIn1Octant: TFrameworkLinesIn1Octant;

      // Конструктор: создание нового эллипсоида.
      constructor Create(BetweenDistanceInMillimeters: Word;
                         RadiusDeterminator: TRadiusDeterminator;
                         RadiusInMillimeters: Word;

                         NumberFrontalFrameworkLinesIn1Octant,
                         NumberHorizontalFrameworkLinesIn1Octant,
                         NumberVerticalFrameworkLinesIn1Octant: Byte;

                         bFrontalFrameworkLinesDraw,
                         bHorizontalFrameworkLinesDraw,
                         bVerticalFrameworkLinesDraw: Boolean);
      // Изменение масштаба всех параметров эллипсоида
      // из-за изменившегося масштабного коэффициента.
      procedure ReScaleAllParameters;                   
      // Расчёт количества точек линии каркаса эллипсоида в первом октанте.
      procedure SetNumPointsInFrameworkLineIn1Octant;
      // Расчёт линий каркаса эллипсоида в первом октанте.
      procedure SetFrameworkLinesIn1Octant;
      //Отрисовка эллипсоида.
      procedure Draw(EllipsoidVertexLineWidth: Single);
      // Выделение динамической памяти
      // под массив указателей на массивы указателей точек
      // линий каркаса эллипсоида в первом октанте трёхмерного пространства.
      procedure NewFrameworkLinesIn1Octant;
      // Удаление линий каркаса эллипсоида в первом октанте
      // путём освобождения динамической памяти.
      procedure DisposeFrameworkLinesIn1Octant;
      // Перерасчёт линий каркаса эллипсоида в первом октанте.
      procedure ReSetFrameworkLinesIn1Octant(
        NewNumFrontalFrameworkLinesIn1Octant,
        NewNumHorizontalFrameworkLinesIn1Octant,
        NewNumVerticalFrameworkLinesIn1Octant: LongInt);
      // Расчёт параметров центров эллипсоида.
      procedure SetCentres;
      // Расчёт радиусов эллипсоида.
      procedure SetRadiuses(DefiningRadiusInMillimeters: Word);
      // Перерасчёт параметров центров эллипсоида.
      procedure ReSetCentres(NewBetweenDistanceInMillimeters: Word);
      // Перерасчёт параметров радиусов эллипсоида.
      procedure ReSetRadiuses(NewRadiusInMillimeters: Word;
                              NewRadiusDeterminator: TRadiusDeterminator);
      // Деструктор: удаление эллипсоида.
      destructor Destroy;
      
    protected
    private
  end; // TEllipsoid

  
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

implementation

// Коструктор.
constructor TEllipsoid.Create(BetweenDistanceInMillimeters: Word;
                              RadiusDeterminator: TRadiusDeterminator;
                              RadiusInMillimeters: Word;

                              NumberFrontalFrameworkLinesIn1Octant,
                              NumberHorizontalFrameworkLinesIn1Octant,
                              NumberVerticalFrameworkLinesIn1Octant: Byte;

                              bFrontalFrameworkLinesDraw,
                              bHorizontalFrameworkLinesDraw,
                              bVerticalFrameworkLinesDraw: Boolean);
begin // Create
  // Вызов метода родительского класса TObject.
  inherited Create;

  DefiningParameters.Centres.BetweenDistanceInMillimeters:=
    BetweenDistanceInMillimeters;

  // Расчёт параметров центров эллипсоида.
  SetCentres;

  DefiningParameters.Radiuses.Determinator:=RadiusDeterminator;
  // Расчёт радиусов эллипсоида.
  SetRadiuses(RadiusInMillimeters);
  with FrameworkLinesIn1Octant do
    begin // with FrameworkLinesIn1Octant do
      Frontal.Number:=NumberFrontalFrameworkLinesIn1Octant;
      Horizontal.Number:=NumberHorizontalFrameworkLinesIn1Octant;
      Vertical.Number:=NumberVerticalFrameworkLinesIn1Octant;

      Frontal.bDraw:=bFrontalFrameworkLinesDraw;
      Horizontal.bDraw:=bHorizontalFrameworkLinesDraw;
      Vertical.bDraw:=bVerticalFrameworkLinesDraw;

      if bFrontalFrameworkLinesDraw or
         bHorizontalFrameworkLinesDraw or
         bVerticalFrameworkLinesDraw

        then bAnyLinesDraw:=True
        else bAnyLinesDraw:=False;
    end; // with FrameworkLinesIn1Octant do

  // Расчёт количества точек линии каркаса эллипсоида в первом октанте.
  SetNumPointsInFrameworkLineIn1Octant;

  // Выделение динамической памяти
  // под массив указателей на массивы указателей точек
  // линий каркаса эллипсоида в первом октанте трёхмерного пространства.
  NewFrameworkLinesIn1Octant;
  // Расчёт линий каркаса эллипсоида в первом октанте.
  SetFrameworkLinesIn1Octant;
end; // Create

// Деструктор.
destructor TEllipsoid.Destroy;
begin // Destroy
  // Удаление линий каркаса эллипсоида в первом октанте
  // путём освобождения динамической памяти.
  DisposeFrameworkLinesIn1Octant;
  // Вызов метода родительского класса TObject.
  inherited Destroy;
end; // Destroy

// Изменение масштаба всех параметров из-за изменившегося
// масштабного коэффициента.
procedure TEllipsoid.ReScaleAllParameters;
begin // TEllipsoid.ReScaleAllParameters
  // Расчёт параметров центров эллипсоида.
  SetCentres;

  DefiningParameters.Radiuses.Determinator:=XRadiusDeterminator;
  // Расчёт радиусов эллипсоида.
  SetRadiuses(DefiningParameters.Radiuses.XRadiusInMillimeters);

  // Расчёт линий каркаса эллипсоида в первом октанте.
  SetFrameworkLinesIn1Octant;
end; // TEllipsoid.ReScaleAllParameters


// Расчёт параметров центров эллипсоида.
procedure TEllipsoid.SetCentres;
begin // TEllipsoid.SetCentres
  with DefiningParameters.Centres do
    begin
      BetweenDistance:=BetweenDistanceInMillimeters*
                       ScaleFactorPercentsInMillimeter;

      RightCoordinates.X:=BetweenDistance/2;
      BetweenDistance:=2*RightCoordinates.X;
      LeftCoordinates.X:=-RightCoordinates.X;

      RightCoordinates.Y:=0;
      RightCoordinates.Z:=0;
      LeftCoordinates.Y:=0;
      LeftCoordinates.Z:=0;
    end; // with DefiningParameters.Centres
end; // TEllipsoid.SetCentres

// Расчёт радиусов эллипсоида.
procedure TEllipsoid.SetRadiuses(DefiningRadiusInMillimeters: Word);
begin // TEllipsoid.SetRadiuses
  with DefiningParameters.Radiuses do
    case Determinator of
      XRadiusDeterminator:
        begin // XRadiusDeterminator
          XRadiusInMillimeters:=DefiningRadiusInMillimeters;
          XRadius:=XRadiusInMillimeters*ScaleFactorPercentsInMillimeter;

          YRadius:=sqrt(XRadius*XRadius -
                        DefiningParameters.Centres.RightCoordinates.X*
                        DefiningParameters.Centres.RightCoordinates.X);
          YRadiusInMillimeters:=Round(YRadius/ScaleFactorPercentsInMillimeter);

          ZRadius:=YRadius;
          ZRadiusInMillimeters:=Round(ZRadius/ScaleFactorPercentsInMillimeter);
        end; // XRadiusDeterminator

      YRadiusDeterminator:
        begin // YRadiusDeterminator
          YRadiusInMillimeters:=DefiningRadiusInMillimeters;
          YRadius:=YRadiusInMillimeters*ScaleFactorPercentsInMillimeter;

          XRadius:=sqrt(YRadius*YRadius +
                        DefiningParameters.Centres.RightCoordinates.X*
                        DefiningParameters.Centres.RightCoordinates.X);
          XRadiusInMillimeters:=Round(XRadius/ScaleFactorPercentsInMillimeter);

          ZRadius:=YRadius;
          ZRadiusInMillimeters:=Round(ZRadius/ScaleFactorPercentsInMillimeter);
        end; // YRadiusDeterminator

      ZRadiusDeterminator:
         begin // ZRadiusDeterminator
           ZRadiusInMillimeters:=DefiningRadiusInMillimeters;
           ZRadius:=ZRadiusInMillimeters*ScaleFactorPercentsInMillimeter;

           XRadius:=sqrt(ZRadius*ZRadius +
                         DefiningParameters.Centres.RightCoordinates.X*
                         DefiningParameters.Centres.RightCoordinates.X);
           XRadiusInMillimeters:=Round(XRadius/ScaleFactorPercentsInMillimeter);

           YRadius:=ZRadius;
           YRadiusInMillimeters:=Round(YRadius/ScaleFactorPercentsInMillimeter);
         end; // ZRadiusDeterminator
    end; // case
end; // TEllipsoid.SetRadiuses

// Перерасчёт параметров центров эллипсоида.
procedure TEllipsoid.ReSetCentres(NewBetweenDistanceInMillimeters: Word);
begin // TEllipsoid.ReSetCentres
  DefiningParameters.Centres.BetweenDistanceInMillimeters:=
    NewBetweenDistanceInMillimeters;
  // Расчёт параметров центров эллипсоида.
  SetCentres;
  DefiningParameters.Radiuses.Determinator:=XRadiusDeterminator;
  // Расчёт радиусов эллипсоида.
  SetRadiuses(DefiningParameters.Radiuses.XRadiusInMillimeters);

  // Расчёт линий нового каркаса эллипсоида в первом октанте.
  SetFrameworkLinesIn1Octant;
end; // TEllipsoid.ReSetCentres

// Перерасчёт параметров радиусов эллипсоида.
procedure TEllipsoid.ReSetRadiuses(NewRadiusInMillimeters: Word;
                                   NewRadiusDeterminator: TRadiusDeterminator);
begin // TEllipsoid.ReSetRadiuses
  DefiningParameters.Radiuses.Determinator:=NewRadiusDeterminator;
  // Расчёт радиусов эллипсоида.
  SetRadiuses(NewRadiusInMillimeters);

  // Расчёт линий нового каркаса эллипсоида в первом октанте.
  SetFrameworkLinesIn1Octant;
end; // TEllipsoid.ReSetRadiuses


// Расчёт количества точек линии каркаса эллипсоида в первом октанте.
procedure TEllipsoid.SetNumPointsInFrameworkLineIn1Octant;
begin // TEllipsoid.SetNumPointsFrameworkLineIn1Octant
  with FrameworkLinesIn1Octant do
    NumFrameworkLinePoints:=3*(Vertical.Number+
                               Horizontal.Number+Frontal.Number);
end; // TEllipsoid.SetNumPointsFrameworkLineIn1Octant

//***********************************************************

// Расчёт линий каркаса эллипсоида в первом октанте.
procedure TEllipsoid.SetFrameworkLinesIn1Octant;
var
  // Параметры циклов
  i, j: Byte;

  // Неменяющаяся координата
  // вертикальной, горизонтальной или фронтальной секущей плоскости,
  // содержащей каркасную линию эллипсоида -
  // эллиптическую дугу,
  // параллельную координатной плоскости YOZ, XOY или XOZ.
  XCurrent, ZCurrent, YCurrent: Single;

  // Текущие радиусы сечения плоскостями линий каркаса эллипсоида.
  XRadiusCurrent, YRadiusCurrent, ZRadiusCurrent: Single;

  // Радиусы эллипсоида.
  OXRadius, OYRadius, OZRadius: Single;

begin // TEllipsoid.SetFrameworkLinesIn1Octant
  // Сокращение названий радиусов эллипсоида.
  with DefiningParameters.Radiuses do
    begin
      OXRadius:=XRadius;
      OYRadius:=YRadius;
      OZRadius:=ZRadius;
    end;

  with FrameworkLinesIn1Octant do
    begin
      // Заполнение массива указателей на массивы указателей точек
      // вертикальных линий каркаса эллипсоида
      // в первом октанте трёхмерного пространства.
      with Vertical do
        begin
          for i:=1 to Number do
            begin
              // Неменяющаяся координата секущей плоскости х = XCurrent,
              // содержащей i-ую вертикальную каркасную линию.
              XCurrent:=(Number-i)*OXRadius/Number;

              // Текущие радиус вертикального сечения
              // плоскостью вертикальной линии каркаса эллипсоида.
              ZRadiusCurrent:=OZRadius*sqrt(1-XCurrent*XCurrent/
                                              OXRadius/OXRadius);
              // YRadiusCurrent:=ZRadiusCurrent;

              for j:=1 to NumFrameworkLinePoints+1 do
                begin
                  FrameworkLines[i]^[j]^.X:=XCurrent;

                  FrameworkLines[i]^[j]^.Y:=(j-1)*ZRadiusCurrent/
                                                  NumFrameworkLinePoints;
                  FrameworkLines[i]^[j]^.Z:=
                    sqrt(ZRadiusCurrent*ZRadiusCurrent-
                         FrameworkLines[i]^[j]^.Y*FrameworkLines[i]^[j]^.Y);
                end; // for j
            end; // for i
        end; // with Vertical

      // Заполнение массива указателей на массивы указателей точек
      // горизонтальных линий каркаса эллипсоида
      // в первом октанте трёхмерного пространства.
      with Horizontal do
        begin
          for i:=1 to Number do
            begin
              // Неменяющаяся координата секущей плоскости z = ZCurrent,
              // содержащей i-ую горизонтальную каркасную линию.
              ZCurrent:=(Number-i)*OZRadius/Number;

              // Текущие радиусы горизонтального сечения
              // плоскостью горизонтальной линии каркаса эллипсоида.
              XRadiusCurrent:=OXRadius*sqrt(1-ZCurrent*ZCurrent/
                                              OZRadius/OZRadius);
              YRadiusCurrent:=OYRadius*sqrt(1-ZCurrent*ZCurrent/
                                              OZRadius/OZRadius);
              for j:=1 to NumFrameworkLinePoints+1 do
                begin
                  FrameworkLines[i]^[j]^.Z:=ZCurrent;

                  FrameworkLines[i]^[j]^.Y:=(j-1)*YRadiusCurrent/
                                                  NumFrameworkLinePoints;

                  FrameworkLines[i]^[j]^.X:=XRadiusCurrent*
                    sqrt(1-FrameworkLines[i]^[j]^.Y*
                           FrameworkLines[i]^[j]^.Y/
                         YRadiusCurrent/YRadiusCurrent);
                end; // for j
            end; // for i
        end; // with Horizontal

      // Заполнение массива указателей на массивы указателей точек
      // Фронтальных линий каркаса эллипсоида
      // в первом октанте трёхмерного пространства.
      with Frontal do
        begin
          for i:=1 to Number do
            begin
              YCurrent:=(Number-i)*OYRadius/Number;

              // Текущиe радиусы фронтального сечения
              // плоскостью фронтальной линии каркаса эллипсоида.

              ZRadiusCurrent:=OZRadius*sqrt(1-YCurrent*YCurrent/
                                              OYRadius/OYRadius);
              XRadiusCurrent:=OXRadius*sqrt(1-YCurrent*YCurrent/
                                              OYRadius/OYRadius);

              for j:=1 to NumFrameworkLinePoints+1 do
                begin
                  FrameworkLines[i]^[j]^.Y:=YCurrent;

                  FrameworkLines[i]^[j]^.Z:=(j-1)*ZRadiusCurrent/
                                                  NumFrameworkLinePoints;

                  FrameworkLines[i]^[j]^.X:=XRadiusCurrent*
                    sqrt(1-FrameworkLines[i]^[j]^.Z*
                           FrameworkLines[i]^[j]^.Z/
                         ZRadiusCurrent/ZRadiusCurrent);
                end; // for j
            end; // for i
        end; // with Frontal
    end; // with FrameworkLinesIn1Octant
end; // TEllipsoid.SetFrameworkLinesIn1Octant

// Выделение динамической памяти
// под массив указателей на массивы указателей точек
// линий каркаса эллипсоида в первом октанте трёхмерного пространства.
procedure TEllipsoid.NewFrameworkLinesIn1Octant;
  // Выделение динамической памяти
  // под параллельные линии каркаса эллипсоида в первом октанте.
  procedure NewParallelFrameworkLinesIn1Octant(
    var ParallelFrameworkLinesIn1Octant: TParallelFrameworkLinesIn1Octant;
    NumFrameworkLinePoints: LongInt);

  var
    // NumFrameworkLinePoints - количество точек для построения
    // линии каркаса эллипсоида в первом октанте.

    // Параметры циклов.
    i, j: Byte;
  begin // NewParallelFrameworkLinesIn1Octant
    with ParallelFrameworkLinesIn1Octant do
      begin
        for i:=1 to Number do
          begin
            // Каркасная линия.
            New(FrameworkLines[i]);
            for j:=1 to NumFrameworkLinePoints+1 do
              // Точка каркасной линии.
              New(FrameworkLines[i]^[j]);
          end; // for i
      end; // with ParallelFrameworkLinesIn1Octant
  end; // NewParallelFrameworkLinesIn1Octant

begin // TEllipsoid.NewFrameworkLinesIn1Octant
  with FrameworkLinesIn1Octant do
    begin
      // Выделение динамической памяти
      // под вертикальные, горизонтальные и фронтальные
      // линии каркаса эллипсоида
      // в первом октанте трёхмерного пространства.
      NewParallelFrameworkLinesIn1Octant(Vertical,NumFrameworkLinePoints);
      NewParallelFrameworkLinesIn1Octant(Horizontal,NumFrameworkLinePoints);
      NewParallelFrameworkLinesIn1Octant(Frontal,NumFrameworkLinePoints);
    end; // with FrameworkLinesIn1Octant
end; // TEllipsoid.NewFrameworkLinesIn1Octant

// Удаление линий каркаса эллипсоида в первом октанте
// путём освобождения динамической памяти.
procedure TEllipsoid.DisposeFrameworkLinesIn1Octant;
  // Удаление параллельных линий каркаса эллипсоида в первом октанте.
  procedure DisposeParallelFrameworkLinesIn1Octant(
    var ParallelFrameworkLinesIn1Octant: TParallelFrameworkLinesIn1Octant;
    NumFrameworkLinePoints: LongInt);

  var
    // NumFrameworkLinePoints - количество точек для построения
    // линии каркаса эллипсоида в первом октанте.

    // Параметры циклов.
    i, j: ShortInt;
  begin // DisposeParallelFrameworkLinesIn1Octant
    // Очистка массива указателей на массивы указателей точек
    // параллельных линий каркаса эллипсоида
    // в первом октанте трёхмерного пространства.
    with ParallelFrameworkLinesIn1Octant do
      begin
        for i:=1 to Number do
          begin
            for j:=1 to NumFrameworkLinePoints+1 do
              begin
                FrameworkLines[i]^[j]:=nil;
                // Удаление точки каркасной линии
                Dispose(FrameworkLines[i]^[j]);
              end; // for j
            FrameworkLines[i]:=nil;  
            // Удаление каркасной линии
            Dispose(FrameworkLines[i]);
          end; // for i
      end; // with ParallelFrameworkLinesIn1Octant
  end; // DisposeParallelFrameworkLinesIn1Octant

begin // TEllipsoid.DisposeFrameworkLinesIn1Octant
  with FrameworkLinesIn1Octant do
    begin
      // Очистка массива указателей на массивы указателей точек
      // вертикальных, горизонтальных и фронтальных
      // линий каркаса эллипсоида
      // в первом октанте трёхмерного пространства.
      DisposeParallelFrameworkLinesIn1Octant(Vertical,NumFrameworkLinePoints);
      DisposeParallelFrameworkLinesIn1Octant(Horizontal,NumFrameworkLinePoints);
      DisposeParallelFrameworkLinesIn1Octant(Frontal,NumFrameworkLinePoints);
    end; // with FrameworkLinesIn1Octant
end; // TEllipsoid.DisposeFrameworkLinesIn1Octant

// Перерасчёт линий каркаса эллипсоида в первом октанте.
procedure TEllipsoid.ReSetFrameworkLinesIn1Octant(
  NewNumFrontalFrameworkLinesIn1Octant,
  NewNumHorizontalFrameworkLinesIn1Octant,
  NewNumVerticalFrameworkLinesIn1Octant: LongInt);
begin // TEllipsoid.ReSetFrameworkLinesIn1Octant
  // Удаление прежних линий каркаса эллипсоида в первом октанте.
  DisposeFrameworkLinesIn1Octant;
  // Изменение количества каркасных линий.
  FrameworkLinesIn1Octant.Frontal.Number:=NewNumFrontalFrameworkLinesIn1Octant;
  FrameworkLinesIn1Octant.Horizontal.Number:=NewNumHorizontalFrameworkLinesIn1Octant;
  FrameworkLinesIn1Octant.Vertical.Number:=NewNumVerticalFrameworkLinesIn1Octant;
  // Расчёт количества точек линии каркаса эллипсоида в первом октанте.
  SetNumPointsInFrameworkLineIn1Octant;
  // Выделение динамической памяти
  // под массив указателей на массивы указателей точек
  // линий каркаса эллипсоида в первом октанте трёхмерного пространства.
  NewFrameworkLinesIn1Octant;
  // Расчёт линий нового каркаса эллипсоида в первом октанте.
  SetFrameworkLinesIn1Octant;
end; // TEllipsoid.ReSetFrameworkLinesIn1Octant

//***********************************************************
//***********************************************************

//Отрисовка эллипсоида.
procedure TEllipsoid.Draw(EllipsoidVertexLineWidth: Single);
  // EllipsoidVertexLineWidth - ширина линий каркаса эллипсоида.

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  // Отрисовка линий вертикального каркаса эллипсоида.
  procedure DrawVerticalFrameworkLines;
  var
    // Параметры циклов
    i, j: Shortint;
  begin // DrawVerticalFrameworkLines
    with FrameworkLinesIn1Octant do
      begin
        // Установка текущего цвета вершин эллипсоида
        with Vertical.VertexColorComponents do
          glColor4f(Red, Green, Blue, AlphaChannel);
        // Отрисовка линий вертикального каркаса эллипсоида.
        for i:=1 to Vertical.Number do
          begin
            // Рисуется последовательность связанных отрезков.
            glBegin(GL_LINE_STRIP);
              // Построение линий каркаса эллипсоида по точкам.
              // I октант.
              for j:=1 to NumFrameworkLinePoints+1 do
                begin
                  glVertex3f(-Vertical.FrameworkLines[i]^[j]^.X,
                              Vertical.FrameworkLines[i]^[j]^.Y,
                              Vertical.FrameworkLines[i]^[j]^.Z);
                end;
              // IV октант.
              for j:=NumFrameworkLinePoints downto 1 do
                begin
                  glVertex3f(-Vertical.FrameworkLines[i]^[j]^.X,
                              Vertical.FrameworkLines[i]^[j]^.Y,
                             -Vertical.FrameworkLines[i]^[j]^.Z);
                end;
            glEnd();

            // Чтобы дважды не прорисовывать линию каркаса в плоскости ZOY.
            if i<Vertical.Number
              then begin
                     // Рисуется последовательность связанных отрезков.
                     glBegin(GL_LINE_STRIP);
                       // Построение линий каркаса эллипсоида по точкам.
                       // V октант.
                       for j:=1 to NumFrameworkLinePoints+1 do
                         begin
                           glvertex3f( Vertical.FrameworkLines[i]^[j]^.X,
                                       Vertical.FrameworkLines[i]^[j]^.Y,
                                       Vertical.FrameworkLines[i]^[j]^.Z);
                         end;
                       // VIII октант.
                       for j:=NumFrameworkLinePoints downto 1 do
                         begin
                           glvertex3f( Vertical.FrameworkLines[i]^[j]^.X,
                                       Vertical.FrameworkLines[i]^[j]^.Y,
                                      -Vertical.FrameworkLines[i]^[j]^.Z);
                         end;
                     glEnd();
                   end; // if i<FrameworkLinesIn1Octant.Vertical.Number
          end; // for i
      end; // with FrameworkLinesIn1Octant
  end; // DrawVerticalFrameworkLines

//******************************************************************************

  // Отрисовка линий горизонтального каркаса эллипсоида.
  procedure DrawHorizontalFrameworkLines;
  var
    // Параметры циклов
    i, j: Shortint;
  begin // DrawHorizontalFrameworkLines
    with FrameworkLinesIn1Octant do
      begin
        // Установка текущего цвета вершин эллипсоида
        with Horizontal.VertexColorComponents do
          glColor4f(Red, Green, Blue, AlphaChannel);
        // Отрисовка линий горизонтального каркаса эллипсоида.
        for i:=1 to Horizontal.Number do
          begin
            // Рисуется последовательность связанных отрезков.
            glBegin(GL_LINE_STRIP);
              // Построение линий каркаса эллипсоида по точкам.
              // I октант.
              for j:=1 to NumFrameworkLinePoints+1 do
                begin
                  glvertex3f(-Horizontal.FrameworkLines[i]^[j]^.X,
                              Horizontal.FrameworkLines[i]^[j]^.Y,
                              Horizontal.FrameworkLines[i]^[j]^.Z);
                end;
              // V октант.
              for j:=NumFrameworkLinePoints downto 1 do
                begin
                  glvertex3f( Horizontal.FrameworkLines[i]^[j]^.X,
                              Horizontal.FrameworkLines[i]^[j]^.Y,
                              Horizontal.FrameworkLines[i]^[j]^.Z);
                end;
            glEnd();
             // Чтобы дважды не прорисовывать линию каркаса в плоскости ZOY.
            if i<Horizontal.Number
              then begin
                     // Рисуется последовательность связанных отрезков.
                     glBegin(GL_LINE_STRIP);
                       // Построение линий каркаса эллипсоида по точкам.
                       // IV октант.
                       for j:=1 to NumFrameworkLinePoints+1 do
                         begin
                           glvertex3f(-Horizontal.FrameworkLines[i]^[j]^.X,
                                       Horizontal.FrameworkLines[i]^[j]^.Y,
                                      -Horizontal.FrameworkLines[i]^[j]^.Z);
                         end;
                       // VIII октант.
                       for j:=NumFrameworkLinePoints downto 1 do
                         begin
                           glvertex3f( Horizontal.FrameworkLines[i]^[j]^.X,
                                       Horizontal.FrameworkLines[i]^[j]^.Y,
                                      -Horizontal.FrameworkLines[i]^[j]^.Z);
                         end;
                     glEnd();
                   end; // if i<FrameworkLinesIn1Octant.Horizontal.Number
          end; // for i
      end; // FrameworkLinesIn1Octant do
  end; // DrawHorizontalFrameworkLines

//******************************************************************************

  // Отрисовка линий фронтального каркаса эллипсоида.
  procedure DrawFrontalFrameworkLines;
  var
    // Параметры циклов
    i, j: Shortint;
  begin // DrawHFrontalFrameworkLines
    with FrameworkLinesIn1Octant do
      begin
        // Установка текущего цвета вершин эллипсоида
        with Frontal.VertexColorComponents do
          glColor4f(Red, Green, Blue, AlphaChannel);
        // Отрисовка линий фронтального каркаса эллипсоида.
        for i:=1 to Frontal.Number do
          begin
            // Рисуется последовательность связанных отрезков.
            glBegin(GL_LINE_STRIP);
              // Построение линий каркаса эллипсоида по точкам.
              // I октант.
              for j:=1 to NumFrameworkLinePoints+1 do
                begin
                  glvertex3f(-Frontal.FrameworkLines[i]^[j]^.X,
                              Frontal.FrameworkLines[i]^[j]^.Y,
                              Frontal.FrameworkLines[i]^[j]^.Z);
                end;
              // V октант.
              for j:=NumFrameworkLinePoints downto 1 do
                begin
                  glvertex3f( Frontal.FrameworkLines[i]^[j]^.X,
                              Frontal.FrameworkLines[i]^[j]^.Y,
                              Frontal.FrameworkLines[i]^[j]^.Z);
                end;
              // VIII октант.
              for j:=2 to NumFrameworkLinePoints+1 do
                begin
                  glvertex3f( Frontal.FrameworkLines[i]^[j]^.X,
                              Frontal.FrameworkLines[i]^[j]^.Y,
                             -Frontal.FrameworkLines[i]^[j]^.Z);
                end;
              // IV октант.
              for j:=NumFrameworkLinePoints downto 1 do
                begin
                  glvertex3f(-Frontal.FrameworkLines[i]^[j]^.X,
                              Frontal.FrameworkLines[i]^[j]^.Y,
                             -Frontal.FrameworkLines[i]^[j]^.Z);
                end;
            glEnd();
          end; // for i
      end; // with FrameworkLinesIn1Octant
  end; // DrawHFrontalFrameworkLines

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

begin // TEllipsoid.Draw
  // Если вообще надо отрисовывать каркас.
  if FrameworkLinesIn1Octant.bAnyLinesDraw=True
    then begin
           // Установка ширины линий.
           glLineWidth(EllipsoidVertexLineWidth);

           // Если эллипсоид вырожден в точку или отрезок.
           if DefiningParameters.Radiuses.YRadiusInMillimeters = 0
             then begin // if DefiningParameters.Radiuses.YRadiusInMillimeters = 0
                    // Установка текущего цвета вершин эллипсоида
                    with FrameworkLinesIn1Octant.Horizontal.VertexColorComponents do
                      glColor4f(Red, Green, Blue, AlphaChannel);

                    with DefiningParameters.Centres do
                      begin //  with DefiningParameters.Centres do
                        // Рисуется последовательность связанных отрезков.
                        glBegin(GL_LINE_STRIP);
                          glvertex3f(-LeftCoordinates.X,
                                      LeftCoordinates.Y,
                                      LeftCoordinates.Z);

                          glvertex3f(-RightCoordinates.X,
                                      RightCoordinates.Y,
                                      RightCoordinates.Z);
                        glEnd();
                      end; //  with DefiningParameters.Centres do
                  end // if DefiningParameters.Radiuses.YRadiusInMillimeters = 0

             // Отрисовка линий каркаса эллипсоида.
             else with FrameworkLinesIn1Octant do
                    begin
                      // Отрисовка линий вертикального каркаса эллипсоида.
                      if Vertical.bDraw=True
                        then DrawVerticalFrameworkLines;
                      // Отрисовка линий горизонтального каркаса эллипсоида.
                      if Horizontal.bDraw=True
                        then DrawHorizontalFrameworkLines;
                      // Отрисовка линий фронтального каркаса эллипсоида.
                      if Frontal.bDraw=True
                        then DrawFrontalFrameworkLines;
                   end; // with FrameworkLinesIn1Octant
        end; // if bAnyLinesDraw
end; // TEllipsoid.Draw

end.
