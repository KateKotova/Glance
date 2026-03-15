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

// Процедуры и функции чтения и записи файлов проектов БМП.
unit Files_Unit;

interface

uses
  // Glance-модули.
  Base_Unit, Integration_Unit, Ellipsoid_Unit,
  // Стандартные модули.
  SysUtils, Dialogs, MainForm_Unit, GridsForm_Unit, Buttons, Menus, StdCtrls,
  ComCtrls, Forms;

type
  // Признаки отрисовки конструктивных элементов поверхности.
  TDrawSurfaceConstructionsSigns = record
    // Признак отрисовки залитой поверхности.
    dsc_bDrawFlooded: Boolean;
    // Признак отрисовки линий каркаса поверхности.
    dsc_bDrawFramework: Boolean;
    // Признак отрисовки точек поверхности.
    dsc_bDrawVertex: Boolean;
  end; // TDrawSurfaceConstructionsSigns

  // Параметры, определяющие построение эллипсоида.
  TEllipsoidBaseParameters = record
    // Радиус, определяющий все остальные его радиусы.
    el_RadiusDeterminator: TRadiusDeterminator;
    // Значение определяющего радиуса в миллиметрах.
    el_DeterminateRadiusInMillimeters: Word;
    // Количество фронтальных линий каркаса в первом октанте.
    el_NumberFrontalFrameworkLinesIn1Octant: Byte;
    // Количество горизонтальных линий каркаса в первом октанте.
    el_NumberHorizontalFrameworkLinesIn1Octant: Byte;
    // Количество вертикальных линий каркаса в первом октанте.
    el_NumberVerticalFrameworkLinesIn1Octant: Byte;
    // Признак отрисовки фронтальных линий каркаса.
    el_bFrontalFrameworkLinesDraw: Boolean;
    // Признак отрисовки горизонтальных линий каркаса.
    el_bHorizontalFrameworkLinesDraw: Boolean;
    // Признак отрисовки вертикальных линий каркаса.
    el_bVerticalFrameworkLinesDraw: Boolean;
  end; // TEllipsoidBaseParameters

  // Параметры, определяющие модель бицентрического монофокусного полупространства (БМП).
  THalfSpaceBaseParameters = record
    // Заголовок записи о модели БМП.
    hs_HalfSpaceTitle: String[15];
    // Межцентровое расстояние в миллиметрах.
    hs_BetweenDistanceInMillimeters: Word;
    // Мачштаб.
    hs_Zoom: Word;
    // Признак отрисовки осей.
    hs_bAxis: Boolean;
    // Признак отрисовки центровых линий.
    hs_bDrawCentersLines: Boolean;

    // Координатная плоскость, вращаемая при обзоре.
    hs_StartRotationPlane: TStartRotationPlane;
    // Горизонтальный угол поворота координатной плоскости вращения
    // относительно исходного положения
    // при выборе данной плоскости в качестве обзорной.
    hs_HorizontalAngleMouseButtonLeft: Single;
    // Вертикальный угол поворота координатной плоскости вращения
    // относительно исходного положения
    // при выборе данной плоскости в качестве обзорной.
    hs_VerticalAngleMouseButtonLeft: Single;

    // Угол наклона радиус-вектора фокуса к оси OX.
    hs_FOXInDegrees: Single;
    // Угол наклона радиус-вектора фокуса к оси OY.
    hs_FOYInDegrees: Single;

    // Признак отрисовки центрофокусных линий исходного фокуса.
    hs_bSourceFocusLines: Boolean;
    // Признак отрисовки центрофокусных линий смещённого фокуса.
    hs_bDisplacedFocusLines: Boolean;

    // Параметры, определяющие построение предельного эллипсоида.
    hs_LimitingEllipsoidBaseParameters: TEllipsoidBaseParameters;
    // Параметры, определяющие построение эллипсоида исходного фокуса.
    hs_SourceFocalEllipsoidBaseParameters: TEllipsoidBaseParameters;
    // Параметры, определяющие построение эллипсоида смещённого фокуса.
    hs_DisplacedFocalEllipsoidBaseParameters: TEllipsoidBaseParameters;

    // Признаки отрисовки конструктивных элементов исходной поверхности.
    hs_DrawSourceSurfaceConstructionsSigns: TDrawSurfaceConstructionsSigns;
    // Признаки отрисовки конструктивных элементов искажённой поверхности.
    hs_DrawDisplacedSurfaceConstructionsSigns: TDrawSurfaceConstructionsSigns;
  end; // THalfSpaceBaseParameters

  // Координаты точки трёхмерного пространства в миллиметрах.
  TCoordinatesInMillemeters = record
    X, Y, Z: SmallInt;
  end; // TCoordinatesInMillemeters


const
  // Строка, информирующая о неверных данных в файле.
  InvalidFileDataString = 'Неверные данные в файле';


  // Загрузка параметров БМП из файла.
procedure LoadHalfSpaceBaseParametersFromFile(FileName: String);
// Сохранение параметров БМП в файле.
procedure SaveHalfSpaceBaseParametersToFile(FileName: String);
// Загрузка координат точек исходной поверхности.
procedure LoadSourceSurfacePointsCoordinatesFromFile(FileName: String);
// Сохранение координат точек исходной поверхности.
procedure SaveSourceSurfacePointsCoordinatesToFile(FileName: String);
// Сохранение координат точек смещённой поверхности в STL-формате.
procedure SaveDisplacedSurfacePointsCoordinatesToFile(FileName: String);
// Сохранение треугольного сегмента, заданного рремя точками, в STL-файл.
procedure WriteSurfaceTriangleToFile(Var SurfaceFile: TextFile;
  Point1, Point2, Point3: TCoordinatesInMillemeters);

implementation

uses
  // Glance-модули.
  FocalEllipsoid_Unit, Surface_Unit;


// Установка определяющих параметров модели БМП.
procedure SetHalfSpaceBaseParameters(var HalfSpaceBaseParameters: THalfSpaceBaseParameters);

  // Установка основных параметров эллипсоида.
  procedure SetEllpsoidBaseParameters(var EllpsoidBaseParameters: TEllipsoidBaseParameters;
                                          Ellipsoid: TEllipsoid);
  begin // SetEllpsoidBaseParameters
    // Параметры, определяющие построение эллипсоида.
    with EllpsoidBaseParameters do
      // Эллипсоид.
      with Ellipsoid do
        begin // LimitingEllipsoid
          with DefiningParameters.Radiuses do
            begin // with DefiningParameters.Radiuses do
              // Радиус, определяющий все остальные его радиусы.
              el_RadiusDeterminator:=Determinator;

              // Значение определяющего радиуса в миллиметрах.
              case el_RadiusDeterminator of
                XRadiusDeterminator:
                  el_DeterminateRadiusInMillimeters:=XRadiusInMillimeters;
                YRadiusDeterminator:
                  el_DeterminateRadiusInMillimeters:=YRadiusInMillimeters;
                ZRadiusDeterminator:
                  el_DeterminateRadiusInMillimeters:=ZRadiusInMillimeters;
              end; // case el_RadiusDeterminator of
            end; // with DefiningParameters.Radiuses do

          with FrameworkLinesIn1Octant do
            begin // FrameworkLinesIn1Octant
              // Количество фронтальных линий каркаса в первом октанте.
              el_NumberFrontalFrameworkLinesIn1Octant:=Frontal.Number;
              // Количество горизонтальных линий каркаса в первом октанте.
              el_NumberHorizontalFrameworkLinesIn1Octant:=Horizontal.Number;
              // Количество вертикальных линий каркаса в первом октанте.
              el_NumberVerticalFrameworkLinesIn1Octant:=Vertical.Number;

              // Признак отрисовки фронтальных линий каркаса.
              el_bFrontalFrameworkLinesDraw:=Frontal.bDraw;
              // Признак отрисовки горизонтальных линий каркаса.
              el_bHorizontalFrameworkLinesDraw:=Horizontal.bDraw;
              // Признак отрисовки вертикальных линий каркаса.
              el_bVerticalFrameworkLinesDraw:=Vertical.bDraw;
            end; // FrameworkLinesIn1Octant
        end; //Ellipsoid
  end; // SetEllpsoidBaseParameters

  // Установка признаков отрисовки конструктивных элементов поверхности.
  procedure SetDrawSurfaceConstructionsSigns(
    var DrawSurfaceConstructionsSigns: TDrawSurfaceConstructionsSigns;
        Surface: TSurface);

  begin // SetDrawSurfaceConstructionsSigns
    with DrawSurfaceConstructionsSigns do
      with Surface do
        begin // Surface
          dsc_bDrawFlooded:=bDrawFlooded;
          dsc_bDrawFramework:=bDrawFramework;
          dsc_bDrawVertex:=bDrawVertex;
        end; // Surface
  end; // SetDrawSurfaceConstructionsSigns


begin // SetHalfSpaceBaseParameters
  // Создание записи определяющих парамеров БМП.
  with HalfSpaceBaseParameters do
    begin // with HalfSpaceBaseParameters do
      // Межцентровое расстояние в миллиметрах.
      hs_BetweenDistanceInMillimeters:=
        LimitingEllipsoid.DefiningParameters.Centres.BetweenDistanceInMillimeters;
      // Мачштаб.
      hs_Zoom:=Zoom;
      // Признак отрисовки осей.
      hs_bAxis:=bAxis;
      // Признак отрисовки центровых линий.
      hs_bDrawCentersLines:=bDrawCentersLines;
      // Координатная плоскость, вращаемая при обзоре.
      hs_StartRotationPlane:=StartRotationPlane;

      // Горизонтальный и вертикальный углы поворота координатной плоскости вращения
      // относительно исходного положения
      // при выборе данной плоскости в качестве обзорной.
      case StartRotationPlane of
        XOYStartRotationPlane:
          begin
            hs_HorizontalAngleMouseButtonLeft:=XAngleMouseButtonLeft;
            hs_VerticalAngleMouseButtonLeft:=YAngleMouseButtonLeft;
          end;

        XOZStartRotationPlane:
          begin
            hs_HorizontalAngleMouseButtonLeft:=ZAngleMouseButtonLeft;
            hs_VerticalAngleMouseButtonLeft:=YAngleMouseButtonLeft;
          end;

        YOZStartRotationPlane:
          begin
            hs_HorizontalAngleMouseButtonLeft:=ZAngleMouseButtonLeft;
            hs_VerticalAngleMouseButtonLeft:=YAngleMouseButtonLeft;
          end;
      end; // case StartRotationPlane of

      // Угол наклона радиус-вектора фокуса к оси OX.
      hs_FOXInDegrees:=SourceFocalEllipsoid.Focus.Angles.FOXInDegrees;
      // Угол наклона радиус-вектора фокуса к оси OY.
      hs_FOYInDegrees:=SourceFocalEllipsoid.Focus.Angles.FOYInDegrees;

      // Признак отрисовки центрофокусных линий исходного фокуса.
      hs_bSourceFocusLines:=SourceFocalEllipsoid.Focus.bFocusLines;
      // Признак отрисовки центрофокусных линий смещённого фокуса.
      hs_bDisplacedFocusLines:=DisplacedFocalEllipsoid.Focus.bFocusLines;

      // Установка основных параметров предельного эллипсоида.
      SetEllpsoidBaseParameters(hs_LimitingEllipsoidBaseParameters,
                                LimitingEllipsoid);
      // Установка основных параметров предельного эллипсоида.
      SetEllpsoidBaseParameters(hs_SourceFocalEllipsoidBaseParameters,
                                SourceFocalEllipsoid);
      // Установка основных параметров предельного эллипсоида.
      SetEllpsoidBaseParameters(hs_DisplacedFocalEllipsoidBaseParameters,
                                DisplacedFocalEllipsoid);

      // Установка признаков отрисовки конструктивных элементов исходной поверхности.
      SetDrawSurfaceConstructionsSigns(hs_DrawSourceSurfaceConstructionsSigns,
                                       SourceSurface);
      // Установка признаков отрисовки конструктивных элементов искажённой поверхности.
      SetDrawSurfaceConstructionsSigns(hs_DrawDisplacedSurfaceConstructionsSigns,
                                       DisplacedSurface);
    end; // with HalfSpaceBaseParameters do
end; // SetHalfSpaceBaseParameters

// Проверка определяющих параметров модели БМП.
procedure CheckHalfSpaceBaseParameters(    HalfSpaceBaseParameters: THalfSpaceBaseParameters;
                                       var ErrorString: String;
                                       var ErrorCode: Byte);

var
  // Половина межцентрового расстояния.
  HalfBetweenDistanceInMillimeters: Word;
  XRadiusInMillimeters,
  YRadiusInMillimeters,
  ZRadiusInMillimeters: Word;

  // Проверка какого-то определяющего радиуса эллипсоида.
  procedure CheckEllipsoidRadius(EllipsoidRadiusInMillimeters,
                                 LowerRadiusLimitInMillimeters,
                                 UpperRadiusLimitInMillimeters: Word;
                                 AxisAndEllipsoidInGenitiveCaseString: String;
                                 LastErrorCode: Byte);

  // AxisAndEllipsoidInGenitiveCaseString - строка названия координатной оси и
  //                                        эллипсоида в родительном падеже.
  begin // CheckEllipsoidDeterminateRadius
    if EllipsoidRadiusInMillimeters >
         UpperRadiusLimitInMillimeters
      then begin
             ErrorString:='Значение определяющего радиуса ' +
               AxisAndEllipsoidInGenitiveCaseString +
               ' превысило допустимое в пределах [' +
               IntToStr(LowerRadiusLimitInMillimeters) +
               ' мм; ' + IntToStr(UpperRadiusLimitInMillimeters) + ' мм]';

             ErrorCode:=LastErrorCode + 1;
             Exit;
           end;

    if EllipsoidRadiusInMillimeters <
         LowerRadiusLimitInMillimeters
      then begin
             ErrorString:='Значение определяющего радиуса ' +
               'предельного эллипсоида меньше допустимое в пределах [' +
               IntToStr(LowerRadiusLimitInMillimeters) +
               ' мм; ' + IntToStr(UpperRadiusLimitInMillimeters) + ' мм]';

             ErrorCode:=LastErrorCode + 2;
           end // if NewRadiusInMillimeters<
  end; // CheckEllipsoidDeterminateRadius

  // Предварительный расчёт радиусов эллипсоида.
  procedure GetRadiusesInMillimeters(EllipsoidBaseParameters: TEllipsoidBaseParameters);
  begin // GetRadiusesInMillimeters
    with EllipsoidBaseParameters do
      case el_RadiusDeterminator of
        XRadiusDeterminator:
          begin // XRadiusDeterminator
            XRadiusInMillimeters:=el_DeterminateRadiusInMillimeters;

            YRadiusInMillimeters:=Round(Sqrt(
              XRadiusInMillimeters * XRadiusInMillimeters -
              HalfBetweenDistanceInMillimeters * HalfBetweenDistanceInMillimeters));

            ZRadiusInMillimeters:=YRadiusInMillimeters;
          end; // XRadiusDeterminator

        YRadiusDeterminator:
           begin // YRadiusDeterminator
             YRadiusInMillimeters:=el_DeterminateRadiusInMillimeters;

             XRadiusInMillimeters:=Round(Sqrt(
               YRadiusInMillimeters * YRadiusInMillimeters +
               HalfBetweenDistanceInMillimeters * HalfBetweenDistanceInMillimeters));

             ZRadiusInMillimeters:=YRadiusInMillimeters;
           end; // YRadiusDeterminator

         ZRadiusDeterminator:
           begin // ZRadiusDeterminator
             ZRadiusInMillimeters:=el_DeterminateRadiusInMillimeters;

             XRadiusInMillimeters:=Round(Sqrt(
               ZRadiusInMillimeters * ZRadiusInMillimeters +
               HalfBetweenDistanceInMillimeters * HalfBetweenDistanceInMillimeters));

             YRadiusInMillimeters:=ZRadiusInMillimeters;
           end; // ZRadiusDeterminator
      end; // case el_RadiusDeterminator of
  end; // GetRadiusesInMillimeters

  // Проверка определяющего радиуса эллипсоида, принадлежащего конкретной оси координат.
  procedure CheckEllipsoidDeterminateRadius(EllipsoidBaseParameters: TEllipsoidBaseParameters;
                                            EllipsoidInGenitiveCaseString: String;
                                            LastErrorCode: Byte;
                                            bCalculateRadiusInMillimeters: Boolean);
  // EllipsoidInGenitiveCaseString - строка названия эллипсоида в родительном падеже.
  // LastErrorCode - последний код ошибки, утверждённый да выподнения данной процедуры.

  begin // CheckEllipsoidDeterminateRadius
    // Проверка определяющего радиуса предельного эллипсоида.
    with EllipsoidBaseParameters do
      case el_RadiusDeterminator of
        XRadiusDeterminator:
          begin // XRadiusDeterminator
            CheckEllipsoidRadius(
              el_DeterminateRadiusInMillimeters,
              HalfBetweenDistanceInMillimeters, XRadiusInMillimeters,
              'по оси ОХ ' + EllipsoidInGenitiveCaseString, LastErrorCode);

           if ErrorCode <> 0 then Exit;

           // Предварительный расчёт радиусов эллипсоида.
           if bCalculateRadiusInMillimeters
              then GetRadiusesInMillimeters(EllipsoidBaseParameters);
          end; // XRadiusDeterminator

        YRadiusDeterminator:
          begin // YRadiusDeterminator
            CheckEllipsoidRadius(
              el_DeterminateRadiusInMillimeters,
              0, YRadiusInMillimeters,
              'по оси ОY ' + EllipsoidInGenitiveCaseString, LastErrorCode + 2);

            if ErrorCode <> 0 then Exit;

           // Предварительный расчёт радиусов эллипсоида.
           if bCalculateRadiusInMillimeters
              then GetRadiusesInMillimeters(EllipsoidBaseParameters);
          end; // YRadiusDeterminator

        ZRadiusDeterminator:
          begin // ZRadiusDeterminator
            CheckEllipsoidRadius(
              el_DeterminateRadiusInMillimeters,
              0, ZRadiusInMillimeters,
              'по оси ОZ ' + EllipsoidInGenitiveCaseString, LastErrorCode + 4);

            if ErrorCode <> 0 then Exit;

           // Предварительный расчёт радиусов эллипсоида.
           if bCalculateRadiusInMillimeters
              then GetRadiusesInMillimeters(EllipsoidBaseParameters);
          end; // ZRadiusDeterminator
      end; // case el_RadiusDeterminator of
  end; // CheckEllipsoidDeterminateRadius

  // Проверка количества параллельных линий каркаса эллипсоида в одном октанте.
  procedure CheckNumberEllipsoidParallelFrameworkLinesIn1Octant(
    NumberParallelFrameworkLinesIn1Octant: Byte;
    ParallelFrameworkLinesInGenitiveCaseString,
    EllipsoidInGenitiveCaseString: String;
    LastErrorCode: Byte);

  begin // CheckNumberEllipsoidParallelFrameworkLinesIn1Octant
   if NumberParallelFrameworkLinesIn1Octant <
        MinNumEllipsoidParallelFrameworkLinesInOctant
     then begin
            ErrorString:='Количество ' + ParallelFrameworkLinesInGenitiveCaseString +
              ' линий каркаса в одном октанте ' + EllipsoidInGenitiveCaseString+
              ' меньше допустимого в пределах [' +
              IntToStr(MinNumEllipsoidParallelFrameworkLinesInOctant) + '; ' +
              IntToStr(MaxNumEllipsoidParallelFrameworkLinesInOctant)+']';

            ErrorCode:=LastErrorCode + 1;
            Exit;
          end; // if NumberParallelFrameworkLinesIn1Octant <

   if NumberParallelFrameworkLinesIn1Octant >
        MaxNumEllipsoidParallelFrameworkLinesInOctant
     then begin
            ErrorString:='Количество ' + ParallelFrameworkLinesInGenitiveCaseString+
              ' линий каркаса в одном октанте ' +  EllipsoidInGenitiveCaseString +
              ' превысило допустимое в пределах [' +
              IntToStr(MinNumEllipsoidParallelFrameworkLinesInOctant) + '; ' +
              IntToStr(MaxNumEllipsoidParallelFrameworkLinesInOctant)+']';

            ErrorCode:=LastErrorCode + 2;
          end; // if NumberParallelFrameworkLinesIn1Octant >
  end; // CheckNumberEllipsoidParallelFrameworkLinesIn1Octant

  // Проверка количества линий каркаса эллипсоида в одном октанте.
  procedure CheckNumberEllipsoidFrameworkLinesIn1Octant(
    EllipsoidBaseParameters: TEllipsoidBaseParameters;
    EllipsoidInGenitiveCaseString: String;
    LastErrorCode: Byte);

  begin // CheckNumberEllipsoidFrameworkLinesIn1Octant
    with EllipsoidBaseParameters do
      begin
        CheckNumberEllipsoidParallelFrameworkLinesIn1Octant(
          el_NumberFrontalFrameworkLinesIn1Octant,
          'фронтальных', EllipsoidInGenitiveCaseString, LastErrorCode);

        if ErrorCode <> 0 then Exit;

        CheckNumberEllipsoidParallelFrameworkLinesIn1Octant(
          el_NumberHorizontalFrameworkLinesIn1Octant,
          'горизонтальных', EllipsoidInGenitiveCaseString, LastErrorCode + 2);

        if ErrorCode <> 0 then Exit;

        CheckNumberEllipsoidParallelFrameworkLinesIn1Octant(
          el_NumberVerticalFrameworkLinesIn1Octant,
          'вертикальных', EllipsoidInGenitiveCaseString, LastErrorCode + 4);
       end;
  end; // CheckNumberEllipsoidFrameworkLinesIn1Octant

  // Преобразование угла наклона радиус-вектора фокуса к оси в диапазон (-180; 180].
  procedure SetFocusAngleInDegreesToRange(var FocusAngleInDegrees: Single);
  begin // SetFocusAngleInDegreesToRange
    FocusAngleInDegrees:=(Trunc(FocusAngleInDegrees*100) mod 36000)/100;

    if FocusAngleInDegrees<=-180
      then FocusAngleInDegrees:=FocusAngleInDegrees+360;
    if FocusAngleInDegrees>180
      then FocusAngleInDegrees:=FocusAngleInDegrees-360;
  end; // SetFocusAngleInDegreesToRange


begin // CheckHalfSpaceBaseParameters
  ErrorCode:=0;
  ErrorString:='';

  with HalfSpaceBaseParameters do
    begin // with HalfSpaceBaseParameters do
      if hs_BetweenDistanceInMillimeters > MaxEllipsoidBetweenDistanceInMillimeters
        then begin
               ErrorString:='Межцентровое рассотяние ' +
                 'предельного эллипсоида превысило допустимое в пределах [0 мм; ' +
                 IntToStr(MaxEllipsoidBetweenDistanceInMillimeters) + ' мм]';

               ErrorCode:=1;
               Exit;
             end; // if NewBetweenDistanceInMillimeters>

      HalfBetweenDistanceInMillimeters:=Round(hs_BetweenDistanceInMillimeters / 2);

      // Преобразование угла наклона радиус-вектора фокуса к оси в диапазон (-180; 180].
      SetFocusAngleInDegreesToRange(hs_FOXInDegrees);

      if hs_FOXInDegrees < 0
        then begin // if hs_FOXInDegrees < 0
               ErrorString:=
                 'Значение угла наклона радиус-вектора фокуса к оси OX ' +
                 'не вошло в допустимые пределы [0; 180]';

               ErrorCode:=2;
               Exit;
             end; //  if hs_FOXInDegrees < 0

      // Преобразование угла наклона радиус-вектора фокуса к оси в диапазон (-180; 180].
      SetFocusAngleInDegreesToRange(hs_FOYInDegrees);

      if hs_FOYInDegrees < 0
        then begin // hs_FOYInDegrees < 0
               ErrorString:=
                 'Значение угла наклона радиус-вектора фокуса к оси OY ' +
                 'не вошло в допустимые пределы [0; 180]';

               ErrorCode:=3;
               Exit;
             end; // hs_FOYInDegrees < 0

      XRadiusInMillimeters:=MaxEllipsoidRadiusInMillimeters;
      YRadiusInMillimeters:=MaxEllipsoidRadiusInMillimeters;
      ZRadiusInMillimeters:=MaxEllipsoidRadiusInMillimeters;

      // Проверка определяющего радиуса предельного эллипсоида,
      // принадлежащего конкретной оси координат.
      CheckEllipsoidDeterminateRadius(hs_LimitingEllipsoidBaseParameters,
                                      'предельного эллипсоида', 3, True);
      if ErrorCode <> 0 then Exit;
      // Проверка определяющего радиуса эллипсоида исходного фокуса,
      // принадлежащего конкретной оси координат.
      CheckEllipsoidDeterminateRadius(hs_SourceFocalEllipsoidBaseParameters,
                                      'эллипсоида исходного фокуса', 9, True);
      if ErrorCode <> 0 then Exit;
      // Проверка определяющего радиуса эллипсоида исходного фокуса,
      // принадлежащего конкретной оси координат.
      CheckEllipsoidDeterminateRadius(hs_DisplacedFocalEllipsoidBaseParameters,
                                      'эллипсоида смещённого фокуса', 15, False);
      if ErrorCode <> 0 then Exit;

      // Проверка количества линий каркаса предельного эллипсоида в одном октанте.
      CheckNumberEllipsoidFrameworkLinesIn1Octant(
        hs_LimitingEllipsoidBaseParameters,
        'предельного эллипсоида', 21);

      if ErrorCode <> 0 then Exit;
      // Проверка количества линий каркаса эллипсоида исходного фокуса в одном октанте.
      CheckNumberEllipsoidFrameworkLinesIn1Octant(
        hs_SourceFocalEllipsoidBaseParameters,
        'эллипсоида исходного фокуса', 27);

      if ErrorCode <> 0 then Exit;
      // Проверка количества линий каркаса эллипсоида смещённого фокуса в одном октанте.
      CheckNumberEllipsoidFrameworkLinesIn1Octant(
        hs_DisplacedFocalEllipsoidBaseParameters,
        'эллипсоида смещённого фокуса', 33);

      // Проверка масштаба.
      if hs_Zoom > MaxZoom
        then begin // if hs_Zoom > MaxZoom
               ErrorString:='Масштаб превысил допустимый в пределах [' +
                 IntToStr(MinZoom) + ' мм; ' + IntToStr(MaxZoom) + ' мм]';

               ErrorCode:=40;
               Exit;
             end; // if hs_Zoom > MaxZoom

      if hs_Zoom < MinZoom
        then begin // if hs_Zoom < MinZom
               ErrorString:='Масштаб меньше допустимого в пределах [' +
                 IntToStr(MinZoom) + ' мм; ' + IntToStr(MaxZoom) + ' мм]';

               ErrorCode:=41;
             end; // if hs_Zoom < MinZom
    end; // with HalfSpaceBaseParameters do
end; // CheckHalfSpaceBaseParameters

// Получение определяющих параметров модели БМП.
procedure GetHalfSpaceBaseParameters(var HalfSpaceBaseParameters: THalfSpaceBaseParameters);

  // Получение основных параметров эллипсоида.
  procedure GetEllipsoidBaseParameters(
    var EllpsoidBaseParameters: TEllipsoidBaseParameters;
    var FocalEllipsoid: TFocalEllipsoid;
        bFocalEllipsoid: Boolean;

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
        VerticalFrameworkUpDown: TUpDown;

    var HideFrameworkSpeedButton: TSpeedButton;
    var FrameworkMenuItem: TMenuItem);

  // bFocalEllipsoid - признак того, что эллипсоид - фокусный.

  begin // GetFocalEllipsoidBaseParameters
    with EllpsoidBaseParameters do
      begin // FocalEllpsoidBaseParameters
        if bFocalEllipsoid
          then begin // if bFocalEllipsoid
                 FocalEllipsoid.Destroy;

                 FocalEllipsoid:=TFocalEllipsoid.Create(
                   HalfSpaceBaseParameters.hs_BetweenDistanceInMillimeters,
                   el_RadiusDeterminator,
                   el_DeterminateRadiusInMillimeters,

                   el_NumberFrontalFrameworkLinesIn1Octant,
                   el_NumberHorizontalFrameworkLinesIn1Octant,
                   el_NumberVerticalFrameworkLinesIn1Octant,

                   el_bFrontalFrameworkLinesDraw,
                   el_bHorizontalFrameworkLinesDraw,
                   el_bVerticalFrameworkLinesDraw,

                   HalfSpaceBaseParameters.hs_FOXInDegrees,
                   HalfSpaceBaseParameters.hs_FOYInDegrees)
               end // if bFocalEllipsoid

          else begin // if not bFocalEllipsoid
                 LimitingEllipsoid.Destroy;

                 LimitingEllipsoid:=TEllipsoid.Create(
                   HalfSpaceBaseParameters.hs_BetweenDistanceInMillimeters,
                   el_RadiusDeterminator,
                   el_DeterminateRadiusInMillimeters,

                   el_NumberFrontalFrameworkLinesIn1Octant,
                   el_NumberHorizontalFrameworkLinesIn1Octant,
                   el_NumberVerticalFrameworkLinesIn1Octant,

                   el_bFrontalFrameworkLinesDraw,
                   el_bHorizontalFrameworkLinesDraw,
                   el_bVerticalFrameworkLinesDraw);
               end; // if not bFocalEllipsoid

          FrontalFrameworkEdit.Text:=IntToStr(el_NumberFrontalFrameworkLinesIn1Octant);
          HorizontalFrameworkEdit.Text:=IntToStr(el_NumberHorizontalFrameworkLinesIn1Octant);
          VerticalFrameworkEdit.Text:=IntToStr(el_NumberVerticalFrameworkLinesIn1Octant);

          FrontalFrameworkSpeedButton.Down:=el_bFrontalFrameworkLinesDraw;
          HorizontalFrameworkSpeedButton.Down:=el_bHorizontalFrameworkLinesDraw;
          VerticalFrameworkSpeedButton.Down:=el_bVerticalFrameworkLinesDraw;

          FrontalFrameworkMenuItem.Checked:=el_bFrontalFrameworkLinesDraw;
          HorizontalFrameworkMenuItem.Checked:=el_bHorizontalFrameworkLinesDraw;
          VerticalFrameworkMenuItem.Checked:=el_bVerticalFrameworkLinesDraw;

          FrontalFrameworkEdit.Enabled:=el_bFrontalFrameworkLinesDraw;
          HorizontalFrameworkEdit.Enabled:=el_bHorizontalFrameworkLinesDraw;
          VerticalFrameworkEdit.Enabled:=el_bVerticalFrameworkLinesDraw;

          FrontalFrameworkUpDown.Enabled:=el_bFrontalFrameworkLinesDraw;
          HorizontalFrameworkUpDown.Enabled:=el_bHorizontalFrameworkLinesDraw;
          VerticalFrameworkUpDown.Enabled:=el_bVerticalFrameworkLinesDraw;


          HideFrameworkSpeedButton.Down:=False;
          FrameworkMenuItem.Checked:=True;

          if el_bFrontalFrameworkLinesDraw or
             el_bHorizontalFrameworkLinesDraw or
             el_bVerticalFrameworkLinesDraw

            then HideFrameworkSpeedButton.Enabled:=True
            else HideFrameworkSpeedButton.Enabled:=False;

          FrameworkMenuItem.Enabled:=HideFrameworkSpeedButton.Enabled;
      end; // FocalEllpsoidBaseParameters
  end; // GetFocalEllipsoidBaseParameters

  // Получение признаков отображения конструктивных эламентов поверхности.
  procedure GetDrawSurfaceConstructionsSigns(
    var DrawSurfaceConstructionsSigns: TDrawSurfaceConstructionsSigns;
    var Surface: TSurface;

    var FloodedSurfaceSpeedButton,
        SurfaceFrameworkSpeedButton,
        SurfaceVertexSpeedButton: TSpeedButton;

    var FloodedSurfaceMenuItem,
        SurfaceFrameworkMenuItem,
        SurfaceVertexMenuItem: TMenuItem;

    var HideSurfaceSpeedButton: TSpeedButton;
        DrawSurfaceMenuItem: TMenuItem);

  begin  // GetDrawSurfaceConstructionsSigns
    with DrawSurfaceConstructionsSigns do
      with Surface do
        begin // with Surface do
          bDrawFlooded:=dsc_bDrawFlooded;
          bDrawFramework:=dsc_bDrawFramework;
          bDrawVertex:=dsc_bDrawVertex;

          FloodedSurfaceSpeedButton.Enabled:=dsc_bDrawFlooded;
          SurfaceFrameworkSpeedButton.Enabled:=dsc_bDrawFramework;
          SurfaceVertexSpeedButton.Enabled:=dsc_bDrawVertex;

          FloodedSurfaceMenuItem.Enabled:=dsc_bDrawFlooded;
          SurfaceFrameworkMenuItem.Enabled:=dsc_bDrawFramework;
          SurfaceVertexMenuItem.Enabled:=dsc_bDrawVertex;

          FloodedSurfaceSpeedButton.Down:=dsc_bDrawFlooded;
          SurfaceFrameworkSpeedButton.Down:=dsc_bDrawFramework;
          SurfaceVertexSpeedButton.Down:=dsc_bDrawVertex;

          FloodedSurfaceMenuItem.Checked:=dsc_bDrawFlooded;
          SurfaceFrameworkMenuItem.Checked:=dsc_bDrawFramework;
          SurfaceVertexMenuItem.Checked:=dsc_bDrawVertex;

          HideSurfaceSpeedButton.Down:=False;
          DrawSurfaceMenuItem.Checked:=True;

          if dsc_bDrawFlooded or dsc_bDrawFramework or dsc_bDrawVertex
            then HideSurfaceSpeedButton.Enabled:=True
            else HideSurfaceSpeedButton.Enabled:=False;

          DrawSurfaceMenuItem.Enabled:=HideSurfaceSpeedButton.Enabled;
        end; // with Surface do
  end; // GetDrawSurfaceConstructionsSigns


begin // GetHalfSpaceBaseParameters
  MainForm.CorrectionsProtocolMemo.Clear;
  MainForm.StatusBar.Panels[0].Text:='';

  // Создание записи определяющих парамеров БМП.
  with HalfSpaceBaseParameters do
    with MainForm do
      begin // with MainForm do
        // Перерасчёт параметров предельного эллипсоида.
        SetScaleFactorPercentsInMillimeter(
          hs_LimitingEllipsoidBaseParameters.el_DeterminateRadiusInMillimeters,
          ScaleFactorPercentsInMillimeter);

        // Получение основных параметров предельного эллипсоида.
        GetEllipsoidBaseParameters(hs_LimitingEllipsoidBaseParameters,
                                   SourceFocalEllipsoid, False,

                                   LimitingFrontalFrameworkSpeedButton,
                                   LimitingHorizontalFrameworkSpeedButton,
                                   LimitingVerticalFrameworkSpeedButton,

                                   LimitingFrontalFrameworkMenuItem,
                                   LimitingHorizontalFrameworkMenuItem,
                                   LimitingVerticalFrameworkMenuItem,

                                   LimitingFrontalFrameworkEdit,
                                   LimitingHorizontalFrameworkEdit,
                                   LimitingVerticalFrameworkEdit,

                                   LimitingFrontalFrameworkUpDown,
                                   LimitingHorizontalFrameworkUpDown,
                                   LimitingVerticalFrameworkUpDown,

                                   HideLimitingFrameworkSpeedButton,
                                   LimitingFrameworkMenuItem);


        // Получение основных параметров эллипсоида исходного фокуса.
        GetEllipsoidBaseParameters(hs_SourceFocalEllipsoidBaseParameters,
                                   SourceFocalEllipsoid, True,

                                   SourceFocalFrontalFrameworkSpeedButton,
                                   SourceFocalHorizontalFrameworkSpeedButton,
                                   SourceFocalVerticalFrameworkSpeedButton,

                                   SourceFocalFrontalFrameworkMenuItem,
                                   SourceFocalHorizontalFrameworkMenuItem,
                                   SourceFocalVerticalFrameworkMenuItem,

                                   SourceFocalFrontalFrameworkEdit,
                                   SourceFocalHorizontalFrameworkEdit,
                                   SourceFocalVerticalFrameworkEdit,

                                   SourceFocalFrontalFrameworkUpDown,
                                   SourceFocalHorizontalFrameworkUpDown,
                                   SourceFocalVerticalFrameworkUpDown,

                                   HideSourceFocalFrameworkSpeedButton,
                                   SourceFocalFrameworkMenuItem);                                   

        // Получение основных параметров эллипсоида смещённого фокуса.
        GetEllipsoidBaseParameters(hs_DisplacedFocalEllipsoidBaseParameters,
                                   DisplacedFocalEllipsoid, True,

                                   DisplacedFocalFrontalFrameworkSpeedButton,
                                   DisplacedFocalHorizontalFrameworkSpeedButton,
                                   DisplacedFocalVerticalFrameworkSpeedButton,

                                   DisplacedFocalFrontalFrameworkMenuItem,
                                   DisplacedFocalHorizontalFrameworkMenuItem,
                                   DisplacedFocalVerticalFrameworkMenuItem,

                                   DisplacedFocalFrontalFrameworkEdit,
                                   DisplacedFocalHorizontalFrameworkEdit,
                                   DisplacedFocalVerticalFrameworkEdit,

                                   DisplacedFocalFrontalFrameworkUpDown,
                                   DisplacedFocalHorizontalFrameworkUpDown,
                                   DisplacedFocalVerticalFrameworkUpDown,

                                   HideDisplacedFocalFrameworkSpeedButton,
                                   DisplacedFocalFrameworkMenuItem);


        // Признак отрисовки центрофокусных линий исходного фокуса.
        SourceFocalEllipsoid.Focus.bFocusLines:=hs_bSourceFocusLines;
        // Признак отрисовки центрофокусных линий смещённого фокуса.
        DisplacedFocalEllipsoid.Focus.bFocusLines:=hs_bDisplacedFocusLines;

        // Отображение хотя бы каких-нибуть центрофокусных линий.
        if hs_bSourceFocusLines or hs_bDisplacedFocusLines
          then bAnyFocalLines:=True
          else bAnyFocalLines:=False;


        // Кнопки оттображения центрофокусных линий эллипсоидов.
        SourceFocalLinesSpeedButton.Down:=hs_bSourceFocusLines;
        DisplacedFocalLinesSpeedButton.Down:=hs_bDisplacedFocusLines;
        // Пункты меню оттображения центрофокусных линий эллипсоидов.
        DrawSourceFocalLinesMenuItem.Checked:=hs_bSourceFocusLines;
        DrawDisplacedFocalLinesMenuItem.Checked:=hs_bDisplacedFocusLines;
        // Отображение всех центрофокусных линий эллипсоидов.
        HideFocalLinesSpeedButton.Down:=False;
        DrawFocalLinesMenuItem.Checked:=True;
        // Доступность управлением отображения  всех центрофокусных линий.
        if hs_bSourceFocusLines or hs_bDisplacedFocusLines
          then HideFocalLinesSpeedButton.Enabled:=True
          else HideFocalLinesSpeedButton.Enabled:=False;

        DrawFocalLinesMenuItem.Enabled:=HideFocalLinesSpeedButton.Enabled;


        // Координатная плоскость, вращаемая при обзоре.
        StartRotationPlane:=hs_StartRotationPlane;
        bRotate:=False;

        // Горизонтальный и вертикальный углы поворота координатной плоскости вращения
        // относительно исходного положения
        // при выборе данной плоскости в качестве обзорной.
        case StartRotationPlane of
          XOYStartRotationPlane:
            begin
              XAngleMouseButtonLeft:=hs_HorizontalAngleMouseButtonLeft;
              XAngleMouseButtonLeft:=hs_VerticalAngleMouseButtonLeft;

              XStartAngle:=0;
              YStartAngle:=180;
              ZStartAngle:=0;
            end;

          XOZStartRotationPlane:
            begin
              ZAngleMouseButtonLeft:=hs_HorizontalAngleMouseButtonLeft;
              YAngleMouseButtonLeft:=hs_VerticalAngleMouseButtonLeft;

              XStartAngle:=90;
              YStartAngle:=180;
              ZStartAngle:=0;
            end;

          YOZStartRotationPlane:
            begin
              ZAngleMouseButtonLeft:=hs_HorizontalAngleMouseButtonLeft;
              YAngleMouseButtonLeft:=hs_VerticalAngleMouseButtonLeft;

              XStartAngle:=90;
              YStartAngle:=180;
              ZStartAngle:=90;
            end;
        end; // case StartRotationPlane of

        // Мачштаб.
        Zoom:=hs_Zoom;
        ZoomMaskEdit.Text:=IntToStr(Zoom);

        // Признак отрисовки осей.
        bAxis:=hs_bAxis;

        AxisSpeedButton.Down:=hs_bAxis;
        AxisMenuItem.Checked:=hs_bAxis;
        HideAxisSpeedButton.Down:=not hs_bAxis;


        // Признак отрисовки центровых линий.
        bDrawCentersLines:=hs_bDrawCentersLines;

        CentersLinesSpeedButton.Down:=hs_bDrawCentersLines;
        CentersLinesMenuItem.Checked:=hs_bDrawCentersLines;
        HideCentersLinesSpeedButton.Down:=not hs_bDrawCentersLines;

        // Вывод параметров предельного эллипсоида.
        LimitingBetweenDistanceMaskEdit.Text:=IntToStr(
          LimitingEllipsoid.DefiningParameters.Centres.BetweenDistanceInMillimeters);
        with LimitingEllipsoid.DefiningParameters.Radiuses do
          begin
            LimitingXRadiusMaskEdit.Text:=IntToStr(XRadiusInMillimeters);
            LimitingYRadiusMaskEdit.Text:=IntToStr(YRadiusInMillimeters);
            LimitingZRadiusMaskEdit.Text:=IntToStr(ZRadiusInMillimeters);
          end; // with LimmitingEllipsoid

        // Вывод всех параметров фокусных эллипсоидов,
        // доступных для просмотра пользователя.
        OutPutAllFocalEllipsoidsParameters;

        // Получение признаков отображения конструктивных эламентов
        // исходной поверхности.
        GetDrawSurfaceConstructionsSigns(hs_DrawSourceSurfaceConstructionsSigns,
                                         SourceSurface,

                                         FloodedSourceSurfaceSpeedButton,
                                         SourceSurfaceFrameworkSpeedButton,
                                         SourceSurfaceVertexSpeedButton,

                                         FloodedSourceSurfaceMenuItem,
                                         SourceSurfaceFrameworkMenuItem,
                                         SourceSurfaceVertexMenuItem,

                                         HideSourceSurfaceSpeedButton,
                                         DrawSourceSurfaceMenuItem);

        // Получение признаков отображения конструктивных эламентов
        // искажённой поверхности.
        GetDrawSurfaceConstructionsSigns(hs_DrawDisplacedSurfaceConstructionsSigns,
                                         DisplacedSurface,

                                         FloodedDisplacedSurfaceSpeedButton,
                                         DisplacedSurfaceFrameworkSpeedButton,
                                         DisplacedSurfaceVertexSpeedButton,

                                         FloodedDisplacedSurfaceMenuItem,
                                         DisplacedSurfaceFrameworkMenuItem,
                                         DisplacedSurfaceVertexMenuItem,

                                         HideDisplacedSurfaceSpeedButton,
                                         DrawDisplacedSurfaceMenuItem);

        // Недоступность объектов отображения поверхностей, если ои не определены.
        if SourceSurface.bDetermined = False
          then DisableDrawingSurfacesObjects(MainForm);
      end; // with MainForm do

  // Установка цветов для объектов модели БМП.
  SetHalfSpaceColors;
end; // GetHalfSpaceBaseParameters

// Установка строки сообщения при ошибке ввода/вывода с кодом ErrorCode
// при работе с файлом с именем FileName.
procedure SetErrorString(var ErrorString: String;
                             ErrorCode: Integer;
                             FileName: String);
begin // SetErrorString
  case ErrorCode of
      2: ErrorString:='Файл ''' + FileName + ''' не найден';
      3: ErrorString:='Ошибочное имя файла ''' + FileName + '''';
      4: ErrorString:='Слишком много открытых файлов';
      5: ErrorString:='Файл ''' + FileName + ''' не доступен';
    100: ErrorString:='Достигнут конец файла ''' + FileName + '''';
    101: ErrorString:='Переполнение диска при работе с файлом ''' + FileName + '''';
    102: ErrorString:='Файловая переменная не ассоциируется с файлом ''' + FileName + '''';
    103: ErrorString:='Файл ''' + FileName + ''' не открыт';
    104: ErrorString:='Файл ''' + FileName + ''' не открыт для записи данных';
    105: ErrorString:='Файл ''' + FileName + ''' не открыт для чтения данных';
    106: ErrorString:='Ошибка формата ввода при работе с файлом ''' + FileName + '''';
    107: ErrorString:='Файл ''' + FileName + ''' уже открыт';
  end; // case ErrorCode of

  MessageDlg(ErrorString, mtWarning, [mbOK], 0);
end; // SetErrorString


// Сохранение параметров БМП в файле.
procedure SaveHalfSpaceBaseParametersToFile(FileName: String);
var
  // Файл определяющих пареметров БМП.
  HalfSpaceBaseParametersFile: File of THalfSpaceBaseParameters;
  // Определяющие параметры модели БМП.
  HalfSpaceBaseParameters: THalfSpaceBaseParameters;
  // Строка сообщения об ошибке ввода/вывода.
  ErrorString: String;

begin // SaveHalfSpaceBaseParametersToFile
  // Установка определяющих параметров модели БМП.
  HalfSpaceBaseParameters.hs_HalfSpaceTitle:='GlanceHalfSpace';
  SetHalfSpaceBaseParameters(HalfSpaceBaseParameters);

  try
    // Связь файловой переменной с файлом с именем FileName.
    Assign(HalfSpaceBaseParametersFile, FileName);
    // Создание и открытие нового файла.
    Rewrite(HalfSpaceBaseParametersFile);
    // Помещение в файл полученной записи.
    Write(HalfSpaceBaseParametersFile, HalfSpaceBaseParameters);
    // Закрытие файла.
    CloseFile(HalfSpaceBaseParametersFile);

  except
    on IO: EInOutError do
      // Установка строки сообщения при ошибке ввода/вывода
      // при работе с файлом с именем FileName.
      SetErrorString(ErrorString, IO.ErrorCode, FileName);

    else MessageDlg('Ошибка ввода/вывода при записи в файл ''' + FileName + '''', mtWarning, [mbOK], 0);
  end; // try ... except
end; // SaveHalfSpaceBaseParametersToFile

// Загрузка параметров БМП из файла.
procedure LoadHalfSpaceBaseParametersFromFile(FileName: String);
var
  // Файл определяющих пареметров БМП.
  HalfSpaceBaseParametersFile: File of THalfSpaceBaseParameters;
  // Определяющие параметры модели БМП.
  HalfSpaceBaseParameters: THalfSpaceBaseParameters;
  // Строка сообщения об ошибке ввода/вывода.
  ErrorString: String;
  // Код ошибки неверных данных в параметрах полупространства.
  ErrorCode: Byte;

begin // LoadHalfSpaceBaseParametersFromFile
  try
    // Связь файловой переменной с файлом с именем FileName.
    Assign(HalfSpaceBaseParametersFile, FileName);
    // Открытие файла.
    Reset(HalfSpaceBaseParametersFile);
    // Чтение из файла новой записи.
    Read(HalfSpaceBaseParametersFile, HalfSpaceBaseParameters);
    // Закрытие файла.
    CloseFile(HalfSpaceBaseParametersFile);

    if HalfSpaceBaseParameters.hs_HalfSpaceTitle <> 'GlanceHalfSpace'
      then begin // if hs_HalfSpaceTitle <>
             ErrorString:='Файл ''' + FileName +
               ''' не является хранителем основных параметров модели БМП';
             MessageDlg(ErrorString, mtWarning, [mbOK], 0);

             Exit;
           end; // if hs_HalfSpaceTitle <>

    // Проверка определяющих параметров модели БМП.
    CheckHalfSpaceBaseParameters(HalfSpaceBaseParameters, ErrorString ,ErrorCode);
    if ErrorCode <> 0
      // Вывод сообщение об ошибке.
      then MessageDlg(InvalidFileDataString + ' ''' + FileName + '''! ' +
             ErrorString, mtWarning, [mbOK], 0)
      else begin
             // Получение определяющих параметров модели БМП.
             GetHalfSpaceBaseParameters(HalfSpaceBaseParameters);
             MainForm.Repaint;
           end;

  except
    on IO: EInOutError do
      // Установка строки сообщения при ошибке ввода/вывода
      // при работе с файлом с именем FileName.
      SetErrorString(ErrorString, IO.ErrorCode, FileName);

    else MessageDlg('Ошибка ввода/вывода при чтении из файла ''' + FileName + '''', mtWarning, [mbOK], 0);
  end; // try ... except
end; // LoadHalfSpaceBaseParametersFromFile

// Сохранение координат точек исходной поверхности.
procedure SaveSourceSurfacePointsCoordinatesToFile(FileName: String);
var
  // Файл координат точеу исходной поверхности в трёхмерном пространстве.
  // Первый элемент файла содержит количество строк и столбцов точек.
  SourceSurfacePointsCoordinatesFile: File of TCoordinatesInMillemeters;
  // Координаты точи исходной поверхности в трёхмерном пространстве.
  SourceSurfacePointCoordinates: TCoordinatesInMillemeters;
  // Строка сообщения об ошибке ввода/вывода.
  ErrorString: String;
  // Параметры циклов.
  i, j: Byte;

begin // SaveSourceSurfacePointsCoordinatesToFile
  try
    // Связь файловой переменной с файлом с именем FileName.
    Assign(SourceSurfacePointsCoordinatesFile, FileName);
    // Создание и открытие нового файла.
    Rewrite(SourceSurfacePointsCoordinatesFile);

    with SourceSurfacePointCoordinates do
      with SourceSurface do
        begin // with SourceSurface do
          // Условный код файла Glance: SourceSurfacePointsCoordinates
          Y:=-6142;    
          X:=NumberPointsRows;
          Z:=NumberPointsColumns;
          // Помещение в файл полученной записи.
          Write(SourceSurfacePointsCoordinatesFile, SourceSurfacePointCoordinates);

          for i:=1 to NumberPointsRows do
            for j:=1 to NumberPointsColumns do
              begin // for j
                X:=GridXInMillimeters[i]^[j]^.Coordinate;
                Y:=GridYInMillimeters[i]^[j]^.Coordinate;
                Z:=GridZInMillimeters[i]^[j]^.Coordinate;
                // Помещение в файл полученной записи.
                Write(SourceSurfacePointsCoordinatesFile, SourceSurfacePointCoordinates);
              end; // for j
        end; // with SourceSurface do

    // Закрытие файла.
    CloseFile(SourceSurfacePointsCoordinatesFile);

  except
    on IO: EInOutError do
      // Установка строки сообщения при ошибке ввода/вывода
      // при работе с файлом с именем FileName.
      SetErrorString(ErrorString, IO.ErrorCode, FileName);

    else MessageDlg('Ошибка ввода/вывода при записи в файл ''' + FileName + '''', mtWarning, [mbOK], 0);
  end; // try ... except
end; // SaveSourceSurfacePointsCoordinatesToFile

// Сохранение координат точек смещённой поверхности в STL-формате.
procedure SaveDisplacedSurfacePointsCoordinatesToFile(FileName: String);
var
  // Расширенное имя файла.
  ExtentedFileName: String;
  // Текстовый STL-файл единичных векторов нормалей и треугольных сегментов
  // сетчатой поверхности.
  DisplacedSurfaceFile: TextFile;
  // Координаты точек смещённой поверхности в трёхмерном пространстве,
  // составляющие прямоугольный сегмент.
  TopLeftPoint, TopRightPoint, BottomLeftPoint, BottomRightPoint:
    TCoordinatesInMillemeters;
  // Минимальные абсцисса, ориданта и аппликата смещённой поверхности.
  MinimumCoordinates: TCoordinatesInMillemeters;
  // Максимальные абсцисса, ориданта и аппликата смещённой поверхности.
  MaximumCoordinates: TCoordinatesInMillemeters;
  // Координаты центра смещённой поверхности.
  Centre: TCoordinatesInMillemeters;
  // Строка сообщения об ошибке ввода/вывода.
  ErrorString: String;
  // Параметры циклов.
  i, j: Byte;
  
begin // SaveDisplacedSurfacePointsCoordinatesToFile
  try
    // Связь файловой переменной с файлом с именем FileName.
    AssignFile(DisplacedSurfaceFile, FileName);
    // Создание и открытие нового файла.
    Rewrite(DisplacedSurfaceFile);

    // Расширенное имя файла.
    ExtentedFileName:=' ' + FileName + '_Glance_2_2_2';
    // Маркер начала файла и заголовок.
    WriteLn(DisplacedSurfaceFile, 'solid' + ExtentedFileName);

    with DisplacedSurface do
      begin // with DisplacedSurface do
        // Для открытия в 3D-редакторе STL-файла лучше сделать,
        // чтобы центр фигуры был в начале координат.

        // Поиск максимальных и минимальных значений координат
        // смещённой поверхности.

        // Минимальные абсцисса, ориданта и аппликата смещённой поверхности.
        MinimumCoordinates.X:=GridXInMillimeters[1]^[1]^.Coordinate;
        MinimumCoordinates.Y:=GridYInMillimeters[1]^[1]^.Coordinate;
        MinimumCoordinates.Z:=GridZInMillimeters[1]^[1]^.Coordinate;
        // Максимальные абсцисса, ориданта и аппликата смещённой поверхности.
        MaximumCoordinates.X:=GridXInMillimeters[1]^[1]^.Coordinate;
        MaximumCoordinates.Y:=GridYInMillimeters[1]^[1]^.Coordinate;
        MaximumCoordinates.Z:=GridZInMillimeters[1]^[1]^.Coordinate;

        for i:=1 to NumberPointsRows do
          for j:=1 to NumberPointsColumns do
            begin // for j
              if GridXInMillimeters[i]^[j]^.Coordinate < MinimumCoordinates.X
                then MinimumCoordinates.X:=GridXInMillimeters[i]^[j]^.Coordinate;
              if GridXInMillimeters[i]^[j]^.Coordinate > MaximumCoordinates.X
                then MaximumCoordinates.X:=GridXInMillimeters[i]^[j]^.Coordinate;

              if GridYInMillimeters[i]^[j]^.Coordinate < MinimumCoordinates.Y
                then MinimumCoordinates.Y:=GridYInMillimeters[i]^[j]^.Coordinate;
              if GridYInMillimeters[i]^[j]^.Coordinate > MaximumCoordinates.Y
                then MaximumCoordinates.Y:=GridYInMillimeters[i]^[j]^.Coordinate;

              if GridZInMillimeters[i]^[j]^.Coordinate < MinimumCoordinates.Z
                then MinimumCoordinates.Z:=GridZInMillimeters[i]^[j]^.Coordinate;
              if GridZInMillimeters[i]^[j]^.Coordinate > MaximumCoordinates.Z
                then MaximumCoordinates.Z:=GridZInMillimeters[i]^[j]^.Coordinate;
            end; // for j

        // Координаты центра смещённой поверхности.
        Centre.X:=(MinimumCoordinates.X + MaximumCoordinates.X) div 2;
        Centre.Y:=(MinimumCoordinates.Y + MaximumCoordinates.Y) div 2;
        Centre.Z:=(MinimumCoordinates.Z + MaximumCoordinates.Z) div 2;

        for i:=1 to NumberPointsRows - 1 do
          for j:=1 to NumberPointsColumns - 1 do
            begin // for j
              // Получение точек текущего прямоугольного сегмента:
              // текущая точка - левая верхняя, остальные:
              // левая нижняя, правая верхняя и правая нижняя.
              // Центр фигуры переноситя в начало координат.

              TopLeftPoint.X:=GridXInMillimeters[i]^[j]^.Coordinate - Centre.X;
              TopLeftPoint.Y:=GridYInMillimeters[i]^[j]^.Coordinate - Centre.Y;
              TopLeftPoint.Z:=GridZInMillimeters[i]^[j]^.Coordinate - Centre.Z;

              TopRightPoint.X:=GridXInMillimeters[i]^[j + 1]^.Coordinate - Centre.X;
              TopRightPoint.Y:=GridYInMillimeters[i]^[j + 1]^.Coordinate - Centre.Y;
              TopRightPoint.Z:=GridZInMillimeters[i]^[j + 1]^.Coordinate - Centre.Z;

              BottomLeftPoint.X:=GridXInMillimeters[i + 1]^[j]^.Coordinate - Centre.X;
              BottomLeftPoint.Y:=GridYInMillimeters[i + 1]^[j]^.Coordinate - Centre.Y;
              BottomLeftPoint.Z:=GridZInMillimeters[i + 1]^[j]^.Coordinate - Centre.Z;

              BottomRightPoint.X:=GridXInMillimeters[i + 1]^[j + 1]^.Coordinate - Centre.X;
              BottomRightPoint.Y:=GridYInMillimeters[i + 1]^[j + 1]^.Coordinate - Centre.Y;
              BottomRightPoint.Z:=GridZInMillimeters[i + 1]^[j + 1]^.Coordinate - Centre.Z;

              // Текущий прямоугольный сегмент делится на 2 треугольных сегмента
              // прямой, проходящей через левую верхнююю и правую нижнюю точки.

              // Запись верхнего треугольника текущего прямоугольного сегмента.
              WriteSurfaceTriangleToFile(DisplacedSurfaceFile,
                TopLeftPoint, TopRightPoint, BottomRightPoint);
              // Запись нижнего треугольника текущего прямоугольного сегмента.
              WriteSurfaceTriangleToFile(DisplacedSurfaceFile,
                TopLeftPoint, BottomRightPoint, BottomLeftPoint);
            end; // for j
     end; // with DisplacedSurface do

    // Маркер конца файла и заголовок.
    WriteLn(DisplacedSurfaceFile, 'endsolid' + ExtentedFileName);
    // Закрытие файла.
    CloseFile(DisplacedSurfaceFile);

  except
    on IO: EInOutError do
      // Установка строки сообщения при ошибке ввода/вывода
      // при работе с файлом с именем FileName.
      SetErrorString(ErrorString, IO.ErrorCode, FileName);

    else
      MessageDlg('Ошибка ввода/вывода при записи в файл ''' + FileName +
                 '''', mtWarning, [mbOK], 0);
  end; // try ... except
end; // SaveDisplacedSurfacePointsCoordinatesToFile

// Сохранение треугольного сегмента, заданного рремя точками, в STL-файл.
procedure WriteSurfaceTriangleToFile(Var SurfaceFile: TextFile;
  Point1, Point2, Point3: TCoordinatesInMillemeters);
var
  // Компоненты вектора нормали к текущему треугольному сегменту поверхности.
  NormalVector: TCoordinatesInMillemeters;
  // Длина вектора нормали к текущему треугольному сегменту поверхности.
  NormalVectorLength: Extended;
  // Строка сообщения об ошибке ввода/вывода.
  ErrorString: String;

begin // WriteSurfaceTriangleToFile
  try
    NormalVector.X:=(Point2.Y - Point1.Y) * (Point3.Z - Point1.Z) -
                    (Point3.Y - Point1.Y) * (Point2.Z - Point1.Z);
    NormalVector.Y:=(Point3.X - Point1.X) * (Point2.Z - Point1.Z) -
                    (Point2.X - Point1.X) * (Point3.Z - Point1.Z);
    NormalVector.Z:=(Point2.X - Point1.X) * (Point3.Y - Point1.Y) -
                    (Point3.X - Point1.X) * (Point2.Y - Point1.Y);
    NormalVectorLength:=Sqrt(NormalVector.X * NormalVector.X +
                             NormalVector.Y * NormalVector.Y +
                             NormalVector.Z * NormalVector.Z);
    {NormalVector.X:=NormalVector.X / NormalVectorLength;
    NormalVector.Y:=NormalVector.Y / NormalVectorLength;
    NormalVector.Z:=NormalVector.Z / NormalVectorLength;}

    // Маркер начала треугольного сегмента.endfacet
    WriteLn(SurfaceFile, ' ':2, 'facet normal ',
            Extended(NormalVector.X / NormalVectorLength), ' ',
            Extended(NormalVector.Y / NormalVectorLength), ' ',
            Extended(NormalVector.Z / NormalVectorLength));

    // Начало заполнения точек.
    WriteLn(SurfaceFile, ' ':4, 'outer loop');
    WriteLn(SurfaceFile, ' ':6, 'vertex ', Point1.X,' ', Point1.Y,' ', Point1.Z);
    WriteLn(SurfaceFile, ' ':6, 'vertex ', Point2.X,' ', Point2.Y,' ', Point2.Z);
    WriteLn(SurfaceFile, ' ':6, 'vertex ', Point3.X,' ', Point3.Y,' ', Point3.Z);
    // Конец заполнения точек.
    WriteLn(SurfaceFile, ' ':4, 'endloop');

    // Маркер конца треугольного сегмента.
    WriteLn(SurfaceFile, ' ':2, 'endfacet');

  except
    on IO: EInOutError do
      // Установка строки сообщения при ошибке ввода/вывода при работе с файлом.
      SetErrorString(ErrorString, IO.ErrorCode, '');

    else
      MessageDlg('Ошибка ввода/вывода при записи в STL-файл', mtWarning, [mbOK], 0);
  end; // try ... except
end; // WriteSurfaceTriangleToFile

// Загрузка координат точек исходной поверхности.
procedure LoadSourceSurfacePointsCoordinatesFromFile(FileName: String);
var
  // Файл координат точеу исходной поверхности в трёхмерном пространстве.
  // Первый элемент файла содержит количество строк и столбцов точек.
  SourceSurfacePointsCoordinatesFile: File of TCoordinatesInMillemeters;
  // Координаты точи исходной поверхности в трёхмерном пространстве.
  SourceSurfacePointCoordinates: TCoordinatesInMillemeters;
  // Строка сообщения об ошибке ввода/вывода.
  ErrorString: String;
  // Код ошибки неверных данных в параметрах полупространства.
  ErrorCode: Byte;
  // Параметры циклов.
  i, j, k: Byte;
  // Количество строк точек исходной поверхности.
  NumberSourceSurfacePointsRows: Byte;
  // Количество столбцов точек исходной поверхности.
  NumberSourceSurfacePointsColumns: Byte;
  
  // Проверка количества рядов точек исходной поверхности.
  procedure CheckNumberSourceSurfacePointsLines(
    NumberSourceSurfacePointsLines: SmallInt;
    MinNumSurfacePointsLines,
    MaxNumSurfacePointsLines: Byte;
    LinesInGenitiveCaseString: String;
    LastErrorCode: Byte);

  // NewNumSurfacePointsLines - количество рядов точек поверхности.
  // MinNumSurfacePointsLines - минимальное количество рядов точек поверхности.
  // MaxNumSurfacePointsLines - максимальное количество рядов точек поверхности.
  // LinesInGenitiveCaseString - строка названия рядов точек поверхности
  //   в родительном падеже.
  begin // ChangeNumberSourceSurfacePointsLines
    if NumberSourceSurfacePointsLines < MinNumSurfacePointsLines
      then begin // if NumberSurfacePointsLines < MinNumSurfacePointsLines
             ErrorString:='Количество ' + LinesInGenitiveCaseString +
               ' точек исходной поверхности меньше допустимого ' +
               'в пределах [' + IntToStr(MinNumSurfacePointsLines) +
               '; ' + IntToStr(MaxNumSurfacePointsLines) + ']';

             ErrorCode:=LastErrorCode + 1;
             Exit;
           end; // if NumberSurfacePointsLines < MinNumSurfacePointsLines

    if NumberSourceSurfacePointsLines > MaxNumSurfacePointsLines
      then begin // if NumberSurfacePointsLines > MaxNumSurfacePointsLines
             ErrorString:='Количество ' + LinesInGenitiveCaseString +
               ' точек исходной поверхности превысило допустимое ' +
               'в пределах [' +IntToStr(MinNumSurfacePointsLines) +
               '; '+IntToStr(MaxNumSurfacePointsLines)+']';

             ErrorCode:=LastErrorCode + 2;
           end; // if NumberSurfacePointsLines > MaxNumSurfacePointsLines
  end; // ChangeNumberSourceSurfacePointsLines

  // Проверка значения координаты точки поверхности
  // на непревышение значения максимального радиуса зрительного эллипсоида.
  procedure CheckSourceSurfacePointCoordinate(SourceSurfacePointCoordinate: SmallInt;
                                              RowIndex,
                                              RowPointIndex: Byte;
                                              CoordinateNameInGenitiveCase: String;
                                              AxisName: Char;
                                              LastErrorCode: Byte);

  begin // CheckSourceSurfacePointCoordinate
    if SourceSurfacePointCoordinate > MaxEllipsoidRadiusInMillimeters
      then begin // if SourceSurfacePointCoordinate >
             ErrorString:='Модуль значения ' + CoordinateNameInGenitiveCase+
               ' точки S[' + IntToStr(RowIndex) + '; ' + AxisName +
               IntToStr(RowPointIndex) + '] превысил максимальное значение '+
               'радиуса зрительного эллипсоида';

             ErrorCode:=LastErrorCode + 1;
           end; // if SourceSurfacePointCoordinate >
  end; // CheckSourceSurfacePointCoordinate

  // Проверка значений координа точки исходной поверхности.
  procedure CheckSourceSurfacePointCoordinates;
  begin // CheckSourceSurfacePointCoordinates
    if SourceSurfacePointCoordinates.Y < 0
      then begin // if SourceSurfacePointCoordinates.Y < 0
             ErrorString:='Ордината точки S[' + IntToStr(i) + '; Y' +
               IntToStr(j) + '] имеет отрицательное значение';

             ErrorCode:=5;
             Exit;
           end; // if SourceSurfacePointCoordinates.Y < 0


    if ErrorCode <> 0 then Exit;
    // Проверка значения координат точки поверхности
    // на непревышение значения максимального радиуса зрительного эллипсоида.
    CheckSourceSurfacePointCoordinate(
      SourceSurfacePointCoordinates.X, i, j, 'абсциссы',  'X', 5);

    if ErrorCode <> 0 then Exit;

    CheckSourceSurfacePointCoordinate(
      SourceSurfacePointCoordinates.Y, i, j, 'ординаты',  'Y', 6);

    if ErrorCode <> 0 then Exit;

    CheckSourceSurfacePointCoordinate(
      SourceSurfacePointCoordinates.Z, i, j, 'аппликаты', 'Z', 7);
  end; // CheckSourceSurfacePointCoordinates

begin // LoadSourceSurfacePointsCoordinatesFromFile
  try
    // Связь файловой переменной с файлом с именем FileName.
    Assign(SourceSurfacePointsCoordinatesFile, FileName);
    // Открытие файла.
    Reset(SourceSurfacePointsCoordinatesFile);
    // Чтение из файла новой записи.
    Read(SourceSurfacePointsCoordinatesFile, SourceSurfacePointCoordinates);

    if SourceSurfacePointCoordinates.Y <> -6142
      then begin // if SourceSurfacePointCoordinates.Y <>
             ErrorString:='Файл ''' + FileName +
               ''' не является хранителем координат точек исходной поверхности';
             MessageDlg(ErrorString, mtWarning, [mbOK], 0);
             Exit;
           end; // if SourceSurfacePointCoordinates.Y <>

    ErrorCode:=0;

    with SourceSurfacePointCoordinates do
      begin // with SourceSurfacePointCoordinates do
        // Проверка количества строк точек исходной поверхности.
        CheckNumberSourceSurfacePointsLines(
          X, MinNumSurfacePointsRows, MaxNumSurfacePointsRows, 'строк', 0);

        if ErrorCode <> 0
          then begin
                 // Вывод сообщение об ошибке.
                 MessageDlg(InvalidFileDataString + ' ''' + FileName + '''! ' +
                            ErrorString, mtWarning, [mbOK], 0);
                 // Закрытие файла.
                 CloseFile(SourceSurfacePointsCoordinatesFile);
                 Exit;
               end;
        NumberSourceSurfacePointsRows:=Trunc(X);

        // Проверка количества столбцов точек исходной поверхности.
        CheckNumberSourceSurfacePointsLines(
          Z, MinNumSurfacePointsColumns, MaxNumSurfacePointsColumns, 'столбцов', 2);

        if ErrorCode <> 0
          then begin
                 // Вывод сообщение об ошибке.
                 MessageDlg(InvalidFileDataString + ' ''' + FileName + '''! ' +
                            ErrorString, mtWarning, [mbOK], 0);
                 // Закрытие файла.
                 CloseFile(SourceSurfacePointsCoordinatesFile);
                 Exit;
               end;
        NumberSourceSurfacePointsColumns:=Trunc(Z);
      end; // with SourceSurfacePointCoordinates do

    // Проверка точек исходной поверхности.
    for i:=1 to NumberSourceSurfacePointsRows do
      for j:=1 to NumberSourceSurfacePointsColumns do
        begin // for j
          // Чтение из файла новой записи.
          Read(SourceSurfacePointsCoordinatesFile, SourceSurfacePointCoordinates);
          // Проверка значений координа точки исходной поверхности.
          CheckSourceSurfacePointCoordinates;

          if ErrorCode <> 0
            then begin
                   // Вывод сообщение об ошибке.
                   MessageDlg(InvalidFileDataString + ' ''' + FileName + '''! ' +
                              ErrorString, mtWarning, [mbOK], 0);
                   // Закрытие файла.
                   CloseFile(SourceSurfacePointsCoordinatesFile);
                   Exit;
                 end;
        end; // for j

    // Закрытие файла.
    CloseFile(SourceSurfacePointsCoordinatesFile);
    // Открытие файла.
    Reset(SourceSurfacePointsCoordinatesFile);
    // Чтение из файла новой записи.
    Read(SourceSurfacePointsCoordinatesFile, SourceSurfacePointCoordinates);

    MainForm.CorrectionsProtocolMemo.Clear;
    MainForm.StatusBar.Panels[0].Text:='';

    if not bGridFormCreated
      then MainForm.SetGridsFormFocusSpeedButtonClick(MainForm);

    with GridsForm do
      begin //  with GridsForm do
        Hide;

        // Количество точек поверхностей и рядов в таблицах.
        SurfacePointsRowsEdit.Text:=IntToStr(NumberSourceSurfacePointsRows);
        SurfacePointsColumnsEdit.Text:=IntToStr(NumberSourceSurfacePointsColumns);

        SourceSurfaceStringGrid.RowCount:=   1 + NumberSourceSurfacePointsRows;
        DisplacedSurfaceStringGrid.RowCount:=1 + NumberSourceSurfacePointsRows;
        SurfaceAreaStringGrid.RowCount:=     1 + NumberSourceSurfacePointsRows;

        SourceSurfaceStringGrid.ColCount:=   1 + 3*NumberSourceSurfacePointsColumns;
        DisplacedSurfaceStringGrid.ColCount:=1 + 3*NumberSourceSurfacePointsColumns;
        SurfaceAreaStringGrid.ColCount:=     1 +   NumberSourceSurfacePointsColumns;

        // Изменение прежних размеров таблиц и формы.
        ResizeStringGrids;

        // Очистка таблиц.
        CleanStringGridsSpeedButtonClick(GridsForm);

        for i:=1 to NumberSourceSurfacePointsRows do
          begin // for i
            k:=1;

            for j:=1 to NumberSourceSurfacePointsColumns do
              begin // for j
                // Чтение из файла новой записи.
                Read(SourceSurfacePointsCoordinatesFile, SourceSurfacePointCoordinates);

                with SourceSurfaceStringGrid do
                  with SourceSurfacePointCoordinates do
                    begin
                      Cells[k,     i]:=IntToStr(X);
                      Cells[k + 1, i]:=IntToStr(Y);
                      Cells[k + 2, i]:=IntToStr(Z);
                    end;

                k:=k + 3;
              end; // for j
          end; // for i

        // Закрытие файла.
        CloseFile(SourceSurfacePointsCoordinatesFile);
        // Построение поверхностей.
        BuildSurfacesSpeedButtonClick(GridsForm);
    
        Close;
      end; //  with GridsForm do
  
  except
    on IO: EInOutError do
      // Установка строки сообщения при ошибке ввода/вывода
      // при работе с файлом с именем FileName.
      SetErrorString(ErrorString, IO.ErrorCode, FileName);

    else MessageDlg('Ошибка ввода/вывода при чтении из файла ''' + FileName + '''', mtWarning, [mbOK], 0);
  end; // try ... except}
end; // LoadSourceSurfacePointsCoordinatesFromFile

end.
