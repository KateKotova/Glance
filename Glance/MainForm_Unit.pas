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

// Главная форма.
unit MainForm_Unit;

interface

uses
  Windows, SysUtils, Forms, ImgList, Controls, Menus, ComCtrls, Graphics,
  ToolWin, Mask, StdCtrls, Buttons, ExtCtrls, Classes, Dialogs, Grids, OpenGL,
  ShellAPI;
type
  TMainForm = class(TForm)

    StatusBar: TStatusBar;
    MainMenu: TMainMenu;
    ToolBar: TToolBar;
    CorrectionsProtocolMemo: TMemo;
    PageControl: TPageControl;

    MainMenuImageList: TImageList;
    PageControlImageList: TImageList;

    SourceFocalTabSheet: TTabSheet;
    DisplacedFocalTabSheet: TTabSheet;
    LimitingTabSheet: TTabSheet;
    FocusDirectionTabSheet: TTabSheet;

    EllipsoidsMenuItem: TMenuItem;
    LimitingEllipsoidMenuItem: TMenuItem;
    AxisMenuItem: TMenuItem;
    LimitingFrameworkMenuItem: TMenuItem;
    N4: TMenuItem;
    LimitingHorizontalFrameworkMenuItem: TMenuItem;
    LimitingVerticalFrameworkMenuItem: TMenuItem;
    N8: TMenuItem;
    ReviewMenuItem: TMenuItem;
    FrontalReviewMenuItem: TMenuItem;
    VerticalReviewMenuItem: TMenuItem;
    HorizontalReviewMenuItem: TMenuItem;
    LimitingFrontalFrameworkMenuItem: TMenuItem;
    SourceFocalEllipsoidMenuItem: TMenuItem;
    DisplacedFocalEllipsoidMenuItem: TMenuItem;
    SourceFocalFrameworkMenuItem: TMenuItem;
    DisplacedFocalFrameworkMenuItem: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    SourceFocalFrontalFrameworkMenuItem: TMenuItem;
    DisplacedFocalFrontalFrameworkMenuItem: TMenuItem;
    SourceFocalHorizontalFrameworkMenuItem: TMenuItem;
    DisplacedFocalHorizontalFrameworkMenuItem: TMenuItem;
    SourceFocalVerticalFrameworkMenuItem: TMenuItem;
    DisplacedFocalVerticalFrameworkMenuItem: TMenuItem;
    N3: TMenuItem;
    FocalLinesMenuItem: TMenuItem;
    DrawSourceFocalLinesMenuItem: TMenuItem;
    DrawDisplacedFocalLinesMenuItem: TMenuItem;
    SurfacesMenuItem: TMenuItem;
        SourceSurfaceMenuItem: TMenuItem;
    DisplacedSurfaceMenuItem: TMenuItem;
    N9: TMenuItem;
    CentersLinesMenuItem: TMenuItem;
    DrawSourceSurfaceMenuItem: TMenuItem;
    N12: TMenuItem;
    DrawDisplacedSurfaceMenuItem: TMenuItem;
    N14: TMenuItem;
    SourceSurfaceVertexMenuItem: TMenuItem;
    SourceSurfaceFrameworkMenuItem: TMenuItem;
    FloodedSourceSurfaceMenuItem: TMenuItem;
    DisplacedSurfaceVertexMenuItem: TMenuItem;
    DisplacedSurfaceFrameworkMenuItem: TMenuItem;
    FloodedDisplacedSurfaceMenuItem: TMenuItem;
    DrawFocalLinesMenuItem: TMenuItem;
    N7: TMenuItem;

    LimitingVerticalProjectionPanel: TPanel;
    LimitingFrontalProjectionPanel: TPanel;
    LimitingHorizontalProjectionPanel: TPanel;
    ToolPanel: TPanel;
    ReviewPanel: TPanel;
    LimitingSpeedButtonsPanel: TPanel;
    LimitingRadiusesPanel: TPanel;
    SourceFocalSpeedButtonsPanel: TPanel;
    DisplacedFocalSpeedButtonsPanel: TPanel;
    SourceFocalRadiusesPanel: TPanel;
    DisplacedFocalRadiusesPanel: TPanel;
    FocusesCoordinatesPanel: TPanel;
    FocusesAnglesPanel: TPanel;
    CorrectionsProtocolPanel: TPanel;
    SourceFocalVerticalProjectionPanel: TPanel;
    SourceFocalFrontalProjectionPanel: TPanel;
    SourceFocalHorizontalProjectionPanel: TPanel;
    DisplacedFocalVerticalProjectionPanel: TPanel;
    DisplacedFocalFrontalProjectionPanel: TPanel;
    DisplacedFocalHorizontalProjectionPanel: TPanel;
    FocusVerticalProjectionPanel: TPanel;
    FocusFrontalProjectionPanel: TPanel;
    FocusHorizontalProjectionPanel: TPanel;
    
    Label1: TLabel;   Label2: TLabel;   Label3: TLabel;   Label4: TLabel;
    Label5: TLabel;   Label6: TLabel;   Label7: TLabel;   Label8: TLabel;
    Label9: TLabel;   Label10: TLabel;  Label11: TLabel;  Label12: TLabel;
    Label13: TLabel;  Label14: TLabel;  Label15: TLabel;  Label16: TLabel;
    Label17: TLabel;  Label20: TLabel;
    Label21: TLabel;  Label22: TLabel;  Label24: TLabel;
    Label25: TLabel;  Label26: TLabel;  Label27: TLabel;  Label28: TLabel;
    Label29: TLabel;  Label30: TLabel;  Label31: TLabel;  Label32: TLabel;
    Label33: TLabel;  Label34: TLabel;  Label35: TLabel;
    Label36: TLabel;  Label38: TLabel;  Label39: TLabel;  Label40: TLabel;
    Label41: TLabel;  Label42: TLabel;  Label43: TLabel;  Label44: TLabel;
    Label45: TLabel;  Label46: TLabel;  Label47: TLabel;  Label48: TLabel;
    Label49: TLabel;  Label50: TLabel;  Label51: TLabel;  Label52: TLabel;
    Label53: TLabel;  Label54: TLabel;  Label55: TLabel;  Label56: TLabel;
    Label57: TLabel;  Label59: TLabel;  Label60: TLabel;  Label58: TLabel;
    Label61: TLabel;
    Label69: TLabel;

    ZoomMaskEdit: TMaskEdit;
    LimitingZRadiusMaskEdit: TMaskEdit;
    LimitingXRadiusMaskEdit: TMaskEdit;
    LimitingBetweenDistanceMaskEdit: TMaskEdit;
    LimitingYRadiusMaskEdit: TMaskEdit;
    SourceFocalXRadiusMaskEdit: TMaskEdit;
    SourceFocalYRadiusMaskEdit: TMaskEdit;
    SourceFocalZRadiusMaskEdit: TMaskEdit;
    DisplacedFocalXRadiusMaskEdit: TMaskEdit;
    DisplacedFocalYRadiusMaskEdit: TMaskEdit;
    DisplacedFocalZRadiusMaskEdit: TMaskEdit;
    SourceFocalRadiusMaskEdit: TMaskEdit;
    DisplacedFocalRadiusMaskEdit: TMaskEdit;
    SourceFocalXMaskEdit: TMaskEdit;
    SourceFocalYMaskEdit: TMaskEdit;
    SourceFocalZMaskEdit: TMaskEdit;
    DisplacedFocalXMaskEdit: TMaskEdit;
    DisplacedFocalYMaskEdit: TMaskEdit;
    DisplacedFocalZMaskEdit: TMaskEdit;
    FOXMaskEdit: TMaskEdit;
    FOYMaskEdit: TMaskEdit;
    FOZMaskEdit: TMaskEdit;

    LimitingFrontalFrameworkSpeedButton: TSpeedButton;
    LimitingHorizontalFrameworkSpeedButton: TSpeedButton;
    LimitingVerticalFrameworkSpeedButton: TSpeedButton;
    AxisSpeedButton: TSpeedButton;
    HorizontalReviewSpeedButton: TSpeedButton;
    VerticalReviewSpeedButton: TSpeedButton;
    FrontalReviewSpeedButton: TSpeedButton;
    HideLimitingFrameworkSpeedButton: TSpeedButton;
    SourceFocalFrontalFrameworkSpeedButton: TSpeedButton;
    DisplacedFocalFrontalFrameworkSpeedButton: TSpeedButton;
    SourceFocalVerticalFrameworkSpeedButton: TSpeedButton;
    DisplacedFocalVerticalFrameworkSpeedButton: TSpeedButton;
    SourceFocalHorizontalFrameworkSpeedButton: TSpeedButton;
    DisplacedFocalHorizontalFrameworkSpeedButton: TSpeedButton;
    HideSourceFocalFrameworkSpeedButton: TSpeedButton;
    HideDisplacedFocalFrameworkSpeedButton: TSpeedButton;
    HideAxisSpeedButton: TSpeedButton;
    SourceFocalLinesSpeedButton: TSpeedButton;
    DisplacedFocalLinesSpeedButton: TSpeedButton;
    HideFocalLinesSpeedButton: TSpeedButton;
    CentersLinesSpeedButton: TSpeedButton;
    HideSourceSurfaceSpeedButton: TSpeedButton;
    HideDisplacedSurfaceSpeedButton: TSpeedButton;
    FloodedSourceSurfaceSpeedButton: TSpeedButton;
    SourceSurfaceFrameworkSpeedButton: TSpeedButton;
    SourceSurfaceVertexSpeedButton: TSpeedButton;
    FloodedDisplacedSurfaceSpeedButton: TSpeedButton;
    DisplacedSurfaceFrameworkSpeedButton: TSpeedButton;
    DisplacedSurfaceVertexSpeedButton: TSpeedButton;
    HideCentersLinesSpeedButton: TSpeedButton;

    LimitingFrontalFrameworkEdit: TEdit;
    LimitingFrontalFrameworkGapEdit: TEdit;
    LimitingHorizontalFrameworkEdit: TEdit;
    LimitingVerticalFrameworkEdit: TEdit;
    LimitingHorizontalFrameworkGapEdit: TEdit;
    LimitingVerticalFrameworkGapEdit: TEdit;
    SourceFocalVerticalFrameworkGapEdit: TEdit;
    DisplacedFocalVerticalFrameworkGapEdit: TEdit;
    SourceFocalFrontallFrameworkGapEdit: TEdit;
    DisplacedFocalFrontalFrameworkGapEdit: TEdit;
    SourceFocalHorizontalFrameworkGapEdit: TEdit;
    DisplacedFocalHorizontalFrameworkGapEdit: TEdit;
    SourceFocalVerticalFrameworkEdit: TEdit;
    DisplacedFocalVerticalFrameworkEdit: TEdit;
    SourceFocalFrontalFrameworkEdit: TEdit;
    DisplacedFocalFrontalFrameworkEdit: TEdit;
    SourceFocalHorizontalFrameworkEdit: TEdit;
    DisplacedFocalHorizontalFrameworkEdit: TEdit;
    FOXEdit: TEdit;
    FOXGapEdit: TEdit;
    FOYGapEdit: TEdit;
    FOZGapEdit: TEdit;
    FOYEdit: TEdit;
    FOZEdit: TEdit;

    LimitingFrontalFrameworkUpDown: TUpDown;
    LimitingHorizontalFrameworkUpDown: TUpDown;
    LimitingVerticalFrameworkUpDown: TUpDown;
    SourceFocalVerticalFrameworkUpDown: TUpDown;
    DisplacedFocalVerticalFrameworkUpDown: TUpDown;
    SourceFocalFrontalFrameworkUpDown: TUpDown;
    DisplacedFocalFrontalFrameworkUpDown: TUpDown;
    SourceFocalHorizontalFrameworkUpDown: TUpDown;
    DisplacedFocalHorizontalFrameworkUpDown: TUpDown;
    LeftGapSeparatorToolButton: TToolButton;
    SeparatorToolButton2: TToolButton;
    SeparatorToolButton3: TToolButton;
    SeparatorToolButton4: TToolButton;
    SeparatorToolButton5: TToolButton;
    SeparatorToolButton6: TToolButton;
    SeparatorToolButton7: TToolButton;
    SeparatorToolButton8: TToolButton;

    LimitingVerticalProjectionImage: TImage;
    LimitingFrontalProjectionImage: TImage;
    LimitingHorizontalProjectionImage: TImage;
    SourceFocalVerticalProjectionImage: TImage;
    SourceFocalFrontalProjectionImage: TImage;
    SourceFocalHorizontalProjectionImage: TImage;
    DisplacedFocalVerticalProjectionImage: TImage;
    DisplacedFocalHorizontalProjectionImage: TImage;
    FocusVerticalProjectionImage: TImage;
    FocusFrontalProjectionImage: TImage;
    FocusHorizontalProjectionImage: TImage;
    DisplacedFocalFrontalProjectionImage: TImage;
    HelpMenuItem: TMenuItem;
    WhatIsBMPMenuItem: TMenuItem;
    AboutProgramMenuItem: TMenuItem;

    HalfSpaceTitlePanel: TPanel;
    Label70: TLabel;
    ResizeHalfSpaceAreaSpeedButton: TSpeedButton;
    ResizeCorrectionsProtocolAreaSpeedButton: TSpeedButton;
    MiddleGapSeparatorToolButton: TToolButton;
    CentreScreenFormPositionRightSpeedButton: TSpeedButton;
    SetGridsFormFocusSpeedButton: TSpeedButton;
    CommonImageList: TImageList;
    CentreScreenFormPositionLaftSpeedButton: TSpeedButton;
    SeparatorToolButton1: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    OpenFileSpeedButton: TSpeedButton;
    SaveFileSpeedButton: TSpeedButton;
    NewFileSpeedButton: TSpeedButton;
    ToolButton3: TToolButton;
    ToolTitlePanel: TPanel;
    HalfSpaceTitleBevel: TBevel;
    ToolTitleOuterBevel: TBevel;
    ToolTitleMiddleBevel: TBevel;
    ToolTitleInnerBevel: TBevel;
    ToolPanelLeftBevel: TBevel;
    Label18: TLabel;
    FielMenuItem: TMenuItem;
    NewFileMenuItem: TMenuItem;
    OpenFileMenuItem: TMenuItem;
    SaveFileMenuItem: TMenuItem;
    N15: TMenuItem;
    ExitMenuItem: TMenuItem;

    procedure ZoomMaskEditExit(Sender: TObject);
    procedure ZoomMaskEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LimitingVerticalFrameworkSpeedButtonClick(Sender: TObject);
    procedure DisplacedFocalFrontalFrameworkSpeedButtonClick(Sender: TObject);
    procedure LimitingHorizontalFrameworkSpeedButtonClick(Sender: TObject);
    procedure AxisSpeedButtonClick(Sender: TObject);
    procedure HorizontalReviewSpeedButtonClick(Sender: TObject);
    procedure VerticalReviewSpeedButtonClick(Sender: TObject);
    procedure FrontalReviewSpeedButtonClick(Sender: TObject);
    procedure HideLimitingFrameworkSpeedButtonClick(Sender: TObject);
    procedure LimitingFrontalFrameworkEditExit(Sender: TObject);
    procedure LimitingFrontalFrameworkEditKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure LimitingFrontalFrameworkUpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure LimitingHorizontalFrameworkEditExit(Sender: TObject);
    procedure LimitingHorizontalFrameworkEditKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure LimitingHorizontalFrameworkUpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure LimitingVerticalFrameworkEditExit(Sender: TObject);
    procedure LimitingVerticalFrameworkEditKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure LimitingVerticalFrameworkUpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure LimitingBetweenDistanceMaskEditExit(Sender: TObject);
    procedure LimitingBetweenDistanceMaskEditKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure LimitingXRadiusMaskEditExit(Sender: TObject);
    procedure LimitingXRadiusMaskEditKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure SourceFocalFrontalFrameworkSpeedButtonClick(Sender: TObject);
    procedure SourceFocalHorizontalFrameworkSpeedButtonClick(Sender: TObject);
    procedure DisplacedFocalHorizontalFrameworkSpeedButtonClick( Sender: TObject);
    procedure SourceFocalVerticalFrameworkSpeedButtonClick(Sender: TObject);
    procedure DisplacedFocalVerticalFrameworkSpeedButtonClick(Sender: TObject);
    procedure HideSourceFocalFrameworkSpeedButtonClick(Sender: TObject);
    procedure HideDisplacedFocalFrameworkSpeedButtonClick(Sender: TObject);
    procedure SourceFocalVerticalFrameworkEditExit(Sender: TObject);
    procedure SourceFocalVerticalFrameworkEditKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure SourceFocalVerticalFrameworkUpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure DisplacedFocalVerticalFrameworkEditExit(Sender: TObject);
    procedure DisplacedFocalVerticalFrameworkEditKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure DisplacedFocalVerticalFrameworkUpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure SourceFocalFrontalFrameworkEditExit(Sender: TObject);
    procedure SourceFocalFrontalFrameworkEditKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure SourceFocalFrontalFrameworkUpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure DisplacedFocalFrontalFrameworkEditExit(Sender: TObject);
    procedure DisplacedFocalFrontalFrameworkEditKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure DisplacedFocalFrontalFrameworkUpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure SourceFocalHorizontalFrameworkEditExit(Sender: TObject);
    procedure SourceFocalHorizontalFrameworkUpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure DisplacedFocalHorizontalFrameworkEditExit(Sender: TObject);
    procedure DisplacedFocalHorizontalFrameworkEditKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure DisplacedFocalHorizontalFrameworkUpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure LimitingFrontalFrameworkSpeedButtonClick(Sender: TObject);
    procedure SourceFocalHorizontalFrameworkEditKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure SourceFocalXRadiusMaskEditExit(Sender: TObject);
    procedure DisplacedFocalXRadiusMaskEditExit(Sender: TObject);
    procedure SourceFocalXRadiusMaskEditKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure DisplacedFocalXRadiusMaskEditKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure SourceFocalYRadiusMaskEditExit(Sender: TObject);
    procedure DisplacedFocalYRadiusMaskEditExit(Sender: TObject);
    procedure SourceFocalYRadiusMaskEditKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure DisplacedFocalYRadiusMaskEditKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure SourceFocalZRadiusMaskEditExit(Sender: TObject);
    procedure DisplacedFocalZRadiusMaskEditExit(Sender: TObject);
    procedure SourceFocalZRadiusMaskEditKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure DisplacedFocalZRadiusMaskEditKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure SourceFocalRadiusMaskEditExit(Sender: TObject);
    procedure SourceFocalRadiusMaskEditKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure DisplacedFocalRadiusMaskEditExit(Sender: TObject);
    procedure DisplacedFocalRadiusMaskEditKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure SourceFocalXMaskEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SourceFocalXMaskEditExit(Sender: TObject);
    procedure SourceFocalYMaskEditExit(Sender: TObject);
    procedure SourceFocalYMaskEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SourceFocalRadiusMaskEditKeyPress(Sender: TObject; var Key: Char);
    procedure SourceFocalZMaskEditExit(Sender: TObject);
    procedure SourceFocalZMaskEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FOXMaskEditExit(Sender: TObject);
    procedure FOXMaskEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FOYMaskEditExit(Sender: TObject);
    procedure FOYMaskEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FOZMaskEditExit(Sender: TObject);
    procedure FOZMaskEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure CentersLinesSpeedButtonClick(Sender: TObject);
    procedure FloodedSourceSurfaceSpeedButtonClick(Sender: TObject);
    procedure SourceSurfaceFrameworkSpeedButtonClick(Sender: TObject);
    procedure SourceSurfaceVertexSpeedButtonClick(Sender: TObject);
    procedure FloodedDisplacedSurfaceSpeedButtonClick(Sender: TObject);
    procedure DisplacedSurfaceFrameworkSpeedButtonClick(Sender: TObject);
    procedure DisplacedSurfaceVertexSpeedButtonClick(Sender: TObject);
    procedure HideSourceSurfaceSpeedButtonClick(Sender: TObject);
    procedure HideDisplacedSurfaceSpeedButtonClick(Sender: TObject);
    procedure SourceFocalLinesSpeedButtonClick(Sender: TObject);
    procedure DisplacedFocalLinesSpeedButtonClick(Sender: TObject);
    procedure HideFocalLinesSpeedButtonClick(Sender: TObject);

    // Недоступность объектов отображения поверхностей.
    procedure DisableDrawingSurfacesObjects(Sender: TObject);
    // Доступность объектов отображения поверхностей.
    procedure EnableDrawingSurfacesObjects(Sender: TObject);
    // Отображение проекций.
    procedure DrawProjection;
    // Проверка того, что данный шрифт установлен.
    function FontInstalled(FontName: String; var bFindFontDirectory: Boolean): Boolean;
    // Установка начальных значений параметров модели БМП.
    procedure SetInitialHalfSpace;
    // Вывод всех параметров фокусных эллипсоидов,
    // доступных для просмотра пользователя.
    procedure OutPutAllFocalEllipsoidsParameters;
    // Изменение значения радиуса эллипсоида.
    procedure ChangeEllipsoidRadius(var NewRadiusInMillimeters: Word;
                                    var RadiusMaskEdit: TMaskEdit;
                                        LowerRadiusLimitInMillimeters,
                                        UpperRadiusLimitInMillimeters: Word;
                                        EllipsoidAndAxisInGenitiveCaseString: String);
    // Изменение количества параллельных линий каркаса эллипсоида
    // при вводе значения в поле редактирования с клавиатуры.
    procedure ChangeNumberEllipsoidParallelFrameworkLinesIn1Octant(
      var ParallelFrameworkEdit: TEdit;
      var NewNumParallelFrameworkLinesIn1Octant: Byte;
          ParallelFrameworkLinesInGenitiveCaseString,
          EllipsoidInGenitiveCaseString: String);

    // Изменение количества рядов точек поверхности.
    procedure ChangeNumberSurfacePointsLines(
      var SurfacePointsLinesEdit: TEdit;
      var NewNumSurfacePointsLines: Byte;
          MinNumSurfacePointsLines,
          MaxNumSurfacePointsLines: Byte;
          LinesInGenitiveCaseString: String);

    // Установка искажённой смещённой поверхности при получении её точек,
    // параллельно перемещённой вдоль их центрофокусных прямых.
    procedure SetDistortedDisplacedSurface;


    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WhatIsBMPMenuItemClick(Sender: TObject);
    // procedure BMPApproachMenuItemClick(Sender: TObject);
    // procedure LORHypothesisMenuItemClick(Sender: TObject);
    // procedure ExperimentalSystemMenuItemClick(Sender: TObject);
    // procedure InterfaceMenuItemClick(Sender: TObject);
    procedure AboutProgramMenuItemClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ResizeHalfSpaceAreaSpeedButtonClick(Sender: TObject);
    procedure ResizeCorrectionsProtocolAreaSpeedButtonClick(
      Sender: TObject);
    procedure ShowGridsFormSpeedButtonClick(Sender: TObject);
    procedure CentreScreenFormPositionRightSpeedButtonClick(Sender: TObject);
    procedure SetGridsFormFocusSpeedButtonClick(Sender: TObject);
    procedure OpenFileSpeedButtonClick(Sender: TObject);
    procedure SaveFileSpeedButtonClick(Sender: TObject);
    procedure NewFileSpeedButtonClick(Sender: TObject);
    procedure PageControlDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure ExitMenuItemClick(Sender: TObject);

  private
    { Private declarations }

    // Контекст отображения OpenGL.
    ImageContextDescriptor: HGLRC;
    // Признак создания контекста отображения.
    bImageContextCreated: Boolean;

    // Установка формата пиксепля.
    procedure PixelFormat;

  public
    { Public declarations }
  end;

  // Компонент который в данный момент является развёрнутым, NoneMaximased,
  // когда все находятся в исходном состоянии.
  TMaximasedMainFormComponent = (CorrectionsProtocolMemoMaximased,
                                 HalfSpaceAreaMaximased,
                                 NoneMainFormMaximased);

const
  // Строка, информирующая о коррекции введённых данных.
  CorrectionsString = 'Введённые данные скорректированы';
  // Строки-отступы для полей шапок таблиц поверхностей.
  LeftGapsSurfaceStringGridString = '     ';
  TopGapsSurfaceStringGridString = '   ';
  GapsSurfaceAreaStringGridString = '       ';
  CorrectionsGapString = '      ';

  // Минимальные размеры рабочей области формы.
  ClientMinimizedWindowWidth = 679;
  ClientMinimizedWindowHeight = 636;

  // Каталог открытия и записи файлов по умолчанию.
  OpenSaveDialogInitialDirectory = 'Examples';
  // Опции диалогов сохранения и записи файлов.
  OpenSaveDialogOptions = [ofOverwritePrompt, ofHideReadOnly, ofNoValidate,
                           ofPathMustExist, ofNoReadOnlyReturn,
                           ofNoTestFileCreate, ofEnableSizing];
  // Файловые фильтры для диалогов сохранения и записи файлов.
  OpenSaveDialogFilter = 'Модель БМП (*.hsp; *.ssp)|*.ssp; *.ssp|' +
                         'Параметры модели БМП (*.hsp)|*.hsp|' +
                         'Точки исходной поверхности (*.ssp)|*.ssp';
  // стартовый фильтр для диалогов сохранения и записи файлов.
  OpenSaveDialogFilterIndex = 1;

var
  MainForm: TMainForm;

  // Максимальные размеры рабочей области формы.
  ClientMaximizedWindowWidth,
  ClientMaximizedWindowHeight: Integer;
  // Признак изменения размеров окна.
  bChangedWindowSize: Boolean;
  // Изображение, содержащее изменения размеров областей окна.
  ResizeAreaBitMap: TBitMap;
  // Компонент который в данный момент является развёрнутым, NoneMaximased,
  // когда все находятся в исходном состоянии.
  MaximasedMainFormComponent: TMaximasedMainFormComponent;
  // Номер N файла с названием 'Модель_N', содержащим основные параметры объектов БМП.
  StartModelNameIndex: Byte;
  // Изорражения на страницах настроек.
  PageControlImages: array[0..3] of TBitMap;


//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

implementation

{$R *.dfm}

uses
  // Glance-модули.
  Files_Unit, AboutGlanceForm_Unit, ProjectionImage_Unit,
  Base_Unit, Integration_Unit, GridsForm_Unit, Ellipsoid_Unit,
  FocalEllipsoid_Unit, Surface_Unit;


// Просмотр горизонтальной плоскости XOY.
procedure TMainForm.HorizontalReviewSpeedButtonClick(Sender: TObject);
begin // TMainForm.HorizontalReviewSpeedButtonClick
  StartRotationPlane:=XOYStartRotationPlane;

  XAngleMouseButtonLeft:=0;
  YAngleMouseButtonLeft:=0;
  ZAngleMouseButtonLeft:=0;

  XStartAngle:=0;
  YStartAngle:=180;
  ZStartAngle:=0;

  Repaint;
end; // TMainForm.HorizontalReviewSpeedButtonClick

// Просмотр вертикальной плоскости YOZ.
procedure TMainForm.VerticalReviewSpeedButtonClick(Sender: TObject);
begin // TMainForm.VerticalReviewSpeedButtonClick
  StartRotationPlane:=YOZStartRotationPlane;

  XAngleMouseButtonLeft:=0;
  YAngleMouseButtonLeft:=0;
  ZAngleMouseButtonLeft:=0;

  XStartAngle:=90;
  YStartAngle:=180;
  ZStartAngle:=90;

  Repaint;
end; // TMainForm.VerticalReviewSpeedButtonClick

// Просмотр фронтальной плоскости XOZ.
procedure TMainForm.FrontalReviewSpeedButtonClick(Sender: TObject);
begin // TMainForm.FrontalReviewSpeedButtonClic
  StartRotationPlane:=XOZStartRotationPlane;

  XAngleMouseButtonLeft:=0;
  YAngleMouseButtonLeft:=0;
  ZAngleMouseButtonLeft:=0;

  XStartAngle:=90;
  YStartAngle:=180;
  ZStartAngle:=0;

  Repaint;
end; // TMainForm.FrontalReviewSpeedButtonClic

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// Изменение масштаба.
procedure TMainForm.ZoomMaskEditExit(Sender: TObject);
begin // TMainForm.ZoomMaskEditExit
  StatusBar.Panels[0].Text:='';
  try
    // Удаление пробелов в тексте.
    DelMaskEditTextGaps(ZoomMaskEdit);

    Zoom:=StrToInt(ZoomMaskEdit.Text);
    if Zoom < MinZoom
      then begin
             Zoom:=MinZoom;
             ZoomMaskEdit.Text:=IntToStr(Zoom);
             CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
               'Значение масштаба, '+
               'меньшее допустимого в пределах ['+
               IntToStr(MinZoom)+'%; '+IntToStr(MaxZoom)+
               '%], исправлено на минимальное!');
             StatusBar.Panels[0].Text:=CorrectionsString;
           end
      else if Zoom > MaxZoom
             then begin
                    Zoom:=MaxZoom;
                    ZoomMaskEdit.Text:=IntToStr(Zoom);
                    CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
                      'Значение масштаба, '+
                      'превысившее допустимое в пределах ['+
                      IntToStr(MinZoom)+'%; '+IntToStr(MaxZoom)+
                      '%], исправлено на максимальное!');
                    StatusBar.Panels[0].Text:=CorrectionsString;
                  end;
  except
    // При вводе пустой строки.
    on EConvertError do
      begin
        Zoom:=100;
        ZoomMaskEdit.Text:='100';
        CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
          'Некорректное значение масштаба '+
          'исправлено на исходное!');
        StatusBar.Panels[0].Text:=CorrectionsString;
      end;
  end;

  Repaint;
end; // TMainForm.ZoomMaskEditExit

// Изменение масштаба при нажатии <Enter>.
procedure TMainForm.ZoomMaskEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin // TMainForm.ZoomMaskEditKeyDown
  if Key = VK_RETURN
    then MainForm.ZoomMaskEditExit(MainForm);
end; // TMainForm.ZoomMaskEditKeyDown

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Отображение фронтальных линий каркаса предельного эллипсоида.
procedure TMainForm.LimitingFrontalFrameworkSpeedButtonClick(Sender: TObject);
begin // TMainForm.LimitingFrontalFrameworkSpeedButtonClick
  // Изменение отображения пареллельных линий каркаса эллипсоида:
  // будучи отображёнными, они сокроются, а, скрытые, они будут отображены.
  ChangeViewingEllipsoidParallelFrameworkLines(
    LimitingEllipsoid.FrameworkLinesIn1Octant.bAnyLinesDraw,
    LimitingEllipsoid.FrameworkLinesIn1Octant.Frontal.bDraw,
    LimitingFrontalFrameworkSpeedButton,
    LimitingVerticalFrameworkSpeedButton,
    LimitingHorizontalFrameworkSpeedButton,
    LimitingFrontalFrameworkMenuItem,
    LimitingFrameworkMenuItem,
    HideLimitingFrameworkSpeedButton,
    LimitingFrontalFrameworkEdit,
    LimitingFrontalFrameworkUpDown);
end; // TMainForm.LimitingFrontalFrameworkSpeedButtonClick

// Отображение горизонтальных линий каркаса предельного эллипсоида.
procedure TMainForm.LimitingHorizontalFrameworkSpeedButtonClick(Sender: TObject);
begin // TMainForm.LimitingHorizontalFrameworkSpeedButtonClick
  // Изменение отображения пареллельных линий каркаса эллипсоида:
  // будучи отображёнными, они сокроются, а, скрытые, они будут отображены.
  ChangeViewingEllipsoidParallelFrameworkLines(
    LimitingEllipsoid.FrameworkLinesIn1Octant.bAnyLinesDraw,
    LimitingEllipsoid.FrameworkLinesIn1Octant.Horizontal.bDraw,
    LimitingHorizontalFrameworkSpeedButton,
    LimitingVerticalFrameworkSpeedButton,
    LimitingFrontalFrameworkSpeedButton,
    LimitingHorizontalFrameworkMenuItem,
    LimitingFrameworkMenuItem,
    HideLimitingFrameworkSpeedButton,
    LimitingHorizontalFrameworkEdit,
    LimitingHorizontalFrameworkUpDown);
end; // TMainForm.LimitingHorizontalFrameworkSpeedButtonClick

// Отображение вертикальных линий каркаса предельного эллипсоида.
procedure TMainForm.LimitingVerticalFrameworkSpeedButtonClick(Sender: TObject);
begin // TMainForm.LimitingVerticalFrameworkSpeedButtonClick
  // Изменение отображения пареллельных линий каркаса эллипсоида:
  // будучи отображёнными, они сокроются, а, скрытые, они будут отображены.
  ChangeViewingEllipsoidParallelFrameworkLines(
    LimitingEllipsoid.FrameworkLinesIn1Octant.bAnyLinesDraw,
    LimitingEllipsoid.FrameworkLinesIn1Octant.Vertical.bDraw,
    LimitingVerticalFrameworkSpeedButton,
    LimitingFrontalFrameworkSpeedButton,
    LimitingHorizontalFrameworkSpeedButton,
    LimitingVerticalFrameworkMenuItem,
    LimitingFrameworkMenuItem,
    HideLimitingFrameworkSpeedButton,
    LimitingVerticalFrameworkEdit,
    LimitingVerticalFrameworkUpDown);
end; // TMainForm.LimitingVerticalFrameworkSpeedButtonClick

//******************************************************************************

// Отображение фронтальных линий каркаса эллипсоида исходного фокуса.
procedure TMainForm.SourceFocalFrontalFrameworkSpeedButtonClick(Sender: TObject);
begin // TMainForm.SourceFocalFrontalFrameworkSpeedButtonClick
  // Изменение отображения пареллельных линий каркаса эллипсоида:
  // будучи отображёнными, они сокроются, а, скрытые, они будут отображены.
  ChangeViewingEllipsoidParallelFrameworkLines(
    SourceFocalEllipsoid.FrameworkLinesIn1Octant.bAnyLinesDraw,
    SourceFocalEllipsoid.FrameworkLinesIn1Octant.Frontal.bDraw,
    SourceFocalFrontalFrameworkSpeedButton,
    SourceFocalVerticalFrameworkSpeedButton,
    SourceFocalHorizontalFrameworkSpeedButton,
    SourceFocalFrontalFrameworkMenuItem,
    SourceFocalFrameworkMenuItem,
    HideSourceFocalFrameworkSpeedButton,
    SourceFocalFrontalFrameworkEdit,
    SourceFocalFrontalFrameworkUpDown);
end; // TMainForm.SourceFocalFrontalFrameworkSpeedButtonClick

// Отображение горизонтальных линий каркаса эллипсоида исходного фокуса.
procedure TMainForm.SourceFocalHorizontalFrameworkSpeedButtonClick(Sender: TObject);
begin // TMainForm.SourceFocalHorizontalFrameworkSpeedButtonClick
  // Изменение отображения пареллельных линий каркаса эллипсоида:
  // будучи отображёнными, они сокроются, а, скрытые, они будут отображены.
  ChangeViewingEllipsoidParallelFrameworkLines(
    SourceFocalEllipsoid.FrameworkLinesIn1Octant.bAnyLinesDraw,
    SourceFocalEllipsoid.FrameworkLinesIn1Octant.Horizontal.bDraw,
    SourceFocalHorizontalFrameworkSpeedButton,
    SourceFocalVerticalFrameworkSpeedButton,
    SourceFocalFrontalFrameworkSpeedButton,
    SourceFocalHorizontalFrameworkMenuItem,
    SourceFocalFrameworkMenuItem,
    HideSourceFocalFrameworkSpeedButton,
    SourceFocalHorizontalFrameworkEdit,
    SourceFocalHorizontalFrameworkUpDown);
end; // TMainForm.SourceFocalHorizontalFrameworkSpeedButtonClick

// Отображение вертикальных линий каркаса эллипсоида исходного фокуса.
procedure TMainForm.SourceFocalVerticalFrameworkSpeedButtonClick(Sender: TObject);
begin // TMainForm.SourceFocalVerticalFrameworkSpeedButtonClick
  // Изменение отображения пареллельных линий каркаса эллипсоида:
  // будучи отображёнными, они сокроются, а, скрытые, они будут отображены.
  ChangeViewingEllipsoidParallelFrameworkLines(
    SourceFocalEllipsoid.FrameworkLinesIn1Octant.bAnyLinesDraw,
    SourceFocalEllipsoid.FrameworkLinesIn1Octant.Vertical.bDraw,
    SourceFocalVerticalFrameworkSpeedButton,
    SourceFocalFrontalFrameworkSpeedButton,
    SourceFocalHorizontalFrameworkSpeedButton,
    SourceFocalVerticalFrameworkMenuItem,
    SourceFocalFrameworkMenuItem,
    HideSourceFocalFrameworkSpeedButton,
    SourceFocalVerticalFrameworkEdit,
    SourceFocalVerticalFrameworkUpDown);
end; // TMainForm.SourceFocalVerticalFrameworkSpeedButtonClick

//******************************************************************************

// Отображение фронтальных линий каркаса эллипсоида смещённого фокуса.
procedure TMainForm.DisplacedFocalFrontalFrameworkSpeedButtonClick(Sender: TObject);
begin // TMainForm.DisplacedFocalFrontalFrameworkSpeedButtonClick
  // Изменение отображения пареллельных линий каркаса эллипсоида:
  // будучи отображёнными, они сокроются, а, скрытые, они будут отображены.
  ChangeViewingEllipsoidParallelFrameworkLines(
    DisplacedFocalEllipsoid.FrameworkLinesIn1Octant.bAnyLinesDraw,
    DisplacedFocalEllipsoid.FrameworkLinesIn1Octant.Frontal.bDraw,
    DisplacedFocalFrontalFrameworkSpeedButton,
    DisplacedFocalVerticalFrameworkSpeedButton,
    DisplacedFocalHorizontalFrameworkSpeedButton,
    DisplacedFocalFrontalFrameworkMenuItem,
    DisplacedFocalFrameworkMenuItem,
    HideDisplacedFocalFrameworkSpeedButton,
    DisplacedFocalFrontalFrameworkEdit,
    DisplacedFocalFrontalFrameworkUpDown);
end; // TMainForm.DisplacedFocalFrontalFrameworkSpeedButtonClick

// Отображение горизонтальных линий каркаса эллипсоида смещённого фокуса.
procedure TMainForm.DisplacedFocalHorizontalFrameworkSpeedButtonClick(Sender: TObject);
begin // TMainForm.DisplacedFocalHorizontalFrameworkSpeedButtonClick
  // Изменение отображения пареллельных линий каркаса эллипсоида:
  // будучи отображёнными, они сокроются, а, скрытые, они будут отображены.
  ChangeViewingEllipsoidParallelFrameworkLines(
    DisplacedFocalEllipsoid.FrameworkLinesIn1Octant.bAnyLinesDraw,
    DisplacedFocalEllipsoid.FrameworkLinesIn1Octant.Horizontal.bDraw,
    DisplacedFocalHorizontalFrameworkSpeedButton,
    DisplacedFocalVerticalFrameworkSpeedButton,
    DisplacedFocalFrontalFrameworkSpeedButton,
    DisplacedFocalHorizontalFrameworkMenuItem,
    DisplacedFocalFrameworkMenuItem,
    HideDisplacedFocalFrameworkSpeedButton,
    DisplacedFocalHorizontalFrameworkEdit,
    DisplacedFocalHorizontalFrameworkUpDown);
end; // TMainForm.DisplacedFocalHorizontalFrameworkSpeedButtonClick

// Отображение вертикальных линий каркаса эллипсоида смещённого фокуса.
procedure TMainForm.DisplacedFocalVerticalFrameworkSpeedButtonClick(Sender: TObject);
begin // TMainForm.DisplacedFocalVerticalFrameworkSpeedButtonClick
  // Изменение отображения пареллельных линий каркаса эллипсоида:
  // будучи отображёнными, они сокроются, а, скрытые, они будут отображены.
  ChangeViewingEllipsoidParallelFrameworkLines(
    DisplacedFocalEllipsoid.FrameworkLinesIn1Octant.bAnyLinesDraw,
    DisplacedFocalEllipsoid.FrameworkLinesIn1Octant.Vertical.bDraw,
    DisplacedFocalVerticalFrameworkSpeedButton,
    DisplacedFocalFrontalFrameworkSpeedButton,
    DisplacedFocalHorizontalFrameworkSpeedButton,
    DisplacedFocalVerticalFrameworkMenuItem,
    DisplacedFocalFrameworkMenuItem,
    HideDisplacedFocalFrameworkSpeedButton,
    DisplacedFocalVerticalFrameworkEdit,
    DisplacedFocalVerticalFrameworkUpDown);
end; // TMainForm.DisplacedFocalVerticalFrameworkSpeedButtonClick

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Не отображать линии каркаса предельного эллипсоида.
procedure TMainForm.HideLimitingFrameworkSpeedButtonClick(Sender: TObject);
begin // TMainForm.HideLimitingFrameworkSpeedButtonClick
  // Изменение неотображения линий каркаса эллипсоида:
  // будучи неотображёнными, они проявятся, а, отображённые, они будут сокрыты.
  ChangeHidingEllipsoidFrameworkLines(
    LimitingEllipsoid.FrameworkLinesIn1Octant.bAnyLinesDraw,
    HideLimitingFrameworkSpeedButton,
    LimitingFrameworkMenuItem,

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
    LimitingVerticalFrameworkUpDown);
end; // TMainForm.HideLimitingFrameworkSpeedButtonClick

// Не отображать линии каркаса эллипсоида исходного фокуса.
procedure TMainForm.HideSourceFocalFrameworkSpeedButtonClick(Sender: TObject);
begin // TMainForm.HideSourceFocalFrameworkSpeedButtonClick
  // Изменение неотображения линий каркаса эллипсоида:
  // будучи неотображёнными, они проявятся, а, отображённые, они будут сокрыты.
  ChangeHidingEllipsoidFrameworkLines(
    SourceFocalEllipsoid.FrameworkLinesIn1Octant.bAnyLinesDraw,
    HideSourceFocalFrameworkSpeedButton,
    SourceFocalFrameworkMenuItem,

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
    SourceFocalVerticalFrameworkUpDown);
end; // TMainForm.HideSourceFocalFrameworkSpeedButtonClick

// Не отображать линии каркаса эллипсоида смещённого фокуса.
procedure TMainForm.HideDisplacedFocalFrameworkSpeedButtonClick(Sender: TObject);
begin // TMainForm.HideDisplacedFocalFrameworkSpeedButtonClick
  // Изменение неотображения линий каркаса эллипсоида:
  // будучи неотображёнными, они проявятся, а, отображённые, они будут сокрыты.
  ChangeHidingEllipsoidFrameworkLines(
    DisplacedFocalEllipsoid.FrameworkLinesIn1Octant.bAnyLinesDraw,
    HideDisplacedFocalFrameworkSpeedButton,
    DisplacedFocalFrameworkMenuItem,

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
    DisplacedFocalVerticalFrameworkUpDown);
end; // TMainForm.HideDisplacedFocalFrameworkSpeedButtonClick

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Изменение количества параллельных линий каркаса эллипсоида
// при вводе значения в поле редактирования с клавиатуры.
procedure TMainForm.ChangeNumberEllipsoidParallelFrameworkLinesIn1Octant(
  var ParallelFrameworkEdit: TEdit;
  var NewNumParallelFrameworkLinesIn1Octant: Byte;
      ParallelFrameworkLinesInGenitiveCaseString,
      EllipsoidInGenitiveCaseString: String);

// ParallelFrameworkEdit - поле, редактирующее количество параллельных линий каркаса эллипсоида.
// NewNumParallelFrameworkLinesIn1Octant - новое количество параллельных линий каркаса в одном октанте.
// ParallelFrameworkLinesInGenitiveCaseString - строка названия
//         параллельных линий каркаса эллипсоида в родительном падеже.
// EllipsoidInGenitiveCaseString - строка названия эллипсоида в родительном падеже.

var
  // Строка-копия.
  TextString: String;

begin // TMainForm.ChangeNumberEllipsoidParallelFrameworkLinesIn1Octant
  StatusBar.Panels[0].Text:='';
  try
    // Удаление пробелов в тексте.
    // Создание строки-копии.
    TextString:=ParallelFrameworkEdit.Text;
    // Удаление пробелов в строке.
    DelStringGaps(TextString);
    // Форматирование строки-оригинала.
    ParallelFrameworkEdit.Text:=TextString;

    NewNumParallelFrameworkLinesIn1Octant:=
      StrToInt(ParallelFrameworkEdit.Text);

    if NewNumParallelFrameworkLinesIn1Octant<
         MinNumEllipsoidParallelFrameworkLinesInOctant
      then begin
             NewNumParallelFrameworkLinesIn1Octant:=
               MinNumEllipsoidParallelFrameworkLinesInOctant;
             ParallelFrameworkEdit.Text:=
               IntToStr(NewNumParallelFrameworkLinesIn1Octant);
             CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
               'Количество '+ParallelFrameworkLinesInGenitiveCaseString+
               ' линий каркаса в одном октанте '+EllipsoidInGenitiveCaseString+
               ', меньшее допустимого '+
               'в пределах ['+IntToStr(MinNumEllipsoidParallelFrameworkLinesInOctant)+
               '; '+IntToStr(MaxNumEllipsoidParallelFrameworkLinesInOctant)+'], '+
               'исправлено на минимальное!');
             StatusBar.Panels[0].Text:=CorrectionsString;
           end // if NewNumParallelFrameworkLinesIn1Octant<

      else if NewNumParallelFrameworkLinesIn1Octant>
                MaxNumEllipsoidParallelFrameworkLinesInOctant
             then begin
                    NewNumParallelFrameworkLinesIn1Octant:=
                      MaxNumEllipsoidParallelFrameworkLinesInOctant;
                    ParallelFrameworkEdit.Text:=
                      IntToStr(NewNumParallelFrameworkLinesIn1Octant);
                    CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
                      'Количество '+ParallelFrameworkLinesInGenitiveCaseString+
                      ' линий каркаса в одном октанте '+
                      EllipsoidInGenitiveCaseString+', превысившее допустимое '+
                      'в пределах ['+IntToStr(MinNumEllipsoidParallelFrameworkLinesInOctant)+
                      '; '+IntToStr(MaxNumEllipsoidParallelFrameworkLinesInOctant)+'], '+
                      'исправлено на максимальое!');
                    StatusBar.Panels[0].Text:=CorrectionsString;
                  end; // if NewNumParallelFrameworkLinesIn1Octant>

  except
    // При вводе пустой строки.
    on EConvertError do
      begin
        NewNumParallelFrameworkLinesIn1Octant:=
          MinNumEllipsoidParallelFrameworkLinesInOctant;
        ParallelFrameworkEdit.Text:=
          IntToStr(NewNumParallelFrameworkLinesIn1Octant);
        CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
          'Некорректное значение количества '+
          ParallelFrameworkLinesInGenitiveCaseString+
          ' линий каркаса в одном октанте '+
          EllipsoidInGenitiveCaseString+' исправлено на исходное!');
        StatusBar.Panels[0].Text:=CorrectionsString;
      end; // on EConvertError
  end; // except
end; // TMainForm.ChangeNumberEllipsoidParallelFrameworkLinesIn1Octant

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// Изменение количества фронтальных линий каркаса предельного эллипсоида.
procedure TMainForm.LimitingFrontalFrameworkEditExit(Sender: TObject);
var
  // Новое количество фронтальных линий каркаса.
  NewNumFrontalFrameworkLinesIn1Octant: Byte;
begin // TMainForm.LimitingFrontalFrameworkEditExit
  // Изменение количества параллельных линий каркаса эллипсоида
  // при вводе значения в поле редактирования с клавиатуры.
  ChangeNumberEllipsoidParallelFrameworkLinesIn1Octant(
    LimitingFrontalFrameworkEdit,NewNumFrontalFrameworkLinesIn1Octant,
    'фронтальных','предельного эллипсоида');

  with LimitingEllipsoid.FrameworkLinesIn1Octant do
    begin
      LimitingEllipsoid.ReSetFrameworkLinesIn1Octant(
        NewNumFrontalFrameworkLinesIn1Octant,
        Horizontal.Number, Vertical.Number);
    end; //  with LimitingEllipsoid.FrameworkLinesIn1Octant

  Repaint;
end; // TMainForm.LimitingFrontalFrameworkEditExit

// Изменение количества горизонтальных линий каркаса предельного эллипсоида.
procedure TMainForm.LimitingHorizontalFrameworkEditExit(Sender: TObject);
var
  // Новое количество горизонтальных линий каркаса.
  NewNumHorizontalFrameworkLinesIn1Octant: Byte;
begin // TMainForm.LimitingHorizontalFrameworkEditExit
  // Изменение количества параллельных линий каркаса эллипсоида
  // при вводе значения в поле редактирования с клавиатуры.
  ChangeNumberEllipsoidParallelFrameworkLinesIn1Octant(
    LimitingHorizontalFrameworkEdit,NewNumHorizontalFrameworkLinesIn1Octant,
    'горизонтальных','предельного эллипсоида');

  with LimitingEllipsoid.FrameworkLinesIn1Octant do
    begin
      LimitingEllipsoid.ReSetFrameworkLinesIn1Octant(
        Frontal.Number,
        NewNumHorizontalFrameworkLinesIn1Octant,
        Vertical.Number);
    end; //  with LimitingEllipsoid.FrameworkLinesIn1Octant

  Repaint;
end; // TMainForm.LimitingHorizontalFrameworkEditExit

// Изменение количества вертикальных линий каркаса предельного эллипсоида.
procedure TMainForm.LimitingVerticalFrameworkEditExit(Sender: TObject);
var
  // Новое количество вертикальных линий каркаса.
  NewNumVerticalFrameworkLinesIn1Octant: Byte;
begin // TMainForm.LimitingVerticalFrameworkEditExit
  // Изменение количества параллельных линий каркаса эллипсоида
  // при вводе значения в поле редактирования с клавиатуры.
  ChangeNumberEllipsoidParallelFrameworkLinesIn1Octant(
    LimitingVerticalFrameworkEdit,NewNumVerticalFrameworkLinesIn1Octant,
    'вертикальных','предельного эллипсоида');

  with LimitingEllipsoid.FrameworkLinesIn1Octant do
    begin
      LimitingEllipsoid.ReSetFrameworkLinesIn1Octant(
        Frontal.Number, Horizontal.Number,
        NewNumVerticalFrameworkLinesIn1Octant);
    end; //  with LimitingEllipsoid.FrameworkLinesIn1Octant

  Repaint;
end; // TMainForm.LimitingVerticalFrameworkEditExit

//******************************************************************************

// Изменение количества фронтальных линий каркаса эллипсоида исходного фокуса.
procedure TMainForm.SourceFocalFrontalFrameworkEditExit(Sender: TObject);
var
  // Новое количество фронтальных линий каркаса.
  NewNumFrontalFrameworkLinesIn1Octant: Byte;
begin // TMainForm.SourceFocalFrontalFrameworkEditExit
  // Изменение количества параллельных линий каркаса эллипсоида
  // при вводе значения в поле редактирования с клавиатуры.
  ChangeNumberEllipsoidParallelFrameworkLinesIn1Octant(
    SourceFocalFrontalFrameworkEdit,NewNumFrontalFrameworkLinesIn1Octant,
    'фронтальных','эллипсоида исходного фокуса');

  with SourceFocalEllipsoid.FrameworkLinesIn1Octant do
    begin
      SourceFocalEllipsoid.ReSetFrameworkLinesIn1Octant(
        NewNumFrontalFrameworkLinesIn1Octant,
        Horizontal.Number, Vertical.Number);
    end; //  with SourceFocalEllipsoid.FrameworkLinesIn1Octant

  Repaint;
end; // TMainForm.SourceFocalFrontalFrameworkEditExit

// Изменение количества горизонтальных линий каркаса эллипсоида исходного фокуса.
procedure TMainForm.SourceFocalHorizontalFrameworkEditExit(Sender: TObject);
var
  // Новое количество горизонтальных линий каркаса.
  NewNumHorizontalFrameworkLinesIn1Octant: Byte;
begin // TMainForm.SourceFocalHorizontalFrameworkEditExit
  // Изменение количества параллельных линий каркаса эллипсоида
  // при вводе значения в поле редактирования с клавиатуры.
  ChangeNumberEllipsoidParallelFrameworkLinesIn1Octant(
    SourceFocalHorizontalFrameworkEdit,NewNumHorizontalFrameworkLinesIn1Octant,
    'горизонтальных','эллипсоида исходного фокуса');

  with SourceFocalEllipsoid.FrameworkLinesIn1Octant do
    begin
      SourceFocalEllipsoid.ReSetFrameworkLinesIn1Octant(
        Frontal.Number,
        NewNumHorizontalFrameworkLinesIn1Octant,
        Vertical.Number);
    end; //  with SourceFocalEllipsoid.FrameworkLinesIn1Octant

  Repaint;
end; // TMainForm.SourceFocalHorizontalFrameworkEditExit

// Изменение количества вертикальных линий каркаса эллипсоида исходного фокуса.
procedure TMainForm.SourceFocalVerticalFrameworkEditExit(Sender: TObject);
var
  // Новое количество вертикальных линий каркаса.
  NewNumVerticalFrameworkLinesIn1Octant: Byte;
begin // TMainForm.SourceFocalVerticalFrameworkEditExit
  // Изменение количества параллельных линий каркаса эллипсоида
  // при вводе значения в поле редактирования с клавиатуры.
  ChangeNumberEllipsoidParallelFrameworkLinesIn1Octant(
    SourceFocalVerticalFrameworkEdit,NewNumVerticalFrameworkLinesIn1Octant,
    'вертикальных','эллипсоида исходного фокуса');

  with SourceFocalEllipsoid.FrameworkLinesIn1Octant do
    begin
      SourceFocalEllipsoid.ReSetFrameworkLinesIn1Octant(
        Frontal.Number, Horizontal.Number,
        NewNumVerticalFrameworkLinesIn1Octant);
    end; //  with SourceFocalEllipsoid.FrameworkLinesIn1Octant

  Repaint;
end; // TMainForm.SourceFocalVerticalFrameworkEditExit

//******************************************************************************

// Изменение количества фронтальных линий каркаса эллипсоида смещённого фокуса.
procedure TMainForm.DisplacedFocalFrontalFrameworkEditExit(Sender: TObject);
var
  // Новое количество фронтальных линий каркаса.
  NewNumFrontalFrameworkLinesIn1Octant: Byte;
begin // TMainForm.DisplacedFocalFrontalFrameworkEditExit
  // Изменение количества параллельных линий каркаса эллипсоида
  // при вводе значения в поле редактирования с клавиатуры.
  ChangeNumberEllipsoidParallelFrameworkLinesIn1Octant(
    DisplacedFocalFrontalFrameworkEdit,NewNumFrontalFrameworkLinesIn1Octant,
    'фронтальных','эллипсоида смещённого фокуса');

  with DisplacedFocalEllipsoid.FrameworkLinesIn1Octant do
    begin
      DisplacedFocalEllipsoid.ReSetFrameworkLinesIn1Octant(
        NewNumFrontalFrameworkLinesIn1Octant,
        Horizontal.Number, Vertical.Number);
    end; //  with DisplacedFocalEllipsoid.FrameworkLinesIn1Octant

  Repaint;
end; // TMainForm.DisplacedFocalFrontalFrameworkEditExit

// Изменение количества горизонтальных линий каркаса эллипсоида смещённого фокуса.
procedure TMainForm.DisplacedFocalHorizontalFrameworkEditExit(Sender: TObject);
var
  // Новое количество горизонтальных линий каркаса.
  NewNumHorizontalFrameworkLinesIn1Octant: Byte;
begin // TMainForm.DisplacedFocalHorizontalFrameworkEditExit
  // Изменение количества параллельных линий каркаса эллипсоида
  // при вводе значения в поле редактирования с клавиатуры.
  ChangeNumberEllipsoidParallelFrameworkLinesIn1Octant(
    DisplacedFocalHorizontalFrameworkEdit,NewNumHorizontalFrameworkLinesIn1Octant,
    'горизонтальных','эллипсоида смещённого фокуса');

  with DisplacedFocalEllipsoid.FrameworkLinesIn1Octant do
    begin
      DisplacedFocalEllipsoid.ReSetFrameworkLinesIn1Octant(
        Frontal.Number,
        NewNumHorizontalFrameworkLinesIn1Octant,
        Vertical.Number);
    end; //  with DisplacedFocalEllipsoid.FrameworkLinesIn1Octant

  Repaint;
end; // TMainForm.DisplacedFocalHorizontalFrameworkEditExit

// Изменение количества вертикальных линий каркаса эллипсоида смещённого фокуса.
procedure TMainForm.DisplacedFocalVerticalFrameworkEditExit(Sender: TObject);
var
  // Новое количество вертикальных линий каркаса.
  NewNumVerticalFrameworkLinesIn1Octant: Byte;
begin // TMainForm.DisplacedFocalVerticalFrameworkEditExit
  // Изменение количества параллельных линий каркаса эллипсоида
  // при вводе значения в поле редактирования с клавиатуры.
  ChangeNumberEllipsoidParallelFrameworkLinesIn1Octant(
    DisplacedFocalVerticalFrameworkEdit,NewNumVerticalFrameworkLinesIn1Octant,
    'вертикальных','эллипсоида смещённого фокуса');

  with DisplacedFocalEllipsoid.FrameworkLinesIn1Octant do
    begin
      DisplacedFocalEllipsoid.ReSetFrameworkLinesIn1Octant(
        Frontal.Number, Horizontal.Number,
        NewNumVerticalFrameworkLinesIn1Octant);
    end; //  with DisplacedFocalEllipsoid.FrameworkLinesIn1Octant

  Repaint;
end; // TMainForm.DisplacedFocalVerticalFrameworkEditExit

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

// Изменение количества фронтальных линий каркаса предельного эллипсоида
// при нажатии <Enter> в метке.
procedure TMainForm.LimitingFrontalFrameworkEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.LimitingFrontalFrameworkEditKeyDown
  if Key = VK_RETURN
    then MainForm.LimitingFrontalFrameworkEditExit(MainForm);
end; // TMainForm.LimitingFrontalFrameworkEditKeyDown

// Изменение количества горизонтальных линий каркаса предельного эллипсоида
// при нажатии <Enter> в метке.
procedure TMainForm.LimitingHorizontalFrameworkEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.LimitingHorizontalFrameworkEditKeyDown
  if Key = VK_RETURN
    then MainForm.LimitingHorizontalFrameworkEditExit(MainForm);
end; // TMainForm.LimitingHorizontalFrameworkEditKeyDown

// Изменение количества вертикальных линий каркаса предельного эллипсоида
// при нажатии <Enter> в метке.
procedure TMainForm.LimitingVerticalFrameworkEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.LimitingVerticalFrameworkEditKeyDown
  if Key = VK_RETURN
    then MainForm.LimitingVerticalFrameworkEditExit(MainForm);
end; // TMainForm.LimitingVerticalFrameworkEditKeyDown

//******************************************************************************

// Изменение количества фронтальных линий каркаса эллипсоида смещённого фокуса
// при нажатии <Enter> в метке.
procedure TMainForm.SourceFocalFrontalFrameworkEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.SourceFocalFrontalFrameworkEditKeyDown
  if Key = VK_RETURN
    then MainForm.SourceFocalFrontalFrameworkEditExit(MainForm);
end; // TMainForm.SourceFocalFrontalFrameworkEditKeyDown

// Изменение количества горизонтальных линий каркаса эллипсоида смещённого фокуса
// при нажатии <Enter> в метке.
procedure TMainForm.SourceFocalHorizontalFrameworkEditKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin // TMainForm.SourceFocalHorizontalFrameworkEditKeyDown
  if Key = VK_RETURN
    then MainForm.SourceFocalHorizontalFrameworkEditExit(MainForm);
end; // TMainForm.SourceFocalHorizontalFrameworkEditKeyDown

// Изменение количества вертикальных линий каркаса эллипсоида исходного фокуса
// при нажатии <Enter> в метке.
procedure TMainForm.SourceFocalVerticalFrameworkEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.SourceFocalVerticalFrameworkEditKeyDown
  if Key = VK_RETURN
    then MainForm.SourceFocalVerticalFrameworkEditExit(MainForm);
end; // TMainForm.SourceFocalVerticalFrameworkEditKeyDown

//******************************************************************************

// Изменение количества фронтальных линий каркаса эллипсоида смещённого фокуса
// при нажатии <Enter> в метке.
procedure TMainForm.DisplacedFocalFrontalFrameworkEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.DisplacedFocalFrontalFrameworkEditKeyDown
  if Key = VK_RETURN
    then MainForm.DisplacedFocalFrontalFrameworkEditExit(MainForm);
end; // TMainForm.DisplacedFocalFrontalFrameworkEditKeyDown

// Изменение количества горизонтальных линий каркаса эллипсоида смещённого фокуса
// при нажатии <Enter> в метке.
procedure TMainForm.DisplacedFocalHorizontalFrameworkEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.DisplacedFocalHorizontalFrameworkEditKeyDown
  if Key = VK_RETURN
    then MainForm.DisplacedFocalHorizontalFrameworkEditExit(MainForm);
end; // TMainForm.DisplacedFocalHorizontalFrameworkEditKeyDown

// Изменение количества вертикальных линий каркаса эллипсоида смещённого фокуса
// при нажатии <Enter> в метке.
procedure TMainForm.DisplacedFocalVerticalFrameworkEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.DisplacedFocalVerticalFrameworkEditKeyDown
  if Key = VK_RETURN
    then MainForm.DisplacedFocalVerticalFrameworkEditExit(MainForm);
end; // TMainForm.DisplacedFocalVerticalFrameworkEditKeyDown

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

// Изменение количества фронтальных линий каркаса предельного эллипсоида
// с помощью кнопок переключения рядом с меткой.
procedure TMainForm.LimitingFrontalFrameworkUpDownClick(Sender: TObject;
  Button: TUDBtnType);
begin // TMainForm.LimitingFrontalFrameworkUpDownClick
  MainForm.LimitingFrontalFrameworkEditExit(MainForm);
end; // TMainForm.LimitingFrontalFrameworkUpDownClick

// Изменение количества горизонтальных линий каркаса предельного эллипсоида
// с помощью кнопок переключения рядом с меткой.
procedure TMainForm.LimitingHorizontalFrameworkUpDownClick(Sender: TObject;
  Button: TUDBtnType);
begin // TMainForm.LimitingHorizontalFrameworkUpDownClick
  MainForm.LimitingHorizontalFrameworkEditExit(MainForm);
end; // TMainForm.LimitingHorizontalFrameworkUpDownClick

// Изменение количества вертикальных линий каркаса предельного эллипсоида
// с помощью кнопок переключения рядом с меткой.
procedure TMainForm.LimitingVerticalFrameworkUpDownClick(Sender: TObject;
  Button: TUDBtnType);
begin // TMainForm.LimitingVerticalFrameworkUpDownClick
  MainForm.LimitingVerticalFrameworkEditExit(MainForm);
end; // TMainForm.LimitingVerticalFrameworkUpDownClick

//******************************************************************************

// Изменение количества фронтальных линий каркаса эллипсоида смещённого фокуса
// с помощью кнопок переключения рядом с меткой.
procedure TMainForm.SourceFocalFrontalFrameworkUpDownClick(Sender: TObject;
  Button: TUDBtnType);
begin // TMainForm.SourceFocalFrontalFrameworkUpDownClick
  MainForm.SourceFocalFrontalFrameworkEditExit(MainForm);
end; // TMainForm.SourceFocalFrontalFrameworkUpDownClick

// Изменение количества горизонтальных линий каркаса эллипсоида исходного фокуса
// с помощью кнопок переключения рядом с меткой.
procedure TMainForm.SourceFocalHorizontalFrameworkUpDownClick(Sender: TObject;
  Button: TUDBtnType);
begin // TMainForm.SourceFocalHorizontalFrameworkUpDownClick
  MainForm.SourceFocalHorizontalFrameworkEditExit(MainForm);
end; // TMainForm.SourceFocalHorizontalFrameworkUpDownClick

// Изменение количества вертикальных линий каркаса эллипсоида исходного фокуса
// с помощью кнопок переключения рядом с меткой.
procedure TMainForm.SourceFocalVerticalFrameworkUpDownClick(Sender: TObject;
  Button: TUDBtnType);
begin // TMainForm.SourceFocalVerticalFrameworkUpDownClick
  MainForm.SourceFocalVerticalFrameworkEditExit(MainForm);
end; // TMainForm.SourceFocalVerticalFrameworkUpDownClick

//******************************************************************************

// Изменение количества фронтальных линий каркаса эллипсоида смещённого фокуса
// с помощью кнопок переключения рядом с меткой.
procedure TMainForm.DisplacedFocalFrontalFrameworkUpDownClick(Sender: TObject;
  Button: TUDBtnType);
begin // TMainForm.DisplacedFocalFrontalFrameworkUpDownClick
  MainForm.DisplacedFocalFrontalFrameworkEditExit(MainForm);
end; // TMainForm.DisplacedFocalFrontalFrameworkUpDownClick

// Изменение количества горизонтальных линий каркаса эллипсоида смещённого фокуса
// с помощью кнопок переключения рядом с меткой.
procedure TMainForm.DisplacedFocalHorizontalFrameworkUpDownClick(Sender: TObject;
  Button: TUDBtnType);
begin // TMainForm.DisplacedFocalHorizontalFrameworkUpDownClick
  MainForm.DisplacedFocalHorizontalFrameworkEditExit(MainForm);
end; // TMainForm.DisplacedFocalHorizontalFrameworkUpDownClick

// Изменение количества вертикальных линий каркаса эллипсоида смещённого фокуса
// с помощью кнопок переключения рядом с меткой.
procedure TMainForm.DisplacedFocalVerticalFrameworkUpDownClick(Sender: TObject;
  Button: TUDBtnType);
begin // TMainForm.DisplacedFocalVerticalFrameworkUpDownClick
  MainForm.DisplacedFocalVerticalFrameworkEditExit(MainForm);
end; // TMainForm.DisplacedFocalVerticalFrameworkUpDownClick

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Изменение межцентрового расстояния предельного эллипсоида.
procedure TMainForm.LimitingBetweenDistanceMaskEditExit(Sender: TObject);
var
  // Новое межцентровое расстояние в миллиметрах.
  NewBetweenDistanceInMillimeters: Word;
begin // TMainForm.LimitingBetweenDistanceMaskEditExit
  StatusBar.Panels[0].Text:='';
  try
    // Удаление пробелов в тексте.
    DelMaskEditTextGaps(LimitingBetweenDistanceMaskEdit);
    NewBetweenDistanceInMillimeters:=
      StrToInt(LimitingBetweenDistanceMaskEdit.Text);

    if NewBetweenDistanceInMillimeters>
      (2*DisplacedFocalEllipsoid.DefiningParameters.Radiuses.XRadiusInMillimeters)
      then begin
             NewBetweenDistanceInMillimeters:=
               2*DisplacedFocalEllipsoid.DefiningParameters.Radiuses.XRadiusInMillimeters;
             LimitingBetweenDistanceMaskEdit.Text:=
               IntToStr(NewBetweenDistanceInMillimeters);
             CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
               'Межцентровое рассотяние '+
               'предельного эллипсоида, превысившее допустимое '+
               'в пределах [0 мм; '+
               IntToStr(2*DisplacedFocalEllipsoid.DefiningParameters.Radiuses.XRadiusInMillimeters)+
               ' мм], исправлено на максимальое!');
             StatusBar.Panels[0].Text:=CorrectionsString;
           end; // if NewBetweenDistanceInMillimeters>

  except
    // При вводе пустой строки.
    on EConvertError do
      begin
        NewBetweenDistanceInMillimeters:=0;
        LimitingBetweenDistanceMaskEdit.Text:='0';
          IntToStr(NewBetweenDistanceInMillimeters);
        CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
          'Некорректное значение межцентрового рассотяния '+
          'предельного эллипсоида исправлено на минимальное!');
        StatusBar.Panels[0].Text:=CorrectionsString;
      end; // on EConvertError
  end; // except

  with LimitingEllipsoid.DefiningParameters.Radiuses do
    begin
      // Перерасчёт координатных центров и связанных с ними параметров
      // предельного эллипсоида.
      LimitingEllipsoid.ReSetCentres(NewBetweenDistanceInMillimeters);
      LimitingXRadiusMaskEdit.Text:=IntToStr(XRadiusInMillimeters);
      LimitingYRadiusMaskEdit.Text:=IntToStr(YRadiusInMillimeters);
      LimitingZRadiusMaskEdit.Text:=IntToStr(ZRadiusInMillimeters);
    end; // with LimitingEllipsoid

  // Перерасчёт параметров центров остальных эллипсоидов.
  SourceFocalEllipsoid.ReSetCentres(NewBetweenDistanceInMillimeters);
  DisplacedFocalEllipsoid.ReSetCentres(NewBetweenDistanceInMillimeters);
  // Построение поверхностей.
  if SourceSurface.bDetermined = True
    then GridsForm.BuildSurfacesSpeedButtonClick(GridsForm)
    else Repaint;
end; // TMainForm.LimitingBetweenDistanceMaskEditExit

// Изменение межцентрового расстояния предельного эллипсоида
// при нажатии <Enter> в метке.
procedure TMainForm.LimitingBetweenDistanceMaskEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.LimitingBetweenDistanceMaskEditKeyDown
  if Key = VK_RETURN
    then MainForm.LimitingBetweenDistanceMaskEditExit(MainForm);
end; // TMainForm.LimitingBetweenDistanceMaskEditKeyDown

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Изменение значения радиуса эллипсоида.
procedure TMainForm.ChangeEllipsoidRadius(var NewRadiusInMillimeters: Word;
                                          var RadiusMaskEdit: TMaskEdit;
                                              LowerRadiusLimitInMillimeters,
                                              UpperRadiusLimitInMillimeters: Word;
                                              EllipsoidAndAxisInGenitiveCaseString: String);

// NewRadiusInMillimeters - новый радиус эллипсоида.
// RadiusMaskEdit - поле, редактирующее значение радиуса эллипсоида.
// NewRadiusInMillimeters - новое значение радиуса эллипсоида в миллиметрах.
// LowerRadiusLimitInMillimeters - нижняя граница
//                                 значения радиуса эллипсоида в миллиметрах
// UpperRadiusLimitInMillimeters - верхняя граница
//                                 значения радиуса эллипсоида в миллиметрах

// EllipsoidAndAxisInGenitiveCaseString - строка названия эллипсоида и
//                                        координатной оси в родительном падеже.

begin // TMainForm.ChangeEllipsoidRadius
  StatusBar.Panels[0].Text:='';
  try
    // Удаление пробелов в тексте.
    DelMaskEditTextGaps(RadiusMaskEdit);
    NewRadiusInMillimeters:=StrToInt(RadiusMaskEdit.Text);

    // Блок выполняется при положительном значении
    // нижней границы значения радиуса эллипсоида.
    if (NewRadiusInMillimeters<LowerRadiusLimitInMillimeters) 
      and (LowerRadiusLimitInMillimeters>0)
      then begin
             NewRadiusInMillimeters:=LowerRadiusLimitInMillimeters;
             CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
               'Значение радиуса '+EllipsoidAndAxisInGenitiveCaseString+
               ', меньшее допустимого в пределах ['+
               IntToStr(LowerRadiusLimitInMillimeters)+
               ' мм; '+IntToStr(UpperRadiusLimitInMillimeters)+
               ' мм], исправлено на минимальное!');
             StatusBar.Panels[0].Text:=CorrectionsString;
           end // if NewRadiusInMillimeters<

      else if NewRadiusInMillimeters>UpperRadiusLimitInMillimeters
             then begin
                    NewRadiusInMillimeters:=UpperRadiusLimitInMillimeters;
                    CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
                      'Значение радиуса '+EllipsoidAndAxisInGenitiveCaseString+
                      ', превысившее допустимое в пределах ['+
                      IntToStr(LowerRadiusLimitInMillimeters)+
                      ' мм; '+IntToStr(UpperRadiusLimitInMillimeters)+' мм], '+
                      'исправлено на максимальое!');
                    StatusBar.Panels[0].Text:=CorrectionsString;
                  end; // if NewRadiusInMillimeters>

  except
    // При вводе пустой строки.
    on EConvertError do
      begin
        NewRadiusInMillimeters:=LowerRadiusLimitInMillimeters;
        CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
          'Некорректное значение радиуса '+EllipsoidAndAxisInGenitiveCaseString+
          ' исправлено на минимальное!');
        StatusBar.Panels[0].Text:=CorrectionsString;
      end; // on EConvertError
  end; // except
end; // TMainForm.ChangeEllipsoidRadius

// Вывод всех параметров фокусных эллипсоидов,
// доступных для просмотра пользователя.
procedure TMainForm.OutPutAllFocalEllipsoidsParameters;
begin // TMainForm.OutPutAllFocalEllipsoidsParameters
  with SourceFocalEllipsoid do
    begin // with SourceFocalEllipsoid
      with DefiningParameters.Radiuses do
        begin // with DefiningParameters.Radiuses
          SourceFocalXRadiusMaskEdit.Text:=IntToStr(XRadiusInMillimeters);
          SourceFocalYRadiusMaskEdit.Text:=IntToStr(YRadiusInMillimeters);
          SourceFocalZRadiusMaskEdit.Text:=IntToStr(ZRadiusInMillimeters);
        end; // with DefiningParameters.Radiuses

      with Focus do
        begin // with Focus
          SourceFocalRadiusMaskEdit.Text:=IntToStr(RadiusVectorInMillimeters);

          SourceFocalXMaskEdit.Text:=IntToStr(XFocusInMillimeters);
          SourceFocalYMaskEdit.Text:=IntToStr(YFocusInMillimeters);
          SourceFocalZMaskEdit.Text:=IntToStr(ZFocusInMillimeters);

          FOXMaskEdit.Text:=Format('%7.2f',[Angles.FOXInDegrees]);
          FOYMaskEdit.Text:=Format('%7.2f',[Angles.FOYInDegrees]);
          FOZMaskEdit.Text:=Format('%7.2f',[Angles.FOZInDegrees]);
        end; // with Focus
    end; // with SourceFocalEllipsoid

  with DisplacedFocalEllipsoid do
    begin // with DisplacedFocalEllipsoid
      with DefiningParameters.Radiuses do
        begin // with DefiningParameters.Radiuses
          DisplacedFocalXRadiusMaskEdit.Text:=IntToStr(XRadiusInMillimeters);
          DisplacedFocalYRadiusMaskEdit.Text:=IntToStr(YRadiusInMillimeters);
          DisplacedFocalZRadiusMaskEdit.Text:=IntToStr(ZRadiusInMillimeters);
        end; // with DefiningParameters.Radiuses

      with Focus do
        begin // with Focus
          DisplacedFocalRadiusMaskEdit.Text:=IntToStr(RadiusVectorInMillimeters);

          DisplacedFocalXMaskEdit.Text:=IntToStr(XFocusInMillimeters);
          DisplacedFocalYMaskEdit.Text:=IntToStr(YFocusInMillimeters);
          DisplacedFocalZMaskEdit.Text:=IntToStr(ZFocusInMillimeters);
        end; // with Focus
    end; // with DisplacedFocalEllipsoid
end; // TMainForm.OutPutAllFocalEllipsoidsParameters

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// Изменение радиуса предельного эллипсоида по оси OX.
procedure TMainForm.LimitingXRadiusMaskEditExit(Sender: TObject);
var
  // Новый радиус по оси OX в миллиметрах.
  NewXRadiusInMillimeters: Word;
begin // TMainForm.LimitingXRadiusMaskEditExit
  // Изменение значения радиуса эллипсоида.
  ChangeEllipsoidRadius(NewXRadiusInMillimeters,LimitingXRadiusMaskEdit,
    SourceFocalEllipsoid.DefiningParameters.Radiuses.XRadiusInMillimeters,
    MaxEllipsoidRadiusInMillimeters, 'предельного эллипсоида по оси OX');

  // Перерасчёт параметров предельного эллипсоида.
  SetScaleFactorPercentsInMillimeter(NewXRadiusInMillimeters,
                                     ScaleFactorPercentsInMillimeter);

  LimitingEllipsoid.SetCentres;
  LimitingBetweenDistanceMaskEdit.Text:=IntToStr(
    LimitingEllipsoid.DefiningParameters.Centres.BetweenDistanceInMillimeters);

  LimitingEllipsoid.ReSetRadiuses(NewXRadiusInMillimeters, XRadiusDeterminator);

  // Изменение масштаба всех параметров остальных эллипсоидов
  // из-за изменившегося масштабного коэффициента.
  SourceFocalEllipsoid.ReScaleAllParameters;
  DisplacedFocalEllipsoid.ReScaleAllParameters;
  // Изменение масштаба всех параметров поверхностей
  // из-за изменившегося масштабного коэффициента.
  SourceSurface.ReScaleAllParameters;
  DisplacedSurface.ReScaleAllParameters;

  with LimitingEllipsoid.DefiningParameters.Radiuses do
    begin
      LimitingXRadiusMaskEdit.Text:=IntToStr(XRadiusInMillimeters);
      LimitingYRadiusMaskEdit.Text:=IntToStr(YRadiusInMillimeters);
      LimitingZRadiusMaskEdit.Text:=IntToStr(ZRadiusInMillimeters);
    end; // with LimitingEllipsoid

  Repaint;
end; // TMainForm.LimitingXRadiusMaskEditExit

//******************************************************************************

// Изменение радиуса исходного эллипсоида по оси OX.
procedure TMainForm.SourceFocalXRadiusMaskEditExit(Sender: TObject);
var
  // Новый радиус по оси OX в миллиметрах.
  NewXRadiusInMillimeters: Word;
begin // TMainForm.SourceFocalXRadiusMaskEditExit
  // Изменение значения радиуса эллипсоида.
  ChangeEllipsoidRadius(NewXRadiusInMillimeters,SourceFocalXRadiusMaskEdit,
    DisplacedFocalEllipsoid.DefiningParameters.Radiuses.XRadiusInMillimeters,
    LimitingEllipsoid.DefiningParameters.Radiuses.XRadiusInMillimeters,
    'исходного эллипсоида по оси OX');

  if (NewXRadiusInMillimeters=
    LimitingEllipsoid.DefiningParameters.Radiuses.XRadiusInMillimeters)
    // Отождествление всех параметров с другим эллипсоидом
    // при ориентации на его конкретный радиус.
    then AssignOtherEllipsoidAllParameters(SourceFocalEllipsoid,
                                           TFocalEllipsoid(LimitingEllipsoid))

    else if (NewXRadiusInMillimeters=
             DisplacedFocalEllipsoid.DefiningParameters.Radiuses.XRadiusInMillimeters)
           // Отождествление всех параметров с другим эллипсоидом
           // при ориентации на его конкретный радиус.
           then AssignOtherEllipsoidAllParameters(SourceFocalEllipsoid,
                                                  DisplacedFocalEllipsoid)
           else SourceFocalEllipsoid.ReSetRadiuses(NewXRadiusInMillimeters,
                                                   XRadiusDeterminator);

  // Вывод всех параметров фокусных эллипсоидов,
  // доступных для просмотра пользователя.
  OutPutAllFocalEllipsoidsParameters;
  // Построение поверхностей.
  if SourceSurface.bDetermined = True
    then GridsForm.BuildSurfacesSpeedButtonClick(GridsForm)
    else Repaint;
end; // TMainForm.SourceFocalXRadiusMaskEditExit

// Изменение радиуса исходного эллипсоида по оси OY.
procedure TMainForm.SourceFocalYRadiusMaskEditExit(Sender: TObject);
var
  // Новый радиус по оси OY в миллиметрах.
  NewYRadiusInMillimeters: Word;
begin // TMainForm.SourceFocalYRadiusMaskEditExit
  // Изменение значения радиуса эллипсоида.
  ChangeEllipsoidRadius(NewYRadiusInMillimeters,SourceFocalYRadiusMaskEdit,
    DisplacedFocalEllipsoid.DefiningParameters.Radiuses.YRadiusInMillimeters,
    LimitingEllipsoid.DefiningParameters.Radiuses.YRadiusInMillimeters,
    'исходного эллипсоида по оси OY');

  if (NewYRadiusInMillimeters=
    LimitingEllipsoid.DefiningParameters.Radiuses.YRadiusInMillimeters)
    // Отождествление всех параметров с другим эллипсоидом
    // при ориентации на его конкретный радиус.
    then AssignOtherEllipsoidAllParameters(SourceFocalEllipsoid,
                                           TFocalEllipsoid(LimitingEllipsoid))

    else if (NewYRadiusInMillimeters=
             DisplacedFocalEllipsoid.DefiningParameters.Radiuses.YRadiusInMillimeters)
           // Отождествление всех параметров с другим эллипсоидом
           // при ориентации на его конкретный радиус.
           then AssignOtherEllipsoidAllParameters(SourceFocalEllipsoid,
                                                  DisplacedFocalEllipsoid)
           else SourceFocalEllipsoid.ReSetRadiuses(NewYRadiusInMillimeters,
                                                   YRadiusDeterminator);

  // Вывод всех параметров фокусных эллипсоидов,
  // доступных для просмотра пользователя.
  OutPutAllFocalEllipsoidsParameters;
  // Построение поверхностей.
  if SourceSurface.bDetermined = True
    then GridsForm.BuildSurfacesSpeedButtonClick(GridsForm)
    else Repaint;
end; // TMainForm.SourceFocalYRadiusMaskEditExit

// Изменение радиуса исходного эллипсоида по оси OZ.
procedure TMainForm.SourceFocalZRadiusMaskEditExit(Sender: TObject);
var
  // Новый радиус по оси OZ в миллиметрах.
  NewZRadiusInMillimeters: Word;
begin // TMainForm.SourceFocalZRadiusMaskEditExit
  // Изменение значения радиуса эллипсоида.
  ChangeEllipsoidRadius(NewZRadiusInMillimeters,SourceFocalZRadiusMaskEdit,
    DisplacedFocalEllipsoid.DefiningParameters.Radiuses.ZRadiusInMillimeters,
    LimitingEllipsoid.DefiningParameters.Radiuses.ZRadiusInMillimeters,
    'исходного эллипсоида по оси OZ');

  if (NewZRadiusInMillimeters=
    LimitingEllipsoid.DefiningParameters.Radiuses.ZRadiusInMillimeters)
    // Отождествление всех параметров с другим эллипсоидом
    // при ориентации на его конкретный радиус.
    then AssignOtherEllipsoidAllParameters(SourceFocalEllipsoid,
                                           TFocalEllipsoid(LimitingEllipsoid))

    else if (NewZRadiusInMillimeters=
             DisplacedFocalEllipsoid.DefiningParameters.Radiuses.ZRadiusInMillimeters)
           // Отождествление всех параметров с другим эллипсоидом
           // при ориентации на его конкретный радиус.
           then AssignOtherEllipsoidAllParameters(SourceFocalEllipsoid,
                                                  DisplacedFocalEllipsoid)
           else SourceFocalEllipsoid.ReSetRadiuses(NewZRadiusInMillimeters,
                                                   ZRadiusDeterminator);

  // Вывод всех параметров фокусных эллипсоидов,
  // доступных для просмотра пользователя.
  OutPutAllFocalEllipsoidsParameters;
  // Построение поверхностей.
  if SourceSurface.bDetermined = True
    then GridsForm.BuildSurfacesSpeedButtonClick(GridsForm)
    else Repaint;
end; // TMainForm.SourceFocalZRadiusMaskEditExit

//******************************************************************************

// Изменение радиуса смещённого эллипсоида по оси OX.
procedure TMainForm.DisplacedFocalXRadiusMaskEditExit(Sender: TObject);
var
  // Новый радиус по оси OX в миллиметрах.
  NewXRadiusInMillimeters: Word;
  // Половина межцентрового расстояния смещённого эллипсоида.
  HalfBetweenDistanceInMillimeters: Word;
begin // TMainForm.DisplacedFocalXRadiusMaskEditExit
  HalfBetweenDistanceInMillimeters:=
    Round(DisplacedFocalEllipsoid.DefiningParameters.Centres.BetweenDistanceInMillimeters/2);

  // Изменение значения радиуса эллипсоида.
  ChangeEllipsoidRadius(NewXRadiusInMillimeters,DisplacedFocalXRadiusMaskEdit,
    HalfBetweenDistanceInMillimeters,
    SourceFocalEllipsoid.DefiningParameters.Radiuses.XRadiusInMillimeters,
    'смещённого эллипсоида по оси OX');

  if (NewXRadiusInMillimeters=
    SourceFocalEllipsoid.DefiningParameters.Radiuses.XRadiusInMillimeters)
    // Отождествление всех параметров с другим эллипсоидом
    // при ориентации на его конкретный радиус.
    then AssignOtherEllipsoidAllParameters(DisplacedFocalEllipsoid,
                                           SourceFocalEllipsoid)
    else DisplacedFocalEllipsoid.ReSetRadiuses(NewXRadiusInMillimeters,
                                               XRadiusDeterminator);

  // Вывод всех параметров фокусных эллипсоидов,
  // доступных для просмотра пользователя.
  OutPutAllFocalEllipsoidsParameters;
  // Построение поверхностей.
  if SourceSurface.bDetermined = True
    then GridsForm.BuildSurfacesSpeedButtonClick(GridsForm)
    else Repaint;
end; // TMainForm.DisplacedFocalXRadiusMaskEditExit

// Изменение радиуса смещённого эллипсоида по оси OY.
procedure TMainForm.DisplacedFocalYRadiusMaskEditExit(Sender: TObject);
var
  // Новый радиус по оси OY в миллиметрах.
  NewYRadiusInMillimeters: Word;
begin // TMainForm.DisplacedFocalYRadiusMaskEditExit
  // Изменение значения радиуса эллипсоида.
  ChangeEllipsoidRadius(NewYRadiusInMillimeters,DisplacedFocalYRadiusMaskEdit,
    0, SourceFocalEllipsoid.DefiningParameters.Radiuses.YRadiusInMillimeters,
    'смещённого эллипсоида по оси OY');

  if (NewYRadiusInMillimeters=
    SourceFocalEllipsoid.DefiningParameters.Radiuses.YRadiusInMillimeters)
    // Отождествление всех параметров с другим эллипсоидом
    // при ориентации на его конкретный радиус.
    then AssignOtherEllipsoidAllParameters(DisplacedFocalEllipsoid,
                                           SourceFocalEllipsoid)
    else DisplacedFocalEllipsoid.ReSetRadiuses(NewYRadiusInMillimeters,
                                               YRadiusDeterminator);

  // Вывод всех параметров фокусных эллипсоидов,
  // доступных для просмотра пользователя.
  OutPutAllFocalEllipsoidsParameters;
  // Построение поверхностей.
  if SourceSurface.bDetermined = True
    then GridsForm.BuildSurfacesSpeedButtonClick(GridsForm)
    else Repaint;
end; // TMainForm.DisplacedFocalYRadiusMaskEditExit

// Изменение радиуса смещённого эллипсоида по оси OZ.
procedure TMainForm.DisplacedFocalZRadiusMaskEditExit(Sender: TObject);
var
  // Новый радиус по оси OZ в миллиметрах.
  NewZRadiusInMillimeters: Word;
begin // TMainForm.DisplacedFocalZRadiusMaskEditExit
  // Изменение значения радиуса эллипсоида.
  ChangeEllipsoidRadius(NewZRadiusInMillimeters,DisplacedFocalZRadiusMaskEdit,
    0, SourceFocalEllipsoid.DefiningParameters.Radiuses.ZRadiusInMillimeters,
    'смещённого эллипсоида по оси OZ');

  if (NewZRadiusInMillimeters=
    SourceFocalEllipsoid.DefiningParameters.Radiuses.ZRadiusInMillimeters)
    // Отождествление всех параметров с другим эллипсоидом
    // при ориентации на его конкретный радиус.
    then AssignOtherEllipsoidAllParameters(DisplacedFocalEllipsoid,
                                           SourceFocalEllipsoid)
    else DisplacedFocalEllipsoid.ReSetRadiuses(NewZRadiusInMillimeters,
                                               ZRadiusDeterminator);

  // Вывод всех параметров фокусных эллипсоидов,
  // доступных для просмотра пользователя.
  OutPutAllFocalEllipsoidsParameters;
  // Построение поверхностей.
  if SourceSurface.bDetermined = True
    then GridsForm.BuildSurfacesSpeedButtonClick(GridsForm)
    else Repaint;
end; // TMainForm.DisplacedFocalZRadiusMaskEditExit

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

// Изменение радиуса предельного эллипсоида по оси OX
// при нажатии <Enter> в метке.
procedure TMainForm.LimitingXRadiusMaskEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.LimitingXRadiusMaskEditKeyDown
  if Key = VK_RETURN
    then MainForm.LimitingXRadiusMaskEditExit(MainForm);
end; // TMainForm.LimitingXRadiusMaskEditKeyDown

//******************************************************************************

// Изменение радиуса эллипсоида исходного фокуса по оси OX
// при нажатии <Enter> в метке.
procedure TMainForm.SourceFocalXRadiusMaskEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.SourceFocalXRadiusMaskEditKeyDown
  if Key = VK_RETURN
    then MainForm.SourceFocalXRadiusMaskEditExit(MainForm);
end; // TMainForm.SourceFocalXRadiusMaskEditKeyDown

// Изменение радиуса эллипсоида исходного фокуса по оси OY
// при нажатии <Enter> в метке.
procedure TMainForm.SourceFocalYRadiusMaskEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.SourceFocalYRadiusMaskEditKeyDown
  if Key = VK_RETURN
    then MainForm.SourceFocalYRadiusMaskEditExit(MainForm);
end; // TMainForm.SourceFocalYRadiusMaskEditKeyDown

// Изменение радиуса эллипсоида исходного фокуса по оси OZ
// при нажатии <Enter> в метке.
procedure TMainForm.SourceFocalZRadiusMaskEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.SourceFocalZRadiusMaskEditKeyDown
  if Key = VK_RETURN
    then MainForm.SourceFocalZRadiusMaskEditExit(MainForm);
end; // TMainForm.SourceFocalZRadiusMaskEditKeyDown

//******************************************************************************

// Изменение радиуса эллипсоида смещённого фокуса по оси OX
// при нажатии <Enter> в метке.
procedure TMainForm.DisplacedFocalXRadiusMaskEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.DisplacedFocalXRadiusMaskEditKeyDown
  if Key = VK_RETURN
    then MainForm.DisplacedFocalXRadiusMaskEditExit(MainForm);
end; // TMainForm.DisplacedFocalXRadiusMaskEditKeyDown

// Изменение радиуса эллипсоида смещённого фокуса по оси OY
// при нажатии <Enter> в метке.
procedure TMainForm.DisplacedFocalYRadiusMaskEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.DisplacedFocalYRadiusMaskEditKeyDown
  if Key = VK_RETURN
    then MainForm.DisplacedFocalYRadiusMaskEditExit(MainForm);
end; // TMainForm.DisplacedFocalYRadiusMaskEditKeyDown

// Изменение радиуса эллипсоида смещённого фокуса по оси OZ
// при нажатии <Enter> в метке.
procedure TMainForm.DisplacedFocalZRadiusMaskEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.DisplacedFocalZRadiusMaskEditKeyDown
  if Key = VK_RETURN
    then MainForm.DisplacedFocalZRadiusMaskEditExit(MainForm);
end; // TMainForm.DisplacedFocalZRadiusMaskEditKeyDown

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Изменение радиус-вектора фокуса эллипсоида исходного фокуса.
procedure TMainForm.SourceFocalRadiusMaskEditExit(Sender: TObject);
var
  // Новый радиус-вектор фокуса эллипсоида исходного фокуса.
  NewRadiusVectorInMillimeters: Word;
begin // TMainForm.SourceFocalRadiusMaskEditExit
  StatusBar.Panels[0].Text:='';
  try
    // Удаление пробелов в тексте.
    DelMaskEditTextGaps(SourceFocalRadiusMaskEdit);
    NewRadiusVectorInMillimeters:=StrToInt(SourceFocalRadiusMaskEdit.Text);

    if NewRadiusVectorInMillimeters<
       DisplacedFocalEllipsoid.Focus.RadiusVectorInMillimeters
      then if (SourceFocalEllipsoid.DefiningParameters.Radiuses.YRadiusInMillimeters=0)
              // Если исходный эллипсоид выожден в отрезок.
              then begin // ...then ... then
                     NewRadiusVectorInMillimeters:=0;

                     DisplacedFocalEllipsoid.Focus.RadiusVectorInMillimeters:=0;
                     DisplacedFocalEllipsoid.Focus.XFocusInMillimeters:=0;
                     DisplacedFocalEllipsoid.Focus.Coordinates.X:=0;

                     CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
                       'Значение радиус-вектора эллипсоида исходного фокуса, '+
                       'меньшее значения радиус-вектора эллипсоида смещённого фокуса '+
                       'исправлено на нулевое!');
                     StatusBar.Panels[0].Text:=CorrectionsString;
                   end // ...then ... then
              // Если исходный эллипсоид не выожден в отрезок.
              else begin // ...then ... else
                     NewRadiusVectorInMillimeters:=
                       DisplacedFocalEllipsoid.Focus.RadiusVectorInMillimeters;
                     CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
                       'Значение радиус-вектора эллипсоида исходного фокуса, '+
                       'меньшее значения радиус-вектора эллипсоида смещённого фокуса '+
                       IntToStr(DisplacedFocalEllipsoid.Focus.RadiusVectorInMillimeters)+
                       ' мм, исправлено на минимальное!');
                     StatusBar.Panels[0].Text:=CorrectionsString;
                   end; // ...then ... else

  except
    // При вводе пустой строки.
    on EConvertError do
      begin
        NewRadiusVectorInMillimeters:=
          DisplacedFocalEllipsoid.Focus.RadiusVectorInMillimeters;
        CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
          'Некорректное значение радиус-вектора эллипсоида исходного фокуса '+
          'исправлено на минимальное!');
        StatusBar.Panels[0].Text:=CorrectionsString;
      end; // on EConvertError
  end; // except

  if (NewRadiusVectorInMillimeters=
    DisplacedFocalEllipsoid.Focus.RadiusVectorInMillimeters)
    // Отождествление всех параметров с другим эллипсоидом
    // при ориентации на его конкретный радиус.
    then AssignOtherEllipsoidAllParameters(SourceFocalEllipsoid,
                                           DisplacedFocalEllipsoid)

    else begin
           // Перерасчёт длины радиус-вектора фокуса фокусного эллипсоида.
           SourceFocalEllipsoid.ReSetFocusRadiusVector(NewRadiusVectorInMillimeters);
           if SourceFocalEllipsoid.DefiningParameters.Radiuses.XRadiusInMillimeters>=
             LimitingEllipsoid.DefiningParameters.Radiuses.XRadiusInMillimeters
             then begin
                    CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
                      'Значения радиусов эллипсоида исходного фокуса, '+
                      'которые не должны превышать значений радиусов предельного эллипсоида '+
                      'исправлены на максимальные!');
                    // Отождествление всех параметров с другим эллипсоидом
                    // при ориентации на его конкретный радиус.
                    AssignOtherEllipsoidAllParameters(SourceFocalEllipsoid,
                                                      TFocalEllipsoid(LimitingEllipsoid));
                    StatusBar.Panels[0].Text:=CorrectionsString;
                  end; // if SourceFocalEllipsoid.DefiningParameters.Radiuses.XRadiusInMillimeters
         end;

  // Вывод всех параметров фокусных эллипсоидов,
  // доступных для просмотра пользователя.
  OutPutAllFocalEllipsoidsParameters;
  // Построение поверхностей.
  if SourceSurface.bDetermined = True
    then GridsForm.BuildSurfacesSpeedButtonClick(GridsForm)
    else Repaint;
end; // TMainForm.SourceFocalRadiusMaskEditExit

// Ввод и отображение информации.
procedure TMainForm.SourceFocalRadiusMaskEditKeyPress(Sender: TObject;
  var Key: Char);
begin // TMainForm.SourceFocalRadiusMaskEditKeyPress
  if (Key = 'T') or (Key = 'Е')
    then ShowMessage('Теорию бицентрического пространства разработала'+
           ' и реализовала в данной программе "Glance 2.2.1"'+
           ' Котова Екатерина Александровна, студентка гр. 443 РГРТУ'+
           ' в 2006 году, представив свою работку в качестве'+
           ' курсового проекта по дисциплине "Инженерная и '+
           ' компьютерная граффика".' );
end; // TMainForm.SourceFocalRadiusMaskEditKeyPress

// Изменение радиус-вектора фокуса эллипсоида смещённого фокуса.
procedure TMainForm.DisplacedFocalRadiusMaskEditExit(Sender: TObject);
var
  // Новый радиус-вектор фокуса эллипсоида смещённого фокуса.
  NewRadiusVectorInMillimeters: Word;
  // Половина межцентрового расстояния смещённого эллипсоида.
  HalfBetweenDistanceInMillimeters: Word;
begin // TMainForm.DisplacedFocalRadiusMaskEditExit
  StatusBar.Panels[0].Text:='';
  HalfBetweenDistanceInMillimeters:=
    Round(DisplacedFocalEllipsoid.DefiningParameters.Centres.BetweenDistanceInMillimeters/2);

  try
    // Удаление пробелов в тексте.
    DelMaskEditTextGaps(DisplacedFocalRadiusMaskEdit);
    NewRadiusVectorInMillimeters:=StrToInt(DisplacedFocalRadiusMaskEdit.Text);

    if NewRadiusVectorInMillimeters>
       SourceFocalEllipsoid.Focus.RadiusVectorInMillimeters
      then if (SourceFocalEllipsoid.DefiningParameters.Radiuses.YRadiusInMillimeters=0)
              // Если исходный эллипсоид выожден в отрезок.
              then begin // ...then ... then
                     NewRadiusVectorInMillimeters:=0;
                     CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
                       'Значение радиус-вектора эллипсоида смещённого фокуса, '+
                       'превысившее значения радиус-вектора эллипсоида исходного фокуса '+
                       'исправлено на нулевое!');
                     StatusBar.Panels[0].Text:=CorrectionsString;
                   end // ...then ... then
              // Если исходный эллипсоид не выожден в отрезок.
              else begin // ...then ... else
                     NewRadiusVectorInMillimeters:=
                       SourceFocalEllipsoid.Focus.RadiusVectorInMillimeters;
                     CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
                       'Значение радиус-вектора эллипсоида смещённого фокуса, '+
                       'превысившее значение радиус-вектора эллипсоида исходного фокуса '+
                       IntToStr(SourceFocalEllipsoid.Focus.RadiusVectorInMillimeters)+
                       ' мм, исправлено на максимальное!');
                     StatusBar.Panels[0].Text:=CorrectionsString;
                   end; // ...then ... else

  except
    // При вводе пустой строки.
    on EConvertError do
      begin
        NewRadiusVectorInMillimeters:=
          SourceFocalEllipsoid.Focus.RadiusVectorInMillimeters;
        CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
          'Некорректное значение радиус-вектора эллипсоида смещённого фокуса '+
          'исправлено на максимальное!');
        StatusBar.Panels[0].Text:=CorrectionsString;
      end; // on EConvertError
  end; // except

  if (NewRadiusVectorInMillimeters=
    SourceFocalEllipsoid.Focus.RadiusVectorInMillimeters)
    // Отождествление всех параметров с другим эллипсоидом
    // при ориентации на его конкретный радиус.
    then AssignOtherEllipsoidAllParameters(DisplacedFocalEllipsoid,
                                           SourceFocalEllipsoid)
    // Перерасчёт длины радиус-вектора фокуса фокусного эллипсоида.
    else DisplacedFocalEllipsoid.ReSetFocusRadiusVector(NewRadiusVectorInMillimeters);

  // Вывод всех параметров фокусных эллипсоидов,
  // доступных для просмотра пользователя.
  OutPutAllFocalEllipsoidsParameters;
  // Построение поверхностей.
  if SourceSurface.bDetermined = True
    then GridsForm.BuildSurfacesSpeedButtonClick(GridsForm)
    else Repaint;
end; // TMainForm.DisplacedFocalRadiusMaskEditExit

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

// Изменение радиус-вектора фокуса эллипсоида сиходного фокуса
// при нажатии <Enter> в метке.
procedure TMainForm.SourceFocalRadiusMaskEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.SourceFocalRadiusMaskEditKeyDown
  if Key = VK_RETURN
    then MainForm.SourceFocalRadiusMaskEditExit(MainForm);
end; // TMainForm.SourceFocalRadiusMaskEditKeyDown

// Изменение радиус-вектора фокуса эллипсоида смещённого фокуса
// при нажатии <Enter> в метке.
procedure TMainForm.DisplacedFocalRadiusMaskEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.DisplacedFocalRadiusMaskEditKeyDown
  if Key = VK_RETURN
    then MainForm.DisplacedFocalRadiusMaskEditExit(MainForm);
end; // TMainForm.DisplacedFocalRadiusMaskEditKeyDown

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Изменение абсциссы фокуса исходного эллипсоида.
procedure TMainForm.SourceFocalXMaskEditExit(Sender: TObject);
var
  // Новая абсцисса фокуса исходного эллипсоида.
  NewFocusXInMillimeters: Smallint;
  // Половина межцентрового расстояния смещённого эллипсоида.
  HalfBetweenDistanceInMillimeters: Word;
begin // TMainForm.SourceFocalXMaskEditExit
  StatusBar.Panels[0].Text:='';
  HalfBetweenDistanceInMillimeters:=
    Round(SourceFocalEllipsoid.DefiningParameters.Centres.BetweenDistanceInMillimeters/2);
  try
    // Удаление пробелов в тексте.
    DelMaskEditTextGaps(SourceFocalXMaskEdit);
    NewFocusXInMillimeters:=StrToInt(SourceFocalXMaskEdit.Text);

    // Фокус лежит на оси ОХ и его абсцисса по модулю меньше
    // половины межцентрового расстояния.
    if (SourceFocalEllipsoid.Focus.YFocusInMillimeters=0) and
       (SourceFocalEllipsoid.Focus.ZFocusInMillimeters=0) and
       (Abs(NewFocusXInMillimeters)<HalfBetweenDistanceInMillimeters)
      then NewFocusXInMillimeters:=HalfBetweenDistanceInMillimeters;

  except
    on EConvertError do
      begin
        NewFocusXInMillimeters:=
          DisplacedFocalEllipsoid.DefiningParameters.Radiuses.XRadiusInMillimeters;
        CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
          'Некорректное значение абсциссы фокуса эллипсоида исходного фокуса '+
          'исправлено на значение '+
          'радиуса эллипсоида смещённого фокуса по оси OX!');
        StatusBar.Panels[0].Text:=CorrectionsString;
      end; // on EConvertError
  end; // except

  // Перерасчёт координат фокуса фокусного эллипсоида.
  SourceFocalEllipsoid.ReSetFocusCoordinates(NewFocusXInMillimeters,
                                             XFocusCoordinateDeterminator);
  // Отождествление всех углов смещённого эллипсоида
  // с углами исходного эллипсоида.
  AssignOtherEllipsoidAngles(DisplacedFocalEllipsoid,SourceFocalEllipsoid);
  // Проверка допустимости заначений радиусов.
  SourceFocalXRadiusMaskEdit.Text:=
    IntToStr(SourceFocalEllipsoid.DefiningParameters.Radiuses.XRadiusInMillimeters);
  MainForm.SourceFocalXRadiusMaskEditExit(MainForm);
end; // TMainForm.SourceFocalXMaskEditExit

//******************************************************************************

// Изменение ординаты фокуса исходного эллипсоида.
procedure TMainForm.SourceFocalYMaskEditExit(Sender: TObject);
var
  // Новая ордината фокуса исходного эллипсоида.
  NewFocusYInMillimeters: Smallint;
  // Половина межцентрового расстояния смещённого эллипсоида.
  HalfBetweenDistanceInMillimeters: Word;
begin // TMainForm.SourceFocalYMaskEditExit
  StatusBar.Panels[0].Text:='';
  HalfBetweenDistanceInMillimeters:=
    Round(SourceFocalEllipsoid.DefiningParameters.Centres.BetweenDistanceInMillimeters/2);
  try
    // Удаление пробелов в тексте.
    DelMaskEditTextGaps(SourceFocalYMaskEdit);
    NewFocusYInMillimeters:=StrToInt(SourceFocalYMaskEdit.Text);

    // Фокус лежит на оси ОХ и его абсцисса по модулю меньше
    // половины межцентрового расстояния.
    if (NewFocusYInMillimeters=0) and
       (SourceFocalEllipsoid.Focus.ZFocusInMillimeters=0) and
       (Abs(SourceFocalEllipsoid.Focus.XFocusInMillimeters)<
        HalfBetweenDistanceInMillimeters)
      then NewFocusYInMillimeters:=HalfBetweenDistanceInMillimeters;

    if (NewFocusYInMillimeters<0)
      then begin
             NewFocusYInMillimeters:=-NewFocusYInMillimeters;
             CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
               'Отрицательное значение '+
               'ординаты фокуса эллипсоида исходного фокуса '+
               'заменено на положительное - '+
               'отрицательная полуось координатной оси OY '+
               'находится вне зрительной области!');
             StatusBar.Panels[0].Text:=CorrectionsString;
           end;
  except
    on EConvertError do
      begin
        NewFocusYInMillimeters:=
          DisplacedFocalEllipsoid.DefiningParameters.Radiuses.YRadiusInMillimeters;
        CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
          'Некорректное значение ординаты фокуса эллипсоида исходного фокуса '+
          'исправлено на значение '+
          'радиуса эллипсоида смещённого фокуса по оси OY!');
        StatusBar.Panels[0].Text:=CorrectionsString;
      end; // on EConvertError
  end; // except

  // Перерасчёт координат фокуса фокусного эллипсоида.
  SourceFocalEllipsoid.ReSetFocusCoordinates(NewFocusYInMillimeters,
                                             YFocusCoordinateDeterminator);
  // Отождествление всех углов смещённого эллипсоида
  // с углами исходного эллипсоида.
  AssignOtherEllipsoidAngles(DisplacedFocalEllipsoid,SourceFocalEllipsoid);
  // Проверка допустимости заначений радиусов.
  SourceFocalYRadiusMaskEdit.Text:=
    IntToStr(SourceFocalEllipsoid.DefiningParameters.Radiuses.YRadiusInMillimeters);
  MainForm.SourceFocalYRadiusMaskEditExit(MainForm);
end; // TMainForm.SourceFocalYMaskEditExit

//******************************************************************************

// Изменение аппликаты фокуса исходного эллипсоида.
procedure TMainForm.SourceFocalZMaskEditExit(Sender: TObject);
var
  // Новая аппликата фокуса исходного эллипсоида.
  NewFocusZInMillimeters: Smallint;
  // Половина межцентрового расстояния смещённого эллипсоида.
  HalfBetweenDistanceInMillimeters: Word;
begin // TMainForm.SourceFocalZMaskEditExit
  StatusBar.Panels[0].Text:='';
  HalfBetweenDistanceInMillimeters:=
    Round(SourceFocalEllipsoid.DefiningParameters.Centres.BetweenDistanceInMillimeters/2);
  try
    // Удаление пробелов в тексте.
    DelMaskEditTextGaps(SourceFocalZMaskEdit);
    NewFocusZInMillimeters:=StrToInt(SourceFocalZMaskEdit.Text);

    // Фокус лежит на оси ОХ и его абсцисса по модулю меньше
    // половины межцентрового расстояния.
    if (SourceFocalEllipsoid.Focus.YFocusInMillimeters=0) and
       (NewFocusZInMillimeters=0) and
       (Abs(SourceFocalEllipsoid.Focus.XFocusInMillimeters)<
        HalfBetweenDistanceInMillimeters)
      then SourceFocalEllipsoid.Focus.XFocusInMillimeters:=
             HalfBetweenDistanceInMillimeters;

  except
    on EConvertError do
      begin
        NewFocusZInMillimeters:=
          DisplacedFocalEllipsoid.DefiningParameters.Radiuses.ZRadiusInMillimeters;
        CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
          'Некорректное значение '+
          'аппликаты фокуса эллипсоида исходного фокуса '+
          'исправлено на значение '+
          'радиуса эллипсоида смещённого фокуса по оси OZ!');
        StatusBar.Panels[0].Text:=CorrectionsString;
      end; // on EConvertError
  end; // except

  // Перерасчёт координат фокуса фокусного эллипсоида.
  SourceFocalEllipsoid.ReSetFocusCoordinates(NewFocusZInMillimeters,
                                             ZFocusCoordinateDeterminator);
  // Отождествление всех углов смещённого эллипсоида
  // с углами исходного эллипсоида.
  AssignOtherEllipsoidAngles(DisplacedFocalEllipsoid,SourceFocalEllipsoid);
  // Проверка допустимости заначений радиусов.
  SourceFocalZRadiusMaskEdit.Text:=
    IntToStr(SourceFocalEllipsoid.DefiningParameters.Radiuses.ZRadiusInMillimeters);
  MainForm.SourceFocalZRadiusMaskEditExit(MainForm);
end; // TMainForm.SourceFocalZMaskEditExit

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

// Изменение абсциссы фокуса исходного эллипсоида
// при нажатии <Enter> в метке.
procedure TMainForm.SourceFocalXMaskEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.SourceFocalXMaskEditKeyDown
  if Key = VK_RETURN
    then MainForm.SourceFocalXMaskEditExit(MainForm);
end; // TMainForm.SourceFocalXMaskEditKeyDown

// Изменение аппликаты фокуса исходного эллипсоида
// при нажатии <Enter> в метке.
procedure TMainForm.SourceFocalZMaskEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.SourceFocalZMaskEditKeyDown
  if Key = VK_RETURN
    then MainForm.SourceFocalZMaskEditExit(MainForm);
end; // TMainForm.SourceFocalZMaskEditKeyDown

// Изменение ординаты фокуса исходного эллипсоида
// при нажатии <Enter> в метке.
procedure TMainForm.SourceFocalYMaskEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin // TMainForm.SourceFocalYMaskEditKeyDown
  if Key = VK_RETURN
    then MainForm.SourceFocalYMaskEditExit(MainForm);
end; // TMainForm.SourceFocalYMaskEditKeyDown

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Изменение угла наклона радиус-вектора фокуса к оси OX.
procedure TMainForm.FOXMaskEditExit(Sender: TObject);
var
  // Новый угл наклона радиус-вектора фокуса к оси OX.
  NewFOXInDegrees: Single;
begin // TMainForm.FOXMaskEditExit
  StatusBar.Panels[0].Text:='';
  with SourceFocalEllipsoid.Focus.Angles do
    begin // with SourceFocalEllipsoid.Focus.Angles
      try
        // Преобразование угла наклона радиус-вектора фокуса к оси в диапазон (-180; 180].
        SetFocalEllipsoidFocusAngleInDegreesToRange(FOXMaskEdit, NewFOXInDegrees);

        if (NewFOXInDegrees<0)
          then begin
                 NewFOXInDegrees:=0;
                 FOZInDegrees:=90;
                 CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
                   'Значение угла наклона радиус-вектора фокуса к оси OX '+
                   'не вошедшее в допустимые пределы [0; 180], '+
                   'исправлено на минимальное!');

                 StatusBar.Panels[0].Text:=CorrectionsString;
               end; // if (NewFOXInDegrees<0)

        // Коррекция значения угла FOZ.
        if ((NewFOXInDegrees>=0) and (NewFOXInDegrees<=90) and
             ((FOZInDegrees<(90-NewFOXInDegrees)) or (FOZInDegrees>(90+NewFOXInDegrees))))
          then begin // if (NewFOXInDegrees>=0) and (NewFOXInDegrees<=90) and
                 FOZInDegrees:=90-NewFOXInDegrees;
                 CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
                   'Значение угла наклона радиус-вектора фокуса к оси OZ '+
                   'не вошедшее в допустимые пределы ['+
                   Format('%7.2f',[90-NewFOXInDegrees])+
                   '; '+Format('%7.2f',[90+NewFOXInDegrees])+
                   '], исправлено на минимальное!');
                 StatusBar.Panels[0].Text:=CorrectionsString;
               end; // if (NewFOXInDegrees>=0) and (NewFOXInDegrees<=90) and}

        if (NewFOXInDegrees>90) and (NewFOXInDegrees<=180) and
           ((FOZInDegrees<(NewFOXInDegrees-90)) or (FOZInDegrees>(270-NewFOXInDegrees)))
          then begin // if (NewFOXInDegrees>90) and (NewFOXInDegrees<=180) and
                 FOZInDegrees:=NewFOXInDegrees-90;
                 CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
                   'Значение угла наклона радиус-вектора фокуса к оси OZ '+
                   'не вошедшее в допустимые пределы ['+
                   Format('%7.2f',[NewFOXInDegrees-90])+
                   '; '+Format('%7.2f',[270-NewFOXInDegrees])+
                   '], исправлено на минимальное!');
                 StatusBar.Panels[0].Text:=CorrectionsString;
               end; // if (NewFOXInDegrees>90) and (NewFOXInDegrees<=180) and
      except
        // При вводе пустой строки или ошибке ввода.
        on EConvertError do
          begin
            NewFOXInDegrees:=0;
            FOZInDegrees:=90;
            CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
              'Некорректное значение '+
              'угла наклона радиус-вектора фокуса к оси OX '+
              'исправлено на минимальное!');
            StatusBar.Panels[0].Text:=CorrectionsString;
          end; // on EConvertError
      end; // except
    end; // with SourceFocalEllipsoid.Focus.Angles

  DisplacedFocalEllipsoid.Focus.Angles.FOZInDegrees:=
    SourceFocalEllipsoid.Focus.Angles.FOZInDegrees;

  // Перерасчёт углов между радиус-вектором и координатными осями.
  SourceFocalEllipsoid.ReSetFocusAngle(NewFOXInDegrees, FOXFocusAngleDeterminator);
  DisplacedFocalEllipsoid.ReSetFocusAngle(NewFOXInDegrees, FOXFocusAngleDeterminator);
  // Вывод всех параметров фокусных эллипсоидов,
  // доступных для просмотра пользователя.
  OutPutAllFocalEllipsoidsParameters;
  // Построение поверхностей.
  if SourceSurface.bDetermined = True
    then GridsForm.BuildSurfacesSpeedButtonClick(GridsForm)
    else Repaint;
end; // TMainForm.FOXMaskEditExit

//******************************************************************************

// Изменение угла наклона радиус-вектора фокуса к оси OY.
procedure TMainForm.FOYMaskEditExit(Sender: TObject);
var
  // Новый угл наклона радиус-вектора фокуса к оси OY.
  NewFOYInDegrees: Single;
begin // TMainForm.FOYMaskEditExit
  StatusBar.Panels[0].Text:='';
  with SourceFocalEllipsoid.Focus.Angles do
    begin // with SourceFocalEllipsoid.Focus.Angles
      try
        // Преобразование угла наклона радиус-вектора фокуса к оси в диапазон (-180; 180].
        SetFocalEllipsoidFocusAngleInDegreesToRange(FOYMaskEdit, NewFOYInDegrees);

        if (NewFOYInDegrees<0) or (NewFOYInDegrees>90)
          then begin
                 NewFOYInDegrees:=0;
                 FOXInDegrees:=90;
                 CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
                   'Значение угла наклона радиус-вектора фокуса к оси OY '+
                   'не вошедшее в допустимые пределы [0; 90], '+
                   'исправлено на минимальное!');
                 StatusBar.Panels[0].Text:=CorrectionsString;
               end; // if (NewFOYInDegrees<0) or (NewFOYInDegrees>90)

        // Коррекция значения угла FOX.
        if (NewFOYInDegrees>=0) and (NewFOYInDegrees<=90) and
           ((FOXInDegrees<(90-NewFOYInDegrees)) or (FOXInDegrees>(90+NewFOYInDegrees)))
          then begin // if (NewFOYInDegrees>=0) and (NewFOYInDegrees<=90) and
                 FOXInDegrees:=90-NewFOYInDegrees;
                 CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
                   'Значение угла наклона радиус-вектора фокуса к оси OX '+
                   'не вошедшее в допустимые пределы ['+
                   Format('%7.2f',[90-NewFOYInDegrees])+
                   '; '+Format('%7.2f',[90+NewFOYInDegrees])+
                   '], исправлено на минимальное!');
                 StatusBar.Panels[0].Text:=CorrectionsString;
               end; // if (NewFOYInDegrees>=0) and (NewFOYInDegrees<=90) and
      except
        // При вводе пустой строки или ошибке ввода.
        on EConvertError do
          begin
            NewFOYInDegrees:=0;
            FOXInDegrees:=90;
            CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
              'Некорректное значение угла наклона радиус-вектора фокуса к оси OY '+
              'исправлено на минимальное!');
            StatusBar.Panels[0].Text:=CorrectionsString;
          end; // on EConvertError
      end; // except
    end; // with SourceFocalEllipsoid.Focus.Angles

  DisplacedFocalEllipsoid.Focus.Angles.FOXInDegrees:=
    SourceFocalEllipsoid.Focus.Angles.FOXInDegrees;

  // Перерасчёт углов между радиус-вектором и координатными осями.
  SourceFocalEllipsoid.ReSetFocusAngle(NewFOYInDegrees, FOYFocusAngleDeterminator);
  DisplacedFocalEllipsoid.ReSetFocusAngle(NewFOYInDegrees, FOYFocusAngleDeterminator);
  // Вывод всех параметров фокусных эллипсоидов,
  // доступных для просмотра пользователя.
  OutPutAllFocalEllipsoidsParameters;
  // Построение поверхностей.
  if SourceSurface.bDetermined = True
    then GridsForm.BuildSurfacesSpeedButtonClick(GridsForm)
    else Repaint;
end; // TMainForm.FOYMaskEditExit

//******************************************************************************

// Изменение угла наклона радиус-вектора фокуса к оси OZ.
procedure TMainForm.FOZMaskEditExit(Sender: TObject);
var
  // Новый угл наклона радиус-вектора фокуса к оси OZ.
  NewFOZInDegrees: Single;
begin // TMainForm.FOZMaskEditExit
  StatusBar.Panels[0].Text:='';
  with SourceFocalEllipsoid.Focus.Angles do
    begin //  with SourceFocalEllipsoid.Focus.Angles
      try
        // Преобразование угла наклона радиус-вектора фокуса к оси в диапазон (-180; 180].
        SetFocalEllipsoidFocusAngleInDegreesToRange(FOZMaskEdit, NewFOZInDegrees);

        if (NewFOZInDegrees<0)
          then begin
                 NewFOZInDegrees:=0;
                 FOYInDegrees:=90;
                 CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
                   'Значение угла наклона радиус-вектора фокуса к оси OX '+
                   'не вошедшее в допустимые пределы [0; 180], '+
                   'исправлено на минимальное!');
                 StatusBar.Panels[0].Text:=CorrectionsString;
               end; // if (NewFOZInDegrees<0)

        // Коррекция значения угла FOY.
        if (NewFOZInDegrees>=0) and (NewFOZInDegrees<=90) and
          ((FOYInDegrees<(90-NewFOZInDegrees)) or (FOYInDegrees>90))
         then begin //  if (NewFOZInDegrees>=0) and (NewFOZInDegrees<=90) and
                FOYInDegrees:=90-NewFOZInDegrees;
                CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
                  'Значение угла наклона радиус-вектора фокуса к оси OY '+
                  'не вошедшее в допустимые пределы ['+
                  Format('%7.2f',[90-NewFOZInDegrees])+
                  '; '+Format('%7.2f',[90])+
                  '], исправлено на минимальное!');
                StatusBar.Panels[0].Text:=CorrectionsString;
              end; //  if (NewFOZInDegrees>=0) and (NewFOZInDegrees<=90) and

       if (NewFOZInDegrees>90) and (NewFOZInDegrees<=180) and
          ((FOYInDegrees<(NewFOZInDegrees-90)) or (FOYInDegrees>90))
         then begin // if (NewFOZInDegrees>90) and (NewFOZInDegrees<=180) and
                FOYInDegrees:=NewFOZInDegrees-90;
                CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
                  'Значение угла наклона радиус-вектора фокуса к оси OY '+
                  'не вошедшее в допустимые пределы ['+
                  Format('%7.2f',[NewFOZInDegrees-90])+
                  '; '+Format('%7.2f',[90])+
                  '], исправлено на минимальное!');
                StatusBar.Panels[0].Text:=CorrectionsString;
              end; // if (NewFOZInDegrees>90) and (NewFOZInDegrees<=180) and
      except
        // При вводе пустой строки или ошибке ввода.
        on EConvertError do
          begin
            NewFOZInDegrees:=0;
            FOYInDegrees:=90;
            CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
              'Некорректное значение '+
              'угла наклона радиус-вектора фокуса к оси OZ '+
              'исправлено на минимальное!');
            StatusBar.Panels[0].Text:=CorrectionsString;
          end; // on EConvertError
      end; // except
    end; //  with SourceFocalEllipsoid.Focus.Angles

  DisplacedFocalEllipsoid.Focus.Angles.FOYInDegrees:=
    SourceFocalEllipsoid.Focus.Angles.FOYInDegrees;

  // Перерасчёт углов между радиус-вектором и координатными осями.
  SourceFocalEllipsoid.ReSetFocusAngle(NewFOZInDegrees, FOZFocusAngleDeterminator);
  DisplacedFocalEllipsoid.ReSetFocusAngle(NewFOZInDegrees, FOZFocusAngleDeterminator);
  // Вывод всех параметров фокусных эллипсоидов,
  // доступных для просмотра пользователя.
  OutPutAllFocalEllipsoidsParameters;
  // Построение поверхностей.
  if SourceSurface.bDetermined = True
    then GridsForm.BuildSurfacesSpeedButtonClick(GridsForm)
    else Repaint;
end; // TMainForm.FOZMaskEditExit

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

// Изменение угла наклона радиус-вектора фокуса к оси OX
// при нажатии <Enter> в метке.
procedure TMainForm.FOXMaskEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin // TMainForm.FOXMaskEditKeyDown
  if Key = VK_RETURN
    then MainForm.FOXMaskEditExit(MainForm);
end; // TMainForm.FOXMaskEditKeyDown

// Изменение угла наклона радиус-вектора фокуса к оси OY
// при нажатии <Enter> в метке.
procedure TMainForm.FOYMaskEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin // TMainForm.FOYMaskEditKeyDown
  if Key = VK_RETURN
    then MainForm.FOYMaskEditExit(MainForm);
end; // TMainForm.FOYMaskEditKeyDown

// Изменение угла наклона радиус-вектора фокуса к оси OZ
// при нажатии <Enter> в метке.
procedure TMainForm.FOZMaskEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin // TMainForm.FOZMaskEditKeyDown
  if Key = VK_RETURN
    then MainForm.FOZMaskEditExit(MainForm);
end; // TMainForm.FOZMaskEditKeyDown

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Изменение отображения центрофокусных линий исходного эллипсоида.
procedure TMainForm.SourceFocalLinesSpeedButtonClick(Sender: TObject);
begin // TMainForm.SourceFocalLinesSpeedButtonClick
// Изменение отображения центрофокусных линий эллипсоида:
// будучи отображёнными, они сокроются, а, скрытые, они будут отображены.
  ChangeViewingEllipsoidFocalLines(bAnyFocalLines,
                                   SourceFocalEllipsoid.Focus.bFocusLines,
                                   SourceFocalLinesSpeedButton,
                                   DisplacedFocalLinesSpeedButton,
                                   DrawSourceFocalLinesMenuItem,
                                   DrawFocalLinesMenuItem,
                                   HideFocalLinesSpeedButton);
end; // TMainForm.SourceFocalLinesSpeedButtonClick

// Изменение отображения центрофокусных линий смещённого эллипсоида.
procedure TMainForm.DisplacedFocalLinesSpeedButtonClick(Sender: TObject);
begin // TMainForm.DisplacedFocalLinesSpeedButtonClick
// Изменение отображения центрофокусных линий эллипсоида:
// будучи отображёнными, они сокроются, а, скрытые, они будут отображены.
  ChangeViewingEllipsoidFocalLines(bAnyFocalLines,
                                   DisplacedFocalEllipsoid.Focus.bFocusLines,
                                   DisplacedFocalLinesSpeedButton,
                                   SourceFocalLinesSpeedButton,
                                   DrawDisplacedFocalLinesMenuItem,
                                   DrawFocalLinesMenuItem,
                                   HideFocalLinesSpeedButton);
end; // TMainForm.DisplacedFocalLinesSpeedButtonClick

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Изменение неотображения центрофокусных линий:
// будучи неотображёнными, они проявятся, а, отображённые, они будут сокрыты.
procedure TMainForm.HideFocalLinesSpeedButtonClick(Sender: TObject);
begin // TMainForm.HideFocalLinesSpeedButtonClick
  // Разрешения на отображение каркаса
  // у кнопки и пункта меню противоположные.
  DrawFocalLinesMenuItem.Checked:=not DrawFocalLinesMenuItem.Checked;
  if DrawFocalLinesMenuItem.Checked=True
    then HideFocalLinesSpeedButton.Down:=False
    else HideFocalLinesSpeedButton.Down:=True;

  if HideFocalLinesSpeedButton.Down=True
    then begin
           bAnyFocalLines:=False;

           SourceFocalLinesSpeedButton.Enabled:=False;
           DisplacedFocalLinesSpeedButton.Enabled:=False;

           DrawSourceFocalLinesMenuItem.Enabled:=False;
           DrawDisplacedFocalLinesMenuItem.Enabled:=False;
         end // if HideFrameworkSpeedButton.Down=True then
    else begin
           bAnyFocalLines:=True;

           SourceFocalLinesSpeedButton.Enabled:=True;
           DisplacedFocalLinesSpeedButton.Enabled:=True;

           DrawSourceFocalLinesMenuItem.Enabled:=True;
           DrawDisplacedFocalLinesMenuItem.Enabled:=True;
         end;  // if HideFrameworkSpeedButton.Down=True else

  Repaint;
end; // TMainForm.HideFocalLinesSpeedButtonClick

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Изменение количества рядов точек поверхности.
procedure TMainForm.ChangeNumberSurfacePointsLines(
  var SurfacePointsLinesEdit: TEdit;
  var NewNumSurfacePointsLines: Byte;
      MinNumSurfacePointsLines,
      MaxNumSurfacePointsLines: Byte;
      LinesInGenitiveCaseString: String);

// SurfacePointsLinesEdit - поле, редактирующее количество рядов точек поверхности.
// NewNumSurfacePointsLines - новое количество рядов точек поверхности.
// MinNumSurfacePointsLines - минимальное количество рядов точек поверхности.
// MaxNumSurfacePointsLines - максимальное количество рядов точек поверхности.
// LinesInGenitiveCaseString - строка названия рядов точек поверхности
//   в родительном падеже.
var
  // Строка-копия.
  TextString: String;

begin // TMainForm.ChangeNumberSurfacePointsLines
  StatusBar.Panels[0].Text:='';
  try
    // Удаление пробелов в тексте.
    // Создание строки-копии.
    TextString:=SurfacePointsLinesEdit.Text;
    // Удаление пробелов в строке.
    DelStringGaps(TextString);
    // Форматирование строки-оригинала.
    SurfacePointsLinesEdit.Text:=TextString;

    NewNumSurfacePointsLines:=
      StrToInt(SurfacePointsLinesEdit.Text);

    if NewNumSurfacePointsLines<MinNumSurfacePointsLines
      then begin
             NewNumSurfacePointsLines:=MinNumSurfacePointsLines;
             SurfacePointsLinesEdit.Text:=IntToStr(NewNumSurfacePointsLines);
             CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
               'Количество '+LinesInGenitiveCaseString+
               ' точек поверхности, меньшее допустимого '+
               'в пределах ['+IntToStr(MinNumSurfacePointsLines)+
               '; '+IntToStr(MaxNumSurfacePointsLines)+'], '+
               'исправлено на минимальное!');
             StatusBar.Panels[0].Text:=CorrectionsString;
           end // if NewNumSurfacePointsLines<MinNumSurfacePointsLines

      else if NewNumSurfacePointsLines>MaxNumSurfacePointsLines
             then begin
                    NewNumSurfacePointsLines:=MaxNumSurfacePointsLines;
                    SurfacePointsLinesEdit.Text:=IntToStr(NewNumSurfacePointsLines);
                    CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
                      'Количество '+LinesInGenitiveCaseString+
                      ' точек поверхности, превысившее допустимое '+
                      'в пределах ['+IntToStr(MinNumSurfacePointsLines)+
                      '; '+IntToStr(MaxNumSurfacePointsLines)+'], '+
                      'исправлено на максимальное!');
                    StatusBar.Panels[0].Text:=CorrectionsString;
                  end; // if NewNumSurfacePointsLines>MaxNumSurfacePointsLines

  except
    // При вводе пустой строки.
    on EConvertError do
      begin
        NewNumSurfacePointsLines:=MinNumSurfacePointsLines;
        SurfacePointsLinesEdit.Text:=IntToStr(NewNumSurfacePointsLines);
        CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
          'Некорректное значение количества '+
          LinesInGenitiveCaseString+' точек поверхности '+
          ' исправлено на исходное!');
        StatusBar.Panels[0].Text:=CorrectionsString;
      end; // on EConvertError
  end; // except
end; // TMainForm.ChangeNumberSurfacePointsLines

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Недоступность объектов отображения поверхностей.
procedure TMainForm.DisableDrawingSurfacesObjects(Sender: TObject);
begin // TMainForm.DisableDrawingSurfacesObjects
  // Недоступность кнопок отображения исходной поверхности.
  FloodedSourceSurfaceSpeedButton.Enabled:=False;
  SourceSurfaceFrameworkSpeedButton.Enabled:=False;
  SourceSurfaceVertexSpeedButton.Enabled:=False;
  // Недоступность кнопок смещённой исходной поверхности.
  FloodedDisplacedSurfaceSpeedButton.Enabled:=False;
  DisplacedSurfaceFrameworkSpeedButton.Enabled:=False;
  DisplacedSurfaceVertexSpeedButton.Enabled:=False;
  // Недоступность кнопки отображения центровых линий.
  CentersLinesSpeedButton.Enabled:=False;

  // Недоступность пунктов меню отображения исходной поверхности.
  FloodedSourceSurfaceMenuItem.Enabled:=False;
  SourceSurfaceFrameworkMenuItem.Enabled:=False;
  SourceSurfaceVertexMenuItem.Enabled:=False;
  // Недоступность пунктов меню смещённой исходной поверхности.
  FloodedDisplacedSurfaceMenuItem.Enabled:=False;
  DisplacedSurfaceFrameworkMenuItem.Enabled:=False;
  DisplacedSurfaceVertexMenuItem.Enabled:=False;
  // Недоступность пункта меню отображения центровых линий.
  CentersLinesMenuItem.Enabled:=False;

  // Недоступность кнопок неотображения поверхностей.
  HideSourceSurfaceSpeedButton.Enabled:=False;
  HideDisplacedSurfaceSpeedButton.Enabled:=False;
  // Недоступность кнопки неотображения центровых линий.
  HideCentersLinesSpeedButton.Enabled:=False;

  // Недоступность пунктов меню отображения поверхностей.
  DrawSourceSurfaceMenuItem.Enabled:=False;
  DrawDisplacedSurfaceMenuItem.Enabled:=False;
end; // TMainForm.DisableDrawingSurfacesObjects

//******************************************************************************

// Доступность объектов отображения поверхностей.
procedure TMainForm.EnableDrawingSurfacesObjects(Sender: TObject);
begin // TMainForm.EnableDrawingSurfacesObjects
  // Если была доступна возможность неотображения исходной поверхности,
  // то возобновить её.
  if SourceSurface.bAnyDraw=True
    then begin // if SourceSurface.bAnyDraw=True then
            DrawSourceSurfaceMenuItem.Enabled:=True;
            HideSourceSurfaceSpeedButton.Enabled:=True;
         end; // if SourceSurface.bAnyDraw=True then

  // Если была доступна возможность отображения элементов исходной поверхности,
  // то возобновитьеё.
  if ((SourceSurface.bAnyDraw=True) and
      (DrawSourceSurfaceMenuItem.Checked=True)) or
     ( SourceSurface.bAnyDraw=False      )
     then begin // if ((SourceSurface.bAnyDraw=True) and
            FloodedSourceSurfaceMenuItem.Enabled:=True;
            SourceSurfaceFrameworkMenuItem.Enabled:=True;
            SourceSurfaceVertexMenuItem.Enabled:=True;

            FloodedSourceSurfaceSpeedButton.Enabled:=True;
            SourceSurfaceFrameworkSpeedButton.Enabled:=True;
            SourceSurfaceVertexSpeedButton.Enabled:=True;
          end; // if ((SourceSurface.bAnyDraw=True) and

  // Если была доступна возможность неотображения смещённой поверхности,
  // то возобновить её.
  if DisplacedSurface.bAnyDraw=True
    then begin // if DisplacedSurface.bAnyDraw=True then
            DrawDisplacedSurfaceMenuItem.Enabled:=True;
            HideDisplacedSurfaceSpeedButton.Enabled:=True;
         end; // if DisplacedSurface.bAnyDraw=True then

  // Если была доступна возможность отображения элементов исходной смещённой,
  // то возобновитьеё.
  if ((DisplacedSurface.bAnyDraw=True) and
      (DrawDisplacedSurfaceMenuItem.Checked=True)) or
     ( DisplacedSurface.bAnyDraw=False      )
     then begin // if ((DisplacedSurface.bAnyDraw=True) and
            FloodedDisplacedSurfaceMenuItem.Enabled:=True;
            DisplacedSurfaceFrameworkMenuItem.Enabled:=True;
            DisplacedSurfaceVertexMenuItem.Enabled:=True;

            FloodedDisplacedSurfaceSpeedButton.Enabled:=True;
            DisplacedSurfaceFrameworkSpeedButton.Enabled:=True;
            DisplacedSurfaceVertexSpeedButton.Enabled:=True;
          end; // if ((DisplacedSurface.bAnyDraw=True) and

  // Возобновить возможность отображения центровых линий.
  CentersLinesMenuItem.Enabled:=True;
  HideCentersLinesSpeedButton.Enabled:=True;
  CentersLinesSpeedButton.Enabled:=True;
end; // TMainForm.EnableDrawingSurfacesObjects

//******************************************************************************
//******************************************************************************

// Установка искажённой смещённой поверхности при получении её точек,
// параллельно перемещённой вдоль их центрофокусных прямых.
procedure TMainForm.SetDistortedDisplacedSurface;
var
  // Параметры циклов.
  i, j: Byte;
  // Признак перемещения исходной точки
  // на поверхность эллипсоид исходного фокуса, а точки,
  // полученной при параллельном переносе исходной, -
  // на поверхность эллипсоид смещённого фокуса
  // во избежение попадания искомой за пределы зрительной области,
  // в  зону отрицательной полуоси координатной оси OY.
  bDisplaceSourceColoredPoint: Boolean;

begin // TMainForm.SetDistortedDisplacedSurface
  for i:=1 to DisplacedSurface.NumberPointsRows do
    for j:=1 to DisplacedSurface.NumberPointsColumns do
      begin // for j
        // Получение точки, параллельно перемещённой вдоль её центрофокусной прямой.
        GetParallelMovedPoint(SourceSurface.GridColoredPoints[i]^[j]^,
                              DisplacedSurface.GridColoredPoints[i]^[j]^,
                              SourceFocalEllipsoid,DisplacedFocalEllipsoid,
                              bDisplaceSourceColoredPoint);
        // Если исходная точка была перемещена.
        if bDisplaceSourceColoredPoint=True
          then begin
                 // Перевод значений координат точки из процентов в миллиметры.
                 SourceSurface.TranslateToMillimetersColoredPointCoordinates(i,j);
                 CorrectionsProtocolMemo.Lines.Add(CorrectionsGapString+
                   'Точка исходной поверхности S['+
                   IntToStr(i)+'; '+IntToStr(j)+'] '+
                   'перемещена на поверхность эллипсоида исходного фокуса, а точка, '+
                   'полученная при параллельном переносе исходной, - '+
                   'на поверхность эллипсоида смещённого фокуса '+
                   'во избежение попадания искомой за пределы зрительной области, '+
                   'в  зону отрицательной полуоси координатной оси OY!');
                 StatusBar.Panels[0].Text:=CorrectionsString;
               end;
        // Перевод значений координат точки из процентов в миллиметры.
        DisplacedSurface.TranslateToMillimetersColoredPointCoordinates(i,j);
      end; // for j
  // Заполнение таблицы значениями координат точек поверхности.
  FillStringGrid(GridsForm.DisplacedSurfaceStringGrid,
                 DisplacedSurfaceStringGridParameters,
                 DisplacedSurface);

  DisplacedSurface.bDetermined:=True;
end; // TMainForm.SetDistortedDisplacedSurface

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Отображение координатных осей.
procedure TMainForm.AxisSpeedButtonClick(Sender: TObject);
begin // TMainForm.AxisSpeedButtonClick
  // Связывание действий объектов, отвечающих за конкретный признак:
  // кнопки истинности признака, кнопки ложности признака и
  // пункта меню истинности признака.
  Connect_SignButton_NotSignButton_SignMenuItem(AxisSpeedButton,
                                                HideAxisSpeedButton,
                                                AxisMenuItem,
                                                bAxis);
end; // TMainForm.AxisSpeedButtonClick

// Отображение центровых линий соединения точек поверхностей
// с опредёлёнными для каждой центрами в соответстии с её областью расположения.
procedure TMainForm.CentersLinesSpeedButtonClick(Sender: TObject);
begin // TMainForm.CentersLinesSpeedButtonClick
  // Связывание действий объектов, отвечающих за конкретный признак:
  // кнопки истинности признака, кнопки ложности признака и
  // пункта меню истинности признака.
  Connect_SignButton_NotSignButton_SignMenuItem(CentersLinesSpeedButton,
                                                HideCentersLinesSpeedButton,
                                                CentersLinesMenuItem,
                                                bDrawCentersLines);
end; // TMainForm.CentersLinesSpeedButtonClick

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Изменение отображения сплошной заливки исходной поверхности.
procedure TMainForm.FloodedSourceSurfaceSpeedButtonClick(Sender: TObject);
begin // TMainForm.FloodedSourceSurfaceSpeedButtonClick
  // Изменение отображения элемента поверхности:
  // будучи отображённым, он сокроется, а, скрытый, он будет отображён.
  ChangeViewingSurface(SourceSurface.bAnyDraw,
                       SourceSurface.bDrawFlooded,
                       FloodedSourceSurfaceSpeedButton,
                       SourceSurfaceFrameworkSpeedButton,
                       SourceSurfaceVertexSpeedButton,
                       FloodedSourceSurfaceMenuItem,
                       DrawSourceSurfaceMenuItem,
                       HideSourceSurfaceSpeedButton);
end; // TMainForm.FloodedSourceSurfaceSpeedButtonClick

// Изменение отображения линий каркаса исходной поверхности.
procedure TMainForm.SourceSurfaceFrameworkSpeedButtonClick(Sender: TObject);
begin // TMainForm.SourceSurfaceFrameworkSpeedButtonClick
  // Изменение отображения элемента поверхности:
  // будучи отображённым, он сокроется, а, скрытый, он будет отображён.
  ChangeViewingSurface(SourceSurface.bAnyDraw,
                       SourceSurface.bDrawFramework,
                       SourceSurfaceFrameworkSpeedButton,
                       FloodedSourceSurfaceSpeedButton,
                       SourceSurfaceVertexSpeedButton,
                       SourceSurfaceFrameworkMenuItem,
                       DrawSourceSurfaceMenuItem,
                       HideSourceSurfaceSpeedButton);
end; // TMainForm.SourceSurfaceFrameworkSpeedButtonClick

// Изменение отображения вершин исходной поверхности.
procedure TMainForm.SourceSurfaceVertexSpeedButtonClick(Sender: TObject);
begin // TMainForm.SourceSurfaceVertexSpeedButtonClick
  // Изменение отображения элемента поверхности:
  // будучи отображённым, он сокроется, а, скрытый, он будет отображён.
  ChangeViewingSurface(SourceSurface.bAnyDraw,
                       SourceSurface.bDrawVertex,
                       SourceSurfaceVertexSpeedButton,
                       FloodedSourceSurfaceSpeedButton,
                       SourceSurfaceFrameworkSpeedButton,
                       SourceSurfaceVertexMenuItem,
                       DrawSourceSurfaceMenuItem,
                       HideSourceSurfaceSpeedButton);
end; // TMainForm.SourceSurfaceVertexSpeedButtonClick

//******************************************************************************

// Изменение отображения сплошной заливки смещённой поверхности.
procedure TMainForm.FloodedDisplacedSurfaceSpeedButtonClick(Sender: TObject);
begin // TMainForm.FloodedDisplacedSurfaceSpeedButtonClick
  // Изменение отображения элемента поверхности:
  // будучи отображённым, он сокроется, а, скрытый, он будет отображён.
  ChangeViewingSurface(DisplacedSurface.bAnyDraw,
                       DisplacedSurface.bDrawFlooded,
                       FloodedDisplacedSurfaceSpeedButton,
                       DisplacedSurfaceFrameworkSpeedButton,
                       DisplacedSurfaceVertexSpeedButton,
                       FloodedDisplacedSurfaceMenuItem,
                       DrawDisplacedSurfaceMenuItem,
                       HideDisplacedSurfaceSpeedButton);
end; // TMainForm.FloodedDisplacedSurfaceSpeedButtonClick

// Изменение отображения линий каркаса смещённой поверхности.
procedure TMainForm.DisplacedSurfaceFrameworkSpeedButtonClick(Sender: TObject);
begin // TMainForm.DisplacedSurfaceFrameworkSpeedButtonClick
  // Изменение отображения элемента поверхности:
  // будучи отображённым, он сокроется, а, скрытый, он будет отображён.
  ChangeViewingSurface(DisplacedSurface.bAnyDraw,
                       DisplacedSurface.bDrawFramework,
                       DisplacedSurfaceFrameworkSpeedButton,
                       FloodedDisplacedSurfaceSpeedButton,
                       DisplacedSurfaceVertexSpeedButton,
                       DisplacedSurfaceFrameworkMenuItem,
                       DrawDisplacedSurfaceMenuItem,
                       HideDisplacedSurfaceSpeedButton);
end; // TMainForm.DisplacedSurfaceFrameworkSpeedButtonClick

// Изменение отображения вершин смещённой поверхности.
procedure TMainForm.DisplacedSurfaceVertexSpeedButtonClick(Sender: TObject);
begin // TMainForm.DisplacedSurfaceVertexSpeedButtonClick
  // Изменение отображения элемента поверхности:
  // будучи отображённым, он сокроется, а, скрытый, он будет отображён.
  ChangeViewingSurface(DisplacedSurface.bAnyDraw,
                       DisplacedSurface.bDrawVertex,
                       DisplacedSurfaceVertexSpeedButton,
                       FloodedDisplacedSurfaceSpeedButton,
                       DisplacedSurfaceFrameworkSpeedButton,
                       DisplacedSurfaceVertexMenuItem,
                       DrawDisplacedSurfaceMenuItem,
                       HideDisplacedSurfaceSpeedButton);
end; // TMainForm.DisplacedSurfaceVertexSpeedButtonClick

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Изменение неотображения исходной поверхности.
procedure TMainForm.HideSourceSurfaceSpeedButtonClick(Sender: TObject);
begin // TMainForm.HideSourceSurfaceSpeedButtonClick
  // Изменение неотображения поверхности:
  // будучи неотображённым, он проявится, а, отображённый, он будут сокрыт.
  ChangeHidingSurface(SourceSurface.bAnyDraw,
                      HideSourceSurfaceSpeedButton,
                      DrawSourceSurfaceMenuItem,

                      FloodedSourceSurfaceSpeedButton,
                      SourceSurfaceFrameworkSpeedButton,
                      SourceSurfaceVertexSpeedButton,

                      FloodedSourceSurfaceMenuItem,
                      SourceSurfaceFrameworkMenuItem,
                      SourceSurfaceVertexMenuItem);

end; // TMainForm.HideSourceSurfaceSpeedButtonClick

// Изменение неотображения смщённой поверхности.
procedure TMainForm.HideDisplacedSurfaceSpeedButtonClick(Sender: TObject);
begin // TMainForm.HideDisplacedSurfaceSpeedButtonClick
  // Изменение неотображения поверхности:
  // будучи неотображённым, он проявится, а, отображённый, он будут сокрыт.
  ChangeHidingSurface(DisplacedSurface.bAnyDraw,
                      HideDisplacedSurfaceSpeedButton,
                      DrawDisplacedSurfaceMenuItem,

                      FloodedDisplacedSurfaceSpeedButton,
                      DisplacedSurfaceFrameworkSpeedButton,
                      DisplacedSurfaceVertexSpeedButton,

                      FloodedDisplacedSurfaceMenuItem,
                      DisplacedSurfaceFrameworkMenuItem,
                      DisplacedSurfaceVertexMenuItem);
end; // TMainForm.HideDisplacedSurfaceSpeedButtonClick

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Отображение проекций.
procedure TMainForm.DrawProjection;
begin // TMainForm.DrawProjection
  with LimitingEllipsoid.DefiningParameters do
    // Отрисовка проекций одного эллипсоида.
    DrawSingleEllipsoidProjection(
      Radiuses.XRadius, Radiuses.YRadius, Radiuses.YRadius,
      Centres.RightCoordinates.X,
      0, 0, 0,
      'LimitingEllipsoid',
      LimitingFrontalProjectionImage,
      LimitingHorizontalProjectionImage,
      LimitingVerticalProjectionImage);

  with SourceFocalEllipsoid do
    // Отрисовка проекций одного эллипсоида.
    DrawSingleEllipsoidProjection(
      DefiningParameters.Radiuses.XRadius,
      DefiningParameters.Radiuses.YRadius,
      DefiningParameters.Radiuses.YRadius,
      DefiningParameters.Centres.RightCoordinates.X,
      Focus.Coordinates.X, Focus.Coordinates.Y, Focus.Coordinates.Z,
      'SourceFocalEllipsoid',
      SourceFocalFrontalProjectionImage,
      SourceFocalHorizontalProjectionImage,
      SourceFocalVerticalProjectionImage);

  with DisplacedFocalEllipsoid do
    // Отрисовка проекций одного эллипсоида.
    DrawSingleEllipsoidProjection(
      DefiningParameters.Radiuses.XRadius,
      DefiningParameters.Radiuses.YRadius,
      DefiningParameters.Radiuses.YRadius,
      DefiningParameters.Centres.RightCoordinates.X,
      Focus.Coordinates.X, Focus.Coordinates.Y, Focus.Coordinates.Z,
      'DisplacedFocalEllipsoid',
      DisplacedFocalFrontalProjectionImage,
      DisplacedFocalHorizontalProjectionImage,
      DisplacedFocalVerticalProjectionImage);

      // Отрисовка проекций фокусных эллипсоидов.
      DrawFocalEllipsoidsProjection(
        SourceFocalEllipsoid.DefiningParameters.Radiuses.XRadius,
        SourceFocalEllipsoid.DefiningParameters.Radiuses.YRadius,
        SourceFocalEllipsoid.DefiningParameters.Radiuses.ZRadius,

        DisplacedFocalEllipsoid.DefiningParameters.Radiuses.XRadius,
        DisplacedFocalEllipsoid.DefiningParameters.Radiuses.YRadius,
        DisplacedFocalEllipsoid.DefiningParameters.Radiuses.ZRadius,

        LimitingEllipsoid.DefiningParameters.Centres.RightCoordinates.X,

        SourceFocalEllipsoid.Focus.Coordinates.X,
        SourceFocalEllipsoid.Focus.Coordinates.Y,
        SourceFocalEllipsoid.Focus.Coordinates.Z,

        DisplacedFocalEllipsoid.Focus.Coordinates.X,
        DisplacedFocalEllipsoid.Focus.Coordinates.Y,
        DisplacedFocalEllipsoid.Focus.Coordinates.Z,

        FocusFrontalProjectionImage,
        FocusHorizontalProjectionImage,
        FocusVerticalProjectionImage);
end; // TMainForm.DrawProjection

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Вызов главной страницы справки.
procedure TMainForm.WhatIsBMPMenuItemClick(Sender: TObject);
var
  ErrorCode: Integer;
begin // TMainForm.WhatIsBMPMenuItemClick
  // Application.HelpContext(1);
  // Открытие справки как внешнего файла, иначе chm-файлы не открываются.
  ErrorCode := Integer(ShellAPI.ShellExecute(Handle, 'open',
               PChar(ExtractFilePath(Application.ExeName) + HelpFileNameString),
               nil, nil, SW_SHOW));
  if ErrorCode <= HINSTANCE_ERROR { = 32 } then
  begin
    case ErrorCode of
      0: Application.MessageBox(PChar
        ('The operating system is out of memory or resources.'),
        'Error', MB_OK or MB_ICONERROR);
      ERROR_FILE_NOT_FOUND: Application.MessageBox(PChar
        ('The specified file was not found.'), 'Error', MB_OK or MB_ICONERROR);
      ERROR_PATH_NOT_FOUND: Application.MessageBox(PChar
        ('The specified path was not found.'), 'Error', MB_OK or MB_ICONERROR);
      ERROR_BAD_FORMAT: Application.MessageBox(PChar
        ('The .exe file is invalid (non-Win32 .exe or error in .exe image).'),
        'Error', MB_OK or MB_ICONERROR);
      SE_ERR_ACCESSDENIED: Application.MessageBox(PChar
        ('The operating system denied access to the specified file.'),
        'Error', MB_OK or MB_ICONERROR);
      SE_ERR_ASSOCINCOMPLETE: Application.MessageBox(PChar
        ('The file name association is incomplete or invalid.'),
        'Error', MB_OK or MB_ICONERROR);
      SE_ERR_DDEBUSY: Application.MessageBox(PChar
        ('The DDE transaction could not be completed because other DDE ' +
        'transactions were being processed.'), 'Error', MB_OK or MB_ICONERROR);
      SE_ERR_DDEFAIL: Application.MessageBox(PChar
        ('The DDE transaction failed.'), 'Error', MB_OK or MB_ICONERROR);
      SE_ERR_DDETIMEOUT: Application.MessageBox
        (PChar('The DDE transaction could not be completed because ' +
        'the request timed out.'), 'Error', MB_OK or MB_ICONERROR);
      SE_ERR_DLLNOTFOUND: Application.MessageBox
        (PChar('The specified DLL was not found.'),
        'Error', MB_OK or MB_ICONERROR);
      {SE_ERR_FNF: Application.MessageBox
        (PChar('The specified file was not found.'),
        'Error', MB_OK or MB_ICONERROR);}
      SE_ERR_NOASSOC: Application.MessageBox(PChar
        ('There is no application associated with the given ' +
        'file name extension. This error will also be returned ' +
        'if you attempt to print a file that is not printable.'),
        'Error', MB_OK or MB_ICONERROR);
      SE_ERR_OOM: Application.MessageBox(PChar
        ('There was not enough memory to complete the operation.'),
        'Error', MB_OK or MB_ICONERROR);
      {SE_ERR_PNF: Application.MessageBox(PChar
        ('The specified path was not found.'), 'Error', MB_OK or MB_ICONERROR);}
      SE_ERR_SHARE: Application.MessageBox(PChar
        ('A sharing violation occurred.'), 'Error', MB_OK or MB_ICONERROR);
    else
      Application.MessageBox(PChar(Format('Unknown Error %d', [ErrorCode])),
        'Error', MB_OK or MB_ICONERROR);
    end; // case ErrorCode of
  end; // if ErrorCode <= HINSTANCE_ERROR}
end; // TMainForm.WhatIsBMPMenuItemClick
{
// Вызов страницы справки "Основные положения БМП-подхода".
procedure TMainForm.BMPApproachMenuItemClick(Sender: TObject);
begin // TMainForm.BMPApproachMenuItemClick
  Application.HelpContext(25);
end; // TMainForm.BMPApproachMenuItemClick

// Вызов страницы справки "Положения гипотезы о распределении LOR-областей".
procedure TMainForm.LORHypothesisMenuItemClick(Sender: TObject);
begin // TMainForm.LORHypothesisMenuItemClick
  Application.HelpContext(26);
end; // TMainForm.LORHypothesisMenuItemClick

// Вызов страницы справки "Экспериментальная система".
procedure TMainForm.ExperimentalSystemMenuItemClick(Sender: TObject);
begin // TMainForm.ExperimentalSystemMenuItemClick
  Application.HelpContext(27);
end; // TMainForm.ExperimentalSystemMenuItemClick

// Вызов страницы справки "Основные компоненты интерфейса  G l a n c e".
procedure TMainForm.InterfaceMenuItemClick(Sender: TObject);
begin // TMainForm.InterfaceMenuItemClick
  Application.HelpContext(2);
end; // TMainForm.InterfaceMenuItemClick
}
// Вызов информации о программе.
procedure TMainForm.AboutProgramMenuItemClick(Sender: TObject);
begin // TMainForm.AboutProgramMenuItemClick
  AboutGlanceForm.ShowModal;
end; // TMainForm.AboutProgramMenuItemClick

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Проверка того, что данный шрифт установлен.
function TMainForm.FontInstalled(    FontName: String;
                                 var bFindFontDirectory: Boolean): Boolean;
// FontName - название шрифта.
// bFindFontDirectory - признак того, что общепринятая директория,
//                      содержащая шрифты. найдена.

var
  // Путь к файлу или директории.
  PathString: String;
  // Запись результатов оиска файла или директории.
  SearchRecord: TSearchRec;

begin // FontInstalled
  {$IOCHECKS OFF}
  // Поиск общепринятого каталога шрифтов.
  bFindFontDirectory:=False;
  PathString:='C:\WINNT\Fonts';
  if FindFirst(PathString,faDirectory,SearchRecord)=0
    then bFindFontDirectory:=True
    else begin
           PathString:='C:\WINDOWS\Fonts';
           if FindFirst(PathString,faDirectory,SearchRecord)=0
             then bFindFontDirectory:=True;
         end;

  // Каталого не найден.
  if bFindFontDirectory=False
    then begin
           FontInstalled:=False;
           Exit;
         end;

  PathString:=PathString+'\'+FontName;
  if FindFirst(PathString,faAnyFile,SearchRecord)=0
    then FontInstalled:=True
    else FontInstalled:=False;
  {$IOCHECKS ON}
end; // FontInstalled

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Закрытие формы.
procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin //  TMainForm.FormClose
  if CloseQuery
    then Application.Terminate;
end; // TMainForm.FormClose

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//******************************************************************************

// Установка формата пиксепля.
procedure TMainForm.PixelFormat;
var
  // Структура, содержащая описание формата пикселей.
  PixelFormatDescriptor: TPixelFormatDescriptor; {*- pfd}
  // Индекс, определяющий конкретный формат пикселей
  // из имеющегося набора форматов.
  IndexPixelFormat: Integer; {*- nPixelFormat}

begin // TMainForm.PixelFormat
  // Заполнение нулями структуры PixelFormatDescriptor
  // для сокращения времени на ззаполнение её полей.
  // FillChar - заполнить символом.
  FillChar(PixelFormatDescriptor,Sizeof(PixelFormatDescriptor),0);

  with PixelFormatDescriptor do
    begin
      // Заполнение размера структуры.
      // Это поле обязательно должно быть заполнено
      // и не доалжно иметь нулевое значение.

      // Версия.
      nVersion:=1;

      // Задание формата пикселей, где отображение происходит в окно формы,
      // поддерживая OpenGL, при наличие двойной буфферизации.
      dwFlags:=PFD_SUPPORT_OPENGL + PFD_DOUBLEBUFFER + PFD_DRAW_TO_WINDOW;
      // Тип цвета.
      iPixelType:=PFD_TYPE_RGBA;

      // Количество цветов.
      cColorBits:=24;

      cAlphaBits:=64;
      cAccumBits:=64;
      cDepthBits:=32;
      cStencilBits:=64;
      iLayerType:=PFD_MAIN_PLANE;
    end; // PixelFormatDescriptor

  // Функция ChoosePixelFormat посматривает в контексте
  // усройства Canvas.Handle(дескриптор окна формы),
  // поддерживаемые форматы пикселей,
  // и выбирает наиболее близкий к описанному в структуре,
  // на которую указывает PixelFormatDescriptor.
  // Эта функция автоматически заполняет структуру так,
  // что она соответствкет некоторому формату пикселей,
  // который поддерживается видеокартой компьютера.
  IndexPixelFormat:=ChoosePixelFormat(Canvas.Handle,@PixelFormatDescriptor); {*- nPixelFormat:=ChoosePixelFormat(Canvas.Handle,@pfd);}

  if IndexPixelFormat<>0
    then SetPixelFormat(Canvas.Handle,IndexPixelFormat,@PixelFormatDescriptor);
end; // TMainForm.PixelFormat

// Установка начальных значений параметров модели БМП.
procedure TMainForm.SetInitialHalfSpace;
var
  // Строка минимального количества каркасных линий в одном октанте.
  MinNumEllipsoidParallelFrameworkLinesInOctantString: String;

  // Активизация поля и связанных с ним кнопок-переключателей
  // и установка минимального количества параллельных линий каркаса в одном октанте.
  procedure EnabledEditAndUpDownAndSetMinNumberParallelFrameworkLiesInOctant(
    var Edit: TEdit;
    var UpDown: TUpDown);

  begin // ActuateEditAndUpDownAndSetMinNumberParallelFrameworkLiesInOctant
    Edit.Enabled:=True;
    UpDown.Enabled:=True;

    Edit.Text:=MinNumEllipsoidParallelFrameworkLinesInOctantString;
  end; // ActuateEditAndUpDownAndSetMinNumberParallelFrameworkLiesInOctant

begin // TMainForm.SetInitialHalfSpace
  // Перерасчёт параметров предельного эллипсоида.
  SetScaleFactorPercentsInMillimeter(50, ScaleFactorPercentsInMillimeter);

  // Создание трёх эллипсоидов: предельного, исходного и смещённого.
  LimitingEllipsoid:=TEllipsoid.Create(
    60, XRadiusDeterminator , 50,
    MinNumEllipsoidParallelFrameworkLinesInOctant,
    MinNumEllipsoidParallelFrameworkLinesInOctant,
    MinNumEllipsoidParallelFrameworkLinesInOctant,
    True, True, True);

  SourceFocalEllipsoid:=TFocalEllipsoid.Create(
    LimitingEllipsoid.DefiningParameters.Centres.BetweenDistanceInMillimeters,
    XRadiusDeterminator, 45,
    MinNumEllipsoidParallelFrameworkLinesInOctant,
    MinNumEllipsoidParallelFrameworkLinesInOctant,
    MinNumEllipsoidParallelFrameworkLinesInOctant,
    True, True, True,
    60, 60);

  DisplacedFocalEllipsoid:=TFocalEllipsoid.Create(
    LimitingEllipsoid.DefiningParameters.Centres.BetweenDistanceInMillimeters,
    XRadiusDeterminator, 40,
    MinNumEllipsoidParallelFrameworkLinesInOctant,
    MinNumEllipsoidParallelFrameworkLinesInOctant,
    MinNumEllipsoidParallelFrameworkLinesInOctant,
    True, True, True,
    SourceFocalEllipsoid.Focus.Angles.FOXInDegrees,
    SourceFocalEllipsoid.Focus.Angles.FOYInDegrees);

  // Установка цветов для объектов модели БМП.
  SetHalfSpaceColors;

  // Признаки отрисовки линий соединения точек центров с фокусами.
  SourceFocalEllipsoid.Focus.bFocusLines:=True;
  DisplacedFocalEllipsoid.Focus.bFocusLines:=True;

  // Параметры вращения.
  StartRotationPlane:=XOZStartRotationPlane;;
  bRotate:=False;
  XAngleMouseButtonLeft:=0;
  YAngleMouseButtonLeft:=0;
  ZAngleMouseButtonLeft:=0;
  XStartAngle:=90;
  YStartAngle:=180;
  ZStartAngle:=0;

  // Параметры увеличения.
  Zoom:=100;
  ZoomMaskEdit.Text:=IntToStr(Zoom);

  // Отображать оси.
  bAxis:= True;

  // Отображать все центрофокусные линии.
  bAnyFocalLines:=True;

  // Вывод параметров предельного эллипсоида.
  LimitingBetweenDistanceMaskEdit.Text:=IntToStr(
    LimitingEllipsoid.DefiningParameters.Centres.BetweenDistanceInMillimeters);

  with LimitingEllipsoid.DefiningParameters.Radiuses do
    begin // with LimitingEllipsoid
      LimitingXRadiusMaskEdit.Text:=IntToStr(XRadiusInMillimeters);
      LimitingYRadiusMaskEdit.Text:=IntToStr(YRadiusInMillimeters);
      LimitingZRadiusMaskEdit.Text:=IntToStr(ZRadiusInMillimeters);
    end; // with LimmitingEllipsoid

  // Создание двух поверхностей: исходной и смещённой.
  SourceSurface:=TSurface.Create;
  DisplacedSurface:=TSurface.Create;
  // Признак отрисовки линий соединения точек поверхностей
  // с точками соответствующих им центров эллипсоида.
  bDrawCentersLines:=True;

  // Вывод всех параметров фокусных эллипсоидов,
  // доступных для просмотра пользователя.
  OutPutAllFocalEllipsoidsParameters;

  // Недоступность объектов отображения поверхностей.
  DisableDrawingSurfacesObjects(MainForm);

  // Управляющие объекты главной формы.
  // Кнопки и пункты меню управляющие отображением осей координат.
  EnbleAndActiveSpeedButtonAndManuItem(AxisSpeedButton, AxisMenuItem);
  // Кнопка неотображения осей координат.
  HideAxisSpeedButton.Enabled:=True;
  HideAxisSpeedButton.Down:=False;

  // Кнопки и пункты меню управляющие отображением центровых линий.
  EnbleAndActiveSpeedButtonAndManuItem(CentersLinesSpeedButton,
                                       CentersLinesMenuItem);
  // Кнопка неотображения осей координат.
  HideCentersLinesSpeedButton.Enabled:=True;
  HideCentersLinesSpeedButton.Down:=False;


  // Кнопки и пункты меню управляющие отображением центрофокусных линий.
  EnbleAndActiveSpeedButtonAndManuItem(SourceFocalLinesSpeedButton,
                                       DrawSourceFocalLinesMenuItem);
  EnbleAndActiveSpeedButtonAndManuItem(DisplacedFocalLinesSpeedButton,
                                       DrawDisplacedFocalLinesMenuItem);
  // Кнопки и пункты меню отображения/неотображения центрофокусных линий.
  EnableAndUpSpeedButtonAndEnableAndCheckedManuItem(
    HideFocalLinesSpeedButton, DrawFocalLinesMenuItem);


  // Кнопки и пункты меню управляющие отображением каркасных линий эллипсоидов.
  EnbleAndActiveSpeedButtonAndManuItem(LimitingFrontalFrameworkSpeedButton,
                                       LimitingFrontalFrameworkMenuItem);

  EnbleAndActiveSpeedButtonAndManuItem(LimitingFrontalFrameworkSpeedButton,
                                       LimitingFrontalFrameworkMenuItem);
  EnbleAndActiveSpeedButtonAndManuItem(LimitingHorizontalFrameworkSpeedButton,
                                       LimitingHorizontalFrameworkMenuItem);
  EnbleAndActiveSpeedButtonAndManuItem(LimitingVerticalFrameworkSpeedButton,
                                       LimitingVerticalFrameworkMenuItem);

  EnbleAndActiveSpeedButtonAndManuItem(SourceFocalFrontalFrameworkSpeedButton,
                                       SourceFocalFrontalFrameworkMenuItem);
  EnbleAndActiveSpeedButtonAndManuItem(SourceFocalHorizontalFrameworkSpeedButton,
                                       SourceFocalHorizontalFrameworkMenuItem);
  EnbleAndActiveSpeedButtonAndManuItem(SourceFocalVerticalFrameworkSpeedButton,
                                       SourceFocalVerticalFrameworkMenuItem);

  EnbleAndActiveSpeedButtonAndManuItem(DisplacedFocalFrontalFrameworkSpeedButton,
                                       DisplacedFocalFrontalFrameworkMenuItem);
  EnbleAndActiveSpeedButtonAndManuItem(DisplacedFocalHorizontalFrameworkSpeedButton,
                                       DisplacedFocalHorizontalFrameworkMenuItem);
  EnbleAndActiveSpeedButtonAndManuItem(DisplacedFocalVerticalFrameworkSpeedButton,
                                       DisplacedFocalVerticalFrameworkMenuItem);


  MinNumEllipsoidParallelFrameworkLinesInOctantString:=
    IntToStr(MinNumEllipsoidParallelFrameworkLinesInOctant);


  // Поля и переключатели количества каркасных линий эллипсоидов.
  EnabledEditAndUpDownAndSetMinNumberParallelFrameworkLiesInOctant(
    LimitingFrontalFrameworkEdit, LimitingFrontalFrameworkUpDown);
  EnabledEditAndUpDownAndSetMinNumberParallelFrameworkLiesInOctant(
    LimitingHorizontalFrameworkEdit, LimitingHorizontalFrameworkUpDown);
  EnabledEditAndUpDownAndSetMinNumberParallelFrameworkLiesInOctant(
    LimitingVerticalFrameworkEdit, LimitingVerticalFrameworkUpDown);

  EnabledEditAndUpDownAndSetMinNumberParallelFrameworkLiesInOctant(
    SourceFocalFrontalFrameworkEdit, SourceFocalFrontalFrameworkUpDown);
  EnabledEditAndUpDownAndSetMinNumberParallelFrameworkLiesInOctant(
    SourceFocalHorizontalFrameworkEdit, SourceFocalHorizontalFrameworkUpDown);
  EnabledEditAndUpDownAndSetMinNumberParallelFrameworkLiesInOctant(
    SourceFocalVerticalFrameworkEdit, SourceFocalVerticalFrameworkUpDown);

  EnabledEditAndUpDownAndSetMinNumberParallelFrameworkLiesInOctant(
    DisplacedFocalFrontalFrameworkEdit, DisplacedFocalFrontalFrameworkUpDown);
  EnabledEditAndUpDownAndSetMinNumberParallelFrameworkLiesInOctant(
    DisplacedFocalHorizontalFrameworkEdit, DisplacedFocalHorizontalFrameworkUpDown);
  EnabledEditAndUpDownAndSetMinNumberParallelFrameworkLiesInOctant(
    DisplacedFocalVerticalFrameworkEdit, DisplacedFocalVerticalFrameworkUpDown);


  // Кнопки и пункты меню отображения/неотображения каркасных линий эллипсоидов.
  EnableAndUpSpeedButtonAndEnableAndCheckedManuItem(
    HideLimitingFrameworkSpeedButton, LimitingFrameworkMenuItem);
  EnableAndUpSpeedButtonAndEnableAndCheckedManuItem(
    HideSourceFocalFrameworkSpeedButton, SourceFocalFrameworkMenuItem);
  EnableAndUpSpeedButtonAndEnableAndCheckedManuItem(
    HideDisplacedFocalFrameworkSpeedButton, DisplacedFocalFrameworkMenuItem);


  // Кнопки и пункты меню управляющие отображением
  // конструктивных элементов поверхностей.
  EnbleAndActiveSpeedButtonAndManuItem(FloodedSourceSurfaceSpeedButton,
                                       FloodedSourceSurfaceMenuItem);
  EnbleAndActiveSpeedButtonAndManuItem(SourceSurfaceFrameworkSpeedButton,
                                       SourceSurfaceFrameworkMenuItem);
  EnbleAndActiveSpeedButtonAndManuItem(SourceSurfaceVertexSpeedButton,
                                       SourceSurfaceVertexMenuItem);

  EnbleAndActiveSpeedButtonAndManuItem(FloodedDisplacedSurfaceSpeedButton,
                                       FloodedDisplacedSurfaceMenuItem);
  EnbleAndActiveSpeedButtonAndManuItem(DisplacedSurfaceFrameworkSpeedButton,
                                       DisplacedSurfaceFrameworkMenuItem);
  EnbleAndActiveSpeedButtonAndManuItem(DisplacedSurfaceVertexSpeedButton,
                                       DisplacedSurfaceVertexMenuItem);

  // Кнопки и пункты меню отображения/неотображения
  // конструктивных элементов поверхностей.
  EnableAndUpSpeedButtonAndEnableAndCheckedManuItem(
    HideSourceSurfaceSpeedButton, DrawSourceSurfaceMenuItem);
  EnableAndUpSpeedButtonAndEnableAndCheckedManuItem(
    HideDisplacedSurfaceSpeedButton, DrawDisplacedSurfaceMenuItem);


  if not bGridFormCreated
    then MainForm.SetGridsFormFocusSpeedButtonClick(MainForm);
  
  with GridsForm do
    begin // with GridsForm do
      Hide;
      // Количество точек поверхностей.
      SurfacePointsRowsEdit.Text:=IntToStr(MinNumSurfacePointsRows);
      SurfacePointsColumnsEdit.Text:=IntToStr(MinNumSurfacePointsColumns);

      SourceSurfaceStringGrid.RowCount:=   1 + MinNumSurfacePointsRows;
      DisplacedSurfaceStringGrid.RowCount:=1 + MinNumSurfacePointsRows;
      SurfaceAreaStringGrid.RowCount:=     1 + MinNumSurfacePointsRows;

      SourceSurfaceStringGrid.ColCount:=   1 + 3*MinNumSurfacePointsColumns;
      DisplacedSurfaceStringGrid.ColCount:=1 + 3*MinNumSurfacePointsColumns;
      SurfaceAreaStringGrid.ColCount:=     1 +   MinNumSurfacePointsColumns;

      // Очистка таблиц.
      CleanStringGridsSpeedButtonClick(GridsForm);

      Close;
    end; // with GridsForm do
end; // TMainForm.SetInitialHalfSpace

//Установка формата пикселей на дескриптор окна формы.
procedure TMainForm.FormCreate(Sender: TObject);
var
  // Параметр циклa.
  i: Byte;

begin // TInnerForm.FormCreate
  // Минимальные размеры рабочей области и расположение окна формы.
  ClientWidth:=ClientMinimizedWindowWidth;
  ClientHeight:=ClientMinimizedWindowHeight;
  // Размещение формы по центру рабочей области экрана.
  CentreScreenWorkAreaFormPosition(MainForm);

  // Максимальные размеры рабочей области.
  ClientMaximizedWindowHeight:=Screen.WorkAreaHeight - (Height - ClientHeight);
  ClientMaximizedWindowWidth:=ClientMaximizedWindowHeight -
                              ToolBar.Height - HalfSpaceTitlePanel.Height;

  // Расчёт коэффициента количества процентов
  // области отображения в миллиметре
  SetScaleFactorPercentsInMillimeter(50,ScaleFactorPercentsInMillimeter);

  // Прзнак того, что форма с таблицами создаётся впервые.
  bFirstGridsFormShow:=True;
  // Признак того, что форма таблиц уже создана.
  bGridFormCreated:=False;    
  // Установка начальных значений параметров модели БМП.
  SetInitialHalfSpace;

  // Установка формата пикселя.
  PixelFormat;
  // Признак создания контекста отображения.
  bImageContextCreated:=False;

  // Цвет тумана равен цвету фона.
  with BackgroundColorComponents do
    begin // with BackgroundColorComponents do
      FogColor[1]:=Red;
      FogColor[2]:=Green;
      FogColor[3]:=Blue;
      FogColor[4]:=AlphaChannel;
    end; // with BackgroundColorComponents do

  // Компонент который в данный момент является развёрнутым, NoneMaximased,
  // когда все находятся в исходном состоянии.
  MaximasedMainFormComponent:=NoneMainFormMaximased;
  // Признак изменения размеров окна.
  bChangedWindowSize:=False;

  ResizeCorrectionsProtocolAreaSpeedButton.Hint:='Развернуть';
  // Изображение, содержащее изменения размеров областей окна.
  ResizeAreaBitMap:=TBitMap.Create;
  // Изображение для расширения области протокола коррекции ввода данных.
  CommonImageList.GetBitmap(0,ResizeAreaBitMap);
  ResizeCorrectionsProtocolAreaSpeedButton.Glyph:=ResizeAreaBitMap;
  // Изображение для расширения области полупространства в окне формы.
  CommonImageList.GetBitmap(2,ResizeAreaBitMap);
  ResizeHalfSpaceAreaSpeedButton.Glyph:=ResizeAreaBitMap;
  
  // Отображаются все таблицы на форме таблиц, кроме таблицы с угловыми точками.
  MaximasedGridsFormComponent:=NoneGridsFormComponentMaximased;
  bSourceSurfaceCornersStringGridPanelShow:=False;

  // Правая кнопка размещения окна по центру экрана всегда находится с правого края окна.
  MiddleGapSeparatorToolButton.Width:=1;
  MiddleGapSeparatorToolButton.Width:=
    ToolBar.Width - MiddleGapSeparatorToolButton.Left -
    CentreScreenFormPositionRightSpeedButton.Width - 2*LeftGapSeparatorToolButton.Width;

  // Номер N файла с названием 'Модель_N', содержащим основные параметры объектов БМП.
  StartModelNameIndex:=1;

  SourceSurfaceStringGridTitleBitMap:=TBitMap.Create;
  SourceSurfaceCornersStringGridTitleBitMap:=TBitMap.Create;
  DisplacedSurfaceStringGridTitleBitMap:=TBitMap.Create;
  SurfaceAreaStringGridTitleBitMap:=TBitMap.Create;
  SurfaceAreaStringGridLeftAreaCellBitMap:=TBitMap.Create;
  SurfaceAreaStringGridCentreAreaCellBitMap:=TBitMap.Create;
  SurfaceAreaStringGridRightAreaCellBitMap:=TBitMap.Create;

  SourceSurfaceStringGridTitleBitMap.LoadFromFile(
    'GridsImages/SourceSurfaceStringGridTitle.bmp');
  SourceSurfaceCornersStringGridTitleBitMap.LoadFromFile(
    'GridsImages/SourceSurfaceCornersStringGridTitle.bmp');
  DisplacedSurfaceStringGridTitleBitMap.LoadFromFile(
    'GridsImages/DisplacedSurfaceStringGridTitle.bmp');
  SurfaceAreaStringGridTitleBitMap.LoadFromFile(
    'GridsImages/SurfaceAreaStringGridTitle.bmp');
  SurfaceAreaStringGridLeftAreaCellBitMap.LoadFromFile(
    'GridsImages/SurfaceAreaStringGridLeftAreaCell.bmp');
  SurfaceAreaStringGridCentreAreaCellBitMap.LoadFromFile(
    'GridsImages/SurfaceAreaStringGridCentreAreaCell.bmp');
  SurfaceAreaStringGridRightAreaCellBitMap.LoadFromFile(
    'GridsImages/SurfaceAreaStringGridRightAreaCell.bmp');

  // Изорражения на страницах настроек.
  for i:=0 to 3 do
    PageControlImages[i]:=TBitMap.Create;

  PageControlImages[0].LoadFromFile('MainImages/LimitingEllipsoid.bmp');
  PageControlImages[1].LoadFromFile('MainImages/SourceFocalEllipsoid.bmp');
  PageControlImages[2].LoadFromFile('MainImages/DisplacedFocalEllipsoid.bmp');
  PageControlImages[3].LoadFromFile('MainImages/FocuseDirection.bmp');
end; // TInnerForm.FormCreate


procedure TMainForm.FormPaint(Sender: TObject);
var
  // Структура, содержащая параметры рисования.
  PaintStructure: TPaintStruct;
  // Контекст воспроизведения - информация об устройстве,
  // на котором будет происходить отображение.
  HandleDescriptor: HDC;

const
  // Цвет фонового освещения.
  Ambient:     array[1..4] of GLFloat = (0.6, 0.6, 0.6, 1);
  // Цвет диффузного освещения.
  Diffuse:     array[1..4] of GLFloat = (0.8, 0.8, 0.8, 1);
  // Цвет минимального диффузного освещения.
  MinDiffuse:  array[1..4] of GLFloat = (0.2, 0.2, 0.2, 1);
  // Цвет зеркального ортражения.
  Specular:    array[1..4] of GLFloat = (0.7, 0.7, 0.7, 1);
  // Степень зеркального отражения материала.
  Shininess = 70;
  // Максимальная степень зеркального отражения материала.
  MaxShininess = 128;
  // Положение источника света.
  PositionLight0:   array[1..4] of GLFloat = (0,   1,   0,   1);

begin // TInnerForm.FormPaint
  // Если размеры окна были изменеы.
  if bChangedWindowSize = True
    then begin
           // Текущий контекст воспроизведения OpenGL никем не будет использоваться.
           wglMakeCurrent(0,0);
           // Удаление контекста воспроизведения.
           wglDeleteContext(ImageContextDescriptor);
           // Признак создания контекста отображения.
           bImageContextCreated:=False;
           // Признак изменения размеров окна.
           bChangedWindowSize:=False;
         end; // if bChangedWindowSize = False

  // Если ещё не создан кортекст отображения, то он создаётся.
  if bImageContextCreated = False
    then begin
           // Функция возвращает новый контекст воспроизведения,
           // который подходит для рисования на устройстве,
           // определённом девкриптором ImageContextDescriptor.
           ImageContextDescriptor:=wglCreateContext(Canvas.Handle);
           // Созжание единственного текущего контекста воспроизведения
           // для работы с графикой OpenGL.
           wglMakeCurrent(Canvas.Handle,ImageContextDescriptor);
           // Признак создания контекста отображения.
           bImageContextCreated:=True;
         end; // if bImageContextCreated = False

  // Область видимости на форме в зависимости от размеров окна формы.
  if MaximasedMainFormComponent = NoneMainFormMaximased
    then begin
           // Перемена мест буферов
           // и вывод вторичного буфера, ставшего главным, на экран.
           // Буферы меняются местами дважды: в начале и в конце -
           // для уменьшения эффекта мерцания при перерисовке формы,
           // хотя это несколько снижает быстродействие.
           // Это необходимо, когда мерцание особенно заметно
           // при быстром изменении количества линий каркаса эллипсоидов,
           // но повторная перемена мест не нужна при увеличенном просмотре
           // (для повышения быстродействия),
           // где невозможно редактирование количества каркасных линий.
           SwapBuffers(Canvas.Handle);

           glViewPort(ToolPanel.Width,
                      StatusBar.Height + CorrectionsProtocolPanel.Height,
                      CorrectionsProtocolPanel.Width - 1,
                      CorrectionsProtocolPanel.Width - 1);
         end
    else glViewPort(0, 0,
                    ClientMaximizedWindowWidth,
                    ClientMaximizedWindowWidth);

    // Установка матрицы.
  glMatrixMode(GL_PROJECTION);
  // Загружается единичная матрица.
  glLoadIdentity();    

  // Начало перерисовки экрана.
  BeginPaint(Canvas.Handle,PaintStructure);

  // Определение красного, зелёного и синего компонентов цвета фона,
  // а также прозрачность (альфа-канал),
  // которые используются при очистке буфера цвета.
  with BackgroundColorComponents do
    glClearColor(Red, Green, Blue, AlphaChannel);

  // Очистка текущей сцены.
  // Параметр GL_COLOR_BUFFER_BIT - буферы, доступные для записи цвета -
  // определяет очищаемые буферы,
  // которые могут задаваться при помощи поразрядной операции ИЛИ.
  glClear(GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT);

  // Масштабирование исходных объектов.
  glScalef(Zoom/100,Zoom/100,Zoom/100);
  // Вращение под заданными углами к нормалям координатных плоскостей.
  glRotate(YAngleMouseButtonLeft + XStartAngle,1,0,0);
  glRotate(XAngleMouseButtonLeft + YStartAngle,0,1,0);
  glRotate(ZAngleMouseButtonLeft + ZStartAngle,0,0,1);

  // Режим тумана.
  glFogi(GL_FOG_MODE, GL_EXP);
  // Плотность (густота) тумана.
  glFogf(GL_FOG_DENSITY, 1.15);
  // Начало действия тумана.
  glFogf(GL_FOG_START, LimitingEllipsoid.DefiningParameters.Radiuses.XRadius/3);
  // Конец действия тумана.
  glFogf(GL_FOG_END, LimitingEllipsoid.DefiningParameters.Radiuses.XRadius);
  // Цвет тумана.
  glFogfv(GL_FOG_COLOR, @FogColor);

  // Включения режима сглаживания для того,
  // чтобы точки были не квдратными , а круглыми.
  glEnable(GL_POINT_SMOOTH);
  // Включение теста глубины - учёт третьего измерения.
  glEnable(GL_DEPTH_TEST);
  // Включение тумана.
  glEnable(GL_FOG);

  // Матовый материал.
  // Определение реакции материала на освещение.
  glMaterialfv(GL_FRONT_AND_BACK,GL_AMBIENT,@Ambient);
  glMaterialfv(GL_FRONT_AND_BACK,GL_DIFFUSE,@Diffuse);
  glMaterialfv(GL_FRONT_AND_BACK,GL_SPECULAR,@Specular);
  glMateriali(GL_FRONT_AND_BACK,GL_SHINiNESS,MaxShininess);
  // Характерискики источника света.
  glLightfv(GL_LIGHT0,GL_AMBIENT,@Ambient);
  glLightfv(GL_LIGHT0,GL_DIFFUSE,@MinDiffuse);
  glLightfv(GL_LIGHT0,GL_SPECULAR,@Specular);
  glLightfv(GL_LIGHT0,GL_POSITION,@PositionLight0);
  glLightModeli(GL_LIGHT_MODEL_TWO_SIDE, 1);

  // Разрешение освещения поверхности.
  glEnable(GL_COLOR_MATERIAL);
  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
  glEnable(GL_BLEND);


  // Отображение эллипсоида смещённого фокуса.
  DisplacedFocalEllipsoid.Draw(EllipsoidVertexLineWidth);
  // Отображение исходного фокусного эллипсоида.
  SourceFocalEllipsoid.Draw(EllipsoidVertexLineWidth);
  // Отображение предельного эллипсоида.
  LimitingEllipsoid.Draw(EllipsoidVertexLineWidth);


  // Запрещение освещения.
  glDisable(GL_COLOR_MATERIAL);
  glDisable(GL_LIGHTING);
  glDisable(GL_LIGHT0);
  glDisable(GL_BLEND);

  // Отрисовка точек поверхностей.
  DisplacedSurface.DrawVertex(SurfacePointSize);
  SourceSurface.DrawVertex(SurfacePointSize);

  
  // Хорошо отражающий материал.
  glLightfv(GL_LIGHT0,GL_DIFFUSE,@Diffuse);
  glMateriali(GL_FRONT_AND_BACK,GL_SHINiNESS,Shininess);

  // Хорошо отражающий материал.
  // Разрешение освещения поверхности.
  glEnable(GL_COLOR_MATERIAL);
  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
  glEnable(GL_BLEND);

  // Отрисовка линий соединения точек поверхностей
  // с точками соответствующих им центров эллипсоида.
  DrawCentersLines(SourceSurface, DisplacedSurface, DisplacedFocalEllipsoid,
                   LeftCentreColorComponents, RightCentreColorComponents,
                   VectorCenterToSurfacePointLineWidth);

  // Отрисовка линий каркаса поверхностей.
  DisplacedSurface.DrawFramework(SurfaceVertexLineWidth);
  SourceSurface.DrawFramework(SurfaceVertexLineWidth);

  // Отрисовка залитых повеохностей.
  DisplacedSurface.DrawFlooded;
  SourceSurface.DrawFlooded;


  // Отключение теста глубины.
  glDisable(GL_DEPTH_TEST);
  // Отключение тумана.
  glDisable(GL_FOG);

  // Матовый материал.
  glLightfv(GL_LIGHT0,GL_DIFFUSE,@MinDiffuse);
  glMateriali(GL_FRONT_AND_BACK,GL_SHINiNESS,MaxShininess);

  // Отрисовка центрофокусных линий эллипсоидов -
  // линий соединения точек центров эллипсоидов с фокусомами.
  DrawFocalLines;
  // Отрисовка координатных осей.
  DrawAxis;


  // Запрещение освещения.
  glDisable(GL_COLOR_MATERIAL);
  glDisable(GL_LIGHTING);
  glDisable(GL_LIGHT0);
  glDisable(GL_BLEND);

  // Отрисовка зрительных центров и фокусов.
  DrawCentresAndFocuses;


  // Вылючение режима сглаживания.
  glDisable(GL_POINT_SMOOTH);

  // Окончательная прорисовка подготовленной сцены в буфере видеопамяти.
  glFlush();
  // Перемена мест буферов
  // и вывод вторичного буфера, ставшего главным, на экран.
  SwapBuffers(Canvas.Handle);
  // Конец рисования
//  glFinish();
  EndPaint(Canvas.Handle, PaintStructure);

  // Отображение проекций.
  if bRotate = False
    then DrawProjection;
end; // TInnerForm.FormPaint

procedure TMainForm.FormDestroy(Sender: TObject);
var
  // Параметр циклов.
  i: Byte;

begin // TMainForm.FormDestroy
  ResizeAreaBitMap.Free;

  LimitingEllipsoid.DisposeFrameworkLinesIn1Octant;
  LimitingEllipsoid.Free;
  SourceFocalEllipsoid.DisposeFrameworkLinesIn1Octant;
  SourceFocalEllipsoid.Free;
  DisplacedFocalEllipsoid.DisposeFrameworkLinesIn1Octant;
  DisplacedFocalEllipsoid.Free;
  SourceSurface.DisposeGrids;
  SourceSurface.Free;
  DisplacedSurface.DisposeGrids;
  DisplacedSurface.Free;

  // Текущий контекст воспроизведения OpenGL никем не будет использоваться.
  wglMakeCurrent(0,0);
  // Удаление контекста воспроизведения.
  wglDeleteContext(ImageContextDescriptor);

  SourceSurfaceStringGridTitleBitMap.Free;
  SourceSurfaceCornersStringGridTitleBitMap.Free;
  DisplacedSurfaceStringGridTitleBitMap.Free;
  SurfaceAreaStringGridTitleBitMap.Free;
  SurfaceAreaStringGridLeftAreaCellBitMap.Free;
  SurfaceAreaStringGridCentreAreaCellBitMap.Free;
  SurfaceAreaStringGridRightAreaCellBitMap.Free;

  // Изорражения на страницах настроек.
  for i:=0 to 3 do
    PageControlImages[i].Free;
end; // TMainForm.FormDestroy

// Захват опорной точки и сигнал к началу вращения.
procedure TMainForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin // InnerForm.FormMouseDown
  if Button=mbLeft
    then begin
           XPositionMouseButtonLeft:=X;
           YPositionMouseButtonLeft:=Y;
           bRotate:=True;
         end;
end; // TInnerForm.FormMouseDown

// Признак конца вращения.
procedure TMainForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin // TInnerForm.FormMouseUp
  if Button=mbLeft
    then bRotate:=False;
end; // TInnerForm.FormMouseUp

// Вращение ассоциируется с передвижением мыши:
// расчитывается углы поворота через перемещение курсора.
procedure TMainForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);

  // Изменение углов поворота исходной плоскости вращения.
  procedure ReSetAnglesMouseButtonLeft(var HorizontalAngleMouseButtonLeft,
                                           VerticalAngleMouseButtonLeft: Single);
  begin // ReSetAnglesMouseButtonLeft
    HorizontalAngleMouseButtonLeft:=HorizontalAngleMouseButtonLeft+
                                    (XPositionMouseButtonLeft - X)/2;
    VerticalAngleMouseButtonLeft:=VerticalAngleMouseButtonLeft+
                                  (YPositionMouseButtonLeft - Y)/2;
  end; // ReSetAnglesMouseButtonLeft

begin // TInnerForm.FormMouseMove
  if bRotate
    then begin
           // Координатная плоскость, вращаемая при обзоре.
           case StartRotationPlane of
             XOYStartRotationPlane:
               ReSetAnglesMouseButtonLeft(XAngleMouseButtonLeft,
                                          YAngleMouseButtonLeft);
             XOZStartRotationPlane:
               ReSetAnglesMouseButtonLeft(ZAngleMouseButtonLeft,
                                          YAngleMouseButtonLeft);
             YOZStartRotationPlane:
               ReSetAnglesMouseButtonLeft(ZAngleMouseButtonLeft,
                                          YAngleMouseButtonLeft);
           end; // case

           XPositionMouseButtonLeft:=X;
           YPositionMouseButtonLeft:=Y;
           InvalidateRect(Handle,nil,false);
         end;
end; // TInnerForm.FormMouseMove

procedure TMainForm.ResizeHalfSpaceAreaSpeedButtonClick(Sender: TObject);
begin
  MiddleGapSeparatorToolButton.Width:=1;

  // Признак минимальных размеров окна формы.
  if MaximasedMainFormComponent = NoneMainFormMaximased
    then begin
           CorrectionsProtocolPanel.Hide;
           ToolPanel.Hide;
           StatusBar.Hide;

           // Максимальные размеры рабочей области и расположение окна формы.
           ClientWidth:=ClientMaximizedWindowWidth;
           ClientHeight:=ClientMaximizedWindowHeight;

           HalfSpaceTitlePanel.Width:=ClientWidth;
           HalfSpaceTitlePanel.Left:=0;

           ResizeHalfSpaceAreaSpeedButton.Hint:='Восстановить';
           // Изображение для восстановления области полупространства в окне формы.
           CommonImageList.GetBitmap(3,ResizeAreaBitMap);
           ResizeHalfSpaceAreaSpeedButton.Glyph:=ResizeAreaBitMap;

           MaximasedMainFormComponent:=HalfSpaceAreaMaximased;
         end
    else begin
           // Минимальные размеры рабочей области и расположение окна формы.
           ClientWidth:=ClientMinimizedWindowWidth;
           ClientHeight:=ClientMinimizedWindowHeight;

           HalfSpaceTitlePanel.Width:=CorrectionsProtocolPanel.Width;
           HalfSpaceTitlePanel.Left:=CorrectionsProtocolPanel.Left;

           CorrectionsProtocolPanel.Show;
           ToolPanel.Show;
           StatusBar.Show;

           ResizeHalfSpaceAreaSpeedButton.Hint:='Развернуть';
           // Изображение для развёртывания области полупространства в окне формы.
           CommonImageList.GetBitmap(2,ResizeAreaBitMap);
           ResizeHalfSpaceAreaSpeedButton.Glyph:=ResizeAreaBitMap;

           MaximasedMainFormComponent:=NoneMainFormMaximased;
         end;

  MiddleGapSeparatorToolButton.Width:=
    ToolBar.Width - MiddleGapSeparatorToolButton.Left -
    CentreScreenFormPositionRightSpeedButton.Width - 2*LeftGapSeparatorToolButton.Width;

  // Размещение формы по центру рабочей области экрана.
  CentreScreenWorkAreaFormPosition(MainForm);
  // Признак изменения размеров окна.
  bChangedWindowSize:=True;
  Repaint
end;

procedure TMainForm.ResizeCorrectionsProtocolAreaSpeedButtonClick(
  Sender: TObject);
begin
  if MaximasedMainFormComponent = NoneMainFormMaximased
    then begin
           HalfSpaceTitlePanel.Hide;
           ResizeHalfSpaceAreaSpeedButton.Enabled:=False;
           CorrectionsProtocolPanel.Top:=33;
           CorrectionsProtocolPanel.Height:=580;

           ResizeCorrectionsProtocolAreaSpeedButton.Hint:='Восстановить';
           // Изображение для восстановления области протокола коррекции ввода данных.
           CommonImageList.GetBitmap(1,ResizeAreaBitMap);
           ResizeCorrectionsProtocolAreaSpeedButton.Glyph:=ResizeAreaBitMap;

           MaximasedMainFormComponent:=CorrectionsProtocolMemoMaximased;
         end
    else begin
           HalfSpaceTitlePanel.Show;
           ResizeHalfSpaceAreaSpeedButton.Enabled:=True;
           CorrectionsProtocolPanel.Top:=503;
           CorrectionsProtocolPanel.Height:=111;

           ResizeCorrectionsProtocolAreaSpeedButton.Hint:='Развернуть';
           // Изображение для расширения области протокола коррекции ввода данных.
           CommonImageList.GetBitmap(0,ResizeAreaBitMap);
           ResizeCorrectionsProtocolAreaSpeedButton.Glyph:=ResizeAreaBitMap;

           MaximasedMainFormComponent:=NoneMainFormMaximased;
         end;
end;


procedure TMainForm.ShowGridsFormSpeedButtonClick(Sender: TObject);
begin
  // Если форма таблиц ещё не создана,
  // то она создаётся, иначе на неё прокто переводится фокус.
  if bGridFormCreated = False
    then begin
           GridsForm:=TGridsForm.Create(Owner);
           //  Application.CreateForm(TGridsForm, GridsForm);
           GridsForm.Show;
         end
    else GridsForm.SetFocus;
end;

procedure TMainForm.CentreScreenFormPositionRightSpeedButtonClick(
  Sender: TObject);
begin
  // Размещение формы по центру рабочей области экрана.
  CentreScreenWorkAreaFormPosition(MainForm);
end;

procedure TMainForm.SetGridsFormFocusSpeedButtonClick(Sender: TObject);
begin
  // Если форма таблиц ещё не создана,
  // то она создаётся, иначе на неё прокто переводится фокус.
  if bGridFormCreated = False
    then begin
           GridsForm:=TGridsForm.Create(Owner);
           //  Application.CreateForm(TGridsForm, GridsForm);
           GridsForm.Show;
         end
    else GridsForm.SetFocus;
end;

procedure TMainForm.OpenFileSpeedButtonClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
  FileName: String;
  FileExtention, p, q: String;

begin // TMainForm.OpenFileSpeedButtonClick
  // Создание объекта OpenDialog.
  OpenDialog:=TOpenDialog.Create(self);

  // Только разрешенные существующие файлы могут быть выбраны.
  OpenDialog.Options:=OpenSaveDialogOptions;

  // Разрешено выбрать только определённые расширения файлов.
  OpenDialog.Filter:=OpenSaveDialogFilter;
  // Выбор файлов Модели БМП как стартовый тип фильтра.
  OpenDialog.FilterIndex:=OpenSaveDialogFilterIndex;

  // 3D-вид.
  OpenDialog.Ctl3D:=true;
  // Заголовок.
  OpenDialog.Title:='Загрузка объектов БМП';

  // Важно!!! Директория по умолчанию меняется и диалог
  // всякий раз создаётся заново, только тогда работает.
  SetCurrentDir(ExtractFilePath(Application.ExeName) +
                OpenSaveDialogInitialDirectory);
  // Нужно, чтобы InitialDir сработало.
  OpenDialog.FileName:='';
  // Установка начального каталога, чтобы сделать его текущим.
  OpenDialog.InitialDir:=GetCurrentDir();

  // Показ диалога открытия файла
  if OpenDialog.Execute
    then begin
           FileName:= OpenDialog.FileName;
           FileExtention:=ExtractFileExt(FileName);

           if OpenDialog.FilterIndex = 1
             then begin // if OpenDialog.FilterIndex = 1
                    // Создание новой модели БМП.
                    NewFileSpeedButtonClick(MainForm);

                    FileName:=ChangeFileExt(FileName, '.hsp');
                    LoadHalfSpaceBaseParametersFromFile(FileName);
                    FileName:=ChangeFileExt(FileName, '.ssp');
                    LoadSourceSurfacePointsCoordinatesFromFile(FileName);
                  end; // if OpenDialog.FilterIndex = 1

           // if FileExtention = '.hsp'
           if OpenDialog.FilterIndex = 2
             // Загрузка параметров БМП из файла.
             then LoadHalfSpaceBaseParametersFromFile(FileName);

           // if FileExtention = '.ssp'
           if OpenDialog.FilterIndex = 3
             // Загрузка координат точек исходной поверхности.
             then LoadSourceSurfacePointsCoordinatesFromFile(FileName);
         end; // if openDialog.Execute then

  // Освобождение диалога
  OpenDialog.Free;
end; // TMainForm.OpenFileSpeedButtonClick

procedure TMainForm.SaveFileSpeedButtonClick(Sender: TObject);
var
  SaveDialog: TSaveDialog;
  FileName: String;

begin
  // Создание объекта OpenDialog.
  SaveDialog:=TSaveDialog.Create(self);

  // Опции на запись файлов.
  SaveDialog.Options:=OpenSaveDialogOptions;

  // Разрешено сохранять файлы только заданных типов.
  SaveDialog.Filter:=OpenSaveDialogFilter;
  SaveDialog.FilterIndex:=OpenSaveDialogFilterIndex;

  // 3D-вид.
  SaveDialog.Ctl3D:=true;
  // Заголовок.
  SaveDialog.Title:='Сохранение объектов БМП';

  // Важно!!! Директория по умолчанию меняется и диалог
  // всякий раз создаётся заново, только тогда работает.
  SetCurrentDir(ExtractFilePath(Application.ExeName) +
                OpenSaveDialogInitialDirectory);  
  // Нужно, чтобы InitialDir сработало.
  SaveDialog.FileName:='';
  // Установка начального каталога, чтобы сделать его текущим.
  SaveDialog.InitialDir:=GetCurrentDir();

  // Номер N файла с названием 'Модель_N', содержащим основные параметры объектов БМП.
  FileName:='Модель_' + IntToStr(StartModelNameIndex) + '.hsp';
  SaveDialog.FileName:=FileName;

  StartModelNameIndex:=StartModelNameIndex + 1;

  // Отображение диалог сохранения файла
  if SaveDialog.Execute
    then begin
           FileName:= SaveDialog.FileName;

           FileName:=ExtractFileName(SaveDialog.FileName);

           if SaveDialog.FilterIndex = 1
             then begin // if OpenDialog1.FilterIndex = 1
                    FileName:=ChangeFileExt(FileName, '.hsp');
                    SaveHalfSpaceBaseParametersToFile(FileName);
                    FileName:=ChangeFileExt(FileName, '.ssp');
                    SaveSourceSurfacePointsCoordinatesToFile(FileName);
                  end; // if OpenDialog1.FilterIndex = 1

           if SaveDialog.FilterIndex = 2
             then begin
                    FileName:=ChangeFileExt(FileName, '.hsp');
                    // Загрузка параметров БМП из файла.
                    SaveHalfSpaceBaseParametersToFile(FileName);
                  end;

           if SaveDialog.FilterIndex = 3
             then begin
                    FileName:=ChangeFileExt(FileName, '.ssp');
                    // Сохранение координат точек исходной поверхности.
                    SaveSourceSurfacePointsCoordinatesToFile(FileName);
                  end;

           // Когда сохраняются не только параметры БМП, но и поверхность,
           // смещённа поверхность сохраняется в STL-формате.
           if (SaveDialog.FilterIndex = 1) or (SaveDialog.FilterIndex = 2)
             then begin
                    FileName:=ChangeFileExt(FileName, '.stl');
                    // Сохранение координат точек смещённой поверхности
                    // в STL-формате.
                    SaveDisplacedSurfacePointsCoordinatesToFile(FileName);
                  end;
         end; // if SaveDialog.Execute

  // Освобождения диалога
  SaveDialog.Free;
end; // TMainForm.SaveFileSpeedButtonClick

// Создание новой модели БМП.
procedure TMainForm.NewFileSpeedButtonClick(Sender: TObject);
begin
  LimitingEllipsoid.Destroy;
  SourceFocalEllipsoid.Destroy;
  DisplacedFocalEllipsoid.Destroy;

  // Установка начальных значений параметров модели БМП.
  SetInitialHalfSpace;

  Repaint;
end;

// Орисовка картинки заголовка страницы.
procedure TMainForm.PageControlDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);

begin
  PageControl.Canvas.Draw(Rect.Left, Rect.Top, PageControlImages[TabIndex]);
end;

procedure TMainForm.ExitMenuItemClick(Sender: TObject);
begin
  if CloseQuery
    then Application.Terminate;
end;

end.




