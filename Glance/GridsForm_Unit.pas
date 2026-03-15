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

// Форма таблиц поверхностей.
unit GridsForm_Unit;

interface

uses
  // Glance-модули.
  Base_Unit, Integration_Unit, Surface_Unit,
  // Стандартные модули.
  Windows, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, Forms, Dialogs, Grids, StdCtrls, Buttons, ComCtrls,
  ExtCtrls, ImgList, ToolWin;

type
  // Массив-столбец указателей на строки ячеек.
  TCellsColumn = array[0..MaxNumSurfacePointsRows] of PString;
  // Указатель на массив-столбец указателей на строки ячеек.
  PCellsColumn = ^TCellsColumn;
  // Массив указателей на массивы-столбецы указателей на строки ячеек.
  TCells = array[0..3*MaxNumSurfacePointsColumns] of PCellsColumn;

  // Параметры таблицы.
  TStringGridParameters = record
    // Количество столбцов и строк в таблице.
    ColCount,
    RowCount: Integer;
    // Максимальное количество прокручиваемых столбцов и строк в таблице.
    MaxNumNonFixedRows,
    MaxNumNonFixedColumns: Integer;
    // Массив указателей на массивы-столбецы указателей на строки ячеек.
    Cells: TCells;
  end; // TStringGridParameters

  // Указатель на параметры таблицы.
  PStringGridParameters = ^TStringGridParameters;
  // Компонент который в данный момент является развёрнутым, NoneMaximased,
  // когда все находятся в исходном состоянии.
  TMaximasedGridsFormComponent = (SourceSurfaceStringGridPanelMaximased,
                                  DisplacedSurfaceStringGridPanelMaximased,
                                  SurfaceAreaStringGridPanelMaximased,
                                  NoneGridsFormComponentMaximased);

                                  
  TGridsForm = class(TForm)
    SourceSurfaceStringGrid: TStringGrid;
    DisplacedSurfaceStringGrid: TStringGrid;
    SurfaceAreaStringGrid: TStringGrid;
    CleanStringGridsSpeedButton: TSpeedButton;
    BuildSurfacesSpeedButton: TSpeedButton;
    SurfacePointsRowsEdit: TEdit;
    SurfacePointsColumnsEdit: TEdit;
    SurfacePointsRowsGapEdit: TEdit;
    SurfacePointsColumnsGapEdit: TEdit;
    SurfacePointsRowsUpDown: TUpDown;
    SurfacePointsColumnsUpDown: TUpDown;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    CentreScreenFormPositionLeftSpeedButton: TSpeedButton;
    SetMainFormFocusSpeedButton: TSpeedButton;
    SourceSurfaceStringGridTitlePanel: TPanel;
    ResizeSourceSurfaceStringGridPanelSpeedButton: TSpeedButton;
    DisplacedSurfaceStringGridTitlePanel: TPanel;
    ResizeDisplacedSurfaceStringGridPanelSpeedButton: TSpeedButton;
    SurfaceAreaStringGridTitlePanel: TPanel;
    ResizeSurfaceAreaStringGridPanelSpeedButton: TSpeedButton;
    SourceSurfaceStringGridPanel: TPanel;
    DisplacedSurfaceStringGridPanel: TPanel;
    SurfaceAreaStringGridPanel: TPanel;
    SourceSurfaceCornersStringGrid: TStringGrid;
    SourceSurfaceCornersStringGridPanel: TPanel;
    SourceSurfaceCornersStringGridTitlePanel: TPanel;
    ShowSourceSurfaceStringGridPanelSpeedButton: TSpeedButton;
    ShowSourceSurfaceCornersStringGridPanelSpeedButton: TSpeedButton;
    ToolBar: TToolBar;
    LeftGapSeparatorToolButton: TToolButton;
    MiddleGapSeparatorToolButton: TToolButton;
    SecondRightGapSeparatorToolButton: TToolButton;
    CentreScreenFormPositionRightSpeedButton: TSpeedButton;
    GridsImageList: TImageList;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SurfacePointsColumnsEditExit(Sender: TObject);
    procedure SurfacePointsColumnsEditKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure SurfacePointsRowsEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SurfacePointsRowsEditExit(Sender: TObject);
    procedure SurfacePointsColumnsUpDownClick(Sender: TObject;
      Button: TUDBtnType);
    procedure SurfacePointsRowsUpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure CleanStringGridsSpeedButtonClick(Sender: TObject);
    procedure BuildSurfacesSpeedButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CentreScreenFormPositionLeftSpeedButtonClick(Sender: TObject);
    procedure SetMainFormFocusSpeedButtonClick(Sender: TObject);
    procedure ResizeSourceSurfaceStringGridPanelSpeedButtonClick(Sender: TObject);
    procedure ResizeDisplacedSurfaceStringGridPanelSpeedButtonClick(Sender: TObject);
    procedure ResizeSurfaceAreaStringGridPanelSpeedButtonClick(Sender: TObject);
    procedure SurfaceAreaStringGridDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure SourceSurfaceStringGridDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure DisplacedSurfaceStringGridDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure SourceSurfaceCornersStringGridDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure ShowSourceSurfaceCornersStringGridPanelSpeedButtonClick(
      Sender: TObject);
    procedure ShowSourceSurfaceStringGridPanelSpeedButtonClick(
      Sender: TObject);
    procedure SourceSurfaceStringGridSetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: String);
    procedure SourceSurfaceCornersStringGridSetEditText(Sender: TObject;
      ACol, ARow: Integer; const Value: String);

    // Подготовка макета формы:
    // размещение компонентов и вычисление размеров.
    procedure MakeFormModel;
    // Изменение прежних размеров таблиц и формы.
    procedure ResizeStringGrids;
    // Подготовка макета формы c развёрнутой одной из панелей:
    // размещение компонентов и вычисление размеров.
    procedure MakeFormModelWithMaximasedPanel(
      var StringGrid: TStringGrid;
      var StringGridPanel: TPanel;
          MaximizedStringGridWidth,
          MaximizedStringGridHeight: Integer);
    // Изменение размеров одной из панелей-контейнеров таблиц:
    // Если она разворачивается, то занимает всю форсму, а две оставшиеся скрываются.
    // Если же она сворачивается, то появляются остальные две панели.
    procedure ResizeStringGridPanel(
      var ResizingStringGridPanel,
          FirstOtherStringGridPanel,
          SecondOtherStringGridPanel: TPanel;
          ResizingStringGridPanelMaximased: TMaximasedGridsFormComponent;
      var ResizeStringGridPanelSpeedButton: TSpeedButton);
    // Изменение полей таблицы угловых точек исходной поверхности
    // в связи с коррекцией данных при построении поверхностей.
    procedure BuildingSurfacesSourceSurfaceCornersStringGridEditing;

          

  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  // Ширина полос прокрутки.
  ScrollBarsWidth = 18;//12;
  // Ширина бордюра внутри рабочей области.
  InnerBorder = 10;
  // Высота облати управляющих кнопок.
  ButtonsAreaHeight = 58;
  // Ширина облати управляющих кнопок.
  ButtonsAreaWidth = 220;

  // Поправка высоты изображения, помещаемого в ячейку таблицы областей.
  SurfaceAreaStringGridCellBitMapHeightAdjustment = 42;
  // Поправка ширины изображения, помещаемого в ячейку таблицы областей.
  SurfaceAreaStringGridCellBitMapWidthAdjustment = -39;
  // Поправка высоты изображения, помещаемого в ячейку таблицы поверхности.
  SurfaceStringGridCellBitMapHeightAdjustment = 26;
  // Поправка ширины изображения, помещаемого в ячейку таблицы поверхности.
  SurfaceStringGridCellBitMapWidthAdjustment = -23;
  // Минимальна ширина панели заголовка таблицы исходной поверхности.
  SourceSurfaceStringGridTitlePanelMinWidth = 288;
  // Минимальна ширина панели заголовка таблицы угловых точек исходной поверхности.
  SourceSurfaceCornersStringGridTitlePanelMinWidth = 314;
  // Минимальна ширина панели заголовка таблицы искажённой поверхности.
  DisplacedSurfaceStringGridTitlePanelMinWidth = 276;
  // Минимальна ширина панели заголовка таблицы областей поверхностеё.
  SurfaceAreaStringGridTitlePanelWidth = 266;
  // Высота строки таблицы.
  DefaultStringGridRowHeight = 20;

var
  GridsForm: TGridsForm;

  // Прзнак того, что форма с таблицами создаётся впервые.
  bFirstGridsFormShow: Boolean;
  // Признак того, что форма таблиц уже создана.
  bGridFormCreated: Boolean;

  // Параметры таблицы исходной поверхности.
  SourceSurfaceStringGridParameters: PStringGridParameters;
  // Параметры таблицы искажённой поверхности.
  DisplacedSurfaceStringGridParameters: PStringGridParameters;
  // Параметры таблицы зрительных облатей точек поверхностей.
  SurfaceAreaStringGridParameters: PStringGridParameters;

  // Разница между шириной бордюра и шириной рабочей области формы таблиц.
  OuterBorderWidth: Integer;
  // Разница между высотой бордюра и высотой рабочей области формы таблиц.
  OuterBorderHeight: Integer;
  // Минимальная ширина рабочей области.
  MinClientWidth: Integer;
  // Максимальная высота рабочей области, не занимаемая таблицами.
  MaxClientHeightWithoutStringGrids: Integer;

  // Максимальная высота таблицы без горизонтальной полосы прокрутки.
  MaxStringGridHeightWithoutScrollBars: Integer;
  // Максимальная высота таблицы с горизонтальной полосой прокрутки.
  MaxStringGridHeightWithScrollBars: Integer;

  // Максимальная ширина таблицы поверхности без вертикальной полосы прокрутки.
  MaxSurfaceStringGridWidthWithoutScrollBars: Integer;
  // Максимальная ширина таблицы поверхности с вертикальной полосой прокрутки.
  MaxSurfaceStringGridWidthWithScrollBars: Integer;

  // Максимальная ширина таблицы областей без вертикальной полосы прокрутки.
  MaxAreaStringGridWidthWithoutScrollBars: Integer;
  // Максимальная ширина таблицы областей с вертикальной полосой прокрутки.
  MaxAreaStringGridWidthWithScrollBars: Integer;

  // Титульные изображения таблиц в левомй верхней фиксированной ячейке.
  // Для таблицы исходной поверхности.
  SourceSurfaceStringGridTitleBitMap: TBitMap;
  // Для таблицы координат угловых точек исходной поверхности.
  SourceSurfaceCornersStringGridTitleBitMap: TBitMap;
  // Для таблицы искажённой поверхности.
  DisplacedSurfaceStringGridTitleBitMap: TBitMap;
  // Для таблицы областей точек поверхностей.
  SurfaceAreaStringGridTitleBitMap: TBitMap;

  // Изображения нефиксированных ячеек таблицы областей,
  // выбор каждого из которых зависит от зрительной области
  // точки поверхностей, связанной с данной ячейкой.
  // Для левой зрительной области.
  SurfaceAreaStringGridLeftAreaCellBitMap: TBitMap;
  // Для среднеё зрительной области.
  SurfaceAreaStringGridCentreAreaCellBitMap: TBitMap;
  // Для правой зрительной области.
  SurfaceAreaStringGridRightAreaCellBitMap: TBitMap;
  
  // Компонент который в данный момент является развёрнутым, NoneMaximased,
  // когда все находятся в исходном состоянии.
  MaximasedGridsFormComponent: TMaximasedGridsFormComponent;

  // Высота таблицы поверхности при отображении всех трёх таблиц.
  MinimizedSurfaceStringGridHeight: Integer;
  // Высота таблицы областей при отображении всех трёх таблиц.
  MinimizedAreaStringGridHeight:Integer;
  // Высота развёрнутой таблицы поверхности.
  MaximizedSurfaceStringGridHeight: Integer;
  // Высота развёрнутой таблицы областей.
  MaximizedAreaStringGridHeight: Integer;

  // Ширина таблицы поверхности при отображении всех трёх таблиц.
  MinimizedSurfaceStringGridWidth: Integer;
  // Ширина таблицы областей при отображении всех трёх таблиц.
  MinimizedAreaStringGridWidth: Integer;
  // Ширина развёрнутой таблицы поверхности.
  MaximizedSurfaceStringGridWidth: Integer;
  // Ширина развёрнутой таблицы областей.
  MaximizedAreaStringGridWidth: Integer;
  // Изображение, содержащее изменения размеров панелей таблиц.
  ResizeStringGridAreaBitMap: TBitMap;
  // Признак отображения панели таблицы угловых точек исходной поверхности.
  bSourceSurfaceCornersStringGridPanelShow: Boolean;


// Выделение динамической памяти под запись параметров таблицы.
// Сохранение параметров таблицы в записи.
procedure SetStringGridParameters(var StringGridParameters: PStringGridParameters;
                                      StringGrid: TStringGrid;
                                      MaxNumNonFixedStringGridColumns: Integer);
// Шапка для таблицы координат точек поверхности.
procedure SetSurfaceStringGridHead(var SurfaceStringGrid: TStringGrid);

// Установка ширины таблицы без скроллера.
procedure GetStringGridWidth(var StringGrid: TStringGrid;
                                 VerticalScrollBarWidth: Byte;
                             var StringGridWidth: Integer);
// Установка высоты таблицы без скроллера.
procedure GetStringGridHeight(var StringGrid: TStringGrid;
                                  HorizontalScrollBarWidth: Byte;
                              var StringGridHeight: Integer);
// Получение параметров таблицы максимальной ширины.
procedure GetStringGridMaxWidthParameters(
      StringGrid: TStringGrid;
  var MaxStringGridWidthWithoutScrollBars,
      MaxStringGridWidthWithScrollBars: Integer);
// Получение параметров таблицы максимальной высоты.
procedure GetStringGridMaxHeightParameters(
      StringGrid: TStringGrid;
  var MaxStringGridHeightWithoutScrollBars,
      MaxStringGridHeightWithScrollBars: Integer);

// Заполнение таблицы значениями координат точек поверхности.
procedure FillStringGrid(var StringGrid: TStringGrid;
                         var StringGridParameters: PStringGridParameters;
                             Surface: TSurface);
// Функция, повторяющая общеизвестную функцию Rect:
// Возвращает рямоугольную область типа TRect.
function GetRect(ALeft, ATop, ARight, ABottom: Integer): TRect;

// Запись строки значения в ячейку с форматированием.
procedure SetCellString(var StringGrid: TStringGrid;
                        var StringGridParameters: PStringGridParameters;
                            RowIndex, ColumnIndex: Byte;
                            NewCellValue: Int64);

// Проверка нового значения поля ячейки.
procedure CheckNewCellValue(var NewCellValue: Int64;
                                UpperLimitInMillimeters: Word;
                                RowPointIndex,
                                RowIndex, ColumnIndex: Byte;
                            var SurfaceStringGrid: TStringGrid;
                            var SurfaceStringGridParameters: PStringGridParameters;
                                CoordinateNameInGenitiveCase: String;
                                AxisName: Char);

// Запись значения новой координаты в один из массивов
// координатных осей исходной поверхности.
procedure SetNewSourceSurfaceCoordinate(NewCellValue: Int64;
                                        DivisionRemainderBy3,
                                        RowPointIndex,
                                        RowIndex: Byte);
                                        
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

implementation

uses
  // Glance-модуль.
  MainForm_Unit;

{$R *.dfm}

// Выделение динамической памяти под запись параметров таблицы.
// Сохранение параметров таблицы в записи.
procedure SetStringGridParameters(var StringGridParameters: PStringGridParameters;
                                      StringGrid: TStringGrid;
                                      MaxNumNonFixedStringGridColumns: Integer);
var
  // StringGridParameters - указатель на запись параметров таблицы.
  // StringGrid - таблица, получающая заначения своих параметров из записи.
  // MaxNumNonFixedStringGridColumns -
  //   максимальное количество прокручиваемых столбцов в таблице.

  // Параметры циклов.
  i, j: Byte;

begin // SetStringGridParameters
  New(StringGridParameters);

  with StringGridParameters^ do
    begin
      RowCount:=StringGrid.RowCount;
      ColCount:=StringGrid.ColCount;
      MaxNumNonFixedRows:=MaxNumSurfacePointsRows;
      MaxNumNonFixedColumns:=MaxNumNonFixedStringGridColumns;

      for j:=0 to MaxNumNonFixedColumns do
        begin
          // Столбец таблицы.
          New(Cells[j]);

          for i:=0 to MaxNumNonFixedRows do
            begin
              // Ячейка столбца таблицы.
              New(Cells[j]^[i]);

              Cells[j]^[i]^:=StringGrid.Cells[j,i]
            end; // for i
        end; // for j
    end; // with StringGridParameters^ do
end; // SetStringGridParameters

//******************************************************************************

// Шапка для таблицы координат точек поверхности.
procedure SetSurfaceStringGridHead(var SurfaceStringGrid: TStringGrid);
var
  // SurfaceStringGrid - таблица координат точек поверхности.
  // SurfaceName - заголовок таблицы в верхнем левом углу.

  // Строка номера ряда точек поверхности.
  NumberLineString: String;
  // Параметры циклов.
  i, j: Byte;

begin // SetSurfaceStringGridHead
  with SurfaceStringGrid do
    begin
      ColCount:=4;
      RowCount:=2;
      // Шапка слева.
      j:=1;
      for i:=1 to MaxNumSurfacePointsColumns do
        begin
          NumberLineString:=IntToStr(i);
          Cells[j,  0]:=TopGapsSurfaceStringGridString+'X'+NumberLineString;
          Cells[j+1,0]:=TopGapsSurfaceStringGridString+'Y'+NumberLineString;
          Cells[j+2,0]:=TopGapsSurfaceStringGridString+'Z'+NumberLineString;
          j:=j+3;
        end; // for i:=1 to MaxNumSurfacePointsRows
      // Шапка сверху.
      for i:=1 to MaxNumSurfacePointsRows do
        Cells[0,i]:=LeftGapsSurfaceStringGridString+IntToStr(i);
    end; // with SurfaceStringGrid
end; // SetSurfaceStringGridHead

//******************************************************************************

// Извлечение параметров таблицы из записи.
// Освобождение динамической памяти из-под записи параметров таблицы.
procedure GetStringGridParameters(var StringGridParameters: PStringGridParameters;
                                  var StringGrid: TStringGrid);
var
  // StringGridParameters - указатель на запись параметров таблицы.
  // StringGrid - таблица, получающая заначения своих параметров из записи.

  // Параметры циклов.
  i, j: Byte;

begin // GetStringGridParameters
  with StringGridParameters^ do
    begin
      StringGrid.RowCount:=RowCount;
      StringGrid.ColCount:=ColCount;

      for j:=0 to MaxNumNonFixedColumns do
        begin
          for i:=0 to MaxNumNonFixedRows do
            begin
              StringGrid.Cells[j,i]:=Cells[j]^[i]^;

              // Удаление ячейки cтолбцa таблицы.
              Dispose(Cells[j]^[i]);
              Cells[j]^[i]:=nil;
            end; // for i
          // Удаление cтолбцa таблицы.
          Dispose(Cells[j]);
          Cells[j]:=nil;
        end; // for j
    end; // with StringGridParameters^ do

  // Удаление записи.
  Dispose(StringGridParameters);
  StringGridParameters:=nil;
end; // GetStringGridParameters

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// Установка ширины таблицы без скроллера.
procedure GetStringGridWidth(var StringGrid: TStringGrid;
                                 VerticalScrollBarWidth: Byte;
                             var StringGridWidth: Integer);
begin // GetStringGridWidth
  with StringGrid do
    StringGridWidth:=ColCount * DefaultColWidth + (ColCount + 1) * GridLineWidth +
                     3 + VerticalScrollBarWidth;
end; // GetStringGridWidth

// Установка высоты таблицы без скроллера.
procedure GetStringGridHeight(var StringGrid: TStringGrid;
                                  HorizontalScrollBarWidth: Byte;
                              var StringGridHeight: Integer);
begin // GetStringGridHeight
  with StringGrid do
    StringGridHeight:=RowCount * DefaultRowHeight + (RowCount + 1) * GridLineWidth +
                      3 + HorizontalScrollBarWidth;
end; // GetStringGridHeight

//******************************************************************************

// Подготовка макета формы c развёрнутой одной из панелей:
// размещение компонентов и вычисление размеров.
procedure TGridsForm.MakeFormModelWithMaximasedPanel(
  var StringGrid: TStringGrid;
  var StringGridPanel: TPanel;
      MaximizedStringGridWidth,
      MaximizedStringGridHeight: Integer);

begin // TGridsForm.MakeFormModelWithMaximasedPanel
  // При минимальной ширине таблиц.
  if MaximizedStringGridWidth < SourceSurfaceStringGridTitlePanelMinWidth
    then StringGridPanel.Width:=
           SourceSurfaceStringGridTitlePanelMinWidth + 2

    // Ширина рабочей области определяется таблицей наибольшей ширины.
    else StringGridPanel.Width:=MaximizedStringGridWidth + 2;

  // Ширина рабочей области.
  ClientWidth:=StringGridPanel.Width + 2*InnerBorder;

  if ClientWidth < MinClientWidth
    then begin
           ClientWidth:=MinClientWidth;
           StringGridPanel.Width:=ClientWidth - 2*InnerBorder;
         end;

  StringGrid.Width:=MaximizedStringGridWidth;

  // Размещение компонентов.
  StringGrid.Height:=MaximizedStringGridHeight;
  StringGridPanel.Height:=StringGrid.Height +
                          SourceSurfaceStringGridTitlePanel.Height + 1;
  StringGridPanel.Top:=SourceSurfaceStringGridPanel.Top;

  // Высота рабочей области.
  ClientHeight:=ToolBar.Height + InnerBorder + ButtonsAreaHeight +
                StringGridPanel.Height;

  StringGrid.Left:=Trunc((StringGridPanel.Width -
                          StringGrid.Width)/2) + 1;
end; // TGridsForm.MakeFormModelWithMaximasedPanel

// Подготовка макета формы:
// размещение компонентов и вычисление размеров.
procedure TGridsForm.MakeFormModel;
begin // TGridsForm.MakeFormModel
  MiddleGapSeparatorToolButton.Width:=1;
  // Если отображается только панель исходной поверхности.
  if bSourceSurfaceCornersStringGridPanelShow = True
    // Подготовка макета формы c развёрнутой панелю угловых точек исходной поверхности.
    then begin // if bSourceSurfaceCornersStringGridPanelShow = True
           // При минимальной ширине таблиц.
           if SourceSurfaceCornersStringGrid.Width < SourceSurfaceCornersStringGridTitlePanelMinWidth
             then SourceSurfaceCornersStringGridPanel.Width:=
                    SourceSurfaceCornersStringGridTitlePanelMinWidth + 2

             // Ширина рабочей области определяется таблицей наибольшей ширины.
             else SourceSurfaceCornersStringGridPanel.Width:=SourceSurfaceCornersStringGrid.Width + 2;

           // Ширина рабочей области.
           ClientWidth:=SourceSurfaceCornersStringGridPanel.Width + 2*InnerBorder;

           if ClientWidth < MinClientWidth
             then begin
                    ClientWidth:=MinClientWidth;
                    SourceSurfaceCornersStringGridPanel.Width:=ClientWidth - 2*InnerBorder;
                  end;

           // Размещение компонентов.
           SourceSurfaceCornersStringGridPanel.Height:=
             SourceSurfaceCornersStringGrid.Height + SourceSurfaceStringGridTitlePanel.Height + 1;

           // Высота рабочей области.
           ClientHeight:=ToolBar.Height + InnerBorder + ButtonsAreaHeight +
                         SourceSurfaceCornersStringGridPanel.Height;

           SourceSurfaceCornersStringGrid.Left:=
             Trunc((SourceSurfaceCornersStringGridPanel.Width -
                    SourceSurfaceCornersStringGrid.Width)/2) + 1;
         end // if bSourceSurfaceCornersStringGridPanelShow = True

    else case MaximasedGridsFormComponent of
           // Если отображаются все таблицы.
           NoneGridsFormComponentMaximased:
             begin // MaximasedGridsFormComponent = NoneMaximased
               // При минимальной ширине таблиц.
               if MinimizedSurfaceStringGridWidth < SourceSurfaceStringGridTitlePanelMinWidth
                 then SourceSurfaceStringGridPanel.Width:=
                        SourceSurfaceStringGridTitlePanelMinWidth + 2

                 // Ширина рабочей области определяется таблицей наибольшей ширины.
                 else if MinimizedSurfaceStringGridWidth > MinimizedAreaStringGridWidth
                        then SourceSurfaceStringGridPanel.Width:=
                               MinimizedSurfaceStringGridWidth + 2
                        else SourceSurfaceStringGridPanel.Width:=
                               MinimizedAreaStringGridWidth + 2;

               // Ширина рабочей области.
               ClientWidth:=SourceSurfaceStringGridPanel.Width + 2*InnerBorder;

               if ClientWidth < MinClientWidth
                 then begin
                        ClientWidth:=MinClientWidth;
                        SourceSurfaceStringGridPanel.Width:=ClientWidth - 2*InnerBorder;
                      end;

               DisplacedSurfaceStringGridPanel.Width:=SourceSurfaceStringGridPanel.Width;
               SurfaceAreaStringGridPanel.Width:=SourceSurfaceStringGridPanel.Width;

               SourceSurfaceStringGrid.Width:=MinimizedSurfaceStringGridWidth;
               DisplacedSurfaceStringGrid.Width:=MinimizedSurfaceStringGridWidth;
               SurfaceAreaStringGrid.Width:=MinimizedAreaStringGridWidth;

               // Размещение компонентов.
               SourceSurfaceStringGrid.Height:=MinimizedSurfaceStringGridHeight;
               DisplacedSurfaceStringGrid.Height:=MinimizedSurfaceStringGridHeight;
               SurfaceAreaStringGrid.Height:=MinimizedAreaStringGridHeight;

               SourceSurfaceStringGridPanel.Height:=SourceSurfaceStringGrid.Height +
                                                    SourceSurfaceStringGridTitlePanel.Height + 1;
               DisplacedSurfaceStringGridPanel.Height:=SourceSurfaceStringGridPanel.Height;
               SurfaceAreaStringGridPanel.Height:=SurfaceAreaStringGrid.Height +
                                                  SourceSurfaceStringGridTitlePanel.Height + 1;

               DisplacedSurfaceStringGridPanel.Top:=SourceSurfaceStringGridPanel.Top +
                                                    SourceSurfaceStringGridPanel.Height +
                                                    InnerBorder;
               SurfaceAreaStringGridPanel.Top:=DisplacedSurfaceStringGridPanel.Top +
                                               DisplacedSurfaceStringGridPanel.Height +
                                               InnerBorder;

               // Высота рабочей области.
               ClientHeight:=ToolBar.Height + 3*InnerBorder + ButtonsAreaHeight +
                             2*SourceSurfaceStringGridPanel.Height +
                             SurfaceAreaStringGridPanel.Height;


               SourceSurfaceStringGrid.Left:=Trunc((SourceSurfaceStringGridPanel.Width -
                                                    SourceSurfaceStringGrid.Width)/2) + 1;
               DisplacedSurfaceStringGrid.Left:=SourceSurfaceStringGrid.Left;
               SurfaceAreaStringGrid.Left:=Trunc((SurfaceAreaStringGridPanel.Width -
                                                  SurfaceAreaStringGrid.Width)/2) + 1;

               SourceSurfaceStringGridPanel.Show;
               DisplacedSurfaceStringGridPanel.Show;
               SurfaceAreaStringGridPanel.Show;
             end; // MaximasedGridsFormComponent = NoneMaximased

           // Если отображается только панель исходной поверхности.
           SourceSurfaceStringGridPanelMaximased:
             // Подготовка макета формы c развёрнутой панелю исходной поверхности.
             MakeFormModelWithMaximasedPanel(SourceSurfaceStringGrid, SourceSurfaceStringGridPanel,
               MaximizedSurfaceStringGridWidth, MaximizedSurfaceStringGridHeight);

           // Если отображается только панель искажённой поверхности.
           DisplacedSurfaceStringGridPanelMaximased:
             // Подготовка макета формы c развёрнутой панелю искажённой поверхности.
             MakeFormModelWithMaximasedPanel(DisplacedSurfaceStringGrid, DisplacedSurfaceStringGridPanel,
               MaximizedSurfaceStringGridWidth, MaximizedSurfaceStringGridHeight);

           // Если отображается только панель областей.
           SurfaceAreaStringGridPanelMaximased:
             // Подготовка макета формы c развёрнутой панелю областей.
             MakeFormModelWithMaximasedPanel(SurfaceAreaStringGrid, SurfaceAreaStringGridPanel,
               MaximizedAreaStringGridWidth, MaximizedAreaStringGridHeight);
         end; // case

  MiddleGapSeparatorToolButton.Width:=
    ToolBar.Width - MiddleGapSeparatorToolButton.Left -
    CentreScreenFormPositionRightSpeedButton.Width - SetMainFormFocusSpeedButton.Width -
    SecondRightGapSeparatorToolButton.Width - 2*LeftGapSeparatorToolButton.Width;

  SourceSurfaceStringGrid.DefaultRowHeight:=DefaultStringGridRowHeight;
  SourceSurfaceCornersStringGrid.DefaultRowHeight:=DefaultStringGridRowHeight;
  DisplacedSurfaceStringGrid.DefaultRowHeight:=DefaultStringGridRowHeight;
  SurfaceAreaStringGrid.DefaultRowHeight:=DefaultStringGridRowHeight;
end; // TGridsForm.MakeFormModel

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// Получение параметров таблицы максимальной ширины.
procedure GetStringGridMaxWidthParameters(
      StringGrid: TStringGrid;
  var MaxStringGridWidthWithoutScrollBars,
      MaxStringGridWidthWithScrollBars: Integer);

var
  // StringGrid - рассматриваемая таблица.
  // MaxStringGridWidthWithoutScrollBars - максимальная ширина таблицы,
  //   отображаемой на экране при отсутствии вертикальноей полосы проекутки.
  // MaxStringGridWidthWithScrollBars - максимальная ширина таблицы,
  //   отображаемой на экране при наличие вертикальноей полосы проекутки.

  // Предельная максимальная ширина таблицы.
  LimitStringGridWidth: Integer;
  // Максимальное количество столбцов таблицы,
  // которое может быть отображено на экране
  // при отсутствии вертикальноей полосы проекутки.
  MaxNumberStringGridColumnsWithoutScrollBars: Integer;
  // Максимальное количество столбцов таблицы,
  // которое может быть отображено на экране
  // при наличие вертикальноей полосы проекутки.
  MaxNumberStringGridColumnsWithScrollBars: Integer;

begin // TGridsForm.GetStringGridMaxWidthParameters
  with StringGrid do
    begin
      LimitStringGridWidth:=Trunc(Screen.WorkAreaWidth - OuterBorderWidth - 2*InnerBorder);

      MaxNumberStringGridColumnsWithoutScrollBars:=
        Trunc((LimitStringGridWidth - 3 - GridLineWidth)/
              (DefaultColWidth + GridLineWidth));

      MaxStringGridWidthWithoutScrollBars:=
        MaxNumberStringGridColumnsWithoutScrollBars *
        DefaultColWidth +
        (MaxNumberStringGridColumnsWithoutScrollBars + 1) *
        GridLineWidth + 3;

      MaxNumberStringGridColumnsWithScrollBars:=
        Trunc((LimitStringGridWidth - 3 - ScrollBarsWidth - GridLineWidth)/
              (DefaultColWidth + GridLineWidth));

      MaxStringGridWidthWithScrollBars:=
        MaxNumberStringGridColumnsWithScrollBars *
        DefaultColWidth +
        (MaxNumberStringGridColumnsWithScrollBars + 1) *
        GridLineWidth + ScrollBarsWidth + 3;
    end; // with StringGrid do
end; // TGridsForm.GetStringGridMaxWidthParameters

//******************************************************************************

// Получение параметров таблицы максимальной высоты.
procedure GetStringGridMaxHeightParameters(
      StringGrid: TStringGrid;
  var MaxStringGridHeightWithoutScrollBars,
      MaxStringGridHeightWithScrollBars: Integer);

var
  // StringGrid - рассматриваемая таблица.
  // MaxStringGridHeightWithoutScrollBars - максимальная высота таблицы,
  //   отображаемой на экране при отсутствии горизонтальной полосы проекутки.
  // MaxStringGridHeightWithScrollBars - максимальная высота таблицы,
  //   отображаемой на экране при наличие горизонтальной полосы проекутки.

  // Предельная максимальная высота таблицы.
  LimitStringGridHeight: Integer;
  // Максимальное количество строк таблицы,
  // которое может быть отображено на экране
  // при отсутствии горизонтальной полосы проекутки.
  MaxNumberStringGridRowsWithoutScrollBars: Integer;
  // Максимальное количество строк таблицы,
  // которое может быть отображено на экране
  // при наличие горизонтальной полосы проекутки.
  MaxNumberStringGridRowsWithScrollBars: Integer;

begin // TGridsForm.GetStringGridMaxHeightParameters
  with StringGrid do
    begin
      LimitStringGridHeight:=Trunc((Screen.WorkAreaHeight -
                                    OuterBorderHeight -
                                    MaxClientHeightWithoutStringGrids)/3);

      MaxNumberStringGridRowsWithoutScrollBars:=
        Trunc((LimitStringGridHeight - 3 - GridLineWidth)/
              (DefaultRowHeight + GridLineWidth));

      MaxStringGridHeightWithoutScrollBars:=
        MaxNumberStringGridRowsWithoutScrollBars * DefaultRowHeight +
        (MaxNumberStringGridRowsWithoutScrollBars + 1) *
        GridLineWidth + 3;

      MaxNumberStringGridRowsWithScrollBars:=
        Trunc((LimitStringGridHeight - 3 - ScrollBarsWidth - GridLineWidth)/
              (DefaultRowHeight + GridLineWidth));

      MaxStringGridHeightWithScrollBars:=
        MaxNumberStringGridRowsWithScrollBars * DefaultRowHeight +
        (MaxNumberStringGridRowsWithScrollBars + 1) * GridLineWidth +
        ScrollBarsWidth + 3;
    end; // with StringGrid do
end; // TGridsForm.GetStringGridMaxHeightParameters

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// Изменение прежних размеров таблиц и формы.
procedure TGridsForm.ResizeStringGrids;
var
  // Признак наличия горизонтальных полос прокрутки в таблицах поверхностей.
  bHorizontalSurfaceStringGrigScrollBars: Boolean;
  // Признак наличия горизонтальной полосы прокрутки в таблице областей.
  bHorizontalAreaStringGrigScrollBars: Boolean;
  // Параметр циклов.
  j: Byte;
  // Индекс столбца таблицы исходной поверхности.
  SourceSurfaceStringGridColumnIndex: Byte;

begin // TGridsForm.ResizeGrids
  with SourceSurfaceCornersStringGrid do
    begin // with SourceSurfaceCornersStringGrid do
      if SourceSurfaceStringGrid.RowCount = 2
        then RowCount:=2
        else begin
               RowCount:=3;
               // Заполнение ячеек левой нижней точки исходной поверхности.
               for j:=0 to 3 do
                 Cells[j,2]:=SourceSurfaceStringGrid.Cells[j,
                               SourceSurfaceStringGrid.RowCount-1];
             end;

      if SourceSurfaceStringGrid.ColCount = 4
        then ColCount:=4
        else begin
               ColCount:=7;
               // Заполнение ячеек правой верхней точки исходной поверхности.
               for j:=4 to 6 do
                 begin
                   SourceSurfaceStringGridColumnIndex:=
                      SourceSurfaceStringGrid.ColCount - (j - 2*(j - 3) + 1);

                   Cells[j,0]:=SourceSurfaceStringGrid.Cells[
                                 SourceSurfaceStringGridColumnIndex, 0];

                   Cells[j,1]:=SourceSurfaceStringGrid.Cells[
                                 SourceSurfaceStringGridColumnIndex, 1];
                 end;
             end;

      if (SourceSurfaceStringGrid.RowCount > 2) and
         (SourceSurfaceStringGrid.ColCount > 4)
        // Заполнение ячеек правой нижней точки исходной поверхности.
        then for j:=4 to 6 do
               Cells[j,2]:=SourceSurfaceStringGrid.Cells[
                             SourceSurfaceStringGridColumnIndex + j - 6,
                             SourceSurfaceStringGrid.RowCount - 1];
  end; // with SourceSurfaceCornersStringGrid do

  // Установка ширины таблицы поверхности без скроллера.
  GetStringGridWidth(SourceSurfaceCornersStringGrid,0,MaximizedSurfaceStringGridWidth);
  SourceSurfaceCornersStringGrid.Width:=MaximizedSurfaceStringGridWidth;
  // Установка высоты таблицы без скроллера.
  GetStringGridHeight(SourceSurfaceCornersStringGrid,0,MaximizedSurfaceStringGridHeight);
  SourceSurfaceCornersStringGrid.Height:=MaximizedSurfaceStringGridHeight;


  // Установка ширины таблицы поверхности без скроллера.
  GetStringGridWidth(SourceSurfaceStringGrid,0,MaximizedSurfaceStringGridWidth);
  MinimizedSurfaceStringGridWidth:=MaximizedSurfaceStringGridWidth;
  // Если ширина таблицы превышает максимальную ширина таблицы
  // без вертикальной полосы прокрутки, то
  // появляется горизонтальная полоса рокрутки,
  // высоту которой следует учесть.
  if MinimizedSurfaceStringGridWidth > MaxSurfaceStringGridWidthWithoutScrollBars
    then bHorizontalSurfaceStringGrigScrollBars:=True
    else bHorizontalSurfaceStringGrigScrollBars:=False;

  // Установка ширины таблицы областей без скроллера.
  GetStringGridWidth(SurfaceAreaStringGrid,0,MaximizedAreaStringGridWidth);
  MinimizedAreaStringGridWidth:=MaximizedAreaStringGridWidth;
  // Если ширина таблицы превышает максимальную ширина таблицы
  // без вертикальной полосы прокрутки, то
  // появляется горизонтальная полоса рокрутки,
  // высоту которой следует учесть.
  if MinimizedAreaStringGridWidth > MaxAreaStringGridWidthWithoutScrollBars
    then bHorizontalAreaStringGrigScrollBars:=True
    else bHorizontalAreaStringGrigScrollBars:=False;

  // Установка высоты таблицы без скроллера.
  GetStringGridHeight(SourceSurfaceStringGrid,0,MaximizedSurfaceStringGridHeight);
  MinimizedSurfaceStringGridHeight:=MaximizedSurfaceStringGridHeight;
  MaximizedAreaStringGridHeight:=MaximizedSurfaceStringGridHeight;
  MinimizedAreaStringGridHeight:=MaximizedSurfaceStringGridHeight;
  // Если высота таблицы превышает максимальную высоту таблицы
  // без горизонтельной полосы прокрутки, то
  // появляется вертикальная полоса рокрутки,
  // ширину которой следует учесть.
  if MinimizedSurfaceStringGridHeight > MaxStringGridHeightWithoutScrollBars
    then begin
           MinimizedSurfaceStringGridHeight:=MaxStringGridHeightWithoutScrollBars;
           MinimizedAreaStringGridHeight:=MaxStringGridHeightWithoutScrollBars;

           if bHorizontalSurfaceStringGrigScrollBars = False
             then // Установка ширины таблиц со скроллером.
                  GetStringGridWidth(SourceSurfaceStringGrid, ScrollBarsWidth,
                                     MinimizedSurfaceStringGridWidth)
             else begin // Два скроллера.
                    MinimizedSurfaceStringGridWidth:=MaxSurfaceStringGridWidthWithScrollBars;
                    MinimizedSurfaceStringGridHeight:=MaxStringGridHeightWithScrollBars;

                    MaximizedSurfaceStringGridHeight:=MaximizedSurfaceStringGridHeight +
                                                      ScrollBarsWidth;
                  end;

           if bHorizontalAreaStringGrigScrollBars = False
             then // Установка ширины таблиц со скроллером.
               GetStringGridWidth(SurfaceAreaStringGrid, ScrollBarsWidth,
                                  MinimizedAreaStringGridWidth)
             else begin // Два скроллера.
                    MinimizedAreaStringGridWidth:=MaxAreaStringGridWidthWithScrollBars;
                    MinimizedAreaStringGridHeight:=MaxStringGridHeightWithScrollBars;

                    MaximizedAreaStringGridHeight:=MaximizedAreaStringGridHeight +
                                                   ScrollBarsWidth;
                  end;

           MaximizedSurfaceStringGridWidth:=MinimizedSurfaceStringGridWidth - ScrollBarsWidth;
           MaximizedAreaStringGridWidth:=MinimizedAreaStringGridWidth - ScrollBarsWidth;
         end
    else begin
           if bHorizontalSurfaceStringGrigScrollBars = True
             then begin // Установка высоты таблиц со скроллером.
                    MinimizedSurfaceStringGridWidth:=MaxSurfaceStringGridWidthWithoutScrollBars;
                    GetStringGridHeight(SourceSurfaceStringGrid, ScrollBarsWidth,
                                        MinimizedSurfaceStringGridHeight);

                    MaximizedSurfaceStringGridHeight:=MinimizedSurfaceStringGridHeight;
                  end;

           if bHorizontalAreaStringGrigScrollBars = True
             then begin // Установка высоты таблиц со скроллером.
                    MinimizedAreaStringGridWidth:=MaxAreaStringGridWidthWithoutScrollBars;
                    GetStringGridHeight(SurfaceAreaStringGrid, ScrollBarsWidth,
                                        MinimizedAreaStringGridHeight);

                    MaximizedAreaStringGridHeight:=MinimizedAreaStringGridHeight;
                  end
             else GetStringGridHeight(SurfaceAreaStringGrid, 0,
                                      MinimizedAreaStringGridHeight);

           MaximizedSurfaceStringGridWidth:=MinimizedSurfaceStringGridWidth;
           MaximizedAreaStringGridWidth:=MinimizedAreaStringGridWidth;
         end;

  // Подготовка макета формы:
  // размещение компонентов и вычисление размеров.
  MakeFormModel;
end; // TGridsForm.ResizeGrids


procedure TGridsForm.FormCreate(Sender: TObject);
var
  // Параметр циклов.
  j: Byte;

begin
  // Признак того, что форма таблиц уже создана.
  bGridFormCreated:=True;

  // Если фома создаётся впервые.
  // Прзнак того, что форма с таблицами создаётся впервые.
  if bFirstGridsFormShow = True
    then begin // if bFirstGridsFormShow = True
           // Шапки таблиц.
           // Шапка для таблиц поверхностей.
           SetSurfaceStringGridHead(SourceSurfaceStringGrid);
           SetSurfaceStringGridHead(SourceSurfaceCornersStringGrid);
           SetSurfaceStringGridHead(DisplacedSurfaceStringGrid);

           // Таблица принадлежности точек областям.
           with SurfaceAreaStringGrid do
             begin
               ColCount:=2;
               RowCount:=2;
               // Шапка слева.
               for j:=1 to MaxNumSurfacePointsRows do
                 Cells[j,0]:=GapsSurfaceAreaStringGridString+IntToStr(j);
               // Шапка сверху.
               for j:=1 to MaxNumSurfacePointsColumns do
                 Cells[0,j]:=GapsSurfaceAreaStringGridString+IntToStr(j);
             end; // with SurfaceAreaStringGrid

           // Разница между шириной бордюра и шириной рабочей области формы таблиц.
           OuterBorderWidth:=Width - ClientWidth;
           // Разница между высотой бордюра и высотой рабочей области формы таблиц.
           OuterBorderHeight:=Height - ClientHeight;
           // Минимальная ширина рабочей области.
           MinClientWidth:=2*InnerBorder + ButtonsAreaWidth;
           // Максимальная высота рабочей области, не занимаемая таблицами.
           MaxClientHeightWithoutStringGrids:=ToolBar.Height + 5*InnerBorder +
             ButtonsAreaHeight + 3*SurfaceAreaStringGridTitlePanel.Height + 3;

           // Получение параметров таблиы максимальной высоты.
           GetStringGridMaxHeightParameters(SourceSurfaceStringGrid,
                                            MaxStringGridHeightWithoutScrollBars,
                                            MaxStringGridHeightWithScrollBars);
           // Получение параметров таблиы поверхности максимальной ширины.
           GetStringGridMaxWidthParameters(
              SourceSurfaceStringGrid,
              MaxSurfaceStringGridWidthWithoutScrollBars,
              MaxSurfaceStringGridWidthWithScrollBars);
           // Получение параметров таблиы областей максимальной ширины.
           GetStringGridMaxWidthParameters(
              SurfaceAreaStringGrid,
              MaxAreaStringGridWidthWithoutScrollBars,
              MaxAreaStringGridWidthWithScrollBars);


           // Установка ширины таблиц без скроллера.
           GetStringGridWidth(SourceSurfaceStringGrid,0,MaximizedSurfaceStringGridWidth);
           MinimizedSurfaceStringGridWidth:=MaximizedSurfaceStringGridWidth;

           GetStringGridWidth(SurfaceAreaStringGrid,0,MaximizedAreaStringGridWidth);
           MinimizedAreaStringGridWidth:=MaximizedAreaStringGridWidth;

           // Установка высот таблиц без скроллера.
           GetStringGridHeight(SourceSurfaceStringGrid,0,MaximizedSurfaceStringGridHeight);
           MaximizedAreaStringGridHeight:=MaximizedSurfaceStringGridHeight;
           MinimizedSurfaceStringGridHeight:=MaximizedSurfaceStringGridHeight;
           MinimizedAreaStringGridHeight:=MaximizedSurfaceStringGridHeight;

           // Подготовка макета формы:
           // размещение компонентов и вычисление размеров.
           MakeFormModel;

           // Прзнак того, что форма с таблицами создаётся впервые.
           bFirstGridsFormShow:=False;
         end // if bFirstGridsFormShow = True

    else begin // if bFirstGridsFormShow = False
           // Извлечение параметров таблиц из записей.
           GetStringGridParameters(SourceSurfaceStringGridParameters,
                                   SourceSurfaceStringGrid);
           GetStringGridParameters(DisplacedSurfaceStringGridParameters,
                                   DisplacedSurfaceStringGrid);
           GetStringGridParameters(SurfaceAreaStringGridParameters,
                                   SurfaceAreaStringGrid);
           // Регуляторы количества точек поверхностей.
           SurfacePointsRowsUpDown.Position:=SurfaceAreaStringGrid.RowCount-1;
           SurfacePointsColumnsUpDown.Position:=SurfaceAreaStringGrid.ColCount-1;

           for j:=0 to 3 do
             begin
               SourceSurfaceCornersStringGrid.Cells[j,0]:=
                 SourceSurfaceStringGrid.Cells[j,0];
               SourceSurfaceCornersStringGrid.Cells[j,1]:=
                 SourceSurfaceStringGrid.Cells[j,1];
             end;

           // Изменение прежних размеров таблиц и формы.
           ResizeStringGrids;
         end; // if bFirstGridsFormShow = False

  // Размещение формы по центру рабочей области экрана.
  Top:=Round(Screen.WorkAreaHeight/2-Height/2);
  Left:=Round(Screen.WorkAreaWidth/2-Width/2);
  
  // Изображение, содержащее изменения размеров панелей-контейнеров таблиц.
  ResizeStringGridAreaBitMap:=TBitMap.Create;

  ResizeSourceSurfaceStringGridPanelSpeedButton.Hint:='Развернуть';
  ResizeDisplacedSurfaceStringGridPanelSpeedButton.Hint:='Развернуть';
  ResizeSurfaceAreaStringGridPanelSpeedButton.Hint:='Развернуть';
  // Изображение для расширения панели исходной поверхности.
  GridsImageList.GetBitmap(0,ResizeStringGridAreaBitMap);
  ResizeSourceSurfaceStringGridPanelSpeedButton.Glyph:=ResizeStringGridAreaBitMap;
  // Изображение для расширения панели искажённой поверхности.
  GridsImageList.GetBitmap(2,ResizeStringGridAreaBitMap);
  ResizeDisplacedSurfaceStringGridPanelSpeedButton.Glyph:=ResizeStringGridAreaBitMap;
  // Изображение для расширения панели областей поверхностей.
  GridsImageList.GetBitmap(4,ResizeStringGridAreaBitMap);
  ResizeSurfaceAreaStringGridPanelSpeedButton.Glyph:=ResizeStringGridAreaBitMap;

  
  SourceSurfaceCornersStringGridPanel.Top:=SourceSurfaceStringGridPanel.Top;
  SourceSurfaceCornersStringGridPanel.Left:=SourceSurfaceStringGridPanel.Left;

  if bSourceSurfaceCornersStringGridPanelShow = True
    then ShowSourceSurfaceCornersStringGridPanelSpeedButtonClick(GridsForm)
    // Компонент который в данный момент является развёрнутым, NoneMaximased,
    // когда все находятся в исходном состоянии.
    else case MaximasedGridsFormComponent of
           SourceSurfaceStringGridPanelMaximased:
             begin
               MaximasedGridsFormComponent:=NoneGridsFormComponentMaximased;
               ResizeSourceSurfaceStringGridPanelSpeedButtonClick(GridsForm);
             end;

           DisplacedSurfaceStringGridPanelMaximased:
             begin
               MaximasedGridsFormComponent:=NoneGridsFormComponentMaximased;
               ResizeDisplacedSurfaceStringGridPanelSpeedButtonClick(GridsForm);
             end;

           SurfaceAreaStringGridPanelMaximased:
             begin
               MaximasedGridsFormComponent:=NoneGridsFormComponentMaximased;
               ResizeSurfaceAreaStringGridPanelSpeedButtonClick(GridsForm);
             end;
         end; // case
end;

//******************************************************************************

// Уничтожение объёкта формы и освобождение занимаемой формой памяти.
procedure TGridsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin // TGridsForm.FormClose
  // Выделение динамической памяти под записи параметров таблиц.
  // Сохранение параметров таблиц в записях.
  SetStringGridParameters(SourceSurfaceStringGridParameters,
                          SourceSurfaceStringGrid,
                          3*MaxNumSurfacePointsColumns);
  SetStringGridParameters(DisplacedSurfaceStringGridParameters,
                          DisplacedSurfaceStringGrid,
                          3*MaxNumSurfacePointsColumns);
  SetStringGridParameters(SurfaceAreaStringGridParameters,
                          SurfaceAreaStringGrid,
                          MaxNumSurfacePointsColumns);
  Action:=caFree;
end; // TGridsForm.FormClose

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Изменение количества строк точек поверхности.
procedure TGridsForm.SurfacePointsRowsEditExit(Sender: TObject);
var
  // Новое количество строк точек поверхности.
  NewNumSurfacePointsRows: Byte;
begin // TGridsForm.SurfacePointsRowsEditExit
  // Изменение количества строк точек поверхности.
  MainForm.ChangeNumberSurfacePointsLines(SurfacePointsRowsEdit,
                                          NewNumSurfacePointsRows,
                                          MinNumSurfacePointsRows,
                                          MaxNumSurfacePointsRows,
                                          'строк');

  SourceSurfaceStringGrid.RowCount:=1+NewNumSurfacePointsRows;
  DisplacedSurfaceStringGrid.RowCount:=1+NewNumSurfacePointsRows;
  SurfaceAreaStringGrid.RowCount:=1+NewNumSurfacePointsRows;

  // Изменение прежних размеров таблиц и формы.
  ResizeStringGrids;
end; // TGridsForm.SurfacePointsRowsEditExit

//******************************************************************************

// Изменение количества столбцов точек поверхности.
procedure TGridsForm.SurfacePointsColumnsEditExit(Sender: TObject);
var
  // Новое количество столбцов точек поверхности.
  NewNumSurfacePointsColumns: Byte;
begin // TGridsForm.SurfacePointsColumnsEditExit
  // Изменение количества столбцов точек поверхности.
  Mainform.ChangeNumberSurfacePointsLines(SurfacePointsColumnsEdit,
                                          NewNumSurfacePointsColumns,
                                          MinNumSurfacePointsColumns,
                                          MaxNumSurfacePointsColumns,
                                          'столбцов');

  SurfaceAreaStringGrid.ColCount:=1+NewNumSurfacePointsColumns;

  // Одной точке соответствуют три поля значений координат
  NewNumSurfacePointsColumns:=3*NewNumSurfacePointsColumns;

  SourceSurfaceStringGrid.ColCount:=1+NewNumSurfacePointsColumns;
  DisplacedSurfaceStringGrid.ColCount:=1+NewNumSurfacePointsColumns;

  // Изменение прежних размеров таблиц и формы.
  ResizeStringGrids;
end; // TGridsForm.SurfacePointsColumnsEditExit

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

// Изменение количества строк точек поверхности
// при нажатии <Enter> в метке.
procedure TGridsForm.SurfacePointsRowsEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TGridsForm.SurfacePointsRowsEditKeyDown
  if Key = VK_RETURN
    then GridsForm.SurfacePointsRowsEditExit(GridsForm);
end; // TGridsForm.SurfacePointsRowsEditKeyDown

// Изменение количества столбцов точек поверхности
// при нажатии <Enter> в метке.
procedure TGridsForm.SurfacePointsColumnsEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TGridsForm.SurfacePointsColumnsEditKeyDown
  if Key = VK_RETURN
    then GridsForm.SurfacePointsColumnsEditExit(GridsForm);
end; // TGridsForm.SurfacePointsColumnsEditKeyDown

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

// Изменение количества строк точек поверхности
// с помощью кнопок переключения рядом с меткой.
procedure TGridsForm.SurfacePointsRowsUpDownClick(Sender: TObject;
  Button: TUDBtnType);
begin // TGridsForm.SurfacePointsRowsUpDownClick
  GridsForm.SurfacePointsRowsEditExit(GridsForm);
end; // TGridsForm.SurfacePointsRowsUpDownClick

// Изменение количества столбцов точек поверхности
// с помощью кнопок переключения рядом с меткой.
procedure TGridsForm.SurfacePointsColumnsUpDownClick(Sender: TObject;
  Button: TUDBtnType);
begin // TGridsForm.SurfacePointsColumnsUpDownClick
  GridsForm.SurfacePointsColumnsEditExit(GridsForm);
end; // TGridsForm.SurfacePointsColumnsUpDownClick

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Изменение полей таблицы угловых точек исходной поверхности
// в связи с коррекцией данных при построении поверхностей.
procedure TGridsForm.BuildingSurfacesSourceSurfaceCornersStringGridEditing;
var
  // Параметр циклов.
  j: Byte;

begin
  with SourceSurfaceCornersStringGrid do
    begin // with SourceSurfaceCornersStringGrid do
      for j:=1 to 3 do
        Cells[j,1]:=SourceSurfaceStringGrid.Cells[j,1];

      if SourceSurfaceStringGrid.RowCount > 2
        then begin
               // Заполнение ячеек левой нижней точки исходной поверхности.
               for j:=1 to 3 do
                 Cells[j,2]:=SourceSurfaceStringGrid.Cells[j,
                               SourceSurfaceStringGrid.RowCount-1];
             end;

      if SourceSurfaceStringGrid.ColCount > 4
        then begin
               // Заполнение ячеек правой верхней точки исходной поверхности.
               for j:=4 to 6 do
                 begin
                   Cells[j,1]:=SourceSurfaceStringGrid.Cells[
                                 SourceSurfaceStringGrid.ColCount - (j - 2*(j - 3) + 1), 1];
                 end;
             end;

      if (SourceSurfaceStringGrid.RowCount > 2) and
         (SourceSurfaceStringGrid.ColCount > 4)
        // Заполнение ячеек правой нижней точки исходной поверхности.
        then for j:=4 to 6 do
               Cells[j,2]:=SourceSurfaceStringGrid.Cells[
                             SourceSurfaceStringGrid.ColCount + j - 7,
                             SourceSurfaceStringGrid.RowCount - 1];
    end; // with SourceSurfaceCornersStringGrid do
end;

// Построение поверхностей.
procedure TGridsForm.BuildSurfacesSpeedButtonClick(Sender: TObject);
var
  // Новое значение поля ячейки.
  NewCellValue: Int64;
  // Строка-копия.
  TextString: String;
  // Параметры циклов.
  i, j: Byte;
  // Номер точки в строке.
  RowPointIndex: Byte;
  // Остаток от деления на три.
  DivisionRemainderBy3: Byte;
  // Количество строк определённого цвета
  // точек поверхности в трёхмерном пространстве.
  SurfaceNumberPoitsRows: Byte;
  // Количество столбцов определённого цвета
  // точек поверхности в трёхмерном пространстве.
  SurfaceNumberPoitsColumns: Byte;

begin // TGridsForm.BuildSurfacesSpeedButtonClick
  // Удаление массивов указателей на массивы указателей
  // точек трёхмерного пространства определённого цвета в строке
  // путём освобождения динамической памяти.
  SourceSurface.DisposeGrids;
  DisplacedSurface.DisposeGrids;

  if bGridFormCreated
    then begin
           SurfaceNumberPoitsRows:=SurfaceAreaStringGrid.RowCount - 1;
           SurfaceNumberPoitsColumns:=SurfaceAreaStringGrid.ColCount - 1;
         end
    else begin
           SurfaceNumberPoitsRows:=SurfaceAreaStringGridParameters^.RowCount - 1;
           SurfaceNumberPoitsColumns:=SurfaceAreaStringGridParameters^.ColCount - 1;
         end;

  SourceSurface.NewGrids(SurfaceNumberPoitsRows, SurfaceNumberPoitsColumns);
  DisplacedSurface.NewGrids(SurfaceNumberPoitsRows, SurfaceNumberPoitsColumns);

  MainForm.StatusBar.Panels[1].Text:='';
  for i:=1 to SurfaceNumberPoitsRows do
    for j:=1 to 3*SurfaceNumberPoitsColumns do
      begin // for j
        // Номер точки в строке.
        RowPointIndex:=((j-1) div 3) + 1;
        // Остаток от деления на три.
        DivisionRemainderBy3:=j mod 3;

        // Создание строки-копии.
        if bGridFormCreated
          then TextString:=SourceSurfaceStringGrid.Cells[j,i]
          else TextString:=SourceSurfaceStringGridParameters^.Cells[j]^[i]^;

        // Удаление пробелов в строке.
        DelStringGaps(TextString);
        if TextString<>''
          then begin
                 try
                   NewCellValue:=StrToInt(TextString);

                   // Запись строки значения в ячейку с форматированием.
                   SetCellString(SourceSurfaceStringGrid,
                                 SourceSurfaceStringGridParameters,
                                 i,j,NewCellValue);

                   if DivisionRemainderBy3=1
                     then CheckNewCellValue(NewCellValue,
                            LimitingEllipsoid.DefiningParameters.Radiuses.XRadiusInMillimeters,
                            RowPointIndex,i,j,
                            SourceSurfaceStringGrid,SourceSurfaceStringGridParameters,
                            'абсциссы', 'Х');

                   if DivisionRemainderBy3=2
                     then begin
                            if NewCellValue<0
                              then begin
                                     NewCellValue:=
                                       SourceFocalEllipsoid.DefiningParameters.Radiuses.YRadiusInMillimeters;

                                     // Запись строки значения в ячейку с форматированием.
                                     SetCellString(SourceSurfaceStringGrid,
                                                   SourceSurfaceStringGridParameters,
                                                   i,j,NewCellValue);

                                     MainForm.CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
                                       'Отрицательное значение ординаты точки S['+
                                       IntToStr(i)+'; Y'+IntToStr(RowPointIndex)+
                                       '] исправлено на значение '+
                                       'радиуса эллипсоида исходного фокуса по оси ОY!');
                                     MainForm.StatusBar.Panels[0].Text:=CorrectionsString;
                                   end // if NewCellValue<0
                               else CheckNewCellValue(NewCellValue,
                                      LimitingEllipsoid.DefiningParameters.Radiuses.YRadiusInMillimeters,
                                      RowPointIndex,i,j,
                                      SourceSurfaceStringGrid,SourceSurfaceStringGridParameters,
                                      'ординаты', 'Y');
                          end; // if (j mod 3)=2

                   if DivisionRemainderBy3=0
                     then CheckNewCellValue(NewCellValue,
                            LimitingEllipsoid.DefiningParameters.Radiuses.ZRadiusInMillimeters,
                            RowPointIndex,i,j,
                            SourceSurfaceStringGrid,SourceSurfaceStringGridParameters,
                            'аппликаты', 'Z');

                 except
                   // При ошибке ввода.
                   on EConvertError do
                     begin
                       NewCellValue:=
                         SourceFocalEllipsoid.DefiningParameters.Radiuses.YRadiusInMillimeters;

                         // Запись строки значения в ячейку с форматированием.
                         SetCellString(SourceSurfaceStringGrid,SourceSurfaceStringGridParameters,
                                       i,j,NewCellValue);

                       if DivisionRemainderBy3=1
                         then TextString:='X'
                         else if DivisionRemainderBy3=2
                                then TextString:='Y'
                                else TextString:='Z';

                       MainForm.CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
                         'Некорректное значение координаты точки S['+
                         IntToStr(i)+'; '+TextString+IntToStr(RowPointIndex)+'] '+
                         'исправлено на значение '+
                         'радиуса эллипсоида исходного фокуса по оси ОY!');
                       MainForm.StatusBar.Panels[0].Text:=CorrectionsString;
                     end; // on EConvertError
                 end; // except

                 // Запись значения новой координаты в один из массивов
                 // координатных осей исходной поверхности.
                 SetNewSourceSurfaceCoordinate(NewCellValue,DivisionRemainderBy3,
                                               RowPointIndex,i);
               end // if TextString<>''

          // При пустой строке.
          else if ( (i=1) and ((j<=3) or
                               (j>=3*SurfaceNumberPoitsColumns)) ) or
                  ( (i=SurfaceNumberPoitsRows) and
                              ((j<=3) or
                               (j>=3*SurfaceNumberPoitsColumns)) )
                 then begin
                        SourceSurface.bDetermined:=False;
                        DisplacedSurface.bDetermined:=False;
                        // Недоступность объектов отображения поверхностей.
                        MainForm.DisableDrawingSurfacesObjects(MainForm);

                        MainForm.Repaint;

                        MainForm.StatusBar.Panels[1].Text:=
                          'Недостаточно данных для построения поверхностей';

                        // Изменение полей таблицы угловых точек исходной поверхности
                        // в связи с коррекцией данных при построении поверхностей.
                        if bGridFormCreated = True
                          then BuildingSurfacesSourceSurfaceCornersStringGridEditing;

                        // Выход из процедуры.
                        Exit;
                      end; // else if ( (i=1) and ((j<=3)
      end; //  for j

  // Автозаполнение методом "центростремительного колоска"
  // массива указателей на массивы указателей
  // точек трёхмерного пространства определённого цвета в столбце.
  SourceSurface.AutoFillGridColoredPoints;
  // Установка принадлежности точек поверхностей зрительным областям.
  SetSurfacesPointsAreas;
  // Установка искажённой смещённой поверхности при получении её точек,
  // параллельно перемещённой вдоль их центрофокусных прямых.
  MainForm.SetDistortedDisplacedSurface;
  // Заполнение таблицы значениями координат точек поверхности.
  FillStringGrid(SourceSurfaceStringGrid,
                 SourceSurfaceStringGridParameters,
                 SourceSurface);
  // Определённость построения исходной поверхности.
  SourceSurface.bDetermined:=True;
  // Доступность объектов отображения поверхностей.
  MainForm.EnableDrawingSurfacesObjects(MainForm);

  // Изменение полей таблицы угловых точек исходной поверхности
  // в связи с коррекцией данных при построении поверхностей.
  if bGridFormCreated
    then begin
           BuildingSurfacesSourceSurfaceCornersStringGridEditing;
           SurfaceAreaStringGrid.Repaint;
         end;

  MainForm.Repaint;
end; // TGridsForm.BuildSurfacesSpeedButtonClick

//******************************************************************************

// Очистка таблиц поверхностей.
procedure TGridsForm.CleanStringGridsSpeedButtonClick(Sender: TObject);
var
  // Параметры циклов.
  i, j, k: Byte;
  // Номер точки в строке.
  RowPointIndex: Byte;
begin // TGridsForm.CleanStringGridsSpeedButtonClick
  // Очистка всех таблиц, связанных с поверхностями по ячейкам.
  for i:=1 to MaxNumSurfacePointsRows do
    begin // for i
      RowPointIndex:=1;
      for j:=1 to MaxNumSurfacePointsColumns do
        begin // for j
          SurfaceAreaStringGrid.Cells[j,i]:='';

          for k:=0 to 2 do
            begin // for k
              SourceSurfaceStringGrid.Cells[RowPointIndex + k, i]:='';
              SourceSurfaceCornersStringGrid.Cells[RowPointIndex + k, i]:='';
              DisplacedSurfaceStringGrid.Cells[RowPointIndex + k, i]:='';
            end; // for k

          RowPointIndex:=RowPointIndex+3;
        end; // for j
    end; // for i
    
  // Неопределённость построения поверхностей.
  SourceSurface.bDetermined:=False;
  DisplacedSurface.bDetermined:=False;
  // Недоступность объектов отображения поверхностей.
  MainForm.DisableDrawingSurfacesObjects(MainForm);

  MainForm.Repaint;
  // Будующие построения не учитывают старых замечаний.
  MainForm.CorrectionsProtocolMemo.Clear;
  MainForm.StatusBar.Panels[0].Text:='';
  MainForm.StatusBar.Panels[1].Text:=
    'Недостаточно данных для построения поверхностей';
end; // TGridsForm.CleanStringGridsSpeedButtonClick

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

procedure TGridsForm.FormDestroy(Sender: TObject);
begin
  ResizeStringGridAreaBitMap.Free;
  // Признак того, что форма таблиц уже создана.
  bGridFormCreated:=False;
end;

//******************************************************************************

// Заполнение таблицы значениями координат точек поверхности.
procedure FillStringGrid(var StringGrid: TStringGrid;
                         var StringGridParameters: PStringGridParameters;
                             Surface: TSurface);
// StringGrid - заполняемая таблица.
  // StringGridParameters - параметры таблицы.
// Surface - поверхность, чьи значения координат точек заносятся в таблицу.

var
  // Параметры циклов.
  i, j: Byte;
  // Номер точки в строке.
  RowPointIndex: Byte;
  
begin // FillStringGrid
  for i:=1 to Surface.NumberPointsRows do
    for j:=1 to Surface.NumberPointsColumns do
      begin // for j
        with Surface do
          begin // with Surface
            // Номер точки в строке.
            RowPointIndex:=j*3-2;
            SetCellString(StringGrid,StringGridParameters,
                          i,RowPointIndex,
                          GridXInMillimeters[i]^[j]^.Coordinate);

            RowPointIndex:=RowPointIndex+1;
            SetCellString(StringGrid,StringGridParameters,
                          i,RowPointIndex,
                          GridYInMillimeters[i]^[j]^.Coordinate);

            RowPointIndex:=RowPointIndex+1;
            SetCellString(StringGrid,StringGridParameters,
                          i,RowPointIndex,
                          GridZInMillimeters[i]^[j]^.Coordinate);
          end; // with Surface
      end; // for j
end; // FillStringGrid
     
// Позиционирование формы по центру на экрана.
procedure TGridsForm.CentreScreenFormPositionLeftSpeedButtonClick(
  Sender: TObject);
begin
  // Размещение формы по центру рабочей области экрана.
  CentreScreenWorkAreaFormPosition(GridsForm);
end;

procedure TGridsForm.SetMainFormFocusSpeedButtonClick(Sender: TObject);
begin
  MainForm.SetFocus;
end;

// Изменение размеров одной из панелей-контейнеров таблиц:
// Если она разворачивается, то занимает всю форсму, а две оставшиеся скрываются.
// Если же она сворачивается, то появляются остальные две панели.
procedure TGridsForm.ResizeStringGridPanel(
  var ResizingStringGridPanel,
      FirstOtherStringGridPanel,
      SecondOtherStringGridPanel: TPanel;
      ResizingStringGridPanelMaximased: TMaximasedGridsFormComponent;
  var ResizeStringGridPanelSpeedButton: TSpeedButton);

begin // TGridsForm.ResizeStringGridPanel
  ResizingStringGridPanel.Hide;
  FirstOtherStringGridPanel.Hide;
  SecondOtherStringGridPanel.Hide;

  if MaximasedGridsFormComponent = NoneGridsFormComponentMaximased
    then begin
           // Отображается только одна панель.
           MaximasedGridsFormComponent:=ResizingStringGridPanelMaximased;

           ResizeStringGridPanelSpeedButton.Hint:='Восстановить';
           // Изображение для восстановления области протокола коррекции ввода данных.
           GridsImageList.GetBitmap(1,ResizeStringGridAreaBitMap);
           ResizeStringGridPanelSpeedButton.Glyph:=ResizeStringGridAreaBitMap;

           MakeFormModel;

           ResizingStringGridPanel.Show;
         end
    else begin
           // Отображаются все панели.
           MaximasedGridsFormComponent:=NoneGridsFormComponentMaximased;

           ResizeStringGridPanelSpeedButton.Hint:='Развернуть';
           // Изображение для расширения области протокола коррекции ввода данных.
           GridsImageList.GetBitmap(0,ResizeStringGridAreaBitMap);
           ResizeStringGridPanelSpeedButton.Glyph:=ResizeStringGridAreaBitMap;

           MakeFormModel;

           ResizingStringGridPanel.Show;
           FirstOtherStringGridPanel.Show;
           SecondOtherStringGridPanel.Show;
         end;

  // Размещение формы по центру рабочей области экрана.
  Top:=Round(Screen.WorkAreaHeight/2-Height/2);
  Left:=Round(Screen.WorkAreaWidth/2-Width/2);
end; // TGridsForm.ResizeStringGridPanel

// Изменение размеров панели таблицы исходной поверхности:
// Если она разворачивается, то занимает всю форсму, а две оставшиеся скрываются.
// Если же она сворачивается, то появляются остальные две панели.
procedure TGridsForm.ResizeSourceSurfaceStringGridPanelSpeedButtonClick(Sender: TObject);
begin // TGridsForm.ResizeSourceSurfaceStringGridPanelSpeedButtonClick
  ResizeStringGridPanel(SourceSurfaceStringGridPanel,
                        DisplacedSurfaceStringGridPanel,
                        SurfaceAreaStringGridPanel,
                        SourceSurfaceStringGridPanelMaximased,
                        ResizeSourceSurfaceStringGridPanelSpeedButton);
end; // TGridsForm.ResizeSourceSurfaceStringGridPanelSpeedButtonClick

// Изменение размеров панели таблицы искажённой поверхности:
// Если она разворачивается, то занимает всю форсму, а две оставшиеся скрываются.
// Если же она сворачивается, то появляются остальные две панели.
procedure TGridsForm.ResizeDisplacedSurfaceStringGridPanelSpeedButtonClick(Sender: TObject);
begin // TGridsForm.ResizeDisplacedSurfaceStringGridPanelSpeedButtonClick
  ResizeStringGridPanel(DisplacedSurfaceStringGridPanel,
                        SourceSurfaceStringGridPanel,
                        SurfaceAreaStringGridPanel,
                        DisplacedSurfaceStringGridPanelMaximased,
                        ResizeDisplacedSurfaceStringGridPanelSpeedButton);
end; // TGridsForm.ResizeDisplacedSurfaceStringGridPanelSpeedButtonClick

// Изменение размеров панели таблицы областей поверхностей:
// Если она разворачивается, то занимает всю форсму, а две оставшиеся скрываются.
// Если же она сворачивается, то появляются остальные две панели.
procedure TGridsForm.ResizeSurfaceAreaStringGridPanelSpeedButtonClick(Sender: TObject);
begin // TGridsForm.ResizeSurfaceAreaStringGridPanelSpeedButtonClick
  ResizeStringGridPanel(SurfaceAreaStringGridPanel,
                        SourceSurfaceStringGridPanel,
                        DisplacedSurfaceStringGridPanel,
                        SurfaceAreaStringGridPanelMaximased,
                        ResizeSurfaceAreaStringGridPanelSpeedButton);
end; // TGridsForm.ResizeSurfaceAreaStringGridPanelSpeedButtonClick 

// Функция, повторяющая общеизвестную функцию Rect:
// Возвращает рямоугольную область типа TRect.
function GetRect(ALeft, ATop, ARight, ABottom: Integer): TRect;
begin
  GetRect:=Rect(ALeft, ATop, ARight, ABottom);
end;

procedure TGridsForm.SurfaceAreaStringGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  // Параметры циклов.
  i, j: Byte;

begin // TGridsForm.SurfaceAreaStringGridDrawCell
  if (ACol = 0) and (ARow = 0)
    then SurfaceAreaStringGrid.Canvas.CopyRect(
           SurfaceAreaStringGrid.CellRect(0,0),
           SurfaceAreaStringGridTitleBitMap.Canvas,
           GetRect(-1, -1,
                   SurfaceAreaStringGridTitleBitMap.Height +
                     SurfaceAreaStringGridCellBitMapHeightAdjustment,
                   SurfaceAreaStringGridTitleBitMap.Width +
                     SurfaceAreaStringGridCellBitMapWidthAdjustment))

    // Заполение ячейки таблицы областий в зависимости
    // от зрительной области соответствующей точки поверхности.
    // Если определённы построения поверхностей.
    else if (ACol <> 0) and (ARow <> 0) and
            (SourceSurface.bDetermined = True) and
            (ARow <= SourceSurface.NumberPointsRows) and
            (ACol <= SourceSurface.NumberPointsColumns)

           then case SourceSurface.GridColoredPoints[ARow]^[ACol]^.Area of
                  // Если точка находится в области правого зрительного центра.
                  RightCenterArea:
                    SurfaceAreaStringGrid.Canvas.CopyRect(
                      SurfaceAreaStringGrid.CellRect(ACol,ARow),
                      SurfaceAreaStringGridRightAreaCellBitMap.Canvas,
                      GetRect(-1, -1,
                              SurfaceAreaStringGridRightAreaCellBitMap.Height +
                                SurfaceAreaStringGridCellBitMapHeightAdjustment,
                              SurfaceAreaStringGridRightAreaCellBitMap.Width +
                                SurfaceAreaStringGridCellBitMapWidthAdjustment));
                  // Если точка находится в области начала координат.
                  OOOArea:
                    SurfaceAreaStringGrid.Canvas.CopyRect(
                      SurfaceAreaStringGrid.CellRect(ACol,ARow),
                      SurfaceAreaStringGridCentreAreaCellBitMap.Canvas,
                      GetRect(-1, -1,
                              SurfaceAreaStringGridCentreAreaCellBitMap.Height +
                                SurfaceAreaStringGridCellBitMapHeightAdjustment,
                              SurfaceAreaStringGridCentreAreaCellBitMap.Width +
                                SurfaceAreaStringGridCellBitMapWidthAdjustment));
                  // Если точка находится в области левого зрительного центра.
                  LeftCenterArea:
                    SurfaceAreaStringGrid.Canvas.CopyRect(
                      SurfaceAreaStringGrid.CellRect(ACol,ARow),
                      SurfaceAreaStringGridLeftAreaCellBitMap.Canvas,
                      GetRect(-1, -1,
                              SurfaceAreaStringGridLeftAreaCellBitMap.Height +
                                SurfaceAreaStringGridCellBitMapHeightAdjustment,
                              SurfaceAreaStringGridLeftAreaCellBitMap.Width +
                                SurfaceAreaStringGridCellBitMapWidthAdjustment));
                end; // case
end; // TGridsForm.SurfaceAreaStringGridDrawCell

procedure TGridsForm.SourceSurfaceStringGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if (ACol = 0) and (ARow = 0)
    then SourceSurfaceStringGrid.Canvas.CopyRect(
           SourceSurfaceStringGrid.CellRect(0,0),
           SourceSurfaceStringGridTitleBitMap.Canvas,
           GetRect(-1, -1,
                   SourceSurfaceStringGridTitleBitMap.Height +
                     SurfaceStringGridCellBitMapHeightAdjustment,
                   SourceSurfaceStringGridTitleBitMap.Width +
                     SurfaceStringGridCellBitMapWidthAdjustment));
end;

procedure TGridsForm.DisplacedSurfaceStringGridDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if (ACol = 0) and (ARow = 0)
    then DisplacedSurfaceStringGrid.Canvas.CopyRect(
           DisplacedSurfaceStringGrid.CellRect(0,0),
           DisplacedSurfaceStringGridTitleBitMap.Canvas,
           GetRect(-1, -1,
                   DisplacedSurfaceStringGridTitleBitMap.Height +
                     SurfaceStringGridCellBitMapHeightAdjustment,
                   DisplacedSurfaceStringGridTitleBitMap.Width +
                     SurfaceStringGridCellBitMapWidthAdjustment));
end;

// Запись строки значения в ячейку с форматированием.
procedure SetCellString(var StringGrid: TStringGrid;
                        var StringGridParameters: PStringGridParameters;
                            RowIndex, ColumnIndex: Byte;
                            NewCellValue: Int64);
var
  // StringGrid - таблица, чья строка заполняется.
  // StringGridParameters - параметры таблицы.
  // RowIndex, ColumnIndex - строка и солбец, содержащие ячейку.
  // NewCellValue - новое значение поля ячейки.

  TextString: String;

begin // SetCellString
  // Выравнивание отрицательного значения.
  TextString:='';
  if NewCellValue>=0
    then TextString:=' ';
  // Форматирование строки-оригинала.
  TextString:=TextString + ' ' + IntToStr(NewCellValue);

  if bGridFormCreated
    then StringGrid.Cells[ColumnIndex,RowIndex]:=TextString
    else StringGridParameters^.Cells[ColumnIndex]^[RowIndex]^:=TextString;
end; // SetCellString

// Проверка нового значения поля ячейки.
procedure CheckNewCellValue(var NewCellValue: Int64;
                                UpperLimitInMillimeters: Word;
                                RowPointIndex,
                                RowIndex, ColumnIndex: Byte;
                            var SurfaceStringGrid: TStringGrid;
                            var SurfaceStringGridParameters: PStringGridParameters;
                                CoordinateNameInGenitiveCase: String;
                                AxisName: Char);
// NewCellValue - новое значение поля ячейки.
// UpperLimitInMillimeters - верхний предел значения поля ячейки.
// RowPointIndex - номер точки в строке.
// RowIndex, ColumnIndex - строка и солбец, содержащие ячейку.
// SurfaceStringGrid - таблица, чья поле ячейки проверяется.
// SurfaceStringGridParameters - параметры таблицы.
// CoordinateNameInGenitiveCase - название координаты в родительном падеже.
// AxisName - название координатной оси.

begin // CheckNewCellValue
  if Abs(NewCellValue)> UpperLimitInMillimeters
    then begin
           NewCellValue:=UpperLimitInMillimeters;

           SetCellString(SurfaceStringGrid,SurfaceStringGridParameters,
                         RowIndex,ColumnIndex,NewCellValue);

           MainForm.CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
             'Модуль значения '+CoordinateNameInGenitiveCase+
             ' точки S['+IntToStr(RowIndex)+'; '+AxisName+
             IntToStr(RowPointIndex)+'] превысил значение '+
             'радиуса предельного эллипсоида по оси O'+AxisName+', '+
             'и данное значение координаты исправлено на максимальное!');
           MainForm.StatusBar.Panels[0].Text:=CorrectionsString;
         end; // if Abs(NewCellValue)>
end; // CheckNewCellValue

// Запись значения новой координаты в один из массивов
// координатных осей исходной поверхности.
procedure SetNewSourceSurfaceCoordinate(NewCellValue: Int64;
                                        DivisionRemainderBy3,
                                        RowPointIndex,
                                        RowIndex: Byte);
// NewCellValue - новое значение поля ячейки.
// DivisionRemainderBy3 - остаток от деления на три.
// RowPointIndex - номер точки в строке.
// RowIndex - строка таблицы.

begin // SetNewSourceSurfaceCoordinate
  with SourceSurface do
    begin
      if DivisionRemainderBy3=1
        then begin
               GridXInMillimeters[RowIndex]^[RowPointIndex]^.Coordinate:=NewCellValue;
               GridXInMillimeters[RowIndex]^[RowPointIndex]^.bDetermined:=True;
             end
        else if DivisionRemainderBy3=2
               then begin
                      GridYInMillimeters[RowIndex]^[RowPointIndex]^.Coordinate:=NewCellValue;
                      GridYInMillimeters[RowIndex]^[RowPointIndex]^.bDetermined:=True;
                    end
               else begin
                      GridZInMillimeters[RowIndex]^[RowPointIndex]^.Coordinate:=NewCellValue;
                      GridZInMillimeters[RowIndex]^[RowPointIndex]^.bDetermined:=True;
                    end;
    end; // with SourceSurface
end; // SetNewSourceSurfaceCoordinate


procedure TGridsForm.SourceSurfaceCornersStringGridDrawCell(
  Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
begin
  if (ACol = 0) and (ARow = 0)
    then SourceSurfaceCornersStringGrid.Canvas.CopyRect(
           SourceSurfaceCornersStringGrid.CellRect(0,0),
           SourceSurfaceCornersStringGridTitleBitMap.Canvas,
           GetRect(-1, -1,
                   SourceSurfaceCornersStringGridTitleBitMap.Height +
                     SurfaceStringGridCellBitMapHeightAdjustment,
                   SourceSurfaceCornersStringGridTitleBitMap.Width +
                     SurfaceStringGridCellBitMapWidthAdjustment));
end;

procedure TGridsForm.ShowSourceSurfaceCornersStringGridPanelSpeedButtonClick(
  Sender: TObject);
begin
  bSourceSurfaceCornersStringGridPanelShow:=True;

  SourceSurfaceStringGridPanel.Hide;
  DisplacedSurfaceStringGridPanel.Hide;
  SurfaceAreaStringGridPanel.Hide;
  SourceSurfaceCornersStringGridPanel.Show;

  MakeFormModel;

  // Размещение формы по центру рабочей области экрана.
  Top:=Round(Screen.WorkAreaHeight/2-Height/2);
  Left:=Round(Screen.WorkAreaWidth/2-Width/2);
end;

procedure TGridsForm.ShowSourceSurfaceStringGridPanelSpeedButtonClick(
  Sender: TObject);
begin
  bSourceSurfaceCornersStringGridPanelShow:=False;

  SourceSurfaceStringGridPanel.Show;
  if MaximasedGridsFormComponent = NoneGridsFormComponentMaximased
    then begin
           DisplacedSurfaceStringGridPanel.Show;
           SurfaceAreaStringGridPanel.Show;
         end;
  SourceSurfaceCornersStringGridPanel.Hide;

  MakeFormModel;

  // Размещение формы по центру рабочей области экрана.
  CentreScreenWorkAreaFormPosition(GridsForm);
end;

procedure TGridsForm.SourceSurfaceStringGridSetEditText(Sender: TObject;
  ACol, ARow: Integer; const Value: String);
begin
  if (ARow = 1) and (ACol <= 3)
    then SourceSurfaceCornersStringGrid.Cells[ACol, ARow]:=Value;

  if (SourceSurfaceStringGrid.RowCount > 2) and
     (ARow = SourceSurfaceStringGrid.RowCount - 1) and (ACol <= 3)
    then SourceSurfaceCornersStringGrid.Cells[ACol, 2]:=Value;


  if (SourceSurfaceStringGrid.ColCount > 4) and
     (ARow = 1) and (ACol >= SourceSurfaceStringGrid.ColCount - 3)
    then SourceSurfaceCornersStringGrid.Cells[
           ACol - SourceSurfaceStringGrid.ColCount + 7, 1]:=Value;

  if (SourceSurfaceStringGrid.RowCount > 2) and
     (SourceSurfaceStringGrid.ColCount > 4) and
     (ARow = SourceSurfaceStringGrid.RowCount - 1) and
     (ACol >= SourceSurfaceStringGrid.ColCount - 3)

    then SourceSurfaceCornersStringGrid.Cells[
           ACol - SourceSurfaceStringGrid.ColCount + 7, 2]:=Value;
end;

procedure TGridsForm.SourceSurfaceCornersStringGridSetEditText(
  Sender: TObject; ACol, ARow: Integer; const Value: String);
begin
  if (ARow = 1) and (ACol <= 3)
    then SourceSurfaceStringGrid.Cells[ACol, ARow]:=Value;

  if (SourceSurfaceStringGrid.RowCount > 2) and
     (ARow = 2) and (ACol <= 3)
    then SourceSurfaceStringGrid.Cells[ACol,
           SourceSurfaceStringGrid.RowCount - 1]:=Value;

  if (SourceSurfaceStringGrid.ColCount > 4) and
     (ARow = 1) and (ACol >= 4)
    then SourceSurfaceStringGrid.Cells[
           SourceSurfaceStringGrid.ColCount - (ACol - 2*(ACol - 3) + 1), 1]:=Value;

  if (SourceSurfaceStringGrid.RowCount > 2) and
     (SourceSurfaceStringGrid.ColCount > 4) and
     (ARow = 2) and (ACol >= 4)

    then SourceSurfaceStringGrid.Cells[
           SourceSurfaceStringGrid.ColCount - (ACol - 2*(ACol - 3) + 1),
           SourceSurfaceStringGrid.RowCount - 1]:=Value;
end;

end.
