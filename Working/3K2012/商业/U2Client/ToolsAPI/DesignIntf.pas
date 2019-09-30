{ ********************************************************************** }
{                                                                        }
{ Delphi and Kylix Cross-Platform Open Tools API                         }
{                                                                        }
{ Copyright (C) 1995, 2002 Borland Software Corporation                  }
{                                                                        }
{ All Rights Reserved.                                                   }
{                                                                        }
{ ********************************************************************** }


unit DesignIntf;

interface

{$IFDEF MSWINDOWS}
uses SysUtils, Classes, Types, TypInfo, IniFiles, DesignMenus, Controls;
{$ENDIF}

{$IFDEF LINUX}
uses SysUtils, Classes, Types, TypInfo, IniFiles, DesignMenus;
{$ENDIF}

{ Property Editor Types }

type
  TPropKind = (pkProperties, pkEvents);

  IProperty = interface;

  TGetPropProc = procedure(const Prop: IProperty) of object;

  TPropertyAttribute = (paValueList, paSubProperties, paDialog, paMultiSelect,
    paAutoUpdate, paSortList, paReadOnly, paRevertable, paFullWidthName,
    paVolatileSubProperties, paVCL, paNotNestable);

  TPropertyAttributes = set of TPropertyAttribute;

{ IProperty
  This is the interface used by the object inspector to edit properties.
    Activate
      Called whenever the property becomes selected in the object inspector.
      This is potentially useful to allow certain property attributes to
      to only be determined whenever the property is selected in the object
      inspector. Only paSubProperties and paMultiSelect, returned from
      GetAttributes, need to be accurate before this method is called.
    AllEqual
      Called whenever there is more than one component selected.  If this
      method returns true, GetValue is called, otherwise blank is displayed
      in the Object Inspector.  This is called only when GetAttributes
      returns paMultiSelect.
    AutoFill
      Called to determine whether the values returned by GetValues can be
      selected incrementally in the Object Inspector.  This is called only when
      GetAttributes returns paValueList.
    Edit
      Called when the '...' button is pressed or the property is double-clicked.
      This can, for example, bring up a dialog to allow the editing the
      component in some more meaningful fashion than by text (e.g. the Font
      property).
    GetAttributes
      Returns the information for use in the Object Inspector to be able to
      show the appropriate tools.  GetAttributes returns a set of type
      TPropertyAttributes:
        paValueList:     The property editor can return an enumerated list of
                         values for the property.  If GetValues calls Proc
                         with values then this attribute should be set.  This
                         will cause the drop-down button to appear to the right
                         of the property in the Object Inspector.
        paSortList:      Object Inspector to sort the list returned by
                         GetValues.
        paSubProperties: The property editor has sub-properties that will be
                         displayed indented and below the current property in
                         standard outline format. If GetProperties will
                         generate property objects then this attribute should
                         be set.
        paDialog:        Indicates that the Edit method will bring up a
                         dialog.  This will cause the '...' button to be
                         displayed to the right of the property in the Object
                         Inspector.
        paMultiSelect:   Allows the property to be displayed when more than
                         one component is selected.  Some properties are not
                         appropriate for multi-selection (e.g. the Name
                         property).
        paAutoUpdate:    Causes the SetValue method to be called on each
                         change made to the editor instead of after the change
                         has been approved (e.g. the Caption property).
        paReadOnly:      Value is not allowed to change.
        paRevertable:    Allows the property to be reverted to the original
                         value.  Things that shouldn't be reverted are nested
                         properties (e.g. Fonts) and elements of a composite
                         property such as set element values.
        paFullWidthName: Tells the object inspector that the value does not
                         need to be rendered and as such the name should be
                         rendered the full width of the inspector.
        paVolatileSubProperties: Any change of property value causes any shown
                         subproperties to be recollected.
        paReference:     Property contains a reference to something else.  When
                         used in conjunction with paSubProperties the referenced
                         object should be displayed as sub properties to this
                         property.
        paNotNestable:   Indicates that the property is not safe to show when
                         showing the properties of an expanded reference.

    GetComponent
      Returns the Index'th component being edited by this property editor.  This
      is used to retrieve the components.  A property editor can only refer to
      multiple components when paMultiSelect is returned from GetAttributes.

    GetEditLimit
      Returns the number of character the user is allowed to enter for the
      value.  The inplace editor of the object inspector will be have its
      text limited set to the return value.  By default this limit is 255.

    GetName
      Returns the name of the property.  By default the value is retrieved
      from the type information with all underbars replaced by spaces.  This
      should only be overridden if the name of the property is not the name
      that should appear in the Object Inspector.

    GetComponentValue
      Return the value as a TComponent if, and only if, it is a object that
      descends from TComponent in Classes, otherwise return nil. This is only
      implemented by the TComponentProperty editor. If you register a component
      property editor that obscures the default TComponentProperty, ensure it
      correctly implements this method.

    GetProperties
      Should be overridden to call PropertyProc for every sub-property (or
      nested property) of the property begin edited and passing a new
      TPropertyEdtior for each sub-property.  By default, PropertyProc is not
      called and no sub-properties are assumed.  TClassProperty will pass a
      new property editor for each published property in a class.  TSetProperty
      passes a new editor for each element in the set.

    GetPropType
      Returns the type information pointer for the property(s) being edited.

    GetValue
      Returns the string value of the property. TPropertyEditor will return
      '(unknown)' by default.

    GetValues
      Called when paValueList is returned in GetAttributes.  Should call Proc
      for every value that is acceptable for this property.  TEnumProperty
      will pass every element in the enumeration.

    SetValue(Value)
      Called to set the value of the property.  The property editor should be
      able to translate the string and call one of the SetXxxValue methods. If
      the string is not in the correct format or not an allowed value, the
      property editor should generate an exception describing the problem. Set
      value can ignore all changes and allow all editing of the property be
      accomplished through the Edit method (e.g. the Picture property).

    ValueAvailable
      Returns true if the value can be accessed without causing an exception.
      This is used to verify you can edit properties of some ActiveX controls
      that are poorly written.

    GetEditValue(out Value): Boolean
      Returns true if value can be edited. }

  IProperty = interface
    ['{7ED7BF29-E349-11D3-AB4A-00C04FB17A72}']
    procedure Activate;
    function AllEqual: Boolean;
    function AutoFill: Boolean;
    procedure Edit;
    function HasInstance(Instance: TPersistent): Boolean;
    function GetAttributes: TPropertyAttributes;
    function GetEditLimit: Integer;
    function GetEditValue(out Value: string): Boolean;
    function GetName: string;
    procedure GetProperties(Proc: TGetPropProc);
    function GetPropInfo: PPropInfo;
    function GetPropType: PTypeInfo;
    function GetValue: string;
    procedure GetValues(Proc: TGetStrProc);
    procedure Revert;
    procedure SetValue(const Value: string);
    function ValueAvailable: Boolean;
  end;

  // IProperty70
  //  GetIsDefault
  //    Return True if the current value is the default value for this
  //    property. Non-default values will be in bold. If IProperty70 is
  //    not implemented by the object, items will not be bolded.
  //    In general, you should return true if a given property will
  //    NOT be stored in the dfm.
  IProperty70 = interface(IProperty)
    ['{57B97F18-B47F-4635-94CB-3344783E7069}']
    function GetIsDefault: Boolean;
    property IsDefault: Boolean read GetIsDefault;
  end;

  IMethodProperty = interface
    ['{392CBF4A-F078-47E9-B731-0E0B7F1F4998}']
  end;

  IActivatable = interface
    ['{F00AA4BD-3459-43E9-ACB2-97DBD1663AFF}']
    procedure Activate;
  end;

  IReferenceProperty = interface
    ['{C7EE2B1E-3F89-40AD-9250-D2667BA3D46B}']
    function GetComponentReference: TComponent;
  end;

{ IDesignerSelections
   Used to transport the selected objects list in and out of the form designer.
   Replaces TDesignerSelectionList in form designer interface.  }

  IDesignerSelections = interface
    ['{7ED7BF30-E349-11D3-AB4A-00C04FB17A72}']
    function Add(const Item: TPersistent): Integer;
    function Equals(const List: IDesignerSelections): Boolean;
    function Get(Index: Integer): TPersistent;
    function GetCount: Integer;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TPersistent read Get; default;
  end;

  IDesigner = interface;
  IDesigner60 = interface
    ['{A29C6480-D4AF-11D3-BA96-0080C78ADCDB}']
    procedure Activate;
    procedure Modified;
    function CreateMethod(const Name: string; TypeData: PTypeData): TMethod;
    function GetMethodName(const Method: TMethod): string;
    procedure GetMethods(TypeData: PTypeData; Proc: TGetStrProc);
    function GetPathAndBaseExeName: string;
    function GetPrivateDirectory: string;
    function GetBaseRegKey: string;
    function GetIDEOptions: TCustomIniFile;
    procedure GetSelections(const List: IDesignerSelections);
    function MethodExists(const Name: string): Boolean;
    procedure RenameMethod(const CurName, NewName: string);
    procedure SelectComponent(Instance: TPersistent);
    procedure SetSelections(const List: IDesignerSelections);
    procedure ShowMethod(const Name: string);
    procedure GetComponentNames(TypeData: PTypeData; Proc: TGetStrProc);
    function GetComponent(const Name: string): TComponent;
    function GetComponentName(Component: TComponent): string;
    function GetObject(const Name: string): TPersistent;
    function GetObjectName(Instance: TPersistent): string;
    procedure GetObjectNames(TypeData: PTypeData; Proc: TGetStrProc);
    function MethodFromAncestor(const Method: TMethod): Boolean;
    function CreateComponent(ComponentClass: TComponentClass; Parent: TComponent;
      Left, Top, Width, Height: Integer): TComponent;
    function CreateCurrentComponent(Parent: TComponent; const Rect: TRect): TComponent;
    function IsComponentLinkable(Component: TComponent): Boolean;
    function IsComponentHidden(Component: TComponent): Boolean;
    procedure MakeComponentLinkable(Component: TComponent);
    procedure Revert(Instance: TPersistent; PropInfo: PPropInfo);
    function GetIsDormant: Boolean;
    procedure GetProjectModules(Proc: TGetModuleProc);
    function GetAncestorDesigner: IDesigner;
    function IsSourceReadOnly: Boolean;
    function GetScrollRanges(const ScrollPosition: TPoint): TPoint;
    procedure Edit(const Component: TComponent);
    procedure ChainCall(const MethodName, InstanceName, InstanceMethod: string;
      TypeData: PTypeData);
    procedure CopySelection;
    procedure CutSelection;
    function CanPaste: Boolean;
    procedure PasteSelection;
    procedure DeleteSelection(ADoAll: Boolean = False);
    procedure ClearSelection;
    procedure NoSelection;
    procedure ModuleFileNames(var ImplFileName, IntfFileName, FormFileName: string);
    function GetRootClassName: string;
    function UniqueName(const BaseName: string): string;
    function GetRoot: TComponent;
    function GetShiftState: TShiftState;
    procedure ModalEdit(EditKey: Char; const ReturnWindow: IActivatable);
    procedure SelectItemName(const PropertyName: string);
    procedure Resurrect;

    property Root: TComponent read GetRoot;
    property IsDormant: Boolean read GetIsDormant;
    property AncestorDesigner: IDesigner read GetAncestorDesigner;
  end;

  IDesigner = interface(IDesigner60)
    ['{2F704CE2-7614-4AAF-B177-357D00D9634B}']
    function GetActiveClassGroup: TPersistentClass;

    function FindRootAncestor(const AClassName: string): TComponent;
    property ActiveClassGroup: TPersistentClass read GetActiveClassGroup;
  end;


  TGetDesignerEvent = procedure(Sender: TObject; out ADesigner: IDesigner) of object;

  { IDesignNotification
    An implementation of this can be registered with RegisterDesignNotifcation
    and it will be called by the designer to allow notifications of various
    events.

      ItemDeleted - AItem has been deleted (triggered indirectly by the
        Notification method of the owner of the component).

      ItemInserted - AItem has been insterted (triggered indirectly by the
        Notification method of the owner of the component).

      ItemModified - The modified method of the given ADesigner was called
        indicating that one or more items may have been modified.

      DesignerOpened - ADesigner has been created. If you store a reference to
        ADesigner you *must* clear that reference when DesignerClosed is called
        with AGoingDormant = False.  If AResurrecting is True, then this designer
        has previously gone dormant and its design root is now being recreated.

      DesignerClosed - ADesigner is in the process of being destroyed. Any
        reference to the designer must be release. You may also want to destroy
        any associated windows that are specific to ADesigner.  If AGoingDormant
        is True then this indicates that the design root is being destroyed but
        the designer itself is not.  This will happen when a design-time package
        is unloaded.  In *most* cases, the reference to the designer must be
        released regardless of the AGoingDormant flag, however it is not
        mandatory. }
  IDesignNotification = interface
    ['{E8C9F739-5601-4ADD-9D95-594132D4CEFD}']
    procedure ItemDeleted(const ADesigner: IDesigner; AItem: TPersistent);
    procedure ItemInserted(const ADesigner: IDesigner; AItem: TPersistent);
    procedure ItemsModified(const ADesigner: IDesigner);
    procedure SelectionChanged(const ADesigner: IDesigner;
      const ASelection: IDesignerSelections);
    procedure DesignerOpened(const ADesigner: IDesigner; AResurrecting: Boolean);
    procedure DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean);
  end;

  { IDesignWindow
    IDesignWindow should be used when the IDesignNotification handler is a
    top level window. It it is also registered with RegisterDesignNotifications.

      WindowHide - This is called when all design windows should be hidden such
        as when the IDE is debugging.

      WindowShow - This is called when all design windows can not be reshown
        such as when the IDE finishes debugging. }
  IDesignWindow = interface(IDesignNotification)
    ['{7ED7BF2E-E349-11D3-AB4A-00C04FB17A72}']
    procedure WindowHide;
    procedure WindowShow;
  end;

  TRegisterDesignNotification = procedure (const DesignNotification: IDesignNotification);

var
  RegisterDesignNotificationProc: TRegisterDesignNotification;
  UnregisterDesignNotificationProc: TRegisterDesignNotification;

procedure RegisterDesignNotification(const DesignNotification: IDesignNotification);
procedure UnregisterDesignNotification(const DesignNotification: IDesignNotification);

type
  TBasePropertyEditor = class(TInterfacedObject)
  protected
    procedure Initialize; virtual; abstract;
    procedure SetPropEntry(Index: Integer; AInstance: TPersistent;
      APropInfo: PPropInfo); virtual; abstract;
  public
    constructor Create(const ADesigner: IDesigner; APropCount: Integer); virtual;
  end;

  TPropertyEditorClass = class of TBasePropertyEditor;

{ RegisterPropertyEditor
  Registers a new property editor for the given type.  When a component is
  selected the Object Inspector will create a property editor for each
  of the component's properties.  The property editor is created based on
  the type of the property.  If, for example, the property type is an
  Integer, the property editor for Integer will be created (by default
  that would be TIntegerProperty). Most properties do not need specialized
  property editors.  For example, if the property is an ordinal type the
  default property editor will restrict the range to the ordinal subtype
  range (e.g. a property of type TMyRange = 1..10 will only allow values
  between 1 and 10 to be entered into the property).  Enumerated types will
  display a drop-down list of all the enumerated values (e.g. TShapes =
  (sCircle, sSquare, sTriangle) will be edited by a drop-down list containing
  only sCircle, sSquare and sTriangle).  A property editor need only be
  created if default property editor or none of the existing property editors
  are sufficient to edit the property.  This is typically because the
  property is an object.  The properties are looked up newest to oldest.
  This allows and existing property editor replaced by a custom property
  editor.

    PropertyType
      The type information pointer returned by the TypeInfo built-in function
      (e.g. TypeInfo(TMyRange) or TypeInfo(TShapes)).

    ComponentClass
      Type of the component to which to restrict this type editor.  This
      parameter can be left nil which will mean this type editor applies to all
      properties of PropertyType.

    PropertyName
      The name of the property to which to restrict this type editor.  This
      parameter is ignored if ComponentClass is nil.  This parameter can be
      an empty string ('') which will mean that this editor applies to all
      properties of PropertyType in ComponentClass.

    EditorClass
      The class of the editor to be created whenever a property of the type
      passed in PropertyTypeInfo is displayed in the Object Inspector.  The
      class will be created by calling EditorClass.Create. }

type
  TRegisterPropertyEditorProc = procedure (PropertyType: PTypeInfo;
    ComponentClass: TClass; const PropertyName: string;
    EditorClass: TPropertyEditorClass);

  TPropertyEditorFilterFunc = function(const ATestEditor: IProperty): Boolean of object;

var
  RegisterPropertyEditorProc: TRegisterPropertyEditorProc;

procedure RegisterPropertyEditor(PropertyType: PTypeInfo;
  ComponentClass: TClass; const PropertyName: string;
  EditorClass: TPropertyEditorClass);

{ SetPropertyEditorGroup
  Restricts the given editor class to be active for the classes associated
  to GroupClass by calls to GroupDescendentsWith. For example, this is used
  to ensure the proper version of TShortCutProperty is created depending on
  if it is a CLX component or a VCL component. Using this is very similar to
  using the ComponentClass parameter of RegisterPropertyEditor, but instead of
  limiting it to a particular class, it limits the editor to a group of classes
  created by StartClassGroup.

    EditorClass
      The class of the editor to restrict to a particular class group.

    GroupClass
      The class used to determine the group EditorClass is restricted to. }

type
  TSetPropertyEditorGroupProc = procedure (EditorClass: TPropertyEditorClass;
    GroupClass: TPersistentClass);

var
  SetPropertyEditorGroupProc: TSetPropertyEditorGroupProc;

procedure SetPropertyEditorGroup(EditorClass: TPropertyEditorClass;
  GroupClass: TPersistentClass);

{ UnlistPublishedProperty
  From time to time there is a need to hide a property that has been published by
  an ancestor class. Whenever this occurs you should make sure that you are
  descending from the right class. We realize, though, that sometimes this is not
  feasible. The following procedure will therefore allow you to make a specific
  property on a specific class not appear in the Object inspector.

  ** Please note that this function does not stop the streaming system from
  streaming the published property nor does it make the published property from
  begin programmatically access at runtime.  It simply tells the object inspector
  not to list (and in turn edit) it when components of the specified class are
  selected. }

procedure UnlistPublishedProperty(ComponentClass: TClass; const PropertyName: string);

{ Standard Property Category Names }

resourcestring
  sActionCategoryName = 'Action';
  sDataCategoryName = 'Data';
  sDatabaseCategoryName = 'Database';
{$IFDEF MSWINDOWS}
  sDragNDropCategoryName = 'Drag, Drop and Docking';
{$ENDIF}
{$IFDEF LINUX}
  sDragNDropCategoryName = 'Drag and Drop';
{$ENDIF}
  sHelpCategoryName = 'Help and Hints';
  sLayoutCategoryName = 'Layout';
  sLegacyCategoryName = 'Legacy';
  sLinkageCategoryName = 'Linkage';
  sLocaleCategoryName = 'Locale';
  sLocalizableCategoryName = 'Localizable';
  sMiscellaneousCategoryName = 'Miscellaneous';
  sVisualCategoryName = 'Visual';
  sInputCategoryName = 'Input';


{ Property Category Types }

type
  TRegisterPropertyInCategoryProc = procedure (const CategoryName: string;
    ComponentClass: TClass; PropertyType: PTypeInfo;
    const PropertyName: string);

var
  RegisterPropertyInCategoryProc: TRegisterPropertyInCategoryProc;

procedure RegisterPropertyInCategory(const CategoryName, PropertyName: string);
   overload;
procedure RegisterPropertyInCategory(const CategoryName: string;
  ComponentClass: TClass; const PropertyName: string); overload;
procedure RegisterPropertyInCategory(const CategoryName: string;
  PropertyType: PTypeInfo; const PropertyName: string); overload;
procedure RegisterPropertyInCategory(const CategoryName: string;
  PropertyType: PTypeInfo); overload;

procedure RegisterPropertiesInCategory(const CategoryName: string;
  const Filters: array of const); overload;
procedure RegisterPropertiesInCategory(const CategoryName: string;
  ComponentClass: TClass; const Filters: array of string); overload;
procedure RegisterPropertiesInCategory(const CategoryName: string;
  PropertyType: PTypeInfo; const Filters: array of string); overload;

resourcestring
  sInvalidFilter = 'Property filters may only be name, class or type based (%d:%d)';

{ Property Mapper }

type
  TPropertyMapperFunc = function(Obj: TPersistent;
    PropInfo: PPropInfo): TPropertyEditorClass;
  TRegisterPropertyMapperProc = procedure (Mapper: TPropertyMapperFunc);

var
  RegisterPropertyMapperProc: TRegisterPropertyMapperProc;

procedure RegisterPropertyMapper(Mapper: TPropertyMapperFunc);

{ Component Editor Types }

type

{ IComponentEditor
  A component editor is created for each component that is selected in the
  form designer based on the component's type (see GetComponentEditor and
  RegisterComponentEditor).  When the component is double-clicked the Edit
  method is called.  When the context menu for the component is invoked the
  GetVerbCount and GetVerb methods are called to build the menu.  If one
  of the verbs are selected ExecuteVerb is called.  Paste is called whenever
  the component is pasted to the clipboard.  You only need to create a
  component editor if you wish to add verbs to the context menu, change
  the default double-click behavior, or paste an additional clipboard format.
  The default component editor (TDefaultEditor) implements Edit to searches the
  properties of the component and generates (or navigates to) the OnCreate,
  OnChanged, or OnClick event (whichever it finds first).  Whenever the
  component modifies the component is *must* call Designer.Modified to inform
  the designer that the form has been modified.

    Edit
      Called when the user double-clicks the component. The component editor can
      bring up a dialog in response to this method, for example, or some kind
      of design expert.  If GetVerbCount is greater than zero, edit will execute
      the first verb in the list (ExecuteVerb(0)).

    ExecuteVerb(Index)
      The Index'ed verb was selected by the use off the context menu.  The
      meaning of this is determined by component editor.

    GetVerb
      The component editor should return a string that will be displayed in the
      context menu.  It is the responsibility of the component editor to place
      the & character and the '...' characters as appropriate.

    GetVerbCount
      The number of valid indices to GetVerb and Execute verb.  The index is assumed
      to be zero based (i.e. 0..GetVerbCount - 1).

    PrepareItem
      While constructing the context menu PrepareItem will be called for
      each verb.  It will be passed the menu item that will be used to represent
      the verb.  The component editor can customize the menu item as it sees fit,
      including adding subitems.  If you don't want that particular menu item
      to be shown, don't free it, simply set its Visible property to False.

    Copy
      Called when the component is being copied to the clipboard.  The
      component's filed image is already on the clipboard.  This gives the
      component editor a chance to paste a different type of format which is
      ignored by the designer but might be recognized by another application.

    IsInInlined
      Determines whether Component is in the Designer which owns it.  Essentially,
      Components should not be able to be added to a Frame instance (collections
      are fine though) so this function checks to determine whether the currently
      selected component is within a Frame instance or not.

    GetComponent
      TODO

    GetDesigner
      TODO
    }

  IComponentEditor = interface
    ['{ECACBA34-DCDF-4BE2-A645-E4404BC06106}']
    procedure Edit;
    procedure ExecuteVerb(Index: Integer);
    function GetVerb(Index: Integer): string;
    function GetVerbCount: Integer;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem);
    procedure Copy;
    function IsInInlined: Boolean;
    function GetComponent: TComponent;
    function GetDesigner: IDesigner;
  end;

{ TBaseComponentEditor
  All component editors are assumed derived from TBaseComponentEditor and
  implements the IComponentEditor interface.

    Create(AComponent, ADesigner)
      Called to create the component editor.  AComponent is the component to
      be edited by the editor.  ADesigner is an interface to the designer to
      find controls and create methods (this is not use often). If a component
      editor modifies the component in any way it *must* call
      ADesigner.Modified. }

  TBaseComponentEditor = class(TInterfacedObject)
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); virtual;
  end;

  TComponentEditorClass = class of TBaseComponentEditor;

  IDefaultEditor = interface(IComponentEditor)
    ['{5484FAE1-5C60-11D1-9FB6-0020AF3D82DA}']
  end;

{ Register a component editor to be created when a component derived from
  ComponentClass is the only selection in the designer }
type
  TRegisterComponentEditorProc = procedure (ComponentClass: TComponentClass;
  ComponentEditor: TComponentEditorClass);

var
  RegisterComponentEditorProc: TRegisterComponentEditorProc;

procedure RegisterComponentEditor(ComponentClass: TComponentClass;
  ComponentEditor: TComponentEditorClass);


{ Selection Editor Types }

type

{ ISelectionEditor
  This interface performs functions similar to IComponentEditor but is not
  limited to one participant at a time.  When a editor menu is needed Delphi
  will look at all of the selected objects and allow all selection editors
  that can match them participate in the menu construction and selection.
  A selection editor is selected by finding the most derived common ancestor
  of all the components in the selection and then finding the selection editor
  that was registered for that class or its closes ancestor.  For example, if
  you register a selection editor for TControl and TButton and a button and
  a label are selected, the TControl selection editor will be created (because
  TControl is their common ancestor) but if two TButton's are selected, the
  TButton selection editor will be created. In other words, all the components
  in the selection are guarenteed, by the designer, to be at least derived
  from the class the selection editor is registered for.

    ExecuteVerb(Index)
      The Index'ed verb was selected by the use off the context menu.  The
      meaning of this is determined by component editor.

    GetVerb
      The component editor should return a string that will be displayed in the
      context menu.  It is the responsibility of the component editor to place
      the & character and the '...' characters as appropriate.

    GetVerbCount
      The number of valid indices to GetVerb and Execute verb.  The index is
      assumed to be zero based (i.e. 0..GetVerbCount - 1).

    PrepareItem
      While constructing the context menu PrepareItem will be called for
      each verb.  It will be passed the menu item that will be used to represent
      the verb.  The selection editor can customize the menu item as it sees fit,
      including adding subitems.  If you don't want that particular menu item
      to be shown, don't free it, simply set its Visible property to False.

    RequiresUnits
      Should call Proc with all the units that are needed to be used when
      using this class. The form designer automatically ensures the unit
      the class was declared in and all its ancestor's units are used in the
      user's program when they use this component. Sometimes, however, an
      event will use a type in one of its parameters that is not in its unit
      nor any of its ancestor's units. If this is the case a selection editor
      should be registerd that implements RequiresUnits and it should call
      Proc for each unit that declare the types needed by its events }

  ISelectionEditor = interface
    ['{B91F7A78-BB2C-45D9-957A-8A45A2D30435}']
    procedure ExecuteVerb(Index: Integer; const List: IDesignerSelections);
    function GetVerb(Index: Integer): string;
    function GetVerbCount: Integer;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem);
    procedure RequiresUnits(Proc: TGetStrProc);
  end;

{ TBaseSelectionEditor
  All selection editors are assumed to derive from this class. A default
  implemenation for the ISelectionEditor interface is provided in
  TSelectionEditor class. }
  TBaseSelectionEditor = class(TInterfacedObject)
  public
    constructor Create(const ADesigner: IDesigner); virtual;
  end;

  TSelectionEditorClass = class of TBaseSelectionEditor;

  ISelectionEditorList = interface
    ['{C1360368-0099-4A7C-A4A8-7650503BA0C6}']
    function Get(Index: Integer): ISelectionEditor;
    function GetCount: Integer;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: ISelectionEditor read Get; default;
  end;

type
  TRegisterSelectionEditorProc = procedure (AClass: TClass; AEditor: TSelectionEditorClass);

var
  RegisterSelectionEditorProc: TRegisterSelectionEditorProc;

procedure RegisterSelectionEditor(AClass: TClass; AEditor: TSelectionEditorClass);

{ Custom Module Types }

{ A custom module allows containers that descend from classes other than TForm
  to be created and edited by the form designer. This is useful for other form
  like containers (e.g. a report designer) or for specialized forms (e.g. an
  ActiveForm) or for generic component containers (e.g. a TDataModule). It is
  assumed that the base class registered will call InitInheritedComponent in its
  constructor which will initialize the component from the associated DFM or
  XFM file stored in the programs resources. See the constructors of TDataModule
  and TForm for examples of how to write such a constructor.

  The following designer assumptions are made, depending on the base components
  ancestor,

    If ComponentBaseClass descends from TForm (in either VCL or Clx),

       it is designed by creating an instance of the component as the form.
       Allows designing TForm descendents and modifying their properties as
       well as the form properties

    If ComponentBaseClass descends from TWinControl or TWidgetControl (but not
    TForm),

       it is designed by creating an instance of the control, placing it into a
       design-time form.  The form's client size is the default size of the
       control.

    If ComponentBaseClass descends from TDataModule,

       it is designed by creating an instance of the class and creating a
       special non-visual container designer to edit the components and display
       the icons of the contained components.

  The module will appear in the project file with a colon and the base class
  name appended after the component name (e.g. MyDataModule: TDataModule).

  Note it is undefined what will happen if you try register anything that does
  not descend from one of the above. }

type
  TCustomModuleAttribute = (cmaVirtualSize);
  TCustomModuleAttributes = set of TCustomModuleAttribute;

{ ICustomModule
  Created when a module is selected and prior to the module being created to
  request information about the custom module.

    GetAttributes
      Return information about the verb. Currently the only defined information
      is whether the designer should be virtually sized. This is only
      meaningful for modules that design visual components but not the
      top level visual component. This causes scroll-bars to appear instead of
      the visual component being client aligned in the parent designer.

    ExecuteVerb
      Execute the verb associated with Index. The text of the verb should be
      returned by GetVerb.

    GetVerb
      Return the text, suitable for placement in a menu, that you want the use
      to operate on the module as a whole.

    GetVerbCount
      Return the number of verbs returned by GetVerb and executed by
      ExecuteVerb.

    PrepareItem
      While constructing the context menu PrepareItem will be called for
      each verb.  It will be passed the menu item that will be used to represent
      the verb.  The module editor can customize the menu item as it sees fit,
      including adding subitems.  If you don't want that particular menu item
      to be shown, don't free it, simply set its Visible property to False.

    Saving
      This is called prior to the module being saved. This allows the custom
      module to make sure the state of the module is consistent prior to saving.
      This method can be left blank.

    ValidateComponent
      This allows the custom module to reject components that are not suitable
      for the module. If the component is not applicable for the module
      ValidateComponent should raise and exception. TCustomModule implements
      this by calling ValidateComponentClass on the class of the component
      so if the filtering is done strictly by class implement
      ValidateComponentClass instead.

    ValidateComponentClass
      ValidateComponentClass is called by the designer to filter the contents
      of the palette to only the classes that are suitable for the module.

    Nestable
      Return true if this module can be nested into other modules. This will
      only be called if the TBaseCustomModule is created with a nil Root and,
      when Root is nil, only Nestable will be called on this interface. }

  ICustomModule = interface
    ['{95DA4A2B-D800-4CBB-B0B8-85AB7D3CFADA}']
    function GetAttributes: TCustomModuleAttributes;
    procedure ExecuteVerb(Index: Integer);
    function GetVerb(Index: Integer): string;
    function GetVerbCount: Integer;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem);
    procedure Saving;
    procedure ValidateComponent(Component: TComponent);
    function ValidateComponentClass(ComponentClass: TComponentClass): Boolean;
    function Nestable: Boolean;
  end;

{ TBaseCustomModule
  All custom modules are assumed to derive from TBaseCustomModule. The ARoot
  ARoot parameter might be nil which means that only Nestable will be called
  on the ICustomModule interfaced implementated by the instance }

  TBaseCustomModule = class(TInterfacedObject)
  public
    constructor Create(ARoot: TComponent; const Designer: IDesigner); virtual;
    class function DesignClass: TComponentClass; virtual;
  end;

  TCustomModuleClass = class of TBaseCustomModule;

  TRegisterCustomModuleProc = procedure (Group: Integer;
    ComponentBaseClass: TComponentClass;
    CustomModuleClass: TCustomModuleClass);

var
  RegisterCustomModuleProc: TRegisterCustomModuleProc;

procedure RegisterCustomModule(ComponentBaseClass: TComponentClass;
  CustomModuleClass: TCustomModuleClass);

{ Designer selection }

type

  { This is the default implementation of IDesignerSelections }
  TDesignerSelections = class(TInterfacedObject, IDesignerSelections)
  private
    FList: TList;
  protected
    function Add(const Item: TPersistent): Integer;
    function Equals(const List: IDesignerSelections): Boolean;
    function Get(Index: Integer): TPersistent;
    function GetCount: Integer;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TPersistent read Get; default;
  public
    constructor Create; virtual;
    constructor Copy(const Selections: IDesignerSelections);
    destructor Destroy; override;
  end;

function CreateSelectionList: IDesignerSelections;

const
  MaxIdentLength = 63;

{ Designer types }

type
  TEditAction = (eaUndo, eaRedo, eaCut, eaCopy, eaPaste, eaDelete, eaSelectAll,
    eaPrint, eaBringToFront, eaSendToBack, eaAlignToGrid, eaFlipChildrenAll,
    eaFlipChildrenSelected);

  TEditStates = (esCanUndo, esCanRedo, esCanCut, esCanCopy, esCanPaste,
    esCanDelete, esCanZOrder, esCanAlignGrid, esCanEditOle, esCanTabOrder,
    esCanCreationOrder, esCanPrint, esCanSelectAll, esCanCreateTemplate);

  TEditState = set of TEditStates;

  IImplementation = interface
    ['{F9D448F2-50BC-11D1-9FB5-0020AF3D82DA}']
    function GetInstance: TObject;
  end;

  IEditHandler = interface
    ['{7ED7BF2D-E349-11D3-AB4A-00C04FB17A72}']
    function EditAction(Action: TEditAction): Boolean;
    function GetEditState: TEditState;
  end;
  IDesignEditQuery = IEditHandler; // For compatiblity with v5.0

{$IFDEF LINUX}
  TThreadAffinity = (taQT, taWine);

  IDesignerThreadAffinity = interface
    ['{7ED7BF2D-E449-11D3-A84A-00C05FB1767A}']
    function GetThreadAffinity: TThreadAffinity;
  end;
{$ENDIF}

{$IFDEF MSWINDOWS}
  { Drag drop interface }
  TDragTarget = class
  private
    FDesigner: IDesigner;
  public
    constructor Create(const ADesigner: IDesigner); virtual;
    function DragOver(Target, Source: TObject; X, Y: Integer;
      State: TDragState): Boolean; virtual; abstract;
    procedure DragDrop(Target, Source: TObject; X, Y: Integer); virtual; abstract;
    property Designer: IDesigner read FDesigner;
  end;

  TDragTargetClass = class of TDragTarget;

  TRegisterDragTargetProc = procedure(const SourceName: string;
    TargetClass: TDragTargetClass);

var
  RegisterDragTargetProc: TRegisterDragTargetProc;

procedure RegisterDragTarget(const SourceName: string; TargetClass: TDragTargetClass);

type
  TRegisterDesignDragObject = procedure (DragObjectClass: TDragObjectClass);

var
  RegisterDesignDragObjectProc: TRegisterDesignDragObject;

procedure RegisterDesignDragObject(DragObjectClass: TDragObjectClass);
{$ENDIF}

implementation

procedure RegisterPropertyMapper(Mapper: TPropertyMapperFunc);
begin
  if Assigned(RegisterPropertyMapperProc) then
    RegisterPropertyMapperProc(Mapper);
end;

procedure RegisterPropertyInCategory(const CategoryName, PropertyName: string);
  overload;
begin
  if Assigned(RegisterPropertyInCategoryProc) then
    RegisterPropertyInCategoryProc(CategoryName, nil, nil, PropertyName);
end;

procedure RegisterPropertyInCategory(const CategoryName: string;
  ComponentClass: TClass; const PropertyName: string); overload;
begin
  if Assigned(RegisterPropertyInCategoryProc) then
    RegisterPropertyInCategoryProc(CategoryName, ComponentClass, nil,
      PropertyName);
end;

procedure RegisterPropertyInCategory(const CategoryName: string;
  PropertyType: PTypeInfo; const PropertyName: string); overload;
begin
  if Assigned(RegisterPropertyInCategoryProc) then
    RegisterPropertyInCategoryProc(CategoryName, nil, PropertyType,
      PropertyName);
end;

procedure RegisterPropertyInCategory(const CategoryName: string;
  PropertyType: PTypeInfo); overload;
begin
  if Assigned(RegisterPropertyInCategoryProc) then
    RegisterPropertyInCategoryProc(CategoryName, nil, PropertyType, '');
end;

procedure RegisterPropertiesInCategory(const CategoryName: string;
  const Filters: array of const); overload;
var
  I: Integer;
begin
  if Assigned(RegisterPropertyInCategoryProc) then
    for I := Low(Filters) to High(Filters) do
      with Filters[I] do
        case vType of
          vtPointer:
            RegisterPropertyInCategoryProc(CategoryName, nil,
              PTypeInfo(vPointer), '');
          vtClass:
            RegisterPropertyInCategoryProc(CategoryName, vClass, nil, '');
          vtAnsiString:
            RegisterPropertyInCategoryProc(CategoryName, nil, nil,
              string(vAnsiString));
        else
          raise Exception.CreateResFmt(@sInvalidFilter, [I, vType]);
        end;
end;

procedure RegisterPropertiesInCategory(const CategoryName: string;
  ComponentClass: TClass; const Filters: array of string); overload;
var
  I: Integer;
begin
  if Assigned(RegisterPropertyInCategoryProc) then
    for I := Low(Filters) to High(Filters) do
      RegisterPropertyInCategoryProc(CategoryName, ComponentClass, nil,
        Filters[I]);
end;

procedure RegisterPropertiesInCategory(const CategoryName: string;
  PropertyType: PTypeInfo; const Filters: array of string); overload;
var
  I: Integer;
begin
  if Assigned(RegisterPropertyInCategoryProc) then
    for I := Low(Filters) to High(Filters) do
      RegisterPropertyInCategoryProc(CategoryName, nil, PropertyType,
        Filters[I]);
end;

{ Design notification registration }

procedure RegisterDesignNotification(const DesignNotification: IDesignNotification);
begin
  if Assigned(RegisterDesignNotificationProc) then
    RegisterDesignNotificationProc(DesignNotification);
end;

procedure UnregisterDesignNotification(const DesignNotification: IDesignNotification);
begin
  if Assigned(UnregisterDesignNotificationProc) then
    UnregisterDesignNotificationProc(DesignNotification);
end;

{ TBasePropertyEditor }

constructor TBasePropertyEditor.Create(const ADesigner: IDesigner;
  APropCount: Integer);
begin
  inherited Create;
end;

{ TBaseComponentEditor }

constructor TBaseComponentEditor.Create(AComponent: TComponent;
  ADesigner: IDesigner);
begin
  inherited Create;
end;

procedure RegisterComponentEditor(ComponentClass: TComponentClass;
  ComponentEditor: TComponentEditorClass);
begin
  if Assigned(RegisterComponentEditorProc) then
    RegisterComponentEditorProc(ComponentClass, ComponentEditor);
end;

{ TDesignerSelections }

function TDesignerSelections.Add(const Item: TPersistent): Integer;
begin
  Result := FList.Add(Item);
end;

constructor TDesignerSelections.Copy(const Selections: IDesignerSelections);
var
  I: Integer;
begin
  Create;
  for I := 0 to Selections.Count - 1 do
    Add(Selections[I]);
end;

constructor TDesignerSelections.Create;
begin
  inherited;
  FList := TList.Create;
end;

destructor TDesignerSelections.Destroy;
begin
  FList.Free;
  inherited;
end;

function TDesignerSelections.Equals(const List: IDesignerSelections): Boolean;
var
  I: Integer;
begin
  Result := False;
  if List.Count <> Count then Exit;
  for I := 0 to Count - 1 do
    if Items[I] <> List[I] then Exit;
  Result := True;
end;

function TDesignerSelections.Get(Index: Integer): TPersistent;
begin
  Result := TPersistent(FList[Index]);
end;

function TDesignerSelections.GetCount: Integer;
begin
  Result := FList.Count;
end;

function CreateSelectionList: IDesignerSelections;
begin
  Result := TDesignerSelections.Create;
end;

procedure RegisterPropertyEditor(PropertyType: PTypeInfo;
  ComponentClass: TClass; const PropertyName: string;
  EditorClass: TPropertyEditorClass);
begin
  if Assigned(RegisterPropertyEditorProc) then
    RegisterPropertyEditorProc(PropertyType, ComponentClass, PropertyName,
      EditorClass);
end;

procedure SetPropertyEditorGroup(EditorClass: TPropertyEditorClass;
  GroupClass: TPersistentClass);
begin
  if Assigned(SetPropertyEditorGroupProc) then
    SetPropertyEditorGroupProc(EditorClass, GroupClass);
end;

procedure UnlistPublishedProperty(ComponentClass: TClass; const PropertyName: string);
var
  LPropInfo: PPropInfo;
begin
  LPropInfo := GetPropInfo(ComponentClass, PropertyName);
  if LPropInfo <> nil then
    RegisterPropertyEditor(LPropInfo^.PropType^, ComponentClass, PropertyName, nil);
end;

{ TBaseSelectionEditor }

constructor TBaseSelectionEditor.Create(const ADesigner: IDesigner);
begin
  inherited Create;
end;

procedure RegisterSelectionEditor(AClass: TClass; AEditor: TSelectionEditorClass);
begin
  if Assigned(RegisterSelectionEditorProc) then
    RegisterSelectionEditorProc(AClass, AEditor);
end;

{ TBaseCustomModule }

constructor TBaseCustomModule.Create(ARoot: TComponent; const Designer: IDesigner);
begin
  inherited Create;
end;

class function TBaseCustomModule.DesignClass: TComponentClass;
begin
  Result := nil;
end;

procedure RegisterCustomModule(ComponentBaseClass: TComponentClass;
  CustomModuleClass: TCustomModuleClass);
begin
  if Assigned(RegisterCustomModuleProc) then
    RegisterCustomModuleProc(CurrentGroup, ComponentBaseClass,
      CustomModuleClass);
end;

{$IFDEF MSWINDOWS}
{ TDragTarget }

constructor TDragTarget.Create(const ADesigner: IDesigner);
begin
  inherited Create;
  FDesigner := ADesigner;
end;

procedure RegisterDragTarget(const SourceName: string; TargetClass: TDragTargetClass);
begin
  if Assigned(RegisterDragTargetProc) then
    RegisterDragTargetProc(SourceName, TargetClass);
end;

procedure RegisterDesignDragObject(DragObjectClass: TDragObjectClass);
begin
  if Assigned(RegisterDesignDragObjectProc) then
    RegisterDesignDragObjectProc(DragObjectClass);
end;

{$ENDIF}
end.
