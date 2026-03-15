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

// Построение поверхности.
unit Surface_Unit;

interface

uses
  // Glance-модули.
  Base_Unit, FocalEllipsoid_Unit,
  // Стандартный модуль.
  OpenGL;

const
  // Минимальное количество строк точек поверхности.
  MinNumSurfacePointsRows=1;
  // Максимальное количество строк точек поверхности.
  MaxNumSurfacePointsRows=20;
  // Минимальное количество столбцов точек поверхности.
  MinNumSurfacePointsColumns=1;
  // Максимальное количество столбцов точек поверхности.
  MaxNumSurfacePointsColumns=20;

type
  // Зрительная область, соотвеетствующая
  // или левому центру, или началу координат, или правому центру.
  TArea = (LeftCenterArea, OOOArea, RightCenterArea);

  // Точка трёхмерного пространства определённого цвета.
  TColoredPoint = record
    // Компоненты цвета точки трёхмерного пространства.
    ColorComponents: TColorComponents;
    // Координаты точи в трёхмерном пространстве.
    Coordinates: TCoordinates;
    // Зрительная область, соотвеетствующая
    // или левому центру, или началу координат, или правому центру.
    Area: TArea;
  end; // TColoredPoint

  // Указатель на точу трёхмерного пространства определённого цвета.
  PColoredPoint = ^TColoredPoint;
  // Массив указателей точек трёхмерного пространства определённого цвета в строке.
  TRowColoredPoints = array[1..MaxNumSurfacePointsColumns] of PColoredPoint;
  // Указатель на массив указателей
  // точек трёхмерного пространства определённого цвета в строке.
  PRowColoredPoints = ^TRowColoredPoints;
  // Массив указателей на массивы указателей
  // точек трёхмерного пространства определённого цвета в строке.
  TGridColoredPoints = array[1..MaxNumSurfacePointsRows] of PRowColoredPoints;

  // Координата точки трёхмерного пространства в миллиметрах.
  TCoordinateInMillimeters = record
    // Значение координаты точки трёхмерного пространства в миллиметрах.
    Coordinate: SmallInt;
    // Признак определённости координаты точки трёхмерного пространства.
    bDetermined: Boolean;
  end; // TCoordinateInMillimeters
  // Указатель на координату точки трёхмерного пространства в миллиметрах.
  PCoordinateInMillimeters = ^TCoordinateInMillimeters;
  // Массив указателей координат одной оси
  // точек трёхмерного пространства в строке в миллиметрах.
  TRowCoordinatesInMillimeters = array[1..MaxNumSurfacePointsColumns] of PCoordinateInMillimeters;
  // Указатель на массив указателей координат одной оси
  // точек трёхмерного пространства в строке в миллиметрах.
  PRowCoordinatesInMillimeters = ^TRowCoordinatesInMillimeters;
  // Массив указателей на массивы указателей
  // координат одной оси точек трёхмерного пространства в строке в миллиметрах.
  TGridCoordinatesInMillimeters = array[1..MaxNumSurfacePointsRows] of PRowCoordinatesInMillimeters;

  // Направление заполнения таблицы.
  TFillDirection = (FromLeftUpperCorner, FromRightLowerCorner);

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  // Поверхность.
  TSurface = class(TObject)
    public
      // Количество строк точек поверхности.
      NumberPointsRows: Byte;
      // Количество столбцов точек поверхности.
      NumberPointsColumns: Byte;
      // Массив указателей на массивы указателей
      // точек трёхмерного пространства определённого цвета в столбце.
      GridColoredPoints: TGridColoredPoints;
      // Массив указателей на массивы указателей
      // координат оси OX точек трёхмерного пространства в строке в миллиметрах.
      GridXInMillimeters: TGridCoordinatesInMillimeters;
      // Массив указателей на массивы указателей
      // координат оси OY точек трёхмерного пространства в строке в миллиметрах.
      GridYInMillimeters: TGridCoordinatesInMillimeters;
      // Массив указателей на массивы указателей
      // координат оси OZ точек трёхмерного пространства в строке в миллиметрах.
      GridZInMillimeters: TGridCoordinatesInMillimeters;

      // Признак определённости координат точек поверхности.
      bDetermined: Boolean;
      // Признак отрисовки залитой поверхности.
      bDrawFlooded: Boolean;
      // Признак отрисовки линий каркаса поверхности.
      bDrawFramework: Boolean;
      // Признак отрисовки точек поверхности.
      bDrawVertex: Boolean;
      // Признак отрисовки поверхности.
      bAnyDraw: Boolean;

      // Конструктор: создание новой поверхности.
      constructor Create;
      // Выделение динамической памяти
      // под массивы указателей на массивы указателей
      // точек трёхмерного пространства в строке.
      procedure NewGrids(NewNumPointsRows, NewNumPointsColumns: Byte);
      // Удаление массива указателей на массивы указателей
      // точек трёхмерного пространства в строке
      // путём освобождения динамической памяти.
      procedure DisposeGrids;
      // Автозаполнение методом "центростремительного колоска"
      // массива указателей на массивы указателей
      // точек трёхмерного пространства определённого цвета в столбце.
      procedure AutoFillGridColoredPoints;
      // Установка принадлежности точки конкретной зрительной области.
      procedure SetColoredPointArea(var ColoredPoint: TColoredPoint;
                                        FocalEllipsoid: TFocalEllipsoid);
      // Отрисовка залитой поверхности.
      procedure DrawFlooded;
      // Отрисовка линий каркаса поверхности.
      procedure DrawFramework(SurfaceVertexLineWidth: Single);
      // Отрисовка точек поверхности.
      procedure DrawVertex(SurfacePointSize: Single);
      // Перевод значений координат точки из процентов в миллиметры.
      procedure TranslateToMillimetersColoredPointCoordinates(
        RowIndex, ColumnIndex: Byte);
      // Изменение масштаба всех параметров из-за изменившегося
      // масштабного коэффициента.
      procedure ReScaleAllParameters;

    protected
    private
      // Заполнение ряда точек трёхмерного пространства.
      procedure FillAllCoordinatesLineColoredPoints(LineName: String;
                                                    LineIndex,
                                                    StartIndex, LimitIndex: Byte;
                                                    FillDirection: TFillDirection);
      // Заполнение ячейки точки трёхмерного пространства с приращением.
      procedure FillCellCoordinateColoredPoint(var Value: SmallInt;
                                                   AxisName: Char;
                                                   RowIndex,ColumnIndex: Byte;
                                                   GridCoordinatesInMillimeters:
                                                     TGridCoordinatesInMillimeters);
      // Заполнение строки точек трёхмерного пространства.
      procedure FillCoordinatesRowColoredPoints(    AxisName: Char;
                                                    RowIndex,
                                                    StartIndex, LimitIndex: Byte;
                                                    FillDirection: TFillDirection;
                                                var GridCoordinatesInMillimeters:
                                                      TGridCoordinatesInMillimeters);
      // Заполнение столбца точек трёхмерного пространства.
      procedure FillCoordinatesColumnColoredPoints(    AxisName: Char;
                                                       ColumnIndex,
                                                       StartIndex, LimitIndex: Byte;
                                                       FillDirection: TFillDirection;
                                                   var GridCoordinatesInMillimeters:
                                                         TGridCoordinatesInMillimeters);
  end; // TSurface

var
  // Признак отрисовки линий соединения точек поверхностей
  // с точками соответствующих им центров эллипсоида.
  bDrawCentersLines: Boolean;

// Отрисовка линий соединения точек поверхностей
// с точками соответствующих им центров эллипсоида.
procedure DrawCentersLines(SourceSurface, DisplacedSurface: TSurface;
                           DisplacedFocalEllipsoid: TFocalEllipsoid;
                           LeftCentreColorComponents,
                           RightCentreColorComponents: TColorComponents;
                           VectorCenterToSurfacePointLineWidth: Single);

// Получение точки, параллельно перемещённой вдоль её центрофокусной прямой.
procedure GetParallelMovedPoint(var SourceColoredPoint,
                                    DisplacedColoredPoint: TColoredPoint;
                                    SourceFocalEllipsoid,
                                    DisplacedFocalEllipsoid: TFocalEllipsoid;
                                var bDisplaceSourceColoredPoint: Boolean);


//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                                

implementation

uses
  // Glance-модуль.
  Ellipsoid_Unit;

// Конструктор: создание новой поверхности из одной точки.
constructor TSurface.Create;
begin // TSurface.Create
  // Вызов метода родительского класса TObject.
  inherited;
  // Выделение динамической памяти
  // под массив указателей на массивы указателей
  // точек трёхмерного пространства определённого цвета в строке.
  NewGrids(1, 1);
  // Признак определённости координат точек поверхности.
  bDetermined:=False;
  // Признак отрисовки залитой поверхности.
  bDrawFlooded:=True;
  // Признак отрисовки линий каркаса поверхности.
  bDrawFramework:=True;
  // Признак отрисовки точек поверхности.
  bDrawVertex:=True;
  // Признак отрисовки поверхности.
  bAnyDraw:=True;
end; // TSurface.Create

// Выделение динамической памяти
// под массивы указателей на массивы указателей
// точек трёхмерного пространства в строке.
procedure TSurface.NewGrids(NewNumPointsRows, NewNumPointsColumns: Byte);
// NewNumPointsRows - новое количество строк определённого цвета
// точек поверхности в трёхмерном пространстве.
// NewNumPointsColums - новое количество столбцовопределённого цвета
// точек поверхности в трёхмерном пространстве.

var
  // Параметры циклов.
  i, j: Byte;
begin // TSurface.NewGrids
  for i:=1 to NewNumPointsRows do
    begin
      // Новая строка точек.
      New(GridXInMillimeters[i]);
      New(GridYInMillimeters[i]);
      New(GridZInMillimeters[i]);

      New(GridColoredPoints[i]);
      for j:=1 to NewNumPointsColumns do
        begin
          // Новая точка.
          New(GridXInMillimeters[i]^[j]);
          New(GridYInMillimeters[i]^[j]);
          New(GridZInMillimeters[i]^[j]);

          New(GridColoredPoints[i]^[j]);

          GridXInMillimeters[i]^[j]^.bDetermined:=False;
          GridYInMillimeters[i]^[j]^.bDetermined:=False;
          GridZInMillimeters[i]^[j]^.bDetermined:=False;
        end; // for j
    end; // for i
  // Увеличение количества строк и столбцов.
  NumberPointsRows:=NewNumPointsRows;
  NumberPointsColumns:=NewNumPointsColumns;
  bDetermined:=False;
end; // TSurface.NewGrids

// Удаление массива указателей на массивы указателей
// точек трёхмерного пространства в строке
// путём освобождения динамической памяти.
procedure TSurface.DisposeGrids;
var
  // Параметры циклов.
  i, j: Byte;
begin // TSurface.DisposeGrids
  for i:=1 to NumberPointsRows do
    begin
      for j:=1 to NumberPointsColumns do
        begin
          GridXInMillimeters[i]^[j]:=nil;
          GridYInMillimeters[i]^[j]:=nil;
          GridZInMillimeters[i]^[j]:=nil;

          GridColoredPoints[i]^[j]:=nil;
          // Удаление точки.
          Dispose(GridXInMillimeters[i]^[j]);
          Dispose(GridYInMillimeters[i]^[j]);
          Dispose(GridZInMillimeters[i]^[j]);

          Dispose(GridColoredPoints[i]^[j]);
        end; // for j
      GridXInMillimeters[i]:=nil;
      GridYInMillimeters[i]:=nil;
      GridZInMillimeters[i]:=nil;


      GridColoredPoints[i]:=nil;
      // Удаление строки точки.
      Dispose(GridXInMillimeters[i]);
      Dispose(GridYInMillimeters[i]);
      Dispose(GridZInMillimeters[i]);

      Dispose(GridColoredPoints[i]);
    end; // for i

  NumberPointsRows:=0;
  NumberPointsColumns:=0;
end; // TSurface.DisposeGrids

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Заполнение ячейки точки трёхмерного пространства с приращением.
procedure TSurface.FillCellCoordinateColoredPoint(var Value: SmallInt;
                                                      AxisName: Char;
                                                      RowIndex,ColumnIndex: Byte;
                                                      GridCoordinatesInMillimeters:
                                                        TGridCoordinatesInMillimeters);
// Value - значение координаты данной точки.
// AxisName - координатная ось, чья координата рассматривается.
// RowIndex - номер строки ячейки.
// ColumnIndex - номер столбца ячейки.
// GridCoordinatesInMillimeters - массив указателей на массивы указателей
//   координат одной оси точек трёхмерного пространства в строке в миллиметрах.
begin // TSurface.FillCellCoordinateColoredPoint
  Value:=GridCoordinatesInMillimeters[RowIndex]^[ColumnIndex]^.Coordinate;

  if AxisName='X'
    then GridColoredPoints[RowIndex]^[ColumnIndex]^.Coordinates.X:=
           Value*ScaleFactorPercentsInMillimeter
    else if AxisName='Y'
           then GridColoredPoints[RowIndex]^[ColumnIndex]^.Coordinates.Y:=
                   Value*ScaleFactorPercentsInMillimeter
           else GridColoredPoints[RowIndex]^[ColumnIndex]^.Coordinates.Z:=
                  Value*ScaleFactorPercentsInMillimeter
end; // TSurface.FillCellCoordinateColoredPoint

//******************************************************************************

// Заполнение строки точек трёхмерного пространства.
procedure TSurface.FillCoordinatesRowColoredPoints(    AxisName: Char;
                                                       RowIndex,
                                                       StartIndex, LimitIndex: Byte;
                                                       FillDirection: TFillDirection;
                                                   var GridCoordinatesInMillimeters:
                                                         TGridCoordinatesInMillimeters);
// AxisName - координатная ось, чья координата рассматривается.                                                         
// RowIndex - номер заполняемой строки матрицы.
// StartIndex - стартовый индекс начального элемента заполнения.
// LimitIndex - предельное значение индекса начального элемента заполнения.
// FillDirection - направление заполнения таблицы.
// GridCoordinatesInMillimeters - массив указателей на массивы указателей
//   координат одной оси точек трёхмерного пространства в строке в миллиметрах.

var
  // Значение начального элЕмента в ряде заполнения.
  StartValue: SmallInt;
  // Значение конечного элемента в ряде заполнения.
  FinishValue: SmallInt;
  // Индекс конечного элемента в ряде заполнения.
  FinishIndex: Byte;
  // Количество элементов матрицы
  // в ряде значений от начального до конечного значения.
  NumberValues: Byte;
  // Приращение к элементу матрицы
  // в ряде значений от начального до конечного значения в миллиметрах.
  DeltaInMillimeters: Integer;

  // Массив указателей координат одной оси
  // точек трёхмерного пространства в строке в миллиметрах.
  // Параметр циклов.
  i: Byte;
  // Инкримент параметра цикла.
  Incriment: -1..1;

begin // TSurface.FillCoordinatesRowColoredPoints
  // Определение значения начального элкмента в ряде заполнения.
  FillCellCoordinateColoredPoint(StartValue, AxisName, RowIndex, StartIndex,
                                 GridCoordinatesInMillimeters);

  // Инкримент зависит от направления заполнения таблицы.
  if FillDirection=FromLeftUpperCorner
    then Incriment:=1
    else Incriment:=-1;

  // Пока не будет достигнут предельный индекс.
  while StartIndex<>LimitIndex do
    begin // while StartIndex<>LimitIndex-Incriment
      FinishIndex:=StartIndex+Incriment;
      NumberValues:=1;
      // Пока не найдётся следующая заполненная ячейка.
      while GridCoordinatesInMillimeters[RowIndex]^[FinishIndex]^.bDetermined =
              False do
        begin // while GridCoordinatesInMillimeters
          FinishIndex:=FinishIndex+Incriment;
          NumberValues:=NumberValues+1;
        end; // while GridCoordinatesInMillimeters

     // Определение значения конечного элкмента в ряде заполнения.
     FillCellCoordinateColoredPoint(FinishValue, AxisName, RowIndex, FinishIndex,
                                    GridCoordinatesInMillimeters);

     i:=StartIndex+Incriment;
      while i<>FinishIndex do
       begin // while i<=FinishIndex-Incriment
         // Приращение к элементу матрицы в ряде значений от начального до конечного значения.
         DeltaInMillimeters:=Round( Abs(StartValue-FinishValue)/NumberValues );

         // Отрицательное приращение.
         if StartValue>FinishValue
           then DeltaInMillimeters:=-DeltaInMillimeters;

         GridCoordinatesInMillimeters[RowIndex]^[i]^.Coordinate:=
           StartValue + DeltaInMillimeters;
         GridCoordinatesInMillimeters[RowIndex]^[i]^.bDetermined:=True;
         // Определение значения элемента в ряде заполнения.
         FillCellCoordinateColoredPoint(StartValue, AxisName, RowIndex, i,
                                        GridCoordinatesInMillimeters);
         NumberValues:=NumberValues-1;
         i:=i+Incriment
       end; //  while i<>FinishIndex

      // Конечная ячейка становится начальной.
      StartIndex:=FinishIndex;
      StartValue:=FinishValue;
    end; // while StartIndex<>LimitIndex-Incriment
end; // TSurface.FillCoordinatesRowColoredPoints

//******************************************************************************

// Заполнение столбца точек трёхмерного пространства.
procedure TSurface.FillCoordinatesColumnColoredPoints(    AxisName: Char;
                                                          ColumnIndex,
                                                          StartIndex, LimitIndex: Byte;
                                                          FillDirection: TFillDirection;
                                                      var GridCoordinatesInMillimeters:
                                                            TGridCoordinatesInMillimeters);
// AxisName - координатная ось, чья координата рассматривается.
// ColumnIndex - номер заполняемого столбца матрицы.
// StartIndex - стартовый индекс начального элемента заполнения.
// LimitIndex - предельное значение индекса начального элемента заполнения.
// FillDirection - направленя заполнением таблицы.
// GridCoordinatesInMillimeters - массив указателей на массивы указателей
//   координат одной оси точек трёхмерного пространства в строке в миллиметрах.

var
  // Значение начального элЕмента в ряде заполнения.
  StartValue: SmallInt;
  // Значение конечного элемента в ряде заполнения.
  FinishValue: SmallInt;
  // Индекс конечного элемента в ряде заполнения.
  FinishIndex: Byte;
  // Количество элементов матрицы
  // в ряде значений от начального до конечного значения.
  NumberValues: Byte;
  // Приращение к элементу матрицы
  // в ряде значений от начального до конечного значения в миллиметрах.
  DeltaInMillimeters: Integer;

  // Массив указателей координат одной оси
  // точек трёхмерного пространства в столбце в миллиметрах.
  // Параметр циклов.
  i: Byte;
  // Инкримент параметра цикла.
  Incriment: -1..1;
  
begin // TSurface.FillCoordinatesColumnColoredPoints
  // Определение значения начального элкмента в ряде заполнения.
  FillCellCoordinateColoredPoint(StartValue, AxisName, StartIndex, ColumnIndex,
                                 GridCoordinatesInMillimeters);

  // Инкримент зависит от направления заполнения таблицы.
  if FillDirection=FromLeftUpperCorner
    then Incriment:=1
    else Incriment:=-1;

  // Пока не будет достигнут предельный индекс.
  while StartIndex<>LimitIndex do
    begin // while StartIndex<>LimitIndex-Incriment
      FinishIndex:=StartIndex+Incriment;
      NumberValues:=1;
      // Пока не найдётся следующая заполненная ячейка.
      while GridCoordinatesInMillimeters[FinishIndex]^[ColumnIndex]^.bDetermined=
              False do
        begin // while GridCoordinatesInMillimeters
          FinishIndex:=FinishIndex+Incriment;
          NumberValues:=NumberValues+1;
        end; // while GridCoordinatesInMillimeters

     // Определение значения конечного элкмента в ряде заполнения.
     FillCellCoordinateColoredPoint(FinishValue, AxisName, FinishIndex, ColumnIndex,
                                    GridCoordinatesInMillimeters);

     i:=StartIndex+Incriment;
     while i<>FinishIndex do
       begin //  while i<>FinishIndex
         // Приращение к элементу матрицы в ряде значений от начального до конечного значения.
         DeltaInMillimeters:=Round( Abs(StartValue-FinishValue)/NumberValues );

         // Отрицательное приращение.
         if StartValue>FinishValue
           then DeltaInMillimeters:=-DeltaInMillimeters;

         GridCoordinatesInMillimeters[i]^[ColumnIndex]^.Coordinate:=
           StartValue + DeltaInMillimeters;

         GridCoordinatesInMillimeters[i]^[ColumnIndex]^.bDetermined:=True;
         // Определение значения элкмента в ряде заполнения.
         FillCellCoordinateColoredPoint(StartValue, AxisName, i, ColumnIndex,
                                        GridCoordinatesInMillimeters);
         NumberValues:=NumberValues-1;
         i:=i+Incriment
       end; // while i<>FinishIndex

      // Конечная ячейка становится начальной.
      StartIndex:=FinishIndex;
      StartValue:=FinishValue;
    end; // while StartIndex<>LimitIndex-Incriment
end; // TSurface.FillCoordinatesColumnColoredPoints

//******************************************************************************

// Заполнение ряда точек трёхмерного пространства.
procedure TSurface.FillAllCoordinatesLineColoredPoints(LineName: String;
                                                       LineIndex,
                                                       StartIndex, LimitIndex: Byte;
                                                       FillDirection: TFillDirection);
// LineName - ряд таблицы, чьи координаты заполняются.
// LineIndex - номер заполняемого ряда матрицы.
// StartIndex - стартовый индекс начального элемента заполнения.
// LimitIndex - предельное значение индекса начального элемента заполнения.
// FillDirection - направленя заполнением таблицы.
begin // TSurface.FillAllCoordinatesLineColoredPoints
  if LineName='Row'
    then begin // then
           FillCoordinatesRowColoredPoints('X',LineIndex,StartIndex,
                                           LimitIndex,FillDirection,GridXInMillimeters);
           FillCoordinatesRowColoredPoints('Y',LineIndex,StartIndex,
                                           LimitIndex,FillDirection,GridYInMillimeters);
           FillCoordinatesRowColoredPoints('Z',LineIndex,StartIndex,
                                           LimitIndex,FillDirection,GridZInMillimeters);
         end // then
    else begin // else
           FillCoordinatesColumnColoredPoints('X',LineIndex,StartIndex,
                                              LimitIndex,FillDirection,GridXInMillimeters);
           FillCoordinatesColumnColoredPoints('Y',LineIndex,StartIndex,
                                              LimitIndex,FillDirection,GridYInMillimeters);
           FillCoordinatesColumnColoredPoints('Z',LineIndex,StartIndex,
                                              LimitIndex,FillDirection,GridZInMillimeters);
         end; // else
end; // TSurface.FillAllCoordinatesLineColoredPoints

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// Автозаполнение методом "центростремительного колоска"
// массива указателей на массивы указателей
// точек трёхмерного пространства определённого цвета в столбце.
procedure TSurface.AutoFillGridColoredPoints;
var
  // Индекс начального элемента в ряде заполнения.
  StartIndex: Byte;
  // Предельное значение индекса элемента заполнения.
  LimitIndex: Byte;

  // Идекс элемента матрицы главной диагонали.
  DiagonalIndex: Byte;
  // Максимальный идекс элемента матрицы главной диагонали.
  MaxDiagonalIndex: Byte;
  // Идекс ряда матрицы.
  LineIndex: Byte;
  
  // Признак кратности итераций заполнения строки и столбца двум.
  bEvenIterationsNumber: Boolean;
  // Направление заполнения таблицы.
  FillDirection: TFillDirection;

begin // TSurface.FillGridColoredPoints
  // Заполнение первой строки точек трёхмерного пространства.
  FillAllCoordinatesLineColoredPoints('Row',1,1,NumberPointsColumns,FromLeftUpperCorner);
  // Заполнение последней строки точек трёхмерного пространства.
  FillAllCoordinatesLineColoredPoints('Row',NumberPointsRows,NumberPointsColumns,1,FromRightLowerCorner);
  // Заполнение первого столбца точек трёхмерного пространства.
  FillAllCoordinatesLineColoredPoints('Column',1,1,NumberPointsRows,FromLeftUpperCorner);
  // Заполнение последнего столбца точек трёхмерного пространства.
  FillAllCoordinatesLineColoredPoints('Column',NumberPointsColumns,NumberPointsRows,1,FromRightLowerCorner);

  // Максимальный идекс элемента главной диагонали матрицы для заполнения
  // равен меньшему из значений количества строк и столбцов в матрице,
  // делённому пополам с округлением вверх.
  if NumberPointsRows<=NumberPointsColumns
    then MaxDiagonalIndex:=NumberPointsRows
    else MaxDiagonalIndex:=NumberPointsColumns;

  if (MaxDiagonalIndex mod 2)=1
    then begin
           MaxDiagonalIndex:=(MaxDiagonalIndex div 2) + 1;
           bEvenIterationsNumber:=False;
         end
    else begin
           MaxDiagonalIndex:=(MaxDiagonalIndex div 2);
           bEvenIterationsNumber:=True;
         end;

  // Идекс элемента матрицы главной диагонали.
  DiagonalIndex:=2;
  // Заполнение методом "колоска" вдоль главной диагонали.
  while DiagonalIndex<=MaxDiagonalIndex do
    begin
      StartIndex:=DiagonalIndex-1;
      LimitIndex:=NumberPointsColumns-StartIndex+1;
      FillDirection:=FromLeftUpperCorner;
      LineIndex:=DiagonalIndex;
      // Заполнение строк точек трёхмерного пространства.
      FillAllCoordinatesLineColoredPoints('Row',LineIndex,StartIndex,
                                          LimitIndex,FillDirection);

      LimitIndex:=NumberPointsRows-StartIndex+1;
      // Заполнение столбцов точек трёхмерного пространства.
      FillAllCoordinatesLineColoredPoints('Column',LineIndex,DiagonalIndex,
                                          LimitIndex,FillDirection);

      if (DiagonalIndex=MaxDiagonalIndex) and (bEvenIterationsNumber=False)
        then Break;

      FillDirection:=FromRightLowerCorner;
      LimitIndex:=DiagonalIndex;
      StartIndex:=NumberPointsColumns-LimitIndex+2;
      LineIndex:=NumberPointsRows-DiagonalIndex+1;
      // Заполнение строк точек трёхмерного пространства.
      FillAllCoordinatesLineColoredPoints('Row',LineIndex,StartIndex,
                                          LimitIndex,FillDirection);

      StartIndex:=NumberPointsRows-LimitIndex+1;
      LineIndex:=NumberPointsColumns-DiagonalIndex+1;
       // Заполнение столбцов точек трёхмерного пространства.
      FillAllCoordinatesLineColoredPoints('Column',LineIndex,StartIndex,
                                          LimitIndex,FillDirection);

      DiagonalIndex:=DiagonalIndex+1;
    end; // while DiagonalIndex<MaxDiagonalIndex
end; // TSurface.FillGridColoredPoints

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Установка принадлежности точки конкретной зрительной области.
procedure TSurface.SetColoredPointArea(var ColoredPoint: TColoredPoint;
                                           FocalEllipsoid: TFocalEllipsoid);
// ColoredPoint - точка трёхмерного пространства определённого цвета.
// FocalEllipsoid - Фокусный эллипсоид.
var
  // Часто употребляемые выражения.
  XZExpression, XYExpression: Single;

begin // TSurface.SetColoredPointArea
  with ColoredPoint do
    begin // with ColoredPoint
      // Для упрощения дальнейших условий.
      // Точка лежит в межцентровой полосе.
      if Abs(Coordinates.X)<=
        FocalEllipsoid.DefiningParameters.Centres.RightCoordinates.X
        then begin
               Area:=OOOArea;
               Exit;
             end;

      // Случай 1.
      // Фокус расположен на оси ОХ - оба центра равно правны.
      if (FocalEllipsoid.Focus.YFocusInMillimeters=0) and
        (FocalEllipsoid.Focus.ZFocusInMillimeters=0)
        then begin
               Area:=OOOArea;
               Exit;
             end; // if (ColoredPoint.Coordinates.Y=0)

      // Случай 2.
      // Фокус лежит в плоскости YOZ -
      // области центров поделены межцентровой полосой.
      if FocalEllipsoid.Focus.XFocusInMillimeters=0
        then begin // if XFocus=0
               if Coordinates.X -
                  FocalEllipsoid.DefiningParameters.Centres.RightCoordinates.X > 0
                 then Area:=RightCenterArea
                 else if Coordinates.X +
                         FocalEllipsoid.DefiningParameters.Centres.RightCoordinates.X < 0
                        then Area:=LeftCenterArea;
               Exit;
             end; // if XFocus=0

      XZExpression:=Coordinates.X - FocalEllipsoid.Focus.Coordinates.X /
                    FocalEllipsoid.Focus.Coordinates.Z * Coordinates.Z;

      // Случай 3.
      // Фокус лежит в плоскости XOZ -
      // области центров разделены плоскостью,
      // перпендикулярной координатной плоскости XOZ,
      // и межцентровой полосой.
      if FocalEllipsoid.Focus.YFocusInMillimeters=0
        then begin // if YFocus=0
               if (XZExpression>0)
                 then Area:=RightCenterArea;

               if (XZExpression<0)
                 then Area:=LeftCenterArea;

               if (XZExpression=0)
                 then Area:=OOOArea;

               Exit;
             end; // if YFocus=0

      XYExpression:=Coordinates.X - FocalEllipsoid.Focus.Coordinates.X /
                    FocalEllipsoid.Focus.Coordinates.Y * Coordinates.Y;

      // Случай 4.
      // Фокус лежит в плоскости XOY -
      // области центров разделены плоскостью,
      // перпендикулярной координатной плоскости XOY,
      // и межцентровой полосой.
      if FocalEllipsoid.Focus.ZFocusInMillimeters=0
        then begin // if ZFocus=0
               if (XYExpression=0)
                 then Area:=OOOArea
                 else if (FocalEllipsoid.Focus.Coordinates.X * XYExpression) > 0
                        then Area:=RightCenterArea
                        else Area:=LeftCenterArea;
               Exit;
             end; // if ZFocus=0

      // Случай 5. Общий случай.
      // области центров разделены плоскостями,
      // пересекающимися по прямой, содержащей радиус-вектор фокуса,
      // одна из которых перпендикулярна координатной плоскости XOY,
      // а вторая - XOZ.
      if (XYExpression*XZExpression)<=0
        then Area:=OOOArea
        else if XYExpression>0
               then Area:=RightCenterArea
               else Area:=LeftCenterArea;
    end; // with ColoredPoint
end; // TSurface.SetColoredPointArea

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// Отрисовка залитой поверхности.
procedure TSurface.DrawFlooded;
var
  // Параметры циклов.
  i, j: Byte;

begin // TSurface.DrawFlooded
  if (bDrawFlooded=True) and (bAnyDraw=True) and (bDetermined=True)
    then for i:=1 to NumberPointsRows-1do
           begin // for i
           // Рисование связанной группы из четырёхугольников
           // (полосы из четырёхугольников) по паре строк.
             glBegin(GL_QUAD_STRIP);
               for j:=1 to NumberPointsColumns do
                 begin
                   // две точки в одном столбце таблицы поверхности
                   // друг под другом.
                   with GridColoredPoints[i]^[j]^ do
                     begin
                       with ColorComponents do
                         glColor4f(Red, Green, Blue, AlphaChannel);
                       with Coordinates do
                         glVertex3f(-X,Y,Z);
                     end; //  with GridColoredPoints[i]^[j]^

                  with GridColoredPoints[i+1]^[j]^ do
                     begin
                       with ColorComponents do
                         glColor4f(Red, Green, Blue, AlphaChannel);
                       with Coordinates do
                          glVertex3f(-X,Y,Z);
                     end; //  with GridColoredPoints[i+1]^[j]^
                 end; // for j:=1 to NumberPointsColumns-1
             glEnd();
           end // for i
end; // TSurface.DrawFlooded

// Отрисовка линий каркаса поверхности.
procedure TSurface.DrawFramework(SurfaceVertexLineWidth: Single);
var
  // Параметры циклов.
  i, j: Byte;

begin // TSurface.DrawFramework
  if (bDrawFramework=True) and (bAnyDraw=True) and (bDetermined=True)
    then begin // if (bDrawFramework=True) and (bDraw=True)
           // Установка ширины линий.
           glLineWidth(SurfaceVertexLineWidth);
           for i:=1 to NumberPointsRows do
             begin
               // Рисуется последовательность связанных отрезков.
               glBegin(GL_LINE_STRIP);
                 for j:=1 to NumberPointsColumns do
                   with GridColoredPoints[i]^[j]^ do
                     begin
                       with ColorComponents do
                         glColor4f(Red*1.5, Green*1.5, Blue*1.5, AlphaChannel);
                       with Coordinates do
                         glVertex3f(-X,Y,Z);
                     end; //  with GridColoredPoints[i]^[j]^
               glEnd();
             end;

           for j:=1 to NumberPointsColumns do
             begin
               // Рисуется последовательность связанных отрезков.
               glBegin(GL_LINE_STRIP);
                 for i:=1 to NumberPointsRows do
                   with GridColoredPoints[i]^[j]^ do
                     begin
                       with ColorComponents do
                         glColor4f(Red*1.5, Green*1.5, Blue*1.5, AlphaChannel);
                       with Coordinates do
                         glVertex3f(-X,Y,Z);
                     end; //  with GridColoredPoints[i]^[j]^
               glEnd();
             end;
         end; // if (bDrawFramework=True) and (bDraw=True)
end; // TSurface.DrawFramework

// Отрисовка точек поверхности.
procedure TSurface.DrawVertex(SurfacePointSize: Single);
var
  // Параметры циклов.
  i, j: Byte;

begin // TSurface.DrawVertex
  if (bDrawVertex=True) and (bAnyDraw=True) and (bDetermined=True)
    then begin // if (DrawVertex=True) and (bDraw=True)
           // Установка размера точек.
           glPointSize(SurfacePointSize);
           // Каждая вершина рассматривается как отдельная точка.
           glBegin(GL_POINTS);
             for i:=1 to NumberPointsRows do
               for j:=1 to NumberPointsColumns do
                 with GridColoredPoints[i]^[j]^ do
                   begin
                     with ColorComponents do
                       glColor4f(Red*2, Green*2, Blue*2, AlphaChannel);
                     with Coordinates do
                       glVertex3f(-X,Y,Z);
                   end; //  with GridColoredPoints[i]^[j]^
           glEnd();
         end; // if (DrawVertex=True) and (bDraw=True)
end; // TSurface.DrawVertex

//******************************************************************************

// Отрисовка линий соединения точек поверхностей
// с точками соответствующих им центров эллипсоида.
procedure DrawCentersLines(SourceSurface, DisplacedSurface: TSurface;
                           DisplacedFocalEllipsoid: TFocalEllipsoid;
                           LeftCentreColorComponents,
                           RightCentreColorComponents: TColorComponents;
                           VectorCenterToSurfacePointLineWidth: Single);
// SourceSurface - исходная поверхность.
// Ellipsoid - эллипсоид, на центры которого ориентируются данные поверхности.
// DisplacedSurface - смещённая поверхность.
// LeftCentreColorComponents, RightCentreColorComponents - компоненты цветов
//   левого и правого центров.
// VectorCenterToSurfacePointLineWidth - ширина линий соединения точек поверхностей
//   с точками соответствующих им центров эллипсоида.

var
  // Параметры циклов.
  i, j: Byte;

begin // DrawCentersLines
  // Признак отрисовки линий соединения точек поверхностей
  // с точками соответствующих им центров эллипсоида.
  if (bDrawCentersLines=True) and (SourceSurface.bDetermined=True)
    then begin // if bDrawCentersLines=True
           // Установка ширины линий.
           glLineWidth(VectorCenterToSurfacePointLineWidth);

           for i:=1 to SourceSurface.NumberPointsRows do
             for j:=1 to SourceSurface.NumberPointsColumns do
               begin // for j
                 // Рисуется последовательность связанных отрезков.
                 glBegin(GL_LINE_STRIP);
                   // Зрительный центр, соответствующий данной точке.
                   case SourceSurface.GridColoredPoints[i]^[j]^.Area of
                     // Если данной точке соответствует зрительная область,
                     // соотвеетствующая левому центру.
                     LeftCenterArea:
                       begin
                         with LeftCentreColorComponents do
                           glColor4f(Red, Green, Blue, AlphaChannel);
                         with DisplacedFocalEllipsoid.DefiningParameters.Centres.LeftCoordinates do
                           glVertex3f(-X,Y,Z);
                       end;

                     // Если данной точке соответствует зрительная область,
                     // соотвеетствующая правому центру.
                     RightCenterArea:
                       begin
                         with RightCentreColorComponents do
                           glColor4f(Red, Green, Blue, AlphaChannel);
                         with DisplacedFocalEllipsoid.DefiningParameters.Centres.RightCoordinates do
                           glVertex3f(-X,Y,Z);
                       end;

                     // Если данной точке соответствует зрительная область,
                     // соотвеетствующая началу координат.
                     OOOArea:
                       begin
                         // Вначале координат - белый цвет.
                         glColor4f(1,1,1,1);
                         glVertex3f(0,0,0);
                       end;
                   end; // case

                   // Если эллипсоид смещённого фокуса не вырожден.
                   if DisplacedFocalEllipsoid.DefiningParameters.Radiuses.YRadiusInMillimeters <> 0
                     then begin // if DisplacedFocalEllipsoid
                            // Точка смещённой поверхности.
                            with DisplacedSurface.GridColoredPoints[i]^[j]^.ColorComponents do
                              glColor4f(Red, Green, Blue, AlphaChannel);
                            with DisplacedSurface.GridColoredPoints[i]^[j]^.Coordinates do
                              glVertex3f(-X,Y,Z);
                          end; // if DisplacedFocalEllipsoid

                   // Точка исходной поверхности.
                   with SourceSurface.GridColoredPoints[i]^[j]^.ColorComponents do
                     glColor4f(Red, Green, Blue, AlphaChannel);
                   with SourceSurface.GridColoredPoints[i]^[j]^.Coordinates do
                     glVertex3f(-X,Y,Z);
                 glEnd();
               end; // for j
         end; // if bDrawCentersLines=True
end; // DrawCentersLines

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  // Перевод значений координат точки из процентов в миллиметры.
  procedure TSurface.TranslateToMillimetersColoredPointCoordinates(
    RowIndex, ColumnIndex: Byte);
    // RowIndex, ColumnIndex - индексы строки и столбца данной точки.
  begin // TSurface.TranslateToMillimetersColoredPointCoordinates
    GridXInMillimeters[RowIndex]^[ColumnIndex]^.Coordinate:=
      Round(GridColoredPoints[RowIndex]^[ColumnIndex]^.Coordinates.X /
            ScaleFactorPercentsInMillimeter);

    GridYInMillimeters[RowIndex]^[ColumnIndex]^.Coordinate:=
      Round(GridColoredPoints[RowIndex]^[ColumnIndex]^.Coordinates.Y /
            ScaleFactorPercentsInMillimeter);

    GridZInMillimeters[RowIndex]^[ColumnIndex]^.Coordinate:=
      Round(GridColoredPoints[RowIndex]^[ColumnIndex]^.Coordinates.Z /
            ScaleFactorPercentsInMillimeter);
  end; // TSurface.TranslateToMillimetersColoredPointCoordinates

  // Изменение масштаба всех параметров из-за изменившегося
  // масштабного коэффициента.
  procedure TSurface.ReScaleAllParameters;
  var
    // Параметры циклов.
    i, j: Byte;
  begin // TSurface.ReScaleAllParameters
    if bDetermined = True
      then for i:=1 to NumberPointsRows do
             for j:=1 to NumberPointsColumns do
               begin // for j
                 GridColoredPoints[i]^[j]^.Coordinates.X:=
                   GridXInMillimeters[i]^[j]^.Coordinate *
                   ScaleFactorPercentsInMillimeter;

                 GridColoredPoints[i]^[j]^.Coordinates.Y:=
                   GridYInMillimeters[i]^[j]^.Coordinate *
                   ScaleFactorPercentsInMillimeter;

                 GridColoredPoints[i]^[j]^.Coordinates.Z:=
                   GridZInMillimeters[i]^[j]^.Coordinate *
                   ScaleFactorPercentsInMillimeter;
               end; // for j
  end; // TSurface.ReScaleAllParameters

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Получение точки, параллельно перемещённой вдоль её центрофокусной прямой.
procedure GetParallelMovedPoint(var SourceColoredPoint,
                                    DisplacedColoredPoint: TColoredPoint;
                                    SourceFocalEllipsoid,
                                    DisplacedFocalEllipsoid: TFocalEllipsoid;
                                var bDisplaceSourceColoredPoint: Boolean);
// SourceColoredPoint - исходная точка.
// DisplacedColoredPoint - точка, полученная при параллельном переносе исходной.
// SourceFocalEllipsoid - эллипсоид исходного фокуса.
// DisplacedFocalEllipsoid - эллипсоид смещённого фокуса.
// bDisplaceSourceColoredPoint - признак перемещения исходной точки
//   на поверхность эллипсоид исходного фокуса, а точки,
//   полученной при параллельном переносе исходной, -
//   на поверхность эллипсоид смещённого фокуса
//   во избежение попадания искомой за пределы зрительной области
  // (в  зону отрицательной полуоси координатной оси OY) или в другой октант.
var
  // Абсцисса зрительного центра.
  XCenter: Single;
  // Постоянное расстояние от эллипсоида до точки.
  EllipsoidAndPointBetweenDistance: Single;
  // Часто употребляемые выражения.
  XZExpression, XYExpression, YZExpression: Single;
  // Координаты точи пересечения центрофокусной прямой
  // и эллипсоида исходного фокуса.
  SourceCrossPointCoordinates: TCoordinates;
  // Координаты точи пересечения центрофокусной прямой
  // и эллипсоида смещённого фокуса.
  DisplacedCrossPointCoordinates: TCoordinates;
  // Коэффициенты квадратного уравнения по убыванию степеней неизвестной.
  FirstCoefficient, SecondCoefficient, ThirdCoefficient: Single;
  // Квадратный корня из дискриминанта, делённого на 4.
  RootFromDiscriminantDividedIn4: Single;
  // Первый корень квадратного уравнения
  // при сложении с квадратным корнем из дискриминанта, делённого на 4,
  // где второй коэффициент, делённый пополам состоит в квадратном уравнении
  // с множителем ( -1 ).
  RootWithRootFromDiscriminantDividedIn4Adding: Single;
  // Bтороq корень квадратного уравнения
  // при вычитании квадратного корня из дискриминанта, делённого на 4,
  // где второй коэффициент, делённый пополам состоит в квадратном уравнении
  // с множителем ( -1 ).
  RootWithRootFromDiscriminantDividedIn4Subtraction: Single;
  // Длина радиус-вектора от зрительного центра до исходной точки.
  SourceColoredPointRadiusVector: Single;
  // Длина радиус-вектора от зрительного центра
  // до точи пересечения центрофокусной прямой и эллипсоида исходного фокуса.
  SourceCrossPointRadiusVector: Single;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  // Вычисление квадратного корня из дискриминанта, делённого на 4.
  procedure GetRootFromDiscriminantDividedIn4;
  begin // GetRootFromDiscriminantDividedIn4
    RootFromDiscriminantDividedIn4:=Sqrt(SecondCoefficient*SecondCoefficient -
                                         FirstCoefficient*ThirdCoefficient);
  end; // GetRootFromDiscriminantDividedIn4

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  // Получение первого корня квадратного уравнения
  // при сложении с квадратным корнем из дискриминанта, делённого на 4,
  // где второй коэффициент, делённый пополам состоит в квадратном уравнении
  // с множителем ( -1 ).
  function GetRootWithRootFromDiscriminantDividedIn4Adding: Single;
  begin // GetRootWithRootFromDiscriminantDividedIn4Adding
    GetRootWithRootFromDiscriminantDividedIn4Adding:=
      (SecondCoefficient + RootFromDiscriminantDividedIn4) /
                                     FirstCoefficient;
  end; // GetRootWithRootFromDiscriminantDividedIn4Adding

  // Получение второго корня квадратного уравнения
  // при вычитании квадратного корня из дискриминанта, делённого на 4,
  // где второй коэффициент, делённый пополам состоит в квадратном уравнении
  // с множителем ( -1 ).
  function GetRootWithRootFromDiscriminantDividedIn4Subtraction: Single;
  begin // GetRootWithRootFromDiscriminantDividedIn4Subtraction
    GetRootWithRootFromDiscriminantDividedIn4Subtraction:=
      (SecondCoefficient - RootFromDiscriminantDividedIn4) /
                                     FirstCoefficient;
  end; // GetRootWithRootFromDiscriminantDividedIn4Subtraction

//******************************************************************************
//******************************************************************************

  // Получение точки пересечения эллиптического сечения эллипсоида
  // в координатной плоскости XOZ и прямой,
  // проходящей через заданную точку и определённый ей зрительный центр.
  procedure GetCrossPointOfXOZEllipseAndStraightLine(    SourceColoredPoint: TColoredPoint;
                                                     var CrossPointCoordinates: TCoordinates;
                                                         FocalEllipsoid: TFocalEllipsoid);
  // SourceColoredPoint - исходная точка.
  // CrossPointCoordinates - точка пересечения эллипсоида и прямой,
  //   проходящей через заданную точку и определённый ей зрительный центр.
  // FocalEllipsoid - фокусный эллипсоид.
  begin // GetCrossPointOfXOZEllipseAndStraightLine
    XZExpression:=Sqr(SourceColoredPoint.Coordinates.Z /
                      FocalEllipsoid.DefiningParameters.Radiuses.YRadius /
                      (SourceColoredPoint.Coordinates.X - XCenter));
    // Коэффициент при квадрате абсциссы точки пересечения.
    FirstCoefficient:=1 / FocalEllipsoid.DefiningParameters.Radiuses.XRadius /
                          FocalEllipsoid.DefiningParameters.Radiuses.XRadius +
                      XZExpression;
    // Коэффициент при абсциссе точки пересечения в первой степени, делённый пополам.
    SecondCoefficient:=XZExpression*XCenter;
    // Свободный член квадратного уравнения относительно абсциссы точки пересечения.
    ThirdCoefficient:=SecondCoefficient*XCenter - 1;
    // Вычисление квадратного корня из дискриминанта, делённого на 4.
    GetRootFromDiscriminantDividedIn4;
    // Получение абсциссы точки пересечения.
    if SourceColoredPoint.Coordinates.X>=0
      then CrossPointCoordinates.X:=GetRootWithRootFromDiscriminantDividedIn4Adding
      else CrossPointCoordinates.X:=GetRootWithRootFromDiscriminantDividedIn4Subtraction;
    // Получение аппилкаты точки пересечения.
    CrossPointCoordinates.Z:=SourceColoredPoint.Coordinates.Z *
      (         CrossPointCoordinates.X - XCenter) /
      (SourceColoredPoint.Coordinates.X - XCenter);
    // Ордината точки пересечения равна нулю:
    // точка лежит в координатной плоскости XOZ.
    CrossPointCoordinates.Y:=0;
  end; // GetCrossPointOfXOZEllipseAndStraightLine

//******************************************************************************

  // Получение точки пересечения эллипсоида и прямой,
  // проходящей через заданную точку и определённый ей зрительный центр.
  procedure GetCrossPointOfEllipsoidAndStraightLine(    SourceColoredPoint: TColoredPoint;
                                                    var CrossPointCoordinates: TCoordinates;
                                                        FocalEllipsoid: TFocalEllipsoid);
  // SourceColoredPoint - исходная точка.
  // CrossPointCoordinates - точка пересечения эллипсоида и прямой,
  //   проходящей через заданную точку и определённый ей зрительный центр.
  // FocalEllipsoid - фокусный эллипсоид.
  begin // GetCrossPointOfEllipsoidAndStraightLine
    XYExpression:=(SourceColoredPoint.Coordinates.X - XCenter) /
                  SourceColoredPoint.Coordinates.Y;
    YZExpression:=SourceColoredPoint.Coordinates.Z /
                  SourceColoredPoint.Coordinates.Y;
    XZExpression:=(YZExpression * YZExpression + 1) /
                  FocalEllipsoid.DefiningParameters.Radiuses.YRadius /
                  FocalEllipsoid.DefiningParameters.Radiuses.YRadius;
    // Коэффициент при квадрате ординаты точки пересечения.
    FirstCoefficient:=XYExpression * XYExpression /
                      FocalEllipsoid.DefiningParameters.Radiuses.XRadius /
                      FocalEllipsoid.DefiningParameters.Radiuses.XRadius +
                      XZExpression;
    // Коэффициент при ординате точки пересечения в первой степени, делённый пополам.
    SecondCoefficient:=XYExpression * XCenter /
                       FocalEllipsoid.DefiningParameters.Radiuses.XRadius /
                       FocalEllipsoid.DefiningParameters.Radiuses.XRadius;
    // Свободный член квадратного уравнения относительно ординаты точки пересечения.
    ThirdCoefficient:=XCenter * XCenter /
                      FocalEllipsoid.DefiningParameters.Radiuses.XRadius /
                      FocalEllipsoid.DefiningParameters.Radiuses.XRadius - 1;
    // Вычисление квадратного корня из дискриминанта, делённого на 4.
    GetRootFromDiscriminantDividedIn4;

    SecondCoefficient:= -SecondCoefficient;
    // Получение ординаты точки пересечения.
    // Получение первого корня квадратного уравнения
    // при сложении с квадратным корнем из дискриминанта, делённого на 4,
    // где второй коэффициент, делённый пополам состоит в квадратном уравнении
    // с множителем ( -1 ).
    CrossPointCoordinates.Y:=GetRootWithRootFromDiscriminantDividedIn4Adding;
    // Получение абсциссы точки пересечения.
    CrossPointCoordinates.X:=XYExpression * CrossPointCoordinates.Y + XCenter;
    // Получение аппилкаты точки пересечения.
    CrossPointCoordinates.Z:=YZExpression * CrossPointCoordinates.Y;
  end; // GetCrossPointOfEllipsoidAndStraightLine

  // Перенос исходной точки на поверхность эллипсоид исходного фокуса, а точки,
  // полученной при параллельном переносе исходной, -
  // на поверхность эллипсоид смещённого фокуса
  // во избежение попадания искомой за пределы зрительной области
  // (в  зону отрицательной полуоси координатной оси OY) или в другой октант.
  procedure DisplaceSourceColoredPoint;
  begin // DisplaceSourceColoredPoint
    // Признак перемещения исходной точки
    // на поверхность эллипсоид исходного фокуса, а точки,
    // полученной при параллельном переносе исходной, -
    // на поверхность эллипсоид смещённого фокуса.
    bDisplaceSourceColoredPoint:=True;

    SourceColoredPoint.Coordinates.X:=SourceCrossPointCoordinates.X;
    SourceColoredPoint.Coordinates.Y:=SourceCrossPointCoordinates.Y;
    SourceColoredPoint.Coordinates.Z:=SourceCrossPointCoordinates.Z;

    DisplacedColoredPoint.Coordinates.X:=DisplacedCrossPointCoordinates.X;
    DisplacedColoredPoint.Coordinates.Y:=DisplacedCrossPointCoordinates.Y;
    DisplacedColoredPoint.Coordinates.Z:=DisplacedCrossPointCoordinates.Z;
  end; // DisplaceSourceColoredPoint

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

begin // GetParallelMovedPoint
  // Признак перемещения исходной точки
  // на поверхность эллипсоид исходного фокуса, а точки,
  // полученной при параллельном переносе исходной, -
  // на поверхность эллипсоид смещённого фокуса
  // во избежение попадания искомой за пределы зрительной области,
  // в  зону отрицательной полуоси координатной оси OY.
  bDisplaceSourceColoredPoint:=False;

  // Случай 1.
  // Исходный эллипсоид вырожден в точку начала координат.
  if (SourceFocalEllipsoid.DefiningParameters.Radiuses.XRadius = 0) or
     // Случай 2.
     // Исходный эллипсоид вырожден в отрезок, соединяющий зрительные центры.
     (SourceFocalEllipsoid.DefiningParameters.Radiuses.YRadius = 0)
    then begin //
           // Точка остаётся на месте
           DisplacedColoredPoint.Coordinates.X:=SourceColoredPoint.Coordinates.X;
           DisplacedColoredPoint.Coordinates.Y:=SourceColoredPoint.Coordinates.Y;
           DisplacedColoredPoint.Coordinates.Z:=SourceColoredPoint.Coordinates.Z;
           Exit;
         end; //

//******************************************************************************

  // Случай 3.
  // Исходная точка лежит на оси OZ.
  if (SourceColoredPoint.Coordinates.X = 0) and
     (SourceColoredPoint.Coordinates.Y = 0)
    then begin // if (SourceColoredPoint.Coordinates.X = 0)
           // Исходная точка лежит на положительной полуоси
           // координатной оси OZ.
           if SourceColoredPoint.Coordinates.Z>0
             then begin // if SourceColoredPoint.Coordinates.Z>=0
                    // Постоянное расстояние от эллипсоида до точки.
                    EllipsoidAndPointBetweenDistance:=Abs(
                      SourceColoredPoint.Coordinates.Z -
                      SourceFocalEllipsoid.DefiningParameters.Radiuses.ZRadius);
                    // Если исходная точка не внутри исходного эллипсоида.
                    if SourceColoredPoint.Coordinates.Z>=
                         SourceFocalEllipsoid.DefiningParameters.Radiuses.ZRadius
                      then DisplacedColoredPoint.Coordinates.Z:=
                             DisplacedFocalEllipsoid.DefiningParameters.Radiuses.ZRadius +
                             EllipsoidAndPointBetweenDistance
                      // Если исходная точка внутри исходного эллипсоида.
                      else DisplacedColoredPoint.Coordinates.Z:=
                             DisplacedFocalEllipsoid.DefiningParameters.Radiuses.ZRadius -
                             EllipsoidAndPointBetweenDistance;
                  end; // if SourceColoredPoint.Coordinates.Z>=0

           // Исходная точка лежит на отрицательной полуоси
           // координатной оси OZ.
           if SourceColoredPoint.Coordinates.Z<0
             then begin // if SourceColoredPoint.Coordinates.Z<0
                    // Постоянное расстояние от эллипсоида до точки.
                    EllipsoidAndPointBetweenDistance:=Abs(
                      SourceColoredPoint.Coordinates.Z +
                      SourceFocalEllipsoid.DefiningParameters.Radiuses.ZRadius);
                    // Если исходная точка не внутри исходного эллипсоида.
                    if SourceColoredPoint.Coordinates.Z<=
                         -SourceFocalEllipsoid.DefiningParameters.Radiuses.ZRadius
                      then DisplacedColoredPoint.Coordinates.Z:=
                             -DisplacedFocalEllipsoid.DefiningParameters.Radiuses.ZRadius -
                             EllipsoidAndPointBetweenDistance
                      // Если исходная точка внутри исходного эллипсоида.
                      else DisplacedColoredPoint.Coordinates.Z:=
                             -DisplacedFocalEllipsoid.DefiningParameters.Radiuses.ZRadius +
                             EllipsoidAndPointBetweenDistance;
                  end; // if SourceColoredPoint.Coordinates.Z<0

           // Если точка искажённой поверхности находится
           // не в одной четверти пространства с точкой исходной поверхности
           // или исходная точка лежит в начале координат,
           // то эти точки переносятся на поверхности
           // соответствующих зрительных эллипсоидов
           // в той же четверти пространства,
           // что и была точка исходной поверхности.
           if (SourceColoredPoint.Coordinates.Z *
               DisplacedColoredPoint.Coordinates.Z < 0) or
              (SourceColoredPoint.Coordinates.Z = 0)
              
             then begin // if SourceColoredPoint.Coordinates.Z *
                    // Признак перемещения исходной точки
                    // на поверхность эллипсоид исходного фокуса, а точки,
                    // полученной при параллельном переносе исходной, -
                    // на поверхность эллипсоид смещённого фокуса.
                    bDisplaceSourceColoredPoint:=True;

                    if SourceColoredPoint.Coordinates.Z>=0
                      then begin // if SourceColoredPoint.Coordinates.Z>=0 then
                             SourceColoredPoint.Coordinates.Z:=
                               SourceFocalEllipsoid.DefiningParameters.Radiuses.ZRadius;
                             DisplacedColoredPoint.Coordinates.Z:=
                               DisplacedFocalEllipsoid.DefiningParameters.Radiuses.ZRadius;
                           end // if SourceColoredPoint.Coordinates.Z>=0 then
                      else begin // if SourceColoredPoint.Coordinates.Z>=0 else
                             SourceColoredPoint.Coordinates.Z:=
                               -SourceFocalEllipsoid.DefiningParameters.Radiuses.ZRadius;
                             DisplacedColoredPoint.Coordinates.Z:=
                               -DisplacedFocalEllipsoid.DefiningParameters.Radiuses.ZRadius;
                           end; // if SourceColoredPoint.Coordinates.Z>=0 else

                  end; // if SourceColoredPoint.Coordinates.Z *

           DisplacedColoredPoint.Coordinates.X:=0;
           DisplacedColoredPoint.Coordinates.Y:=0;

           Exit;
         end; // if (SourceColoredPoint.Coordinates.X = 0)

//******************************************************************************

  // Абсцисса зрительного центра.
  if SourceColoredPoint.Area = OOOArea
    then XCenter:=0
    else if SourceColoredPoint.Area=LeftCenterArea
           then XCenter:=
                  SourceFocalEllipsoid.DefiningParameters.Centres.LeftCoordinates.X
           else XCenter:=
                  SourceFocalEllipsoid.DefiningParameters.Centres.RightCoordinates.X;

  // Случай 4.
  // Исходная точка лежит в плоскости XOZ.
  if SourceColoredPoint.Coordinates.Y = 0
    then begin // if SourceColoredPoint.Coordinates.Y = 0
           // Координаты точи пересечения центрофокусной прямой
           // и эллипсоида исходного фокуса.
           // Получение точки пересечения эллиптического сечения эллипсоида
           // в координатной плоскости XOZ и прямой,
           // проходящей через заданную точку и определённый ей зрительный центр.
           GetCrossPointOfXOZEllipseAndStraightLine(SourceColoredPoint,
                                                    SourceCrossPointCoordinates,
                                                    SourceFocalEllipsoid);
           // Координаты точи пересечения центрофокусной прямой
           // и эллипсоида смещённого фокуса.
           // Получение точки пересечения эллиптического сечения эллипсоида
           // в координатной плоскости XOZ и прямой,
           // проходящей через заданную точку и определённый ей зрительный центр.
           GetCrossPointOfXOZEllipseAndStraightLine(SourceColoredPoint,
                                                    DisplacedCrossPointCoordinates,
                                                    DisplacedFocalEllipsoid);
           // Постоянное расстояние от эллипсоида до точки.
           EllipsoidAndPointBetweenDistance:=Sqrt(
             Sqr(SourceColoredPoint.Coordinates.X - SourceCrossPointCoordinates.X) +
             Sqr(SourceColoredPoint.Coordinates.Z - SourceCrossPointCoordinates.Z));

           XZExpression:=SourceColoredPoint.Coordinates.Z /
             (SourceColoredPoint.Coordinates.X - XCenter);
           YZExpression:=XZExpression * XCenter +
             DisplacedCrossPointCoordinates.Z;

           // Коэффициент при квадрате абсциссы точки,
           // полученной при параллельном переносе исходной.
           FirstCoefficient:=1 + XZExpression * XZExpression;
           // Коэффициент при абсциссе точки,
           // полученной при параллельном переносе исходной..
           SecondCoefficient:=DisplacedCrossPointCoordinates.X +
             XZExpression * YZExpression;
           // Свободный член квадратного уравнения относительно абсциссы точки,
           // полученной при параллельном переносе исходной.
           ThirdCoefficient:=DisplacedCrossPointCoordinates.X *
                             DisplacedCrossPointCoordinates.X +
             YZExpression * YZExpression -
             EllipsoidAndPointBetweenDistance * EllipsoidAndPointBetweenDistance;

           // Вычисление квадратного корня из дискриминанта, делённого на 4.
           GetRootFromDiscriminantDividedIn4;
           // Первый корень квадратного уравнения
           // при сложении с квадратным корнем из дискриминанта, делённого на 4,
           // где второй коэффициент, делённый пополам состоит в квадратном уравнении
           // с множителем ( -1 ).
           RootWithRootFromDiscriminantDividedIn4Adding:=
             GetRootWithRootFromDiscriminantDividedIn4Adding;
           // Bтороq корень квадратного уравнения
           // при вычитании квадратного корня из дискриминанта, делённого на 4,
           // где второй коэффициент, делённый пополам состоит в квадратном уравнении
           // с множителем ( -1 ).
           RootWithRootFromDiscriminantDividedIn4Subtraction:=
             GetRootWithRootFromDiscriminantDividedIn4Subtraction;
           // Длина радиус-вектора от зрительного центра до исходной точки.
           SourceColoredPointRadiusVector:=Sqrt(
             Sqr(XCenter - SourceColoredPoint.Coordinates.X) +
             SourceColoredPoint.Coordinates.Z * SourceColoredPoint.Coordinates.Z);
           // Длина радиус-вектора от зрительного центра
           // до точи пересечения центрофокусной прямой и эллипсоида исходного фокуса.
           SourceCrossPointRadiusVector:=Sqrt(
             Sqr(XCenter - SourceCrossPointCoordinates.X) +
             SourceCrossPointCoordinates.Z * SourceCrossPointCoordinates.Z);

           if SourceColoredPoint.Coordinates.X>=0
             // Если исходная точка лежит
             // в правой полуплоскости координатной плоскости XOZ.
             then begin // if SourceColoredPoint then
                    if SourceColoredPointRadiusVector>=
                         SourceCrossPointRadiusVector
                      // Если исходная точка не внутри исходного эллипсоида.
                      then DisplacedColoredPoint.Coordinates.X:=
                             RootWithRootFromDiscriminantDividedIn4Adding
                      // Если исходная точка внутри исходного эллипсоида.
                      else DisplacedColoredPoint.Coordinates.X:=
                             RootWithRootFromDiscriminantDividedIn4Subtraction;
                  end // if SourceColoredPoint then
             // Если исходная точка лежит
             // в левой полуплоскости координатной плоскости XOZ.
             else begin // if SourceColoredPoint else
                    if SourceColoredPointRadiusVector>=
                         SourceCrossPointRadiusVector
                      // Если исходная точка не внутри исходного эллипсоида.
                      then DisplacedColoredPoint.Coordinates.X:=
                             RootWithRootFromDiscriminantDividedIn4Subtraction
                      // Если исходная точка внутри исходного эллипсоида.
                      else DisplacedColoredPoint.Coordinates.X:=
                             RootWithRootFromDiscriminantDividedIn4Adding;
                  end; // if SourceColoredPoint else

           DisplacedColoredPoint.Coordinates.Z:=XZExpression *
             (DisplacedColoredPoint.Coordinates.X - XCenter);

           // Если точка искажённой поверхности находится
           // не в одном октанте с точкой исходной поверхности,
           // то эти точки переносятся на поверхности
           // соответствующих зрительных эллипсоидов в том же октанте,
           // что и была точка исходной поверхности.
           if (SourceColoredPoint.Coordinates.X *
               DisplacedColoredPoint.Coordinates.X < 0) or
              (SourceColoredPoint.Coordinates.Z *
               DisplacedColoredPoint.Coordinates.Z < 0)
             then
               // Перенос исходной точки на поверхность эллипсоид исходного фокуса, а точки,
               // полученной при параллельном переносе исходной, -
               // на поверхность эллипсоид смещённого фокуса
               // во избежение попадания искомой за пределы зрительной области
               // (в  зону отрицательной полуоси координатной оси OY) или в другой октант.
               DisplaceSourceColoredPoint

             else DisplacedColoredPoint.Coordinates.Y:=0;

           Exit;
         end; // if SourceColoredPoint.Coordinates.Y = 0

//******************************************************************************
  // Случай 5. Общий случай.
  // Координаты точи пересечения центрофокусной прямой
  // и эллипсоида исходного фокуса.
  // Получение точки пересечения эллипсоида и прямой,
  // проходящей через заданную точку и определённый ей зрительный центр.
  GetCrossPointOfEllipsoidAndStraightLine(SourceColoredPoint,
                                          SourceCrossPointCoordinates,
                                          SourceFocalEllipsoid);
  // Координаты точи пересечения центрофокусной прямой
  // и эллипсоида смещённого фокуса.
  // Получение точки пересечения эллипсоида и прямой,
  // проходящей через заданную точку и определённый ей зрительный центр.
  GetCrossPointOfEllipsoidAndStraightLine(SourceColoredPoint,
                                          DisplacedCrossPointCoordinates,
                                          DisplacedFocalEllipsoid);
  // Постоянное расстояние от эллипсоида до точки.
  EllipsoidAndPointBetweenDistance:=Sqrt(
    Sqr(SourceColoredPoint.Coordinates.X - SourceCrossPointCoordinates.X) +
    Sqr(SourceColoredPoint.Coordinates.Y - SourceCrossPointCoordinates.Y) +
    Sqr(SourceColoredPoint.Coordinates.Z - SourceCrossPointCoordinates.Z));

  XYExpression:=(SourceColoredPoint.Coordinates.X - XCenter) /
                 SourceColoredPoint.Coordinates.Y;
  YZExpression:=SourceColoredPoint.Coordinates.Z /
                SourceColoredPoint.Coordinates.Y;
  XZExpression:=-XCenter + DisplacedCrossPointCoordinates.X;

  // Коэффициент при квадрате ординаты точки,
  // полученной при параллельном переносе исходной.
  FirstCoefficient:=1 + XYExpression*XYExpression + YZExpression*YZExpression;
  // Коэффициент при ординате точки,
  // полученной при параллельном переносе исходной..
  SecondCoefficient:=DisplacedCrossPointCoordinates.Y +
    XYExpression * XZExpression + DisplacedCrossPointCoordinates.Z * YZExpression;
  // Свободный член квадратного уравнения относительно ординаты точки,
  // полученной при параллельном переносе исходной.
  ThirdCoefficient:=DisplacedCrossPointCoordinates.Y *
                    DisplacedCrossPointCoordinates.Y + XZExpression*XZExpression +
    DisplacedCrossPointCoordinates.Z * DisplacedCrossPointCoordinates.Z -
    EllipsoidAndPointBetweenDistance * EllipsoidAndPointBetweenDistance;

  // Вычисление квадратного корня из дискриминанта, делённого на 4.
  GetRootFromDiscriminantDividedIn4;
  // Первый корень квадратного уравнения
  // при сложении с квадратным корнем из дискриминанта, делённого на 4,
  // где второй коэффициент, делённый пополам состоит в квадратном уравнении
  // с множителем ( -1 ).
  RootWithRootFromDiscriminantDividedIn4Adding:=
    GetRootWithRootFromDiscriminantDividedIn4Adding;
  // Bтороq корень квадратного уравнения
  // при вычитании квадратного корня из дискриминанта, делённого на 4,
  // где второй коэффициент, делённый пополам состоит в квадратном уравнении
  // с множителем ( -1 ).
  RootWithRootFromDiscriminantDividedIn4Subtraction:=
    GetRootWithRootFromDiscriminantDividedIn4Subtraction;
  // Длина радиус-вектора от зрительного центра до исходной точки.
  SourceColoredPointRadiusVector:=Sqrt(
    Sqr(XCenter - SourceColoredPoint.Coordinates.X) +
    SourceColoredPoint.Coordinates.Y * SourceColoredPoint.Coordinates.Y +
    SourceColoredPoint.Coordinates.Z * SourceColoredPoint.Coordinates.Z);
  // Длина радиус-вектора от зрительного центра
  // до точи пересечения центрофокусной прямой и эллипсоида исходного фокуса.
  SourceCrossPointRadiusVector:=Sqrt(
    Sqr(XCenter - SourceCrossPointCoordinates.X) +
    SourceCrossPointCoordinates.Y * SourceCrossPointCoordinates.Y +
    SourceCrossPointCoordinates.Z * SourceCrossPointCoordinates.Z);

  if SourceColoredPointRadiusVector>=SourceCrossPointRadiusVector
    // Если исходная точка не внутри исходного эллипсоида.
    then DisplacedColoredPoint.Coordinates.Y:=
           RootWithRootFromDiscriminantDividedIn4Adding
    // Если исходная точка внутри исходного эллипсоида.
    else DisplacedColoredPoint.Coordinates.Y:=
           RootWithRootFromDiscriminantDividedIn4Subtraction;

  if DisplacedColoredPoint.Coordinates.Y<0
    // Ордината точки, полученной при параллельном переносе исходной отрицательна.
    then
      // Перенос исходной точки на поверхность эллипсоид исходного фокуса, а точки,
      // полученной при параллельном переносе исходной, -
      // на поверхность эллипсоид смещённого фокуса
      // во избежение попадания искомой за пределы зрительной области
      // (в  зону отрицательной полуоси координатной оси OY) или в другой октант.
      DisplaceSourceColoredPoint

    // Ордината точки, полученной при параллельном переносе исходной неотрицательна.
    else begin // else
           DisplacedColoredPoint.Coordinates.X:=
             XYExpression * DisplacedColoredPoint.Coordinates.Y + XCenter;
           DisplacedColoredPoint.Coordinates.Z:=
             YZExpression * DisplacedColoredPoint.Coordinates.Y;
         end;// else
end; // GetParallelMovedPoint

end.
