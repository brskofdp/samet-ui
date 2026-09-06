-- READ
-- This ui & code is really old, as it is one of my FIRST ever uis.
-- Expect a lot of bugs and issues.

--[[
	Utopiahack
	Made by samet
	example at bottom

	documentation:
	function Library:Window(Data: table
		Name: string,
	)

	function Window:Page(Data: table
		Name: string,
	)

	function Page:Section(Data: table
		Name: string,
		Side: number,
	)

	function Section:Toggle(Data: table
		Name: string,
		Default: boolean,
		Flag: string,
		Callback: function,
	)

	function Toggle:Keybind(Data: table
		Name: string,
		Flag: string,
		Default: EnumItem,
		Mode: string,
		Callback: function,
	)

	function Toggle:Colorpicker(Data: table
		Name: string,
		Flag: string,
		Default: Color3,
		Alpha: number,
		Callback: function,
	)

	function Section:Button(Data: table
		Name: string,
		Callback: function,
	)

	function Section:Slider(Data: table
		Name: string,
		Min: number,
		Max: number,
		Decimals: number,
		Default: number,
		Flag: string,
		Callback: function,
	)

	function Section:Dropdown(Data: table
		Name: string,
		Options: table,
		Default: string,
		Flag: string,
		Multi: boolean,
		Callback: function,
	)

	function Section:Keybind(Data: table
		Name: string,
		Flag: string,
		Default: EnumItem,
		Mode: string,
		Callback: function,
	)

	function Section:Colorpicker(Data: table
		Name: string,
		Flag: string,
		Default: Color3,
		Alpha: number,
		Callback: function,
	)

	function Section:Textbox(Data: table
		Name: string,
		Default: string,
		Placeholder: string,
		Flag: string,
		Callback: function,
	)
]]

if getgenv().Library then 
	getgenv().Library:Unload();
end;

local LoadingTick = tick();
local Library; do
	if game:GetService("RunService"):IsStudio() then
		writefile = function() end;
		readfile = function() end;
		isfile = function() end;
		delfile = function() end;
		isfolder = function() end;
		makefolder = function() end;
		listfiles = function() end;
		getgenv = function() end;
		getcustomasset = function() end;
		cloneref = function() end;
	end;

	-- Services
	local TweenService = game:GetService("TweenService");
	local UserInputService = game:GetService("UserInputService");
	local Workspace = game:GetService("Workspace");
	local Players = game:GetService("Players");
	local HttpService = game:GetService("HttpService");
	local RunService = game:GetService("RunService");
	local CoreGui = cloneref(game:GetService("CoreGui"));

	-- Globals
	local INew = Instance.new;

	local StringFormat = string.format;
	local StringFind = string.find;
	local StringLower = string.lower;
	local StringGmatch = string.match;
	local StringSub = string.sub;
	local StringGSub = string.gsub;

	local TableFind = table.find;
	local TableRemove = table.remove;
	local TableInsert = table.insert;
	local TableConcat = table.concat;

	local U2New = UDim2.new;
	local UNew = UDim.new;
	local U2FromOffset = UDim2.fromOffset;
	local V2New = Vector2.new;

	local MathClamp = math.clamp;
	local MathFloor = math.floor;

	local TaskSpawn = task.spawn;

	local FromRGB = Color3.fromRGB;
	local FromHSV = Color3.fromHSV;
	local FromRGBKey = ColorSequenceKeypoint.new;
	local FromRGBSeq = ColorSequence.new;
	local NumberKey = NumberSequenceKeypoint.new;
	local NumberSeq = NumberSequence.new;

	local LocalPlayer = Players.LocalPlayer;
	local Camera = Workspace.CurrentCamera;

	local UIFont; 

	-- Library
	Library = {
		Flags = { };

		Theme = {
			["Background"] = FromRGB(16, 18, 20);
			["Inline"] = FromRGB(23, 25, 27);
			["Border"] = FromRGB(37, 40, 36);
			["Accent"] = FromRGB(104, 218, 155);
			["Text"] = FromRGB(237, 239, 241);
			["Element"] = FromRGB(35, 38, 41);
			["Text Border"] = FromRGB(0, 0, 0);
		};

		Files = {
			Directory =  "utopiahack";
			Configs = "Configs";
			Fonts = "Fonts";
		};

		TweenInfo =  TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);

		MenuKeybind = Enum.KeyCode.Z;

		Version = "v1.0.0";

		-- Ignore below
		ThemeInstances = { };
		ThemeMap = { };
		Connections = { };
		Pages = { };
		SubPages = { };
		Sections = { };
		SetFlags = { };
		Holder = nil;
		MainFrame = nil;
		Dragging = nil;
		CurrentColorpicker = nil;
		KeyList = nil;
		NotifHolder = nil;
	};

	Library.__index = Library;
	Library.Pages.__index = Library.Pages;
	Library.SubPages.__index = Library.SubPages;
	Library.Sections.__index = Library.Sections;

	local Keys               = {
		["Unknown"]          = "Unknown";
		["Backspace"]        = "Back";
		["Tab"]              = "Tab";
		["Clear"]            = "Clear";
		["Return"]           = "Return";
		["Pause"]            = "Pause";
		["Escape"]           = "Escape";
		["Space"]            = "Space";
		["QuotedDouble"]     = '"';
		["Hash"]             = "#";
		["Dollar"]           = "$";
		["Percent"]          = "%";
		["Ampersand"]        = "&";
		["Quote"]            = "'";
		["LeftParenthesis"]  = "(";
		["RightParenthesis"] = " )";
		["Asterisk"]         = "*";
		["Plus"]             = "+";
		["Comma"]            = ",";
		["Minus"]            = "-";
		["Period"]           = ".";
		["Slash"]            = "`";
		["Three"]            = "3";
		["Seven"]            = "7";
		["Eight"]            = "8";
		["Colon"]            = ":";
		["Semicolon"]        = ";";
		["LessThan"]         = "<";
		["GreaterThan"]      = ">";
		["Question"]         = "?";
		["Equals"]           = "=";
		["At"]               = "@";
		["LeftBracket"]      = "LeftBracket";
		["RightBracket"]     = "RightBracked";
		["BackSlash"]        = "BackSlash";
		["Caret"]            = "^";
		["Underscore"]       = "_";
		["Backquote"]        = "`";
		["LeftCurly"]        = "{";
		["Pipe"]             = "|";
		["RightCurly"]       = "}";
		["Tilde"]            = "~";
		["Delete"]           = "Delete";
		["End"]              = "End";
		["KeypadZero"]       = "Keypad0";
		["KeypadOne"]        = "Keypad1";
		["KeypadTwo"]        = "Keypad2";
		["KeypadThree"]      = "Keypad3";
		["KeypadFour"]       = "Keypad4";
		["KeypadFive"]       = "Keypad5";
		["KeypadSix"]        = "Keypad6";
		["KeypadSeven"]      = "Keypad7";
		["KeypadEight"]      = "Keypad8";
		["KeypadNine"]       = "Keypad9";
		["KeypadPeriod"]     = "KeypadP";
		["KeypadDivide"]     = "KeypadD";
		["KeypadMultiply"]   = "KeypadM";
		["KeypadMinus"]      = "KeypadM";
		["KeypadPlus"]       = "KeypadP";
		["KeypadEnter"]      = "KeypadE";
		["KeypadEquals"]     = "KeypadE";
	
		["Insert"]           = "Insert";
		["Home"]             = "Home";
		["PageUp"]           = "PageUp";
		["PageDown"]         = "PageDown";
		["RightShift"]       = "RightShift";
		["LeftShift"]        = "LeftShift";
		["RightControl"]     = "RightControl";
		["LeftControl"]      = "LeftControl";
		["LeftAlt"]          = "LeftAlt";
		["RightAlt"]         = "RightAlt";
	};

	local Tween = {}; do -- Tweens
		Tween.__index = Tween;

		Tween.Create = function(self, Object, Info, Goal)
			if not (Object or Goal or Info or Library) then 
				return end;

			Info = Info or Library.TweenInfo

			local NewTween = {
				Info = Info;
				Object = Object;
				Tween = TweenService:Create( Object, Info, Goal )
			};

			setmetatable(NewTween, Tween);

			NewTween.Tween:Play();

			return NewTween;
		end;

		Tween.Get = function(self)
			return self.Tween, self.Object, self.Info;
		end;

		Tween.Play = function(self)
			self.Tween:Play();
		end;

		Tween.Clean = function(self)
			self.Tween:Pause();
			self = nil;
		end;
	end;

	local Objects = {}; do -- Objects
		Objects.__index = Objects;

		Objects.New = function(self, Class, Properties)
			local Item = {
				Object = INew(Class);
				Properties = Properties;
				Class = Class;
				Dragging = false;
			};

			setmetatable(Item, Objects);

			for Property, Value in Properties do
				Item.Object[Property] = Value;
			end;

			return Item;
		end;

		Objects.Border = function(self)
			local Gui = self.Object;

			local Border = Objects:New("UIStroke", {
				Parent = Gui;
				Color = Library.Theme.Border;
				Thickness = 1;
				LineJoinMode = Enum.LineJoinMode.Miter;
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
			}); Library:AddToTheme(Border.Object, {Color = "Border"});

			return Border;
		end;

		Objects.TextBorder = function(self)
			local Gui = self.Object;

			local Border = Objects:New("UIStroke", {
				Parent = Gui;
				Color = Library.Theme.TextBorder;
				Thickness = 1;
				LineJoinMode = Enum.LineJoinMode.Miter;
				ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
			}); Library:AddToTheme(Border.Object, {Color = "Text Border"});

			return Border;
		end;

		Objects.Tween = function(self, Info, Goal)
			local NewTween = Tween:Create(self.Object, Info, Goal);
			return NewTween;
		end;

		Objects.Dragify = function(self, Name)
			local Gui = self.Object
			local Dragging = false;
			local DragStart, StartPosition;


			local Update = function(Input)
				local Delta = Input.Position - DragStart;
				Tween:Create(
					Gui, 
					TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), 
					{Position = U2New(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y);}
				);
				
				Library.Flags[Name] = {
					X = Gui.Position.X.Offset;
					Y = Gui.Position.Y.Offset;
				};
			end;

			Library:Connect(Gui.InputBegan, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Dragging = true;
					DragStart = Input.Position;
					StartPosition = Gui.Position;
				end;
			end, Gui.Name .. "Draggable1");

			Library:Connect(Gui.InputEnded, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 then
					Dragging = false;
				end;
			end, Gui.Name .. "Draggable2");

			Library:Connect(UserInputService.InputChanged, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseMovement and Dragging then
					Update(Input);
				end;
			end, Gui.Name .. "Draggable3");

			Library.SetFlags[Name] = function(X, Y)
				Gui.Position = U2New(0, X, 0, Y);
			end;

			return Dragging;
		end;

		Objects.Resizeable = function(self, Min, Max, Name)
			Min = Min or V2New(592, 413);

			local Gui = self.Object;

			local Resizing = false;
			local Start = U2New();
			local Delta = U2New();
			local ResizeMax = Gui.Parent.AbsoluteSize - Gui.AbsoluteSize;

			local ResizeButton = Objects:New("ImageButton", {
				Parent = Gui,
				AnchorPoint = V2New(1, 1),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(0, 8, 0, 8),
				Position = U2New(1, 0, 1, 0),
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				ImageColor3 = Library.Theme.Accent;
				Image = "rbxassetid://7368471234";
				AutoButtonColor = false;
			});

			Library:AddToTheme(ResizeButton.Object, {ImageColor3 = "Accent"});

			Library:Connect(ResizeButton.Object.InputBegan, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Resizing = true;
					Start = Gui.Size - U2New(0, Input.Position.X, 0, Input.Position.Y);
				end;
			end, Gui.Name .. "Resizer1");

			Library:Connect(ResizeButton.Object.InputEnded, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Resizing = false;
				end;
			end, Gui.Name .. "Resizer2");

			Library:Connect(UserInputService.InputChanged, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseMovement and Resizing then
					ResizeMax = Max or Gui.Parent.AbsoluteSize - Gui.AbsoluteSize;

					Delta = Start + U2New(0, Input.Position.X, 0, Input.Position.Y);
					Delta = U2New(
						0, MathClamp(Delta.X.Offset, Min.X, ResizeMax.X),
						0, MathClamp(Delta.Y.Offset, Min.Y, ResizeMax.Y)
					);

					Tween:Create(
						Gui,
						TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
						{Size = Delta}
					);
				end;
			end, Gui.Name .. "Resizer3");

			return Resizing;
		end;

		Objects.Tooltip = function(self, Text)
			local Gui = self.Object;

			if (Text == nil) then 
				return end;

			local RenderStepped;
			local MousePos = UserInputService:GetMouseLocation();

			local NewTooltip = Objects:New("Frame", {
				Parent = Library.Holder.Object;
				BackgroundColor3 = Library.Theme.Background;
				Size = U2New(0, 0, 0, 20);
				BorderSizePixel = 0;
				ClipsDescendants = true;
				Position = U2New(0, MousePos.X, 0, MousePos.Y - 45);
				Visible = false;
				ZIndex = 5;
			}); Library:AddToTheme(NewTooltip.Object, {BackgroundColor3 = "Background"});

			NewTooltip:Border();

			local Label = Objects:New("TextLabel", {
				Parent = NewTooltip.Object;
				BackgroundTransparency = 1;
				Size = U2New(1, -6, 1, 0);
				Text = Text;
				Position = U2New(0, 6, 0, 1);
				TextSize = 13;
				TextColor3 = Library.Theme.Text;
				FontFace = UIFont;
				TextStrokeTransparency = 0;
				ZIndex = 5;
				TextXAlignment = Enum.TextXAlignment.Left;
			});	Library:AddToTheme(Label.Object, {TextColor3 = "Text"});

			Label:TextBorder();

			Library:Connect(Gui.MouseEnter, function()
				NewTooltip.Object.Visible = true;
				Tween:Create(NewTooltip.Object, nil, {Size = U2New(0, Label.Object.TextBounds.X + 13, 0, 20)});

				RenderStepped = RunService.RenderStepped:Connect(function()
					MousePos = UserInputService:GetMouseLocation();

					Tween:Create(NewTooltip.Object, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
						Position = U2New(0, MousePos.X, 0, MousePos.Y - 45)
					});
				end);
			end);

			Library:Connect(Gui.MouseLeave, function()
				Tween:Create(NewTooltip.Object, nil, {Size = U2New(0, 0, 0, 20)});
				task.wait(0.2);
				NewTooltip.Object.Visible = false;

				if RenderStepped then 
					RenderStepped:Disconnect();
				end;
			end);
		end;

		Objects.Clean = function(self)
			self.Object:Destroy();
			self = nil;
		end;
	end;

	do -- Library
		Library.Holder = Objects:New("ScreenGui", {
			Parent =  gethui and gethui() or CoreGui,
			Name = "\0",
			ZIndexBehavior = Enum.ZIndexBehavior.Global
		});

		Library.NotifHolder = Objects:New("Frame", {
			Parent = Library.Holder.Object,
			BorderColor3 = FromRGB(0, 0, 0),
			AnchorPoint = V2New(0, 0.5),
			BackgroundTransparency = 1,
			Position = U2New(0, 8, 0.5, 0),
			Name = "NotificationHolders",
			Size = U2New(0.221, 0, 1, -15),
			BorderSizePixel = 0,
			BackgroundColor3 = FromRGB(255, 255, 255)
		});

		Objects:New("UIListLayout", {
			Parent = Library.NotifHolder.Object,
			Padding = UNew(0, 7),
			SortOrder = Enum.SortOrder.LayoutOrder
		});

		function Library:DoFolders()
			if not isfolder(Library.Files.Directory) then 
				makefolder(Library.Files.Directory);
			end;

			if not isfolder(Library.Files.Directory .. "/" .. Library.Files.Configs) then 
				makefolder(Library.Files.Directory .. "/" .. Library.Files.Configs);
			end;

			if not isfolder(Library.Files.Directory .. "/" .. Library.Files.Fonts) then 
				makefolder(Library.Files.Directory .. "/" .. Library.Files.Fonts);
			end;
		end;

		Library:DoFolders();

		function Library:GetDirectory()
			if not isfolder(Library.Files.Directory) then 
				Library:DoFolders() end;

			return Library.Files.Directory .. "/";
		end;

		function Library:GetConfigsDirectory()
			if not isfolder(Library.Files.Configs) then 
				Library:DoFolders() end;

			return Library.Files.Directory .. "/" .. Library.Files.Configs .. "/";
		end;

		function Library:GetFontsDirectory()
			if not isfolder(Library.Files.Fonts) then 
				Library:DoFolders() end;

			return Library.Files.Directory .. "/" .. Library.Files.Fonts .. "/";
		end;

		do  -- Custom Font
			local FontHandler = {};

			function FontHandler:New(Name, Weight, Style, Asset)
				if not isfile(Library.Files.Directory .. "/" .. Library.Files.Fonts .. "/" .. Name .. ".json") then
					if not isfile(Library.Files.Directory .. "/" .. Library.Files.Fonts .. "/" .. Asset.Id) then
						writefile(Library.Files.Directory .. "/" .. Library.Files.Fonts .. "/" .. Asset.Id, game:HttpGet(Asset.Url));
					end;

					local Data = {
						name = Name,
						faces = {{
							name = "Regular",
							weight = Weight,
							style = Style,
							assetId = getcustomasset(Library.Files.Directory .. "/" .. Library.Files.Fonts .. "/" .. Asset.Id);
						}};
					};

					writefile(Library.Files.Directory .. "/" .. Library.Files.Fonts .. "/" .. Name .. ".json", HttpService:JSONEncode(Data));
					return getcustomasset(Library.Files.Directory .. "/" .. Library.Files.Fonts .. "/" .. Name .. ".json");
				end;
			end;

			function FontHandler:Get(Name)
				if isfile(Library.Files.Directory .. "/" .. Library.Files.Fonts .. "/" .. Name .. ".json") then
					return Font.new(getcustomasset(Library.Files.Directory .. "/" .. Library.Files.Fonts .. "/" .. Name .. ".json"));
				end;
			end;

			FontHandler:New("UIFont", 200, "normal", {Id = "OpenSansPX.ttf", Url = "https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/open-sans-px.ttf"});
			UIFont = FontHandler:Get("UIFont");
		end;

		function Library:WrapFunction(Function)
			local Thread = function(...)
				local Args = ...; 

				TaskSpawn(function()
					Function(Args);
				end);
			end;

			return Thread;
		end;

		function Library:Connect(Signal, Callback, Name)
			local Connection = {
				Connection = Signal:Connect(Callback);
				Signal = Signal;
				Callback = Callback;
				Name = Name;
			};
	
			TableInsert(Library.Connections, Connection);
	
			return Connection;
		end;

		function Library:Disconnect(Name)
			for _, Connection in Library.Connections do 
				if Connection.Name == Name then 
					Connection.Connection:Disconnect();
					break;
				end;
			end;    
		end;

		function Library:GetEnum(Name) -- credits to alex
			local Parts = { };

			for Index, Value in StringGmatch(Name, "[%w_]+") do
				TableInsert(Parts, Index);
			end;

			local EnumTable = Enum;
			for Index = 2, #Parts do
				local Item = EnumTable[Parts[Index]];

				EnumTable = Item;
			end;

			return EnumTable;
		end;

		function Library:AddToTheme(Object, Properties)
			local Data = {
				Instance = Object,
				Properties = Properties,
			};

			for Index, Value in Data.Properties do
				if type(Value) == "string" then
					Data.Instance[Index] = Library.Theme[Value];
				else
					Data.Instance[Index] = Value();
				end;
			end;

			TableInsert(Library.ThemeInstances, Data);
			Library.ThemeMap[Object] = Data;
		end;

		function Library:NextFlag()
			local Index = #Library.Flags + 1;
			return StringFormat("flag_%s", Index);
		end;

		function Library:GetConfig()
			local Config = {};

			local Success, Error = pcall(function()
				for Index, Value in Library.Flags do 
					if type(Value) == "table" and Value.Mode then
						Config[Index] = {Key = tostring(Value.Key), Mode = Value.Mode, Toggled = Value.Toggled};
					elseif type(Value) == "table" and Value.Color then
						Config[Index] = {Color = "#" .. Value.HexValue, Alpha = Value.Alpha};
					elseif type(Value) == "table" and Value.X and Value.Y then 
						Config[Index] = {X = Value.X, Y = Value.Y};
					else
						Config[Index] = Value;
					end;
				end;
			end);

			if not Success then
				Library:Notification("Failed to get config, report this to the devs:\n"..Error, 5, FromRGB(255, 0, 0));
			end;

			return HttpService:JSONEncode(Config);
		end;

		function Library:LoadConfig(Config)
			local Decoded = HttpService:JSONDecode(Config);

            local Success, Error = pcall(function()
                for Index, Value in Decoded do 
					local SetFunction = Library.SetFlags[Index];

					if not SetFunction then 
						continue;
					end;

					if type(Value) == "table" and Value.Key then 
						SetFunction(Value);
					elseif type(Value) == "table" and Value.Color then
						SetFunction(Value.Color, Value.Alpha);
					elseif type(Value) == "table" and Value.X and Value.Y then
						SetFunction(Value.X, Value.Y);
					else
						SetFunction(Value);
					end;
                end;
            end);

			if not Success then
				Library:Notification("Failed to load config, report this to the devs:\n"..Error, 5, FromRGB(255, 0, 0));
			else
				Library:Notification("Loaded config successfully", 5, FromRGB(0, 255, 0));
			end;
		end;

		function Library:ChangeObjectTheme(Object, Properties)
			if Library.ThemeMap[Object] then
				local Data = Library.ThemeMap[Object];
				Data.Properties = Properties;

				Library.ThemeMap[Object] = Data;
			end;
		end;

		function Library:ChangeTheme(Theme, Color)
			Library.Theme[Theme] = Color
	
			for Object, Value in Library.ThemeMap do
				local Properties = Value.Properties
	
				for PropertyName, PropertyTheme in Properties do
					if PropertyTheme == Theme then
						Object[PropertyName] = Color;
					end;
				end;
			end;
		end;

		function Library:ListConfigs(Element)
			local CurrentList = { };
			local List = { };

			for Index, Value in listfiles(Library.Files.Directory .. "/" .. Library.Files.Configs) do
				local FileName = StringGSub(Value, Library.Files.Directory .. "\\Configs\\", ""):gsub(".json", "");
				List[#List + 1] = FileName;
			end;

			local IsNew = #List ~= CurrentList;

			if not IsNew then
				for Index = 1, #List do
					if List[Index] ~= CurrentList[Index] then
						IsNew = true;
						break;
					end;
				end;
			else
				CurrentList = List;
				Element:Refresh(CurrentList);
			end;
		end;

		function Library:RoundNumber(Number, Float)
			local Multiplier = 1 / (Float or 1);
			return MathFloor(Number * Multiplier + 0.5) / Multiplier;
		end;

		function Library:ToRich(Text, Color)
			return `<font color="rgb({MathFloor(Color.R * 255)}, {MathFloor(Color.G * 255)}, {MathFloor(Color.B * 255)})">{Text}</font>`;
		end;

		function Library:Unload()
			for _, Connection in Library.Connections do 
				Connection.Connection:Disconnect();
			end;

			if Library.Holder then
				Library.Holder:Clean();
			end;

			getgenv().Library = nil;
			Library = nil;
		end;

		function Library:KeybindList(Name)
			local KeybindList = {};

			Library.KeyList = KeybindList

			local KeybindListBackground = Objects:New("Frame", {
				Parent = Library.Holder.Object;
				BackgroundColor3 = Library.Theme.Background;
				AutomaticSize = Enum.AutomaticSize.XY;
				AnchorPoint = V2New(0, 0.5);
				Position = U2New(0, 15, 0.5, 0);
				BorderSizePixel = 0,
				Size = U2New(0, 0, 0, 0),
			});

			KeybindListBackground:Dragify(Name)

			KeybindListBackground:Border()
			Library:AddToTheme(KeybindListBackground.Object, {BackgroundColor3 = "Background"});

			local AccentLiner = Objects:New("Frame", {
				Parent = KeybindListBackground.Object,
				Name = "Liner",
				Position = U2New(0, -5, 0, -2),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, 10, 0, 1),
				BackgroundColor3 = Library.Theme.Accent,
				BorderSizePixel = 0,
			}); Library:AddToTheme(AccentLiner.Object, {BackgroundColor3 = "Accent"});

			Objects:New("UIPadding", {
				Parent = KeybindListBackground.Object,
				PaddingLeft = UDim.new(0, 5),
				PaddingRight = UDim.new(0, 5),
				PaddingTop = UDim.new(0, 2),
				PaddingBottom = UDim.new(0, 5),
			})

			local Title = Objects:New("TextLabel", {
				Parent = KeybindListBackground.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "Keybinds",
				Name = "Title",
				Position = U2New(0, -11, 0, 0),
				Size = U2New(0, 75, 0, 20),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Center,
				BorderSizePixel = 0,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			}); Library:AddToTheme(Title.Object, {TextColor3 = "Text"});

			Title:TextBorder()

			local KeybindContent = Objects:New("Frame", {
				Parent = KeybindListBackground.Object,
				BackgroundColor3 = Library.Theme.Background;
				AutomaticSize = Enum.AutomaticSize.XY;
				Position = U2New(0, 0, 0, 20),
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
			});

			Objects:New("UIPadding", {
				Parent = KeybindContent.Object,
				PaddingLeft = UDim.new(0, 5),
				PaddingRight = UDim.new(0, 5),
				PaddingTop = UDim.new(0, 2),
			});

			Objects:New("UIListLayout", {
				Parent = KeybindContent.Object,
				SortOrder = Enum.SortOrder.LayoutOrder,
			});

			function KeybindList:Add(Name, Key, Mode)
				local NewKey = Objects:New("TextLabel", {
					Parent = KeybindContent.Object,
					FontFace = UIFont,
					TextColor3 = Library.Theme.Text,
					BorderColor3 = FromRGB(0, 0, 0),
					Text = Name .. ": [" .. Key .. "]" .. " (".. Mode ..")",
					Name = "Key",
					AutomaticSize = Enum.AutomaticSize.X,
					Position = U2New(0, 0, 0, 0),
					Size = U2New(0, 0, 0, 15),
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Center,
					BorderSizePixel = 0,
					TextSize = 13,
					BackgroundColor3 = FromRGB(255, 255, 255)
				}); Library:AddToTheme(NewKey.Object, {TextColor3 = "Text"});

				function NewKey:Set(Name, Key, Mode)
					NewKey.Object.Text = Name .. ": [" .. Key .. "]" .. " (".. Mode ..")";
				end

				function NewKey:SetStatus(Bool)
					if Bool then 
						NewKey:Tween(nil, {TextColor3 = Library.Theme.Accent});
						Library:ChangeObjectTheme(NewKey.Object, {TextColor3 = "Accent"});
					else 
						NewKey:Tween(nil, {TextColor3 = Library.Theme.Text});
						Library:ChangeObjectTheme(NewKey.Object, {TextColor3 = "Text"});
					end;
				end;

				return NewKey;
			end;

			function KeybindList:SetVisibility(Bool)
				KeybindListBackground.Object.Visible = Bool;
			end

			return KeybindList;
		end;

		function Library:CreateColorpicker(Data)
			local Colorpicker = {
				Open = false;
				Color = nil,
				Hue = nil,
				HexValue = nil;
				Alpha = nil;
				Tabs = {};
				Saturation = nil;
				Value = nil;
				Class = "Colorpicker"
			};

			Library.Flags[Data.Flag] = {};

			local ColorpickerWindow = Objects:New("Frame", {
				Parent = Library.MainFrame.Object,
				Size = U2New(0, 300, 0, 213),
				Name = "ColorpickerWindow",
				Position = U2New(1, 5, 0, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				BackgroundColor3 = Library.Theme.Background;
				Visible = false;
				ClipsDescendants = true;
				BackgroundTransparency = 0;
			});

			Library:AddToTheme(ColorpickerWindow.Object, {BackgroundColor3 = "Background"});
			ColorpickerWindow:Border();

			local NewColorpicker = Objects:New("Frame", {
				Parent = Data.Parent,
				BackgroundTransparency = 1,
				Name = Data.Name,
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, 0, 0, 12),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});
			
			local Text = Objects:New("TextLabel", {
				Parent = NewColorpicker.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				BorderColor3 = FromRGB(0, 0, 0),
				Text = Data.Name,
				Name = "Text",
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				Size = U2New(1, 0, 1, 0),
				BorderSizePixel = 0,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			}); Library:AddToTheme(Text.Object, {TextColor3 = "Text"});

			Text:TextBorder();
			
			local ColorpickerButton = Objects:New("TextButton", {
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
				TextColor3 = FromRGB(0, 0, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "",
				AutoButtonColor = false,
				AnchorPoint = V2New(1, 0),
				Name = "Button",
				Position = U2New(1, 0, 0, 0),
				Size = U2New(0.134, 0, 0, 12),
				BorderSizePixel = 0,
				TextSize = 14,
				BackgroundColor3 = FromRGB(89, 155, 255);
			});

			ColorpickerButton:Tooltip(Data.Tooltip)

			local CalculateCount = function(Index)
				local MaxButtonsAdded = 5;

				local Row = MathFloor(Index / MaxButtonsAdded);
				local Column = Index % MaxButtonsAdded;
			
				local ButtonSize = ColorpickerButton.Object.AbsoluteSize;
				local Spacing = 28;
			
				local XPosition = (ButtonSize.X + Spacing) * Column - Spacing;
			
				return U2New(1, -XPosition, 0, Row * (ButtonSize.Y + Spacing));
			end;

			ColorpickerButton.Object.Position = CalculateCount(Data.Count);

			if Data.IsToggle then 
				NewColorpicker:Clean();
				Text:Clean();
				ColorpickerButton.Object.Parent = Data.Parent;
			else
				ColorpickerButton.Object.Parent = NewColorpicker.Object;
				NewColorpicker:Tooltip(Data.Tooltip);
			end;

			ColorpickerButton:Border();

			local UIGradient = Objects:New("UIGradient", {
				Parent = ColorpickerButton.Object,
				Rotation = 90,
				Color = FromRGBSeq{FromRGBKey(0, FromRGB(255, 255, 255)), FromRGBKey(1, FromRGB(165, 165, 165))}
			});		
			
			local WindowTitle = Objects:New("TextLabel", {
				Parent = ColorpickerWindow.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				BorderColor3 = FromRGB(0, 0, 0),
				Text = Data.Name,
				Name = "Title",
				Size = U2New(1, -35, 0, 20),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				Position = U2New(0, 8, 0, 3),
				BorderSizePixel = 0,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			}); Library:AddToTheme(WindowTitle.Object, {TextColor3 = "Text"});

			WindowTitle:TextBorder();

			local AccentLiner = Objects:New("Frame", {
				Parent = ColorpickerWindow.Object,
				Name = "Liner",
				Position = U2New(0, 0, 0, 24),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, 0, 0, 1),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme.Accent
			});

			Library:AddToTheme(AccentLiner.Object, {BackgroundColor3 = "Accent"});

			local UIGradient2 = Objects:New("UIGradient", {
				Parent = AccentLiner.Object,
				Transparency = NumberSeq{NumberKey(0, 1), NumberKey(0.494, 0), NumberKey(1, 1)}
			});

			local ColorpickerTabHolder = Objects:New("Frame", {
				Parent = ColorpickerWindow.Object,
				Name = "Tabs",
				Position = U2New(0, 5, 0.141, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(0.25, 0, 0.84, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme.Background
			});

			Library:AddToTheme(ColorpickerTabHolder.Object, {BackgroundColor3 = "Background"});
			ColorpickerTabHolder:Border();
			
			local ColorpickerRealTabHolder = Objects:New("Frame", {
				Parent = ColorpickerTabHolder.Object,
				Name = "Holder",
				BackgroundTransparency = 1,
				Position = U2New(0, 0, 0, 2),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, 0, 1, -14),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});
			
			local UIListLayout = Objects:New("UIListLayout", {
				Parent = ColorpickerRealTabHolder.Object,
				Padding = UNew(0, 6),
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder
			});

			local ContentContainer = Objects:New("Frame", {
				Parent = ColorpickerWindow.Object,
				Name = "Content",
				BackgroundTransparency = 1,
				Position = U2New(0.29, 0, 0.135, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(0.69, 0, 0.86, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});

			local CreateTabs = function()
				do
					local Picking = Objects:New("TextButton", {
						Parent = ColorpickerRealTabHolder.Object,
						FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
						TextColor3 = FromRGB(0, 0, 0),
						BorderColor3 = FromRGB(0, 0, 0),
						Text = "",
						AutoButtonColor = false,
						Name = "Picking",
						Size = U2New(0.95, 0, 0, 24),
						BorderSizePixel = 0,
						TextSize = 14,
						BackgroundColor3 = Library.Theme.Inline
					});

					Library:AddToTheme(Picking.Object, {BackgroundColor3 = "Inline"});
					Picking:Border(Picking.Object);
					
					local UIGradient99 = Objects:New("UIGradient", {
						Parent = Picking.Object,
						Rotation = 90,
						Color = FromRGBSeq{FromRGBKey(0, FromRGB(255, 255, 255)), FromRGBKey(1, FromRGB(165, 165, 165))}
					});
					
					local Liner = Objects:New("Frame", {
						Parent = Picking.Object,
						Name = "Liner",
						BorderColor3 = FromRGB(0, 0, 0),
						Size = U2New(0, 1, 0, 0),
						BorderSizePixel = 0,
						BackgroundTransparency = 0;
						BackgroundColor3 = Library.Theme.Accent
					});

					Library:AddToTheme(Liner.Object, {BackgroundColor3 = "Accent"});
					
					local Glow = Objects:New("Frame", {
						Parent = Picking.Object,
						Name = "Glow",
						BorderColor3 = FromRGB(0, 0, 0),
						Size = U2New(0, 25, 0, 0),
						BorderSizePixel = 0,
						BackgroundTransparency = 1,
						BackgroundColor3 = Library.Theme.Accent
					});

					Library:AddToTheme(Glow.Object, {BackgroundColor3 = "Accent"});
					
					local UIGradie531nt = Objects:New("UIGradient", {
						Parent = Glow.Object,
						Transparency = NumberSeq{NumberKey(0, 0), NumberKey(0.198, 0.84375), NumberKey(0.389, 0.918749988079071), NumberKey(0.54, 0.9624999761581421), NumberKey(0.718, 0.949999988079071), NumberKey(1, 1)}
					});
					
					local Text = Objects:New("TextLabel", {
						Parent = Picking.Object,
						FontFace = UIFont,
						TextColor3 = Library.Theme.Text,
						BorderColor3 = FromRGB(0, 0, 0),
						Text = "Picking",
						Name = "Text",
						Size = U2New(1, 0, 1, 0),
						BackgroundTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Left,
						Position = U2New(0, 10, 0, 0),
						BorderSizePixel = 0,
						TextSize = 13,
						TextTransparency = .48;
						BackgroundColor3 = FromRGB(255, 255, 255)
					}); Library:AddToTheme(Text.Object, {TextColor3 = "Text"});

					Text:TextBorder();

					local PickingTab = Objects:New("Frame", {
						Parent = ContentContainer.Object,
						BackgroundTransparency = 1,
						Name = "PickingTab",
						BorderColor3 = FromRGB(0, 0, 0),
						Size = U2New(1, 0, 1, 0),
						BorderSizePixel = 0,
						BackgroundColor3 = FromRGB(255, 255, 255),
						Visible = false;
					});

					Colorpicker.Tabs["Picking"] = {
						Object = Picking.Object;
						Liner = Liner.Object;
						Glow = Glow.Object;
						Text = Text.Object;
						Content = PickingTab.Object
					};

					Library:Connect(Picking.Object.MouseButton1Click, function()
						Tween:Create(Glow.Object, nil, {Size = U2New(0, 25, 1, 0), BackgroundTransparency = 0});
						Tween:Create(Liner.Object, nil, {Size = U2New(0, 1, 1, 0), BackgroundTransparency = 0});
						Tween:Create(Text.Object, nil, {Position = U2New(0, 10, 0, 0), TextTransparency = 0});

						PickingTab.Object.Visible = true;

						for i, v in next, Colorpicker.Tabs do
							if i ~= "Picking" then
								Tween:Create(v.Glow, nil, {Size = U2New(0, 25, 0, 0), BackgroundTransparency = 1});
								Tween:Create(v.Liner, nil, {Size = U2New(0, 1, 0, 0), BackgroundTransparency = 1});
								Tween:Create(v.Text, nil, {Position = U2New(0, 10, 0, 0), TextTransparency = 0.48});

								v.Content.Visible = false;
							end;
						end;
					end, "PickingSwitchEvent");
				end;
				do
					local Colorings = Objects:New("TextButton", {
						Parent = ColorpickerRealTabHolder.Object,
						FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
						TextColor3 = FromRGB(0, 0, 0),
						BorderColor3 = FromRGB(0, 0, 0),
						Text = "",
						AutoButtonColor = false,
						Name = "Picking",
						Size = U2New(0.95, 0, 0, 24),
						BorderSizePixel = 0,
						TextSize = 14,
						BackgroundColor3 = Library.Theme.Inline
					});

					Library:AddToTheme(Colorings.Object, {BackgroundColor3 = "Inline"});
					Colorings:Border();
					
					local UIGradient99 = Objects:New("UIGradient", {
						Parent = Colorings.Object,
						Rotation = 90,
						Color = FromRGBSeq{FromRGBKey(0, FromRGB(255, 255, 255)), FromRGBKey(1, FromRGB(165, 165, 165))}
					});
					
					local Liner = Objects:New("Frame", {
						Parent = Colorings.Object,
						Name = "Liner",
						BorderColor3 = FromRGB(0, 0, 0),
						Size = U2New(0, 1, 0, 0),
						BorderSizePixel = 0,
						BackgroundTransparency = 0;
						BackgroundColor3 = Library.Theme.Accent
					});

					Library:AddToTheme(Liner.Object, {BackgroundColor3 = "Accent"});
					
					local Glow = Objects:New("Frame", {
						Parent = Colorings.Object,
						Name = "Glow",
						BorderColor3 = FromRGB(0, 0, 0),
						Size = U2New(0, 25, 0, 0),
						BorderSizePixel = 0,
						BackgroundTransparency = 1,
						BackgroundColor3 = Library.Theme.Accent
					});

					Library:AddToTheme(Glow.Object, {BackgroundColor3 = "Accent"});
					
					local UIGradie531nt = Objects:New("UIGradient", {
						Parent = Glow.Object,
						Transparency = NumberSeq{NumberKey(0, 0), NumberKey(0.198, 0.84375), NumberKey(0.389, 0.918749988079071), NumberKey(0.54, 0.9624999761581421), NumberKey(0.718, 0.949999988079071), NumberKey(1, 1)}
					});
					
					local Text = Objects:New("TextLabel", {
						Parent = Colorings.Object,
						FontFace = UIFont,
						TextColor3 = Library.Theme.Text,
						BorderColor3 = FromRGB(0, 0, 0),
						Text = "Colors",
						Name = "Text",
						Size = U2New(1, 0, 1, 0),
						BackgroundTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Left,
						Position = U2New(0, 10, 0, 0),
						BorderSizePixel = 0,
						TextTransparency = .48;
						TextSize = 13,
						BackgroundColor3 = FromRGB(255, 255, 255)
					});	Library:AddToTheme(Text.Object, {TextColor3 = "Text"});

					Text:TextBorder();

					local ColorsTab = Objects:New("Frame", {
						Parent = ContentContainer.Object,
						BackgroundTransparency = 1,
						Name = "ColorsTab",
						BorderColor3 = FromRGB(0, 0, 0),
						Size = U2New(1, 0, 1, 0),
						BorderSizePixel = 0,
						BackgroundColor3 = FromRGB(255, 255, 255),
						Visible = false;
					});

					Colorpicker.Tabs["Colors"] = {
						Object = Colorings.Object;
						Liner = Liner.Object;
						Glow = Glow.Object;
						Text = Text.Object;
						Content = ColorsTab.Object
					};

					Library:Connect(Colorings.Object.MouseButton1Click, function()
						Tween:Create(Glow.Object, nil, {Size = U2New(0, 25, 1, 0), BackgroundTransparency = 0});
						Tween:Create(Liner.Object, nil, {Size = U2New(0, 1, 1, 0), BackgroundTransparency = 0});
						Tween:Create(Text.Object, nil, {Position = U2New(0, 10, 0, 0), TextTransparency = 0});

						ColorsTab.Object.Visible = true;

						for i, v in next, Colorpicker.Tabs do
							if i ~= "Colors" then
								Tween:Create(v.Glow, nil, {Size = U2New(0, 25, 0, 0), BackgroundTransparency = 1});
								Tween:Create(v.Liner, nil, {Size = U2New(0, 1, 0, 0), BackgroundTransparency = 1});
								Tween:Create(v.Text, nil, {Position = U2New(0, 10, 0, 0), TextTransparency = 0.48});
								v.Content.Visible = false;
							end;
						end;
					end, "ColoringsSwitchEvent");
				end;
			end;

			CreateTabs();

			for i, v in next, Colorpicker.Tabs do
				if i ~= "Picking" then
					Tween:Create(v.Glow, nil, {Size = U2New(0, 25, 0, 0), BackgroundTransparency = 1});
					Tween:Create(v.Liner, nil, {Size = U2New(0, 1, 0, 0), BackgroundTransparency = 1});
					Tween:Create(v.Text, nil, {Position = U2New(0, 10, 0, 0), TextTransparency = 0.48});

					v.Content.Visible = false;
				elseif i ==  "Picking" then
					Tween:Create(v.Glow, nil, {Size = U2New(0, 25, 1, 0), BackgroundTransparency = 0});
					Tween:Create(v.Liner, nil, {Size = U2New(0, 1, 1, 0), BackgroundTransparency = 0});
					Tween:Create(v.Text, nil, {Position = U2New(0, 10, 0, 0), TextTransparency = 0});

					v.Content.Visible = true;
				end;
			end;

			local ColorPalette = Objects:New("TextButton", {
				Parent = Colorpicker.Tabs.Picking.Content,
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
				TextColor3 = FromRGB(0, 0, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "",
				AutoButtonColor = false,
				Name = "Palette",
				Size = U2New(0.75, 0, 0.88, 0),
				BorderSizePixel = 0,
				TextSize = 14,
				BackgroundColor3 = FromRGB(89, 155, 255)
			});

			ColorPalette:Border();
			
			local SaturationImage = Objects:New("ImageLabel", {
				Parent = ColorPalette.Object,
				Image = "rbxassetid://130624743341203",
				BackgroundTransparency = 1,
				Name = "Saturation",
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, 0, 1, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});
			
			local ValueImage = Objects:New("ImageLabel", {
				Parent = ColorPalette.Object,
				Image = "rbxassetid://96192970265863",
				BackgroundTransparency = 1,
				Name = "Value",
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, 0, 1, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});
			
			local ColorDragger = Objects:New("Frame", {
				Parent = ColorPalette.Object,
				Name = "Dragger",
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(0, 2, 0, 2),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});
			
			ColorDragger:Border();

			local HueColor = Objects:New("ImageButton", {
				Parent = Colorpicker.Tabs.Picking.Content,
				Image = "rbxassetid://133334110106525",
				Name = "Hue",
				Position = U2New(0.78, 0, 0, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(0.08, 0, 0.88, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255),
				AutoButtonColor = false;
				BackgroundTransparency = 1;
			});

			HueColor:Border();
			
			local HueDragger = Objects:New("Frame", {
				Parent = HueColor.Object,
				Name = "Dragger",
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, 0, 0, 1),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});

			HueDragger:Border();	

			local AlphaColor = Objects:New("TextButton", {
				Parent = Colorpicker.Tabs.Picking.Content,
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
				TextColor3 = FromRGB(0, 0, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "",
				AutoButtonColor = false,
				AnchorPoint = V2New(1, 0),
				Name = "Alpha",
				Position = U2New(1, -4, 0, 0),
				Size = U2New(0.08, 0, 0.88, 0),
				BorderSizePixel = 0,
				TextSize = 14,
				BackgroundColor3 = FromRGB(89, 155, 255);
			});

			AlphaColor:Border();
			
			local CheckersIMGAlpha = Objects:New("ImageLabel", {
				Parent = AlphaColor.Object,
				ScaleType = Enum.ScaleType.Tile,
				BorderColor3 = FromRGB(0, 0, 0),
				Image = "http://www.roblox.com/asset/?id=18274452449",
				BackgroundTransparency = 1,
				Name = "Checkers",
				Size = U2New(1, 0, 1, 0),
				TileSize = U2New(0, 6, 0, 6),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});

			local CheckersIMGColorButton = Objects:New("ImageLabel", {
				Parent = ColorpickerButton.Object,
				ScaleType = Enum.ScaleType.Tile,
				BorderColor3 = FromRGB(0, 0, 0),
				Image = "http://www.roblox.com/asset/?id=18274452449",
				BackgroundTransparency = 1,
				Name = "Checkers",
				Size = U2New(1, 0, 1, 0),
				TileSize = U2New(0, 6, 0, 6),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255),
				ImageTransparency = 1;
			});

			local UIGradient4 = Objects:New("UIGradient", {
				Parent = CheckersIMGAlpha.Object,
				Rotation = -90,
				Transparency = NumberSeq{NumberKey(0, 1), NumberKey(1, 0)}
			});
			
			local AlphaDragger = Objects:New("Frame", {
				Parent = AlphaColor.Object,
				Name = "Dragger",
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, 0, 0, 1),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});
		
			AlphaDragger:Border();

			local RedGreenAlphaLabel = Objects:New("TextBox", {
				Parent = Colorpicker.Tabs.Picking.Content,
				RichText = true,
				TextColor3 = Library.Theme.Text,
				BorderColor3 = FromRGB(0, 0, 0),
				Text = `<font color="rgb(89, 155, 255)">89, 155, 255, </font>0`,
				Size = U2New(0.98, 0, 0, 15),
				Name = "RGBA",
				Position = U2New(0, 0, 0.9, 0),
				BorderSizePixel = 0,
				FontFace =UIFont,
				TextSize = 13,
				BackgroundColor3 = FromRGB(33, 36, 39)
			}); Library:AddToTheme(RedGreenAlphaLabel.Object, {TextColor3 = "Text"});

			RedGreenAlphaLabel:Border();
			RedGreenAlphaLabel:TextBorder();

			local UIPadding = Objects:New("UIPadding", {
				Parent = RedGreenAlphaLabel.Object,
				PaddingTop = UNew(0, 3)
			});			
			
			local UIGradient00 = Objects:New("UIGradient", {
				Parent = RedGreenAlphaLabel.Object,
				Rotation = 90,
				Color = FromRGBSeq{FromRGBKey(0, FromRGB(255, 255, 255)), FromRGBKey(1, FromRGB(165, 165, 165))}
			});			

			local MinimizeButton = Objects:New("TextButton", {
				Parent = ColorpickerWindow.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "X",
				AutoButtonColor = false,
				AnchorPoint = V2New(1, 0),
				Name = "Minimize",
				BackgroundTransparency = 1,
				Position = U2New(1, 0, 0, 2),
				Size = U2New(0, 20, 0, 20),
				BorderSizePixel = 0,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});Library:AddToTheme(MinimizeButton.Object, {TextColor3 = "Text"});

			local CurrentColorWithoutAlpha = Objects:New("Frame", {
				Parent = Colorpicker.Tabs.Colors.Content,
				Name = "CurrentColorWithoutAlpha",
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(0.48, 0, 0, 80),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(89, 155, 255)
			}); 

			CurrentColorWithoutAlpha:Border();
			
			local CurrentColorWithoutAlphaText = Objects:New("TextLabel", {
				Parent = CurrentColorWithoutAlpha.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "Alpha: 0",
				Name = "Text",
				BackgroundTransparency = 1,
				Position = U2New(0, 0, 1, 5),
				Size = U2New(1, 0, 0, 15),
				BorderSizePixel = 0,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			}); Library:AddToTheme(CurrentColorWithoutAlphaText.Object, {TextColor3 = "Text"});
			
			CurrentColorWithoutAlphaText:TextBorder();

			local CurrentColorWithAlpha = Objects:New("Frame", {
				Parent = Colorpicker.Tabs.Colors.Content,
				AnchorPoint = V2New(1, 0),
				Name = "CurrentColorWithAlpha",
				Position = U2New(1, 0, 0, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(0.48, 0, 0, 80),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(89, 155, 255)
			});
			
			local CheckersIMGColorWithAlpha = Objects:New("ImageLabel", {
				Parent = CurrentColorWithAlpha.Object,
				ScaleType = Enum.ScaleType.Tile,
				ImageTransparency = 0.6100000143051147,
				BorderColor3 = FromRGB(0, 0, 0),
				Image = "http://www.roblox.com/asset/?id=18274452449",
				BackgroundTransparency = 1,
				Name = "Checkers",
				Size = U2New(1, 0, 1, 0),
				TileSize = U2New(0, 6, 0, 6),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});

			local CheckersImgColorWithAlphaText = Objects:New("TextLabel", {
				Parent = CurrentColorWithAlpha.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "Alpha: 0.61",
				Name = "Text",
				BackgroundTransparency = 1,
				Position = U2New(0, 0, 1, 5),
				Size = U2New(1, 0, 0, 15),
				BorderSizePixel = 0,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});

			local RGBTextColors = Objects:New("TextLabel", {
				Parent = Colorpicker.Tabs.Colors.Content,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				BorderColor3 = FromRGB(0, 0, 0),
				Text = `<font color="rgb(89, 155, 255)">89, 155, 255</font>`,
				Name = "RGB",
				Size = U2New(1, 0, 0, 15),
				Position = U2New(0, 0, 0.57, 0),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				RichText = true,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			}); Library:AddToTheme(RGBTextColors.Object, {TextColor3 = "Text"});

			RGBTextColors:TextBorder();

			local HSVTextColors = Objects:New("TextLabel", {
				Parent = Colorpicker.Tabs.Colors.Content,
				FontFace = UIFont,
				TextColor3 = FromRGB(235, 235, 235),
				BorderColor3 = FromRGB(0, 0, 0),
				Text = `HSV: <font color="rgb(89, 155, 255)">216°, 65%, 100%</font>`,
				Name = "HSV",
				Size = U2New(1, 0, 0, 15),
				Position = U2New(0, 0, 0.65, 0),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				RichText = true,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});	Library:AddToTheme(HSVTextColors.Object, {TextColor3 = "Text"});

			HSVTextColors:TextBorder();

			local HEXTextColors = Objects:New("TextLabel", {
				Parent = Colorpicker.Tabs.Colors.Content,
				FontFace = UIFont,
				TextColor3 = FromRGB(235, 235, 235),
				BorderColor3 = FromRGB(0, 0, 0),
				Text = `HEX: <font color="rgb(89, 155, 255)">#599cff</font`,
				Name = "HEX",
				Size = U2New(1, 0, 0, 15),
				Position = U2New(0, 0, 0.74, 0),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				RichText = true,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			}); Library:AddToTheme(HEXTextColors.Object, {TextColor3 = "Text"})

			local FadeObjects = {
				{ColorpickerWindow.Object, "BackgroundTransparency"},
				{ColorPalette.Object, "BackgroundTransparency"},
				{ValueImage.Object, "ImageTransparency"},
				{SaturationImage.Object, "ImageTransparency"},
				{HueColor.Object, "ImageTransparency"},
				{AlphaColor.Object, "BackgroundTransparency"},
				{CheckersIMGAlpha.Object, "ImageTransparency"},
				{ColorDragger.Object, "BackgroundTransparency"},
				{RedGreenAlphaLabel.Object, "BackgroundTransparency"},
				{RedGreenAlphaLabel.Object, "TextTransparency"}
			}
			
			function Colorpicker:Fade(Transparency)
				for _, v in next, FadeObjects do
					Tween:Create(v[1], nil, {
						[v[2]] = Transparency;
					});
				end;
			end;

			HEXTextColors:TextBorder();

			CheckersImgColorWithAlphaText:TextBorder();
			Library:AddToTheme(CheckersImgColorWithAlphaText.Object, {TextColor3 = "Text"});

			Library:Connect(MinimizeButton.Object.MouseEnter, function()
				Tween:Create(MinimizeButton.Object, nil, {TextColor3 = Library.Theme.Accent});
				task.wait(0.2);
				Library:ChangeObjectTheme(MinimizeButton.Object, {TextColor3 = "Accent"});
			end);

			Library:Connect(MinimizeButton.Object.MouseLeave, function()
				Tween:Create(MinimizeButton.Object, nil, {TextColor3 = Library.Theme.Text});
				task.wait(0.2);
				Library:ChangeObjectTheme(MinimizeButton.Object, {TextColor3 = "Text"});
			end);
			
			local SearchStepped 
			Library:Connect(RedGreenAlphaLabel.Object.Focused, function()
				SearchStepped = RunService.RenderStepped:Connect(function()
					local RgbText = RedGreenAlphaLabel.Object.Text
                    local Red, Green, Blue = RgbText:match("(%d+),%s*(%d+),%s*(%d+)")
                    Red, Green, Blue = tonumber(Red), tonumber(Green), tonumber(Blue)

					Colorpicker:Set(FromRGB(Red, Green, Blue):ToHex(), Colorpicker.Alpha, true)
				end)
			end)

			Library:Connect(RedGreenAlphaLabel.Object.FocusLost, function()
				if SearchStepped then 
					SearchStepped:Disconnect()
					SearchStepped = nil
				end
			end)

			local SlidingPallette = false;
			local SlidingHue = false;
			local SlidingAlpha = false;

			function Colorpicker:Update(Debounce)
				Tween:Create(ColorPalette.Object, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundColor3 = FromHSV(self.Hue, 1, 1);});
				Tween:Create(ColorpickerButton.Object, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundColor3 = FromHSV(self.Hue, self.Saturation, self.Value);});
				Tween:Create(AlphaColor.Object, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundColor3 = FromHSV(self.Hue, self.Saturation, self.Value);});
				Tween:Create(CurrentColorWithoutAlpha.Object, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundColor3 = FromHSV(self.Hue, self.Saturation, self.Value);});
				Tween:Create(CurrentColorWithAlpha.Object, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundColor3 = FromHSV(self.Hue, self.Saturation, self.Value);});
				Tween:Create(CheckersIMGColorButton.Object, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = self.Alpha});
				Tween:Create(CheckersIMGColorWithAlpha.Object, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = self.Alpha});

				local Red = FromHSV(self.Hue, self.Saturation, self.Value).R;
				local Green = FromHSV(self.Hue, self.Saturation, self.Value).G;
				local Blue = FromHSV(self.Hue, self.Saturation, self.Value).B;

				local String = `{tostring(MathFloor(Red * 255))}, {tostring(MathFloor(Green * 255))}, {tostring(MathFloor(Blue * 255))}`;
				local FloorHue, FloorSat, FloorVal = Library:RoundNumber(self.Hue, 0.01), Library:RoundNumber(self.Saturation, 0.01), Library:RoundNumber(self.Value, 0.01);

				self.Color = FromHSV(self.Hue, self.Saturation, self.Value);
				self.HexValue = self.Color:ToHex();

				Library.Flags[Data.Flag] = {
					Color = self.Color;
					HexValue = self.HexValue;
					Alpha = self.Alpha;
				};

				if not Debounce then
					RedGreenAlphaLabel.Object.Text = `{Library:ToRich(String, self.Color)}`;
				end

				CheckersImgColorWithAlphaText.Object.Text = `Alpha: {Library:RoundNumber(self.Alpha, 0.01)}`;
				RGBTextColors.Object.Text = `RGB: {Library:ToRich(String, self.Color)}`;
				HSVTextColors.Object.Text = `HSV: %{Library:ToRich(FloorHue, self.Color)}, %{Library:ToRich(FloorSat, self.Color)}, %{Library:ToRich(FloorVal, self.Color)}`;
				HEXTextColors.Object.Text = `HEX: #{Library:ToRich(self.Color:ToHex(), self.Color)}`;
				
				if Data.Callback then
					Data.Callback(self.Color);
				end;
			end;

			function Colorpicker:SlidePalette(Input)
				if not SlidingPallette then 
					return end;

				local ValueX = MathClamp(1 - (Input.Position.X - ColorPalette.Object.AbsolutePosition.X) / ColorPalette.Object.AbsoluteSize.X, 0, 1);
				local ValueY = MathClamp(1 - (Input.Position.Y - ColorPalette.Object.AbsolutePosition.Y) / ColorPalette.Object.AbsoluteSize.Y, 0, 1);

				self.Saturation = ValueX;
				self.Value = ValueY;

				local SlideX = MathClamp((Input.Position.X - ColorPalette.Object.AbsolutePosition.X) / ColorPalette.Object.AbsoluteSize.X, 0, 1);
				local SlideY = MathClamp((Input.Position.Y - ColorPalette.Object.AbsolutePosition.Y) / ColorPalette.Object.AbsoluteSize.Y, 0, 1);

				Tween:Create(ColorDragger.Object, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = U2New(SlideX, 0, SlideY, 0)});
				Colorpicker:Update();
			end;

			function Colorpicker:SlideHue(Input)
				if not SlidingHue then 
					return end;

				local SlideY = MathClamp((Input.Position.Y - HueColor.Object.AbsolutePosition.Y) / HueColor.Object.AbsoluteSize.Y, 0, 1);
				local RealSlideY = MathClamp((Input.Position.Y - HueColor.Object.AbsolutePosition.Y) / HueColor.Object.AbsoluteSize.Y, 0, .985);

				self.Hue = SlideY;

				Tween:Create(HueDragger.Object, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = U2New(0, 0, RealSlideY, 0)});
				Colorpicker:Update();
			end;

			function Colorpicker:SlideAlpha(Input)
				if not SlidingAlpha then 
					return end;
				
				local SlideY = MathClamp((Input.Position.Y - AlphaColor.Object.AbsolutePosition.Y) / AlphaColor.Object.AbsoluteSize.Y, 0, 1);
				local RealSlideY = MathClamp((Input.Position.Y - AlphaColor.Object.AbsolutePosition.Y) / AlphaColor.Object.AbsoluteSize.Y, 0, .985);

				self.Alpha = SlideY;

				Tween:Create(AlphaDragger.Object, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = U2New(0, 0, RealSlideY, 0)});
				Tween:Create(CheckersIMGColorButton.Object, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = self.Alpha});
				Tween:Create(CheckersIMGColorWithAlpha.Object, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = self.Alpha});
				Colorpicker:Update();
			end;

			function Colorpicker:SetVisiblity(Bool)
				if Data.IsToggle then 
					return end;

				NewColorpicker.Object.Visible = Bool;
			end;

			function Colorpicker:Get()
				return Colorpicker.Value;
			end;

			function Colorpicker:Set(Color, Alpha, Debounce)
				if type(Color) == "table" then 
					Color = FromRGB(Color[1], Color[2], Color[3]);
					Alpha = Color[4];
				end;
			
				if type(Color) == "string" then 
					Color = Color3.fromHex(Color);
				end;

				self.Hue, self.Saturation, self.Value = Color:ToHSV();
				self.Alpha = Alpha or 0;

				self.Color = FromHSV(self.Hue, self.Saturation, self.Value);

				Library.Flags[Data.Flag] = {
					Color = self.Color,
					HexValue = self.Color:ToHex(),
					Alpha = self.Alpha
				}

				local ColorPositionX = MathClamp(1 - self.Saturation, 0, 1);
				local ColorPositionY = MathClamp(1 - self.Value, 0, 1);

				ColorDragger.Object.Position = U2New(ColorPositionX, 0, ColorPositionY, 0);

				local HuePositionY = MathClamp(self.Hue, 0, .985);

				HueDragger.Object.Position = U2New(0, 0, HuePositionY, 0);

				local AlphaPositionY = MathClamp(self.Alpha, 0, .985);

				AlphaDragger.Object.Position = U2New(0, 0, AlphaPositionY, 0);

				local CurrentColor = FromHSV(self.Hue, self.Saturation, self.Value);
				Colorpicker.Color = CurrentColor;

				Colorpicker.HexValue = Colorpicker.Color:ToHex();
				
				Tween:Create(CheckersIMGColorButton.Object, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = self.Alpha});
				Colorpicker:Update(Debounce);
			end;

			Library:Connect(ColorPalette.Object.InputBegan, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					SlidingPallette = true;
					Colorpicker:SlidePalette(Input);
				end;
			end);

			Library:Connect(ColorPalette.Object.InputEnded, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					SlidingPallette = false;
				end;
			end);

			Library:Connect(HueColor.Object.InputBegan, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					SlidingHue = true;
					Colorpicker:SlideHue(Input);
				end;
			end);

			Library:Connect(HueColor.Object.InputEnded, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					SlidingHue = false;
				end;
			end);

			Library:Connect(AlphaColor.Object.InputBegan, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					SlidingAlpha = true;
					Colorpicker:SlideAlpha(Input);
				end;
			end);

			Library:Connect(AlphaColor.Object.InputEnded, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					SlidingAlpha = false;
				end;
			end);

			Library:Connect(UserInputService.InputChanged, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseMovement then
					Colorpicker:SlidePalette(Input);
					Colorpicker:SlideHue(Input);
					Colorpicker:SlideAlpha(Input);
				end;
			end);

			function Colorpicker:SetOpen(Bool)
				self.Open = Bool;
			
				if Bool then
					if Library.CurrentColorpicker and Library.CurrentColorpicker ~= self then
						Library.CurrentColorpicker:SetOpen(false);
					end;
			
					Library.CurrentColorpicker = self;
			
					ColorpickerWindow.Object.Visible = true;
			
					self:Fade(0);
			
					local ColorPositionX = MathClamp(1 - self.Saturation, 0, 1);
					local ColorPositionY = MathClamp(1 - self.Value, 0, 1);
			
					Tween:Create(ColorDragger.Object, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
						Position = U2New(ColorPositionX, 0, ColorPositionY, 0);
					});
				else
					self:Fade(1);
			
					Tween:Create(ColorDragger.Object, nil, {
						Position = U2New(0.32, 0, 0.5, 0);
					});
			
					task.delay(0.17, function()
						if not self.Open then
							ColorpickerWindow.Object.Visible = false
			
							if Library.CurrentColorpicker == self then
								Library.CurrentColorpicker = nil;
							end;
						end;
					end);
				end;
			end;

			Library:Connect(MinimizeButton.Object.MouseButton1Click, function()
				Colorpicker:SetOpen(false);
			end);

			Library:Connect(ColorpickerButton.Object.MouseButton1Click, function()
				Colorpicker:SetOpen(not Colorpicker.Open);
			end);

			if Data.Default then
				Colorpicker:Set(Data.Default, Data.Alpha);
			end;

			local Red = FromHSV(Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value).R;
			local Green = FromHSV(Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value).G;
			local Blue = FromHSV(Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value).B;

			local String = `{tostring(MathFloor(Red * 255))}, {tostring(MathFloor(Green * 255))}, {tostring(MathFloor(Blue * 255))}`;
			RedGreenAlphaLabel.Object.Text = `RGBA: {Library:ToRich(String, Colorpicker.Color)}, {Library:RoundNumber(Colorpicker.Alpha, 0.01)}`;

			Library.SetFlags[Data.Flag] = function(Color, Alpha)
				Colorpicker:Set(Color, Alpha)
			end;

			return Colorpicker;
		end;

		function Library:Watermark(Text)
			local Watermark = { };

			local WatermarkBackground = Objects:New("Frame", {
				Parent = Library.Holder.Object;
				Size = U2New(0, 0, 0, 20);
				AutomaticSize = Enum.AutomaticSize.X;
				BackgroundColor3 = Library.Theme.Background;
				BorderSizePixel = 0;
				AnchorPoint = V2New(0.5, 0),
				Position = U2New(0.5, 0, 0, 20),
				Visible = true
			}); Library:AddToTheme(WatermarkBackground.Object, {BackgroundColor3 = "Background"});

			WatermarkBackground:Border();
			WatermarkBackground:Dragify(Text);

			local WatermarkText = Objects:New("TextLabel", {
				Parent = WatermarkBackground.Object;
				BackgroundTransparency = 1;
				Size = U2New(1, 0, 1, 0);
				Text = Text;
				Position = U2New(0, 0, 0, -1);
				TextSize = 13;
				TextColor3 = Library.Theme.Text;
				FontFace = UIFont;
				TextXAlignment = Enum.TextXAlignment.Left;
				AutomaticSize = Enum.AutomaticSize.X;
			}); Library:AddToTheme(WatermarkText.Object, {TextColor3 = "Text"});
			
			WatermarkText:TextBorder();

			Objects:New("UIPadding", {
				Parent = WatermarkText.Object;
				PaddingLeft = UNew(0, 6),
				PaddingRight = UNew(0, 6),
				PaddingTop = UNew(0, 3)
			});

			local AccentLine = Objects:New("Frame", {
				Parent = WatermarkBackground.Object;
				BackgroundColor3 = Library.Theme.Accent;
				Size = U2New(1, 0, 0, 1);
				BorderSizePixel = 0;
				Position = U2New(0, 0, 0, 0);
			}); Library:AddToTheme(AccentLine.Object, {BackgroundColor3 = "Accent"});

			function Watermark:SetVisiblity(Bool)
				WatermarkBackground.Object.Visible = Bool;
			end;

			return Watermark;
		end;

		function Library:Notification(Text, Duration, Color)
			local NewNotification = Objects:New("Frame", {
				Parent = Library.NotifHolder.Object;
				BackgroundColor3 = Library.Theme.Background;	
				Size = U2New(0, 0, 0, 20);
				BorderSizePixel = 0;
				ClipsDescendants = true;
				Visible = false;
				AutomaticSize = Enum.AutomaticSize.XY;
				ZIndex = 5;
				BackgroundTransparency = 1;
			});

			local Padding = Objects:New("UIPadding", {
				Parent = NewNotification.Object,
				PaddingRight = UNew(0, 6),
			})

			NewNotification:Border(NewNotification.Object);
			Library:AddToTheme(NewNotification.Object, {BackgroundColor3 = "Background"});

			local Label = Objects:New("TextLabel", {
				Parent = NewNotification.Object;
				BackgroundTransparency = 1;
				Size = U2New(1, -6, 1, 0);
				Text = Text;
				Position = U2New(0, 6, 0, 2);
				TextSize = 13;
				TextColor3 = Library.Theme.Text;
				FontFace = UIFont;
				TextStrokeTransparency = 0;
				ZIndex = 5;
				TextXAlignment = Enum.TextXAlignment.Left;
				TextWrapped = true;
				AutomaticSize = Enum.AutomaticSize.XY;
				TextTransparency = 1;
			});

			Library:AddToTheme(Label.Object, {TextColor3 = "Text"});
			local Border = Label:TextBorder();
			Border.Object.Transparency = 1;

			local AccentLine = Objects:New("Frame", {
				Parent = NewNotification.Object;
				BackgroundColor3 = Color;
				Size = U2New(0, 1, 1, 2);
				Position = U2New(0, 0, 0, 0);
				BorderSizePixel = 0;
				ZIndex = 5;
			});

			task.spawn(function()
				NewNotification.Object.Visible = true;
				task.wait(0.1);
				local a = Tween:Create(NewNotification.Object, nil, {BackgroundTransparency = 0});
				a.Tween.Completed:Wait();
				Tween:Create(Border.Object,  nil, {Transparency = 0});
				Tween:Create(Label.Object, nil, {TextTransparency = 0});
			end);

			task.delay(Duration + 0.1, function()
				Tween:Create(Border.Object,  nil, {Transparency = 1});
				Tween:Create(Label.Object, nil, {TextTransparency = 1});
				task.wait(0.1);
				local a = Tween:Create(NewNotification.Object, nil, {BackgroundTransparency = 0});
				a.Tween.Completed:Wait();
				NewNotification.Object.Visible = false;
			end);
		end;

		function Library:Window(Data)
			Data = Data or {};

			local Window = {
				Name = Data.Name or "Roblox UI Library",
				Tabs = {};
				SubTabs = {};
				Sections = {};
				Elements = {};
				Dragging = false;
				IsOpen = true
			};

			local MainFrame = Objects:New("Frame", {
				Parent = Library.Holder.Object,
				Name = "MainFrame",
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(0, 592, 0, 413),
				Position = U2New(0,Camera.ViewportSize.X / 2,0,Camera.ViewportSize.Y / 2);
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme.Background
			}); Library:AddToTheme(MainFrame.Object, {BackgroundColor3 = "Background"});

			Library.MainFrame = MainFrame;

			MainFrame:Border();

			local Title = Objects:New("TextLabel", {
				Parent = MainFrame.Object,
				FontFace = UIFont,
				TextColor3 = FromRGB(235, 235, 235),
				BorderColor3 = FromRGB(0, 0, 0),
				Text = Data.Name,
				Name = "Title",
				BackgroundTransparency = 1,
				Position = U2New(0, 0, 0, 3),
				Size = U2New(1, 0, 0, 20),
				BorderSizePixel = 0,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			}) Library:AddToTheme(Title.Object, {TextColor3 = "Text"});
			
			Title:TextBorder();

			local Inline = Objects:New("Frame", {
				Parent = MainFrame.Object,
				Name = "Inline",
				Position = U2New(0, 7, 0, 27),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, -14, 1, -34),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme.Inline
			}); Library:AddToTheme(Inline.Object, {BackgroundColor3 = "Inline"});

			Inline:Border();

			Objects:New("UIPadding", {
				Parent = Inline.Object,
				PaddingRight = UNew(0, 4)
			});

			local Tabs = Objects:New("Frame", {
				Parent = Inline.Object,
				AnchorPoint = V2New(0, 0.5),
				Name = "Tabs",
				Position = U2New(0, 6, 0.5, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(0.25, 0, 1, -12),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme.Background
			}); Library:AddToTheme(Tabs.Object, {BackgroundColor3 = "Background"});

			Tabs:Border();

			local TabHolder = Objects:New("Frame", {
				Parent = Tabs.Object,
				Name = "Holder",
				BackgroundTransparency = 1,
				Position = U2New(0, 0, 0, 4),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, 0, 1, -14),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});

			Objects:New("UIListLayout", {
				Parent = TabHolder.Object,
				Padding = UNew(0, 6),
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				SortOrder = Enum.SortOrder.LayoutOrder
			});

			Objects:New("UIPadding", {
				Parent = TabHolder.Object,
				PaddingLeft = UNew(0, 7),
				PaddingTop = UNew(0, 3)
			});

			local Subtabs = Objects:New("Frame", {
				Parent = Inline.Object,
				Name = "Subtabs",
				Position = U2New(0.27, 0, 0, 6),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(0.72, 4, 0.069, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme.Background
			});			

			local SubTabsHolder = Objects:New("Frame", {
				Parent = Subtabs.Object,
				BackgroundTransparency = 1,
				Name = "Holder",
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, 0, 1, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			}); Library:AddToTheme(Subtabs.Object, {BackgroundColor3 = "Background"});
			
			Subtabs:Border();

			local ContentContainer = Objects:New("Frame", {
				Parent = Inline.Object,
				Name = "Content",
				Position = U2New(0.27, 0, 0.1, -1),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(0.72, 4, 0.886, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme.Background
			});	Library:AddToTheme(ContentContainer.Object, {BackgroundColor3 = "Background"});		
			
			ContentContainer:Border();

			Window.Elements = {
				MainFrame = MainFrame;
				Inline = Inline;
				Tabs = Tabs;
				TabHolder = TabHolder;
				Subtabs = Subtabs;
				SubTabsHolder = SubTabsHolder;
				ContentContainer = ContentContainer;
			};

			do -- Dragging
				local Gui = MainFrame.Object
				local DragStart, StartPosition;

				local Update = function(Input)
					local Delta = Input.Position - DragStart;
					Tween:Create(
						Gui, 
						TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), 
						{Position = U2New(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y);}
					);

					Library.Flags["MainFramePosition"] = {
						X = Gui.Position.X.Offset;
						Y = Gui.Position.Y.Offset;
					};
				end;

				Library:Connect(Gui.InputBegan, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
						Library.Dragging = true;
						DragStart = Input.Position;
						StartPosition = Gui.Position;
					end;
				end, Gui.Name .. "Draggable1");

				Library:Connect(Gui.InputEnded, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						Library.Dragging = false;
					end;
				end, Gui.Name .. "Draggable2");

				Library:Connect(UserInputService.InputChanged, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseMovement and Library.Dragging then
						Update(Input);
					end;
				end, Gui.Name .. "Draggable3");
			end;

			MainFrame:Resizeable(V2New(592, 413), V2New(9999, 9999));

			Library:Connect(UserInputService.InputBegan, function(Input)
				if Input.KeyCode == Library.MenuKeybind or Input.UserInputType == Library.MenuKeybind then
					Window.IsOpen = not Window.IsOpen
					MainFrame.Object.Visible = Window.IsOpen
				end
			end)

			Library.SetFlags["MainFramePosition"] = function(X, Y)
				MainFrame.Object.Position = U2New(0, X, 0, Y);
			end;

			return setmetatable(Window, Library);
		end;

		function Library:Page(Data)
			Data = Data or {};

			local Page = {
				Window = self,
				Name = Data.Name or "Page",
				Active = false,
				Elements = {};
			};

			local TabButton = Objects:New("TextButton", {
				Parent = Page.Window.Elements.TabHolder.Object,
				FontFace = UIFont,
				TextColor3 = FromRGB(0, 0, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "",
				AutoButtonColor = false,
				Name = Page.Name,
				Size = U2New(1, -7, 0, 24),
				BorderSizePixel = 0,
				TextSize = 14,
				BackgroundColor3 = Library.Theme.Inline
			}); Library:AddToTheme(TabButton.Object, {BackgroundColor3 = "Inline"});

			TabButton:Border();

			Objects:New("UIGradient", {
				Parent = TabButton.Object,
				Rotation = 90,
				Color = FromRGBSeq{FromRGBKey(0, FromRGB(255, 255, 255)), FromRGBKey(1, FromRGB(165, 165, 165))}
			});

			local Liner = Objects:New("Frame", {
				Parent = TabButton.Object,
				BackgroundTransparency = 1,
				Name = "Liner",
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(0, 1, 0, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme.Accent
			});

			local Glow = Objects:New("Frame", {
				Parent = TabButton.Object,
				BackgroundTransparency = 1,
				Name = "Glow",
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(0, 25, 0, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme.Accent
			});

			Library:AddToTheme(Liner.Object, {BackgroundColor3 = "Accent"});
			Library:AddToTheme(Glow.Object, {BackgroundColor3 = "Accent"});

			Objects:New("UIGradient", {
				Parent = Glow.Object,
				Transparency = NumberSeq{NumberKey(0, 0), NumberKey(0.198, 0.84375), NumberKey(0.389, 0.918749988079071), NumberKey(0.54, 0.9624999761581421), NumberKey(0.718, 0.949999988079071), NumberKey(1, 1)}
			});

			local Text = Objects:New("TextLabel", {
				Parent = TabButton.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				TextTransparency = 0.48,
				Text = Page.Name,
				Name = "Text",
				Size = U2New(1, 0, 1, 0),
				Position = U2New(0, 5, 0, 0),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				BorderColor3 = FromRGB(0, 0, 0),
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});

			Text:TextBorder(Text.Object);
			Library:AddToTheme(Text.Object, {TextColor3 = "Text"});

			local TabContent = Objects:New("Frame", {
				Parent = Page.Window.Elements.ContentContainer.Object,
				BackgroundTransparency = 1,
				Name = Page.Name,
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, 0, 1, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255),
				Visible = false;
			});

			local SubPageButtons = Objects:New("Frame", {
				Parent = Page.Window.Elements.SubTabsHolder.Object,
				BackgroundColor3 = FromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, 0, 1, 0),
				BorderSizePixel = 0,
				Visible = false;
			});

			Objects:New("UIListLayout", {
				Parent = SubPageButtons.Object,
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				Padding = UNew(0, 4),
				SortOrder = Enum.SortOrder.LayoutOrder
			});			

			Page.Elements = {
				TabButton = TabButton,
				Text = Text,
				TabContent = TabContent,
				SubPageButtons = SubPageButtons;
			};

			function Page:Switch(Bool)
				Page.Active = Bool;
				Tween:Create(Glow.Object, nil, {Transparency = Bool and 0 or 1, Size = Bool and U2New(0, 25, 1, 0) or U2New(0, 25, 0, 0)});
				Tween:Create(Liner.Object, nil, {Transparency = Bool and 0 or 1, Size = Bool and U2New(0, 1, 1, 0) or U2New(0, 1, 0, 0)});
				Tween:Create(Text.Object, nil, {TextTransparency = Bool and 0 or 0.48, Position = Bool and U2New(0, 10, 0, 0) or U2New(0, 5, 0, 0)});
				TabContent.Object.Visible = Bool;
				SubPageButtons.Object.Visible = Bool;
			end;

			Library:Connect(TabButton.Object.MouseButton1Click, function()
				for Index, Tab in Page.Window.Tabs do
					Tab:Switch(Tab == Page);
				end;
			end);

			TableInsert(Page.Window.Tabs, Page);
			return setmetatable(Page, Library.Pages);
		end;

		function Library.Pages:SubPage(Data)
			Data = Data or {};

			local Page = {
				Window = self.Window,
				Tab = self,
				Name = Data.Name or "Page",
				Active = false,
				Elements = {};
			};

			local TabButton = Objects:New("TextButton", {
				Parent = Page.Tab.Elements.SubPageButtons.Object,
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
				TextColor3 = FromRGB(0, 0, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "",
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				Name = "Inactive",
				Size = U2New(1, 0, 1, 0),
				BorderSizePixel = 0,
				TextSize = 14,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});

			local Text = Objects:New("TextLabel", {
				Parent = TabButton.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				TextTransparency = 0.48,
				Text = Page.Name,
				Name = "Text",
				Size = U2New(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Position = U2New(0, 0, 0, 1),
				BorderSizePixel = 0,
				BorderColor3 = FromRGB(0, 0, 0),
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});

			Library:AddToTheme(Text.Object, {TextColor3 = "Text"});
			Text:TextBorder(Text.Object);

			local Glow = Objects:New("Frame", {
				Parent = TabButton.Object,
				BorderColor3 = FromRGB(0, 0, 0),
				AnchorPoint = V2New(0.5, 1),
				BackgroundTransparency = 1,
				Position = U2New(0.5, 0, 1, 0),
				Name = "Glow",
				Size = U2New(0, 0, 0, 15),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme.Accent
			});

			Library:AddToTheme(Glow.Object, {BackgroundColor3 = "Accent"});

			local UIGradient = Objects:New("UIGradient", {
				Parent = Glow.Object,
				Rotation = -90,
				Transparency = NumberSeq{NumberKey(0, 0), NumberKey(0.198, 0.84375), NumberKey(0.389, 0.918749988079071), NumberKey(0.54, 0.9624999761581421), NumberKey(0.718, 0.949999988079071), NumberKey(1, 1)}
			});

			local Liner = Objects:New("Frame", {
				Parent = TabButton.Object,
				BorderColor3 = FromRGB(0, 0, 0),
				AnchorPoint = V2New(0.5, 1),
				BackgroundTransparency = 1,
				Position = U2New(0.5, 0, 1, 0),
				Name = "Liner",
				Size = U2New(0, 0, 0, 1),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme.Accent
			});

			Library:AddToTheme(Liner.Object, {BackgroundColor3 = "Accent"});

			local TabContent = Objects:New("Frame", {
				Parent = Page.Tab.Elements.TabContent.Object,
				BackgroundTransparency = 1,
				Size = U2New(1,0,1,0),
				BorderSizePixel = 0,
				Name = Page.Name,
				Visible = false,
			});

			local SectionHolders = Objects:New("ScrollingFrame", {
				Parent = TabContent.Object,
				ScrollBarImageColor3 = FromRGB(0, 0, 0),
				Active = true,
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				ScrollBarThickness = 0,
				Name = "SectionHolders",
				BackgroundTransparency = 1,
				Size = U2New(1, 0, 1, 0),
				BackgroundColor3 = FromRGB(255, 255, 255),
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				CanvasSize = U2New(0, 0, 0, 0)
			});

			Objects:New("UIPadding", {
				Parent = SectionHolders.Object,
				PaddingBottom = UNew(0, 17)
			});

			local Left = Objects:New("Frame", {
				Parent = SectionHolders.Object,
				Name = "Left",
				BackgroundTransparency = 1,
				Position = U2New(0.01, 1, 0.013, 1),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(0.47, 4, 1, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});

			Objects:New("UIListLayout", {
				Parent = Left.Object,
				Padding = UNew(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder
			});

			local Right = Objects:New("Frame", {
				Parent = SectionHolders.Object,
				BorderColor3 = FromRGB(0, 0, 0),
				AnchorPoint = V2New(1, 0),
				BackgroundTransparency = 1,
				Position = U2New(0.99, -1, 0.013, 1),
				Name = "Right",
				Size = U2New(0.47, 4, 1, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});

			local UIListLayout2 = Objects:New("UIListLayout", {
				Parent = Right.Object,
				Padding = UNew(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder
			});

			function Page:Switch(Bool)
				Page.Active = Bool;
				Tween:Create(Glow.Object, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Transparency = Bool and 0 or 1, Size = Bool and U2New(1,0,0,15) or U2New(0,0,0,15)});
				Tween:Create(Liner.Object, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Transparency = Bool and 0 or 1, Size = Bool and U2New(1,0,0,1) or U2New(0,0,0,1)});
				Tween:Create(Text.Object, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = Bool and 0 or 0.48});
				TabContent.Object.Visible = Bool;
			end;

			Library:Connect(TabButton.Object.MouseButton1Click, function()
				for Index, Tab in Page.Window.SubTabs do
					Tab:Switch(Tab == Page);
				end;
			end);

			Page.Elements = {
				Holders = SectionHolders.Object,
				Left = Left.Object,
				Right = Right.Object;
			};

			TableInsert(Page.Window.SubTabs, Page);
			return setmetatable(Page, Library.SubPages);
		end;

		function Library.SubPages:Section(Data)
			Data = Data or {};

			local Section = {
				Window = self.Tab.Window,
				Tab = self.Tab,
				SubTab = self,
				Name = Data.Name or "Section";
				Side = Data.Side or "Left";
				Minimized = false;
				Elements = {};
			};

			local NewSection = Objects:New("Frame", {
				Parent = StringLower(Section.Side) == "left" and Section.SubTab.Elements.Left or StringLower(Section.Side) == "right" and Section.SubTab.Elements.Right,
				Name = Section.Name,
				Size = U2New(1, 0, 0, 35),
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Library.Theme.Inline;
			});

			Library:AddToTheme(NewSection.Object, {BackgroundColor3 = "Inline"});
			NewSection:Border();

			local Topbar = Objects:New("Frame", {
				Parent = NewSection.Object,
				Name = "Topbar",
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, 0, 0, 20),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme.Inline
			});

			Library:AddToTheme(Topbar.Object, {BackgroundColor3 = "Inline"});
			Topbar:Border()

			local Liner = Objects:New("Frame", {
				Parent = Topbar.Object,
				AnchorPoint = V2New(0, 1),
				Name = "Liner",
				Position = U2New(0, 0, 1, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, 0, 0, 1),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme.Accent
			});

			Library:AddToTheme(Liner.Object, {BackgroundColor3 = "Accent"});

			Objects:New("UIGradient", {
				Parent = Liner.Object,
				Transparency = NumberSeq{NumberKey(0, 1), NumberKey(0.494, 0), NumberKey(1, 1)}
			});

			local Text = Objects:New("TextLabel", {
				Parent = Topbar.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				BorderColor3 = FromRGB(0, 0, 0),
				Text = Section.Name,
				Name = "Text",
				Size = U2New(1, -25, 1, 0),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				Position = U2New(0, 5, 0, 0),
				BorderSizePixel = 0,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});

			Library:AddToTheme(Text.Object, {TextColor3 = "Text"});
			Text:TextBorder();
			
			local Content = Objects:New("Frame", {
				Parent = NewSection.Object,
				Name = "Content",
				BackgroundTransparency = 1,
				Position = U2New(0, 7, 0, 28),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, -14, 1, -20),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255),
			});

			Objects:New("UIListLayout", {
				Parent = Content.Object,
				Padding = UNew(0, 6),
				SortOrder = Enum.SortOrder.LayoutOrder
			});

			Objects:New("UIGradient", {
				Parent = Topbar.Object,
				Rotation = 90,
				Color = FromRGBSeq{FromRGBKey(0, FromRGB(255, 255, 255)), FromRGBKey(1, FromRGB(165, 165, 165))}
			});

			Section.Elements = {
				Content = Content.Object
			};

			return setmetatable(Section, Library.Sections);
		end;

		function Library.Sections:Toggle(Data)
			Data = Data or {};

			local Toggle = {
				Window = self.Window,
				Tab = self.Tab,
				SubPage = self.SubTab,
				Section = self,

				Name = Data.Name or 'Toggle',
				Flag = Data.Flag or Library:NextFlag(),
				Default = Data.Default or false,
				Callback = Data.Callback or function() end,
				Tooltip = Data.Tooltip or Data.tooltip,
				Value = false,
				Class = "Toggle";
				Count = 0;
			};

			local NewToggle = Objects:New("TextButton", {
				Parent = Toggle.Section.Elements.Content,
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
				TextColor3 = FromRGB(0, 0, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "",
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				Name = Toggle.Name,
				Size = U2New(1, 0, 0, 13),
				BorderSizePixel = 0,
				TextSize = 14,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});

			NewToggle:Tooltip(Toggle.Tooltip);

			local Indicator = Objects:New("Frame", {
				Parent = NewToggle.Object,
				AnchorPoint = V2New(0, 0.5),
				Name = "Indicator",
				Position = U2New(0, 0, 0.5, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(0, 10, 0, 10),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme.Element
			}); Library:AddToTheme(Indicator.Object, {BackgroundColor3 = "Element"});

			Indicator:Border();

			Objects:New("UIGradient", {
				Parent = Indicator.Object,
				Rotation = 90,
				Color = FromRGBSeq{FromRGBKey(0, FromRGB(255, 255, 255)), FromRGBKey(1, FromRGB(165, 165, 165))}
			});

			local Text = Objects:New("TextLabel", {
				Parent = NewToggle.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				TextTransparency = 0.48,
				Text = Toggle.Name,
				Name = "Text",
				Size = U2New(1, -15, 1, 0),
				Position = U2New(0, 15, 0, 1),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				BorderColor3 = FromRGB(0, 0, 0),
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			}); Library:AddToTheme(Text.Object, {TextColor3 = "Text"});

			Text:TextBorder();

			function Toggle:Set(Bool)
				Toggle.Value = Bool;

				Tween:Create(Indicator.Object, nil, {BackgroundColor3 = Bool and Library.Theme.Accent or Library.Theme.Element});
				Tween:Create(Text.Object, nil, {TextTransparency = Bool and 0 or 0.48});
				Library:ChangeObjectTheme(Indicator.Object, {BackgroundColor3 = Bool and "Accent" or "Element"});

				Library.Flags[Toggle.Flag] = Toggle.Value;

				if Toggle.Callback then 
					Toggle.Callback(Toggle.Value);
				end;
			end;

			function Toggle:SetVisiblity(Bool)
				NewToggle.Object.Visible = Bool;
			end;

			function Toggle:Get()
				return Toggle.Value;
			end;

			Library:Connect(NewToggle.Object.MouseButton1Click, function()
				Toggle:Set(not Toggle.Value);
			end);

			if Toggle.Default then
				Toggle:Set(Toggle.Default);
			end;

			function Toggle:Colorpicker(Data)
				local Colorpicker = {
					Name = Data.Name or 'Colorpicker',
					Flag = Data.Flag or Library:NextFlag();
					Default = Data.Default or FromRGB(255, 0, 0);
					Alpha = Data.Alpha or 1;
					Callback = Data.Callback or function() end;
					IsToggle = true;
				};
	
				Colorpicker.Parent = NewToggle.Object;
				Toggle.Count += 1;
				Colorpicker.Count = Toggle.Count;
	
				local ColorpickerNew = Library:CreateColorpicker(Colorpicker);
				return Colorpicker;
			end;

			function Toggle:Keybind(Data)
				Data = Data or {};
	
				local Keybind = {
					Window = self.Window,
					Tab = self.Tab,
					SubPage = self.SubTab,
					Section = self,
	
					Name = Data.Name or 'Keybind',
					Flag = Data.Flag or Library:NextFlag(),
					Default = Data.Default or Enum.KeyCode.F;
					Callback = Data.Callback or function() end;
					Mode = Data.Mode or "Toggle";
					Picking = false;
					Key = nil;
					Value = "";
					Toggled = false;
					Open = false;
					Class = "Keybind";
				};

				Library.Flags[Keybind.Flag] = { };
	
				local KeyButton = Objects:New("TextButton", {
					Parent = NewToggle.Object,
					FontFace = UIFont,
					TextColor3 = Library.Theme.Text,
					BorderColor3 = FromRGB(0, 0, 0),
					Text = "MB2",
					AutoButtonColor = false,
					AnchorPoint = V2New(1, 0),
					Size = U2New(0, 28, 1, 0),
					Name = "Key",
					Position = U2New(1, 0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = 13,
					BackgroundTransparency = 1,
					BackgroundColor3 = Library.Theme.Background
				}); Library:AddToTheme(KeyButton.Object, {TextColor3 = "Text"});
	
				KeyButton:TextBorder();
	
				Objects:New("UIPadding", {
					Parent = KeyButton.Object,
					PaddingTop = UNew(0, 2)
				});

				local KeybindListItem;
				if Library.KeyList then 
					KeybindListItem = Library.KeyList:Add(Keybind.Name, Keybind.Value or "None", Keybind.Mode or "None");
				end;
	
				local ModesWindow = Objects:New("Frame", {
					Parent = NewToggle.Object,
					Visible = false,
					Name = "Window",
					AnchorPoint = V2New(1, 0),
					Position = U2New(1, 0, 0, 20),
					BorderColor3 = FromRGB(0, 0, 0),
					Size = U2New(0, 0, 0, 1),
					BorderSizePixel = 0,
					BackgroundColor3 = Library.Theme.Inline,
					ClipsDescendants = true;
				}); Library:AddToTheme(ModesWindow.Object, {BackgroundColor3 = "Inline"});
	
				ModesWindow:Border();
	
				local ToggleMode = Objects:New("TextButton", {
					Parent = ModesWindow.Object,
					FontFace = UIFont,
					TextColor3 = Library.Theme.Text,
					BorderColor3 = FromRGB(0, 0, 0),
					Text = "Toggle",
					AutoButtonColor = false,
					BackgroundTransparency = 1,
					Name = "Toggle",
					Size = U2New(1, 0, 0, 15),
					BorderSizePixel = 0,
					TextSize = 13,
					BackgroundColor3 = FromRGB(255, 255, 255)
				});	Library:AddToTheme(ToggleMode.Object, {TextColor3 = "Text"});
	
				ToggleMode:TextBorder();
	
				local HoldMode = Objects:New("TextButton", {
					Parent = ModesWindow.Object,
					FontFace = UIFont,
					TextColor3 = Library.Theme.Text,
					BorderColor3 = FromRGB(0, 0, 0),
					Text = "Hold",
					AutoButtonColor = false,
					Name = "Hold",
					BackgroundTransparency = 1,
					Position = U2New(0, 0, 0, 18),
					Size = U2New(1, 0, 0, 15),
					BorderSizePixel = 0,
					TextSize = 13,
					BackgroundColor3 = FromRGB(255, 255, 255)
				});	Library:AddToTheme(HoldMode.Object, {TextColor3 = "Text"});
				
				HoldMode:TextBorder();
	
				local AlwaysMode = Objects:New("TextButton", {
					Parent = ModesWindow.Object,
					FontFace = UIFont,
					TextColor3 = Library.Theme.Text,
					BorderColor3 = FromRGB(0, 0, 0),
					Text = "Always",
					AutoButtonColor = false,
					Name = "Always",
					BackgroundTransparency = 1,
					Position = U2New(0, 0, 0, 36),
					Size = U2New(1, 0, 0, 15),
					BorderSizePixel = 0,
					TextSize = 13,
					BackgroundColor3 = FromRGB(255, 255, 255)
				}); Library:AddToTheme(AlwaysMode.Object, {TextColor3 = "Text"});

				AlwaysMode:TextBorder();
	
				local Modes = {
					["Toggle"] = ToggleMode.Object;
					["Hold"] = HoldMode.Object;
					["Always"] = AlwaysMode.Object;
				};

				local Update = function()
					if not KeybindListItem then return end
					KeybindListItem:Set(Keybind.Name, Keybind.Value or "None", Keybind.Mode or "None");
					KeybindListItem:SetStatus(Keybind.Toggled);
				end
	
				function Keybind:Set(Key)		
					if UserInputService:GetFocusedTextBox() then return end

					if tostring(Key):find("Enum") then
						Keybind.Key = tostring(Key);

						Key = Key.Name == "Backspace" and "None" or Key.Name;
	
						local KeyString = Keys[Keybind.Key] or StringGSub(Key, "Enum.", "");
						local TextToDisplay = StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None";
	
						Keybind.Value = TextToDisplay;
						KeyButton.Object.Text = TextToDisplay;

						Library.Flags[Keybind.Flag] = {
							Key = Keybind.Key,
							Mode = Keybind.Mode,
							Toggled = Keybind.Toggled
						}
	
						if Keybind.Callback then 
							Keybind.Callback(Keybind.Toggled);
						end;

						Update();
					elseif TableFind({"Toggle", "Hold", "Always"}, Key) then
						Keybind:SetMode(Key);
	
						if Keybind.Callback then 
							Keybind.Callback(Keybind.Toggled);
						end;

						Update();
					elseif type(Key) == "table" then 
						local RealKey = Key.Key == "Backspace" and "None" or Key.Key;
						Keybind.Key = tostring(Key.Key);

						if Key.Mode then
							Keybind:SetMode(Key.Mode);
						else
							Keybind:SetMode("Toggle");
						end;

						Library.Flags[Keybind.Flag] = {
							Key = Keybind.Key,
							Mode = Keybind.Mode,
							Toggled = Keybind.Toggled
						}
	
						local KeyString = Keys[Keybind.Key] or string.gsub(tostring(RealKey), "Enum.", "") or RealKey;
						local TextToDisplay = KeyString and string.gsub(string.gsub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None";
	
						TextToDisplay = string.gsub(string.gsub(KeyString, "KeyCode.", ""), "UserInputType.", "")
	
						Keybind.Value = TextToDisplay;
						KeyButton.Object.Text = TextToDisplay;
	
						if Keybind.Callback then 
							Keybind.Callback(Keybind.Toggled);
						end;

						Update();
					end;
	
					Keybind.Picking = false;
	
					KeyButton.Object.Size = U2New(0, KeyButton.Object.TextBounds.X + 10, 1, 0);
					Tween:Create(KeyButton.Object, nil, {TextColor3 = Library.Theme.Text});
					Library:ChangeObjectTheme(KeyButton.Object, {TextColor3 = "Text"});
				end;
	
				function Keybind:SetMode(Mode)
					Keybind.Mode = Mode;
	
					if Keybind.Mode == "Always" then 
						Keybind.Toggled = true;
					end;
	
					for Index, Value in Modes do 
						if Index == Mode then 
							Tween:Create(Value, nil, {TextColor3 = Library.Theme.Accent});
							Library:ChangeObjectTheme(Value, {TextColor3 = "Accent"});
						else 
							Tween:Create(Value, nil, {TextColor3 = Library.Theme.Text});
							Library:ChangeObjectTheme(Value, {TextColor3 = "Text"});
						end;
					end;

					Library.Flags[Keybind.Flag] = {
						Key = Keybind.Key,
						Mode = Keybind.Mode,
						Toggled = Keybind.Toggled
					}

					Update();
				end;
	
				function Keybind:SetVisiblity(Bool)
					NewToggle.Object.Visible = Bool;
				end;
	
				function Keybind:Get(Bool)
					return Keybind.Toggled;
				end;
	
				function Keybind:Press(Bool)
					if Keybind.Mode == "Toggle" then
						Keybind.Toggled = not Keybind.Toggled;
					elseif Keybind.Mode == "Hold" then
						Keybind.Toggled = Bool;
					elseif Keybind.Mode == "Always" then
						Keybind.Toggled = true;
					end;
	
					if Keybind.Callback then
						Keybind.Callback(Keybind.Toggled);
					end;

					Library.Flags[Keybind.Flag] = { 
						Key = Keybind.Key,
						Mode = Keybind.Mode,
						Toggled = Keybind.Toggled
					};

					Update();
				end;
	
				Library:Connect(KeyButton.Object.MouseButton1Click, function()
					if Keybind.Picking then 
						return end;
	
					Tween:Create(KeyButton.Object, nil, {TextColor3 = Library.Theme.Accent});
					Library:ChangeObjectTheme(KeyButton.Object, {TextColor3 = "Accent"});
	
					Keybind.Picking = true;
	
					local InputBegan;
					InputBegan = UserInputService.InputBegan:Connect(function(Input)
						if Input.UserInputType == Enum.UserInputType.Keyboard then
							Keybind:Set(Input.KeyCode);
						else
							Keybind:Set(Input.UserInputType);
						end;
	
						InputBegan:Disconnect();
						InputBegan = nil;
					end);
				end);
	
				Library:Connect(KeyButton.Object.MouseButton2Click, function()
					Keybind.Open = not Keybind.Open;
	
					if Keybind.Open then
						ModesWindow.Object.Visible = true;
						ModesWindow.Object.ZIndex = 15;
						for Index, Value in ModesWindow.Object:GetChildren() do
							if Value:IsA("TextButton") then 
								Value.ZIndex = 15;
							end;
						end;

						local a = Tween:Create(ModesWindow.Object, nil, {Size = U2New(0, 50, 0, 1)});
						a.Tween.Completed:Wait();
						task.wait(0.05);
						Tween:Create(ModesWindow.Object, nil, {Size = U2New(0, 50, 0, 50)});
					else
						local a = Tween:Create(ModesWindow.Object, nil, {Size = U2New(0, 50, 0, 1)});
						a.Tween.Completed:Wait();
						Tween:Create(ModesWindow.Object, nil, {Size = U2New(0, 0, 0, 1)});
						task.wait(0.05);
						ModesWindow.Object.Visible = false;

						ModesWindow.Object.ZIndex = 1;
						for Index, Value in ModesWindow.Object:GetChildren() do
							if Value:IsA("TextButton") then 
								Value.ZIndex = 1;
							end;
						end;
					end;
				end);
	
				Library:Connect(ToggleMode.Object.MouseButton1Click, function()
					Keybind:Set("Toggle");
				end);
	
				Library:Connect(HoldMode.Object.MouseButton1Click, function()
					Keybind:Set("Hold");
				end);
	
				Library:Connect(AlwaysMode.Object.MouseButton1Click, function()
					Keybind:Set("Always");
				end);

				Library:Connect(UserInputService.InputBegan, function(Input)
					if tostring(Input.KeyCode) == Keybind.Key and not Keybind.Picking then 
						if Keybind.Mode == "Toggle" then 
							Keybind:Press();
						elseif Keybind.Mode == "Hold" then 
							Keybind:Press(true);
						end;
					elseif tostring(Input.UserInputType) == Keybind.Key and not Keybind.Picking then 
						if Keybind.Mode == "Toggle" then 
							Keybind:Press();
						elseif Keybind.Mode == "Hold" then 
							Keybind:Press(true);
						end;
					end;
				end);
	
				Library:Connect(UserInputService.InputEnded, function(Input)
					if tostring(Input.KeyCode) == Keybind.Key or tostring(Input.UserInputType) == Keybind.Key then
						if Keybind.Mode == "Hold" then
							Keybind:Press(false);
						end;
					end;
				end);
	
				if Keybind.Default then
					Keybind:Set({Mode = Keybind.Mode, Key = Keybind.Default, Toggled = false});
				end;
	
				Library.SetFlags[Keybind.Flag] = function(Value)
					Keybind:Set(Value);
				end;

				return Keybind;
			end;

			Library.SetFlags[Toggle.Flag] = function(Value)
				Toggle:Set(Value);
			end;

			return Toggle;
		end;

		function Library.Sections:Button(Data)
			local Button = {
				Window = self.Window,
				Tab = self.Tab,
				SubPage = self.SubTab,
				Section = self,

				Name = Data.Name or 'Toggle',
				Callback = Data.Callback or function() end,
				Tooltip = Data.Tooltip or Data.tooltip,
			};

			local NewButton = Objects:New("TextButton", {
				Parent = Button.Section.Elements.Content,
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
				TextColor3 = FromRGB(0, 0, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "",
				AutoButtonColor = false,
				Name = Button.Name,
				Size = U2New(1, 0, 0, 15),
				BorderSizePixel = 0,
				TextSize = 14,
				BackgroundColor3 = Library.Theme.Element
			}); Library:AddToTheme(NewButton.Object, {BackgroundColor3 = "Element"})
			
			NewButton:Tooltip(Button.Tooltip);
			NewButton:Border();

			Objects:New("UIGradient", {
				Parent = NewButton.Object,
				Rotation = 90,
				Color = FromRGBSeq{FromRGBKey(0, FromRGB(255, 255, 255)), FromRGBKey(1, FromRGB(165, 165, 165))}
			});

			local Text = Objects:New("TextLabel", {
				Parent = NewButton.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				BorderColor3 = FromRGB(0, 0, 0),
				Text = Button.Name,
				Name = "Text",
				BackgroundTransparency = 1,
				Position = U2New(0, 0, 0, 1),
				Size = U2New(1, 0, 1, 0),
				BorderSizePixel = 0,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});	Library:AddToTheme(Text.Object, {TextColor3 = "Text"});

			Text:TextBorder();

			function Button:Press()
				Tween:Create(NewButton.Object, nil, {BackgroundColor3 = Library.Theme.Accent});
				Library:ChangeObjectTheme(NewButton.Object, {BackgroundColor3 = "Accent"});
				Button.Callback();
				task.wait(0.1);
				Tween:Create(NewButton.Object, nil, {BackgroundColor3 = Library.Theme.Element});
				Library:ChangeObjectTheme(NewButton.Object, {BackgroundColor3 = "Element"});
			end;

			function Button:SetVisiblity(Bool)
				NewButton.Object.Visible = Bool;
			end;

			function Button:CreateSub(Data)
				local SubButton = {
					Name = Data.Name or 'Toggle',
					Callback = Data.Callback or function() end,
				};

				local ButtonHolder = Objects:New("Frame", {
					Parent = Button.Section.Elements.Content,
					Name = "\0",
					Size = U2New(1, 0, 0, 15),
					BorderColor3 = FromRGB(0, 0, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = FromRGB(255, 255, 255),
					BackgroundTransparency = 1
				});

				NewButton.Object.Parent = ButtonHolder.Object;
				NewButton.Object.Size = U2New(0.487, 0, 0, 15);

				local NewSubButton = Objects:New("TextButton", {
					Parent = ButtonHolder.Object,
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
					TextColor3 = FromRGB(0, 0, 0),
					BorderColor3 = FromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					Name = SubButton.Name,
					Size = U2New(0.487, 0, 0, 15),
					AnchorPoint = V2New(1, 0),
					Position = U2New(1,0,0,0);
					BorderSizePixel = 0,
					TextSize = 14,
					BackgroundColor3 = Library.Theme.Element
				}); Library:AddToTheme(NewSubButton.Object, {BackgroundColor3 = "Element"});

				NewSubButton:Border();
				NewSubButton:Tooltip(Data.Tooltip);

				Objects:New("UIGradient", {
					Parent = NewSubButton.Object,
					Rotation = 90,
					Color = FromRGBSeq{FromRGBKey(0, FromRGB(255, 255, 255)), FromRGBKey(1, FromRGB(165, 165, 165))}
				});

				local SubText = Objects:New("TextLabel", {
					Parent = NewSubButton.Object,
					FontFace = UIFont,
					TextColor3 = Library.Theme.Text,
					BorderColor3 = FromRGB(0, 0, 0),
					Text = SubButton.Name,
					Name = "Text",
					BackgroundTransparency = 1,
					Position = U2New(0, 0, 0, 1),
					Size = U2New(1, 0, 1, 0),
					BorderSizePixel = 0,
					TextSize = 13,
					BackgroundColor3 = FromRGB(255, 255, 255)
				});	Library:AddToTheme(SubText.Object, {TextColor3 = "Text"});

				SubText:TextBorder();

				function SubButton:Press()
					Tween:Create(NewSubButton.Object, nil, {BackgroundColor3 = Library.Theme.Accent});
					Library:ChangeObjectTheme(NewSubButton.Object, {BackgroundColor3 = "Accent"});
					SubButton.Callback();
					task.wait(0.1);
					Tween:Create(NewSubButton.Object, nil, {BackgroundColor3 = Library.Theme.Element});
					Library:ChangeObjectTheme(NewSubButton.Object, {BackgroundColor3 = "Element"});
				end;

				Library:Connect(NewSubButton.Object.MouseButton1Click, function()
					SubButton:Press();
				end);

				return SubButton;
			end;

			Library:Connect(NewButton.Object.MouseButton1Click, function()
				Button:Press();
			end);

			return Button;
		end;

		function Library.Sections:Slider(Data)
			Data = Data or {};

			local Slider = {
				Window = self.Window,
				Tab = self.Tab,
				SubPage = self.SubTab,
				Section = self,

				Name = Data.Name or 'Slider',
				Min = Data.Min or 0,
				Max = Data.Max or 100,
				Default = Data.Default or Data.Max / 2,
				Flag = Data.Flag or Library:NextFlag(),
				Suffix = Data.Suffix or "",
				Tooltip = Data.Tooltip or Data.tooltip,
				Decimals = Data.Decimals,
				Value = 0,
				Infinite = Data.Infinite or false,
				Callback = Data.Callback or function() end,
				Compact = Data.Compact or false,
				Class = "Slider";
			};

			local Sliding = false;

			local NewSlider = Objects:New("Frame", {
				Parent = Slider.Section.Elements.Content,
				BackgroundTransparency = 1,
				Name = Slider.Name,
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, 0, 0, 35),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});

			NewSlider:Tooltip(Slider.Tooltip);

			local Text = Objects:New("TextLabel", {
				Parent = NewSlider.Object,
				FontFace = UIFont,
				TextColor3 = FromRGB(235, 235, 235),
				BorderColor3 = FromRGB(0, 0, 0),
				Text = Slider.Name,
				Name = "Text",
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				Size = U2New(1, 0, 0, 15),
				BorderSizePixel = 0,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});	Library:AddToTheme(Text.Object, {TextColor3 = "Text"});

			Text:TextBorder();

			local Real_Slider = Objects:New("Frame", {
				Parent = NewSlider.Object,
				AnchorPoint = V2New(0, 1),
				Name = "Real_Slider",
				Position = U2New(0, 0, 1, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, 0, 0, 14),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme.Element
			}); Library:AddToTheme(Real_Slider.Object, {BackgroundColor3 = "Element"});
			
			Real_Slider:Border();

			Objects:New("UIGradient", {
				Parent = Real_Slider.Object,
				Rotation = 90,
				Color = FromRGBSeq{FromRGBKey(0, FromRGB(255, 255, 255)), FromRGBKey(1, FromRGB(165, 165, 165))}
			});

			local Indicator = Objects:New("Frame", {
				Parent = Real_Slider.Object,
				Name = "Indicator",
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(0.5, 0, 1, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme.Accent
			}); Library:AddToTheme(Indicator.Object, {BackgroundColor3 = "Accent"});

			Objects:New("UIGradient", {
				Parent = Indicator.Object,
				Rotation = 90,
				Color = FromRGBSeq{FromRGBKey(0, FromRGB(255, 255, 255)), FromRGBKey(1, FromRGB(165, 165, 165))}
			});

			local ValueText = Objects:New("TextLabel", {
				Parent = Real_Slider.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "50/100%",
				Name = "Value",
				BackgroundTransparency = 1,
				Position = U2New(0, 0, 0, 1),
				Size = U2New(1, 0, 1, 0),
				BorderSizePixel = 0,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			}); Library:AddToTheme(ValueText.Object, {TextColor3 = "Text"});
			
			ValueText:TextBorder();

			if Slider.Compact then
				NewSlider.Object.Size = U2New(1,0,0,14);
				Text:Clean();
			end;

			function Slider:Set(Value)
				Slider.Value = MathClamp(Library:RoundNumber(Value, Slider.Decimals), Slider.Min, Slider.Max);

				if Slider.Infinite and Slider.Value >= Slider.Max then
					ValueText.Object.Text = "Infinite";
				end;

				Library.Flags[Slider.Flag] = Slider.Value;

				Tween:Create(
					Indicator.Object, 
					TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), 
					{Size = U2New((Slider.Value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1, 0)}
				);

				if Slider.Compact then
					ValueText.Object.Text = string.format("%s: %s/%s%s", Slider.Name, tostring(Slider.Value), tostring(Slider.Max), Slider.Suffix);
				else
					ValueText.Object.Text = string.format("%s/%s%s", tostring(Slider.Value), tostring(Slider.Max), Slider.Suffix);
				end;

				if Slider.Callback then
					Slider.Callback(Slider.Value);
				end;
			end;

			function Slider:SetVisiblity(Bool)
				NewSlider.Object.Visible = Bool;
			end;

			function Slider:Get()
				return Slider.Value;
			end;

			Library:Connect(Real_Slider.Object.InputBegan, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Sliding = true;

					local SizeX = (Input.Position.X - Real_Slider.Object.AbsolutePosition.X) / Real_Slider.Object.AbsoluteSize.X;
					local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min;

					Slider:Set(Value);

					Input.Changed:Connect(function()
						if Input.UserInputState == Enum.UserInputState.End then
							Sliding = false;
						end;
					end);
				end;
			end, Slider.Name .. "InputBegan");

			Library:Connect(UserInputService.InputChanged, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseMovement and Sliding then
					local SizeX = (Input.Position.X - Real_Slider.Object.AbsolutePosition.X) / Real_Slider.Object.AbsoluteSize.X;
					local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min;

					Slider:Set(Value);
					Library.Dragging = nil;
				end;
			end, Slider.Name .. "InputChanged");

			if Slider.Default then
				Slider:Set(Slider.Default);
			end;

			Library.SetFlags[Slider.Flag] = function(Value)
				Slider:Set(Value);
			end;

			return Slider;
		end;

		function Library.Sections:Dropdown(Data)
			Data = Data or {};

			local Dropdown = {
				Window = self.Window,
				Tab = self.Tab,
				SubPage = self.SubTab,
				Section = self,

				Name = Data.Name or 'Dropdown',
				Flag = Data.Flag or Library:NextFlag();
				Value = {};
				Tooltip = Data.Tooltip or Data.tooltip or nil,
				Compact = Data.Compact or false,
				Callback = Data.Callback or function() end;
				Multi = Data.Multi or false,
				Open = false,
				Default = Data.Default or Data.Options[1];
				Options = {};
				Class = "Dropdown";
			};

			local NewDropdown = Objects:New("Frame", {
				Parent = Dropdown.Section.Elements.Content,
				BackgroundTransparency = 1,
				Name = Dropdown.Name,
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, 0, 0, 35),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});

			NewDropdown:Tooltip(Dropdown.Tooltip);
			
			local Text = Objects:New("TextLabel", {
				Parent = NewDropdown.Object,
				FontFace =UIFont,
				TextColor3 = FromRGB(235, 235, 235),
				BorderColor3 = FromRGB(0, 0, 0),
				Text = Dropdown.Name,
				Name = "Text",
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				Size = U2New(1, 0, 0, 15),
				BorderSizePixel = 0,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			}); Library:AddToTheme(Text.Object, {TextColor3 = "Text"});
			
			Text:TextBorder();
			
			local RealDropdown = Objects:New("Frame", {
				Parent = NewDropdown.Object,
				AnchorPoint = V2New(0, 1),
				Name = "RealDropdown",
				Position = U2New(0, 0, 1, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, 0, 0, 15),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme.Element
			}); Library:AddToTheme(RealDropdown.Object, {BackgroundColor3 = "Element"});

			RealDropdown:Border();
			
			Objects:New("UIGradient", {
				Parent = RealDropdown.Object,
				Rotation = 90,
				Color = FromRGBSeq{FromRGBKey(0, FromRGB(255, 255, 255)), FromRGBKey(1, FromRGB(165, 165, 165))}
			});
			
			local ValueText = Objects:New("TextLabel", {
				Parent = RealDropdown.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "--",
				Name = "Value",
				Size = U2New(1, -19, 1, 0),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				Position = U2New(0, 5, 0, 0),
				BorderSizePixel = 0,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255),
				TextTruncate = Enum.TextTruncate.AtEnd;
			});	Library:AddToTheme(ValueText.Object, {TextColor3 = "Text"});
			
			ValueText:TextBorder();
			
			local OpenButton = Objects:New("TextButton", {
				Parent = NewDropdown.Object,
				FontFace = UIFont,
				TextColor3 = FromRGB(0, 0, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "",
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				Name = "Open",
				Size = U2New(1, 0, 1, 0),
				BorderSizePixel = 0,
				TextSize = 14,
				BackgroundColor3 = FromRGB(255, 255, 255),
				ZIndex = 5,
			});
			
			local PlusIcon = Objects:New("TextLabel", {
				Parent = RealDropdown.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "+",
				AnchorPoint = V2New(1, 0),
				Name = "PlusIcon",
				BackgroundTransparency = 1,
				Position = U2New(1, 0, 0, 0),
				Size = U2New(0, 15, 0, 15),
				BorderSizePixel = 0,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			})  Library:AddToTheme(PlusIcon.Object, {TextColor3 = "Text"});

			PlusIcon:TextBorder();
			
			local OptionHolder = Objects:New("Frame", {
				Parent = NewDropdown.Object,
				Visible = false,
				BorderColor3 = FromRGB(0, 0, 0),
				Name = "OptionHolder",
				Position = U2New(0, 0, 1, 5),
				Size = U2New(1, 0, 0, 15),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Library.Theme.Inline
			});	Library:AddToTheme(OptionHolder.Object, {BackgroundColor3 = "Inline"});

			OptionHolder:Border();
			
			Objects:New("UIListLayout", {
				Parent = OptionHolder.Object,
				SortOrder = Enum.SortOrder.LayoutOrder
			});

			function Dropdown:SetOpen(Bool)
				Dropdown.Open = Bool;

				if Bool then
					for _, Item in NewDropdown.Object:GetDescendants() do
						if not StringFind(Item.ClassName, "UI") then
							Item.ZIndex = 15;
						end;	
					end;
					OptionHolder.Object.Visible = true;
					PlusIcon.Object.Position = U2New(1, 0, 0, -1);
					PlusIcon.Object.Text = "-";
				else
					for _, Item in NewDropdown.Object:GetDescendants() do
						if not StringFind(Item.ClassName, "UI") then
							Item.ZIndex = 1;
						end;	
					end;
					OptionHolder.Object.Visible = false;
					PlusIcon.Object.Position = U2New(1, 0, 0, 0);
					PlusIcon.Object.Text = "+";
				end;
			end;

			function Dropdown:SetVisiblity(Bool)
				NewDropdown.Object.Visible = Bool;
			end;

			function Dropdown:Get()
				return Dropdown.Value;
			end;

			Library:Connect(OpenButton.Object.MouseButton1Click, function()
				Dropdown:SetOpen(not Dropdown.Open);
			end);

			function Dropdown:Set(Option)
				if Dropdown.Multi then
					if type(Option) ~= "table" then 
						return end; 

					for Index, Value in Option do
						local IsFound = Dropdown.Options[Value];

						if not IsFound then 
							continue end;

						IsFound.IsSelected = true;

						Tween:Create(IsFound.Text, nil, {Position = U2New(0, 10, 0, 0), TextTransparency = 0});
						Tween:Create(IsFound.Liner, nil, {BackgroundTransparency = 0, Size = U2New(0, 1, 1, 0)});
						Tween:Create(IsFound.Glow, nil, {BackgroundTransparency = 0, Size = U2New(0, 25, 1, 0)});
					end;

					Dropdown.Value = Option;

					Library.Flags[Dropdown.Flag] = Dropdown.Value;

					ValueText.Object.Text = TableConcat(Option, ", ");

					for _, Value in Dropdown.Options do 
						if not table.find(Option, Value.Name) then 
							Value.IsSelected = false;
							Tween:Create(Value.Text, nil, {Position = U2New(0, 5, 0, 0), TextTransparency = 0.48});
							Tween:Create(Value.Liner, nil, {BackgroundTransparency = 1, Size = U2New(0, 1, 1, 0)});
							Tween:Create(Value.Glow, nil, {BackgroundTransparency = 1, Size = U2New(0, 25, 1, 0)});
						end;
					end;
				else
					local OptionData = Dropdown.Options[Option];

					if not OptionData then  
						return end;

					OptionData.IsSelected = true;
					Dropdown.Value = Option;

					Library.Flags[Dropdown.Flag] = Dropdown.Value;

					ValueText.Object.Text = OptionData.IsSelected and OptionData.Name or "--";

					Tween:Create(OptionData.Text, nil, {Position = U2New(0, 10, 0, 0), TextTransparency = 0});
					Tween:Create(OptionData.Liner, nil, {BackgroundTransparency = 0, Size = U2New(0, 1, 1, 0)});
					Tween:Create(OptionData.Glow, nil, {BackgroundTransparency = 0, Size = U2New(0, 25, 1, 0)});
					
					for _, Value in Dropdown.Options do 
						if Value ~= OptionData then 
							Value.IsSelected = false;
							Tween:Create(Value.Text, nil, {Position = U2New(0, 5, 0, 0), TextTransparency = 0.48});
							Tween:Create(Value.Liner, nil, {BackgroundTransparency = 1, Size = U2New(0, 0, 1, 0)});
							Tween:Create(Value.Glow, nil, {BackgroundTransparency = 1, Size = U2New(0, 0, 1, 0)});
						end;
					end;
				end;

				if Dropdown.Callback then
					Dropdown.Callback(Dropdown.Value);
				end;
			end;

			function Dropdown:AddOption(Option)
				local OptionButton = Objects:New("TextButton", {
					Parent = OptionHolder.Object,
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
					TextColor3 = FromRGB(0, 0, 0),
					BorderColor3 = FromRGB(0, 0, 0),
					Text = "",
					AutoButtonColor = false,
					BackgroundTransparency = 1,
					Name = "Option",
					Size = U2New(1, 0, 0, 20),
					BorderSizePixel = 0,
					TextSize = 14,
					BackgroundColor3 = FromRGB(255, 255, 255)
				});
				
				local Glow = Objects:New("Frame", {
					Parent = OptionButton.Object,
					Name = "Glow",
					BorderColor3 = FromRGB(0, 0, 0),
					Size = U2New(0, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					BackgroundColor3 = Library.Theme.Accent
				});

				Library:AddToTheme(Glow.Object, {BackgroundColor3 = "Accent"});
				
				local UIGradient = Objects:New("UIGradient", {
					Parent = Glow.Object,
					Transparency = NumberSeq{NumberKey(0, 0), NumberKey(0.198, 0.84375), NumberKey(0.389, 0.918749988079071), NumberKey(0.54, 0.9624999761581421), NumberKey(0.718, 0.949999988079071), NumberKey(1, 1)}
				});
				
				local Liner = Objects:New("Frame", {
					Parent = OptionButton.Object,
					Name = "Liner",
					BorderColor3 = FromRGB(0, 0, 0),
					Size = U2New(0, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					BackgroundColor3 = Library.Theme.Accent
				});

				Library:AddToTheme(Liner.Object, {BackgroundColor3 = "Accent"});
				
				local Text = Objects:New("TextLabel", {
					Parent = OptionButton.Object,
					FontFace = UIFont,
					TextColor3 = Library.Theme.Text,
					BorderColor3 = FromRGB(0, 0, 0),
					Text = Option,
					Name = "Text",
					Size = U2New(1, 0, 1, 0),
					BackgroundTransparency = 1,
					TextTransparency = 0.48;
					TextXAlignment = Enum.TextXAlignment.Left,
					Position = U2New(0, 5, 0, 0),
					BorderSizePixel = 0,
					TextSize = 13,
					BackgroundColor3 = FromRGB(255, 255, 255)
				});

				Text:TextBorder(Text.Object);
				Library:AddToTheme(Text.Object, {TextColor3 = "Text"});

				local NewOption = {
					Name = Option;
					Object = OptionButton.Object;
					Text = Text.Object;
					Glow = Glow.Object;
					Liner = Liner.Object;
					IsSelected = false;
				};

				function NewOption:Set()
					NewOption.IsSelected = not NewOption.IsSelected;

					if Dropdown.Multi then
						local Index = TableFind(Dropdown.Value, NewOption.Name);

						if not Index then 
							TableInsert(Dropdown.Value, NewOption.Name);
						else
							TableRemove(Dropdown.Value, Index);
						end;

						Library.Flags[Dropdown.Flag] = Dropdown.Value;

						local TextToDisplay = #Dropdown.Value > 0 and TableConcat(Dropdown.Value, ", ") or "--";

						ValueText.Object.Text = TextToDisplay;

						Tween:Create(NewOption.Text, nil, {Position = not Index and U2New(0, 10, 0, 0) or U2New(0, 5, 0, 0), TextTransparency = not Index and 0 or 0.48});
						Tween:Create(NewOption.Liner, nil, {BackgroundTransparency = not Index and 0 or 1, Size = not Index and U2New(0, 1, 1, 0) or U2New(0, 0, 1, 0)});
						Tween:Create(NewOption.Glow, nil, {BackgroundTransparency = not Index and 0 or 1, Size = not Index and U2New(0, 25, 1, 0) or U2New(0, 0, 1, 0)});
					else
						if NewOption.IsSelected then
							Dropdown.Value = NewOption.Name;

							Library.Flags[Dropdown.Flag] = Dropdown.Value;

							Tween:Create(NewOption.Text, nil, {Position = U2New(0, 10, 0, 0), TextTransparency = 0});
							Tween:Create(NewOption.Liner, nil, {BackgroundTransparency = 0, Size = U2New(0, 1, 1, 0)});
							Tween:Create(NewOption.Glow, nil, {BackgroundTransparency = 0, Size = U2New(0, 25, 1, 0)});

							ValueText.Object.Text = NewOption.IsSelected and NewOption.Name or "--";

							for _, Value in Dropdown.Options do 
								if Value ~= NewOption then 
									Value.IsSelected = false;
									Tween:Create(Value.Text, nil, {Position = U2New(0, 5, 0, 0), TextTransparency = 0.48});
									Tween:Create(Value.Liner, nil, {BackgroundTransparency = 1, Size = U2New(0, 1, 1, 0)});
									Tween:Create(Value.Glow, nil, {BackgroundTransparency = 1, Size = U2New(0, 25, 1, 0)});
								end;
							end;
						else
							Dropdown.Value = nil;

							Tween:Create(NewOption.Text, nil, {Position = U2New(0, 5, 0, 0), TextTransparency = 0.48});
							Tween:Create(NewOption.Liner, nil, {BackgroundTransparency = 1, Size = U2New(0, 1, 1, 0)});
							Tween:Create(NewOption.Glow, nil, {BackgroundTransparency = 1, Size = U2New(0, 25, 1, 0)});

							ValueText.Object.Text = "--";
						end;
					end;

					if Dropdown.Callback then
						Dropdown.Callback(Dropdown.Value);
					end;
				end;

				Library:Connect(NewOption.Object.MouseButton1Click, function()
					NewOption:Set();
				end, NewOption.Name .. "clickEvent");

				Dropdown.Options[NewOption.Name] = NewOption;
			end;

			function Dropdown:RemoveOption(Option)
				local IsFound = Dropdown.Options[Option];

				if not IsFound then 
					return end;

				IsFound:Clean();
			end;

			function Dropdown:Refresh(List)
				for _, Option in Dropdown.Options do 
					Option.Object:Destroy();
				end;

				for _, Option in List do 
					Dropdown:AddOption(Option);
				end;
			end;

			for _, Option in Data.Options do
				Dropdown:AddOption(Option);
			end;
	
			if Dropdown.Default then
				Dropdown:Set(Dropdown.Default);
			end;

			Library.SetFlags[Dropdown.Flag] = function(Value)
				Dropdown:Set(Value);
			end;

			return Dropdown;
		end;

		function Library.Sections:Colorpicker(Data)
			Data = Data or {};

			local Colorpicker = {
				Window = self.Window,
				Tab = self.Tab,
				SubPage = self.SubTab,
				Section = self,

				Name = Data.Name or 'Colorpicker',
				Flag = Data.Flag or Library:NextFlag();
				Default = Data.Default or FromRGB(255, 0, 0);
				Alpha = Data.Alpha or 1;
				Callback = Data.Callback or function() end;
				IsToggle = false;
				Count = 0;
				Class = "Colorpicker";
			};

			Colorpicker.Parent = Colorpicker.Section.Elements.Content;
			Colorpicker.Count += 1;

			local ColorpickerNew = Library:CreateColorpicker(Colorpicker);
			return Colorpicker;
		end;

		function Library.Sections:Keybind(Data)
			Data = Data or {};

			local Keybind = {
				Window = self.Window,
				Tab = self.Tab,
				SubPage = self.SubTab,
				Section = self,

				Name = Data.Name or 'Keybind',
				Flag = Data.Flag or Library:NextFlag(),
				Default = Data.Default or Enum.KeyCode.F;
				Callback = Data.Callback or function() end;
				Mode = Data.Mode or "Toggle";
				ToolTip = Data.Tooltip or Data.tooltip,
				Picking = false;
				Key = nil;
				Value = "";
				Toggled = false;
				Open = false;
				Class = "Keybind";
			};
			
			Library.Flags[Keybind.Flag] = { };

			local NewKeybind = Objects:New("Frame", {
				Parent = Keybind.Section.Elements.Content,
				BackgroundTransparency = 1,
				Name = "Keybind",
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, 0, 0, 15),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});

			NewKeybind:Tooltip(Keybind.Tooltip);

			local KeybindListItem;
			if Library.KeyList then 
				KeybindListItem = Library.KeyList:Add(Keybind.Name, Keybind.Value or "None", Keybind.Mode or "None");
			end;

			local Text = Objects:New("TextLabel", {
				Parent = NewKeybind.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				BorderColor3 = FromRGB(0, 0, 0),
				Text = Keybind.Name,
				Name = "Text",
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				Size = U2New(1, 0, 1, 0),
				BorderSizePixel = 0,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			}); Library:AddToTheme(Text.Object, {TextColor3 = "Text"});

			Text:TextBorder();

			local KeyButton = Objects:New("TextButton", {
				Parent = NewKeybind.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "MB2",
				AutoButtonColor = false,
				AnchorPoint = V2New(1, 0),
				Size = U2New(0, 28, 1, 0),
				Name = "Key",
				Position = U2New(1, 0, 0, 0),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				TextSize = 13,
				BackgroundTransparency = 1,
				BackgroundColor3 = Library.Theme.Background
			}); Library:AddToTheme(KeyButton.Object, {TextColor3 = "Text"});

			KeyButton:TextBorder();

			Objects:New("UIPadding", {
				Parent = KeyButton.Object,
				PaddingTop = UNew(0, 2)
			});

			local ModesWindow = Objects:New("Frame", {
				Parent = NewKeybind.Object,
				Visible = false,
				Name = "Window",
				AnchorPoint = V2New(1, 0),
				Position = U2New(1, 0, 0, 20),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(0, 0, 0, 1),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme.Inline,
				ClipsDescendants = true;
			}); Library:AddToTheme(ModesWindow.Object, {BackgroundColor3 = "Inline"});

			ModesWindow:Border();

			local ToggleMode = Objects:New("TextButton", {
				Parent = ModesWindow.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "Toggle",
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				Name = "Toggle",
				Size = U2New(1, 0, 0, 15),
				BorderSizePixel = 0,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			}); Library:AddToTheme(ToggleMode.Object, {TextColor3 = "Text"});

			ToggleMode:TextBorder();

			local HoldMode = Objects:New("TextButton", {
				Parent = ModesWindow.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "Hold",
				AutoButtonColor = false,
				Name = "Hold",
				BackgroundTransparency = 1,
				Position = U2New(0, 0, 0, 18),
				Size = U2New(1, 0, 0, 15),
				BorderSizePixel = 0,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			}); Library:AddToTheme(HoldMode.Object, {TextColor3 = "Text"});

			HoldMode:TextBorder();

			local AlwaysMode = Objects:New("TextButton", {
				Parent = ModesWindow.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "Always",
				AutoButtonColor = false,
				Name = "Always",
				BackgroundTransparency = 1,
				Position = U2New(0, 0, 0, 36),
				Size = U2New(1, 0, 0, 15),
				BorderSizePixel = 0,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255)
			}); Library:AddToTheme(AlwaysMode.Object, {TextColor3 = "Text"});

			AlwaysMode:TextBorder();

			local Modes = {
				["Toggle"] = ToggleMode.Object;
				["Hold"] = HoldMode.Object;
				["Always"] = AlwaysMode.Object;
			};

			local Update = function()
				if not KeybindListItem then return end;
				KeybindListItem:Set(Keybind.Name, Keybind.Value or "None", Keybind.Mode or "None");
				KeybindListItem:SetStatus(Keybind.Toggled);
			end;

			function Keybind:Set(Key)
				if tostring(Key):find("Enum") then
					Keybind.Key = Key;
					Key = Key.Name == "Backspace" and "None" or Key.Name;

					local KeyString = Keys[Keybind.Key] or StringGSub(Key, "Enum.", "");
					local TextToDisplay = StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None";

					Keybind.Value = TextToDisplay;
					KeyButton.Object.Text = TextToDisplay;

					if Keybind.Callback then 
						Keybind.Callback(Keybind.Toggled);
					end;

					Library.Flags[Keybind.Flag] = { 
						Key = Keybind.Key,
						Mode = Keybind.Mode,
						Toggled = Keybind.Toggled
					};

					Update();
				elseif TableFind({"Toggle", "Hold", "Always"}, Key) then
					Keybind:SetMode(Key);

					if Keybind.Callback then 
						Keybind.Callback(Keybind.Toggled);
					end;

					Update();
				elseif type(Key) == "table" then 
					local RealKey = Key.Key == "Backspace" and "None" or Key.Key;
					Keybind.Key = Key.Key;

					if Key.Mode then
						Keybind:SetMode(Key.Mode);
					else
						Keybind:SetMode("Toggle");
					end;

					Library.Flags[Keybind.Flag] = { 
						Key = Keybind.Key,
						Mode = Keybind.Mode,
						Toggled = Keybind.Toggled
					};

                    local KeyString = Keys[Keybind.Key] or string.gsub(tostring(RealKey), "Enum.", "") or RealKey;
                    local TextToDisplay = KeyString and string.gsub(string.gsub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None";

                    TextToDisplay = string.gsub(string.gsub(KeyString, "KeyCode.", ""), "UserInputType.", "")

					Keybind.Value = TextToDisplay;
					KeyButton.Object.Text = TextToDisplay;

					if Keybind.Callback then 
						Keybind.Callback(Keybind.Toggled);
					end;

					Update();
				end;

				Keybind.Picking = false;

				KeyButton.Object.Size = U2New(0, KeyButton.Object.TextBounds.X + 10, 1, 0);
				Tween:Create(KeyButton.Object, nil, {TextColor3 = Library.Theme.Text});
				Library:ChangeObjectTheme(KeyButton.Object, {TextColor3 = "Text"});
			end;

			function Keybind:SetMode(Mode)
				Keybind.Mode = Mode;

				if Keybind.Mode == "Always" then 
					Keybind.Toggled = true;
				end;

				for Index, Value in Modes do 
					if Index == Mode then 
						Tween:Create(Value, nil, {TextColor3 = Library.Theme.Accent});
						Library:ChangeObjectTheme(Value, {TextColor3 = "Accent"});
					else 
						Tween:Create(Value, nil, {TextColor3 = Library.Theme.Text});
						Library:ChangeObjectTheme(Value, {TextColor3 = "Text"});
					end;
				end;

				Library.Flags[Keybind.Flag] = { 
					Key = Keybind.Key,
					Mode = Keybind.Mode,
					Toggled = Keybind.Toggled
				};

				Update();
			end;

			function Keybind:SetVisiblity(Bool)
				NewKeybind.Object.Visible = Bool;
			end;

			function Keybind:Get(Bool)
				return Keybind.Toggled;
			end;

			function Keybind:Press(Bool)
				if Keybind.Mode == "Toggle" then
					Keybind.Toggled = not Keybind.Toggled;
				elseif Keybind.Mode == "Hold" then
					Keybind.Toggled = Bool;
				elseif Keybind.Mode == "Always" then
					Keybind.Toggled = true;
				end;

				if Keybind.Callback then
					Keybind.Callback(Keybind.Toggled);
				end;

				Library.Flags[Keybind.Flag] = { 
					Key = Keybind.Key,
					Mode = Keybind.Mode,
					Toggled = Keybind.Toggled
				};

				Update();
			end;

			Library:Connect(KeyButton.Object.MouseButton1Click, function()
				if Keybind.Picking then 
					return end;

				Tween:Create(KeyButton.Object, nil, {TextColor3 = Library.Theme.Accent});
				Library:ChangeObjectTheme(KeyButton.Object, {TextColor3 = "Accent"});

				Keybind.Picking = true;

				local InputBegan;
				InputBegan = UserInputService.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.Keyboard then
						Keybind:Set(Input.KeyCode);
					else
						Keybind:Set(Input.UserInputType);
					end;

					InputBegan:Disconnect();
					InputBegan = nil;
				end);
			end);

			Library:Connect(UserInputService.InputBegan, function(Input)
				if Input.KeyCode == Keybind.Key or Input.UserInputType == Keybind.Key then
					if Keybind.Mode == "Toggle" then
						Keybind:Press();
					elseif Keybind.Mode == "Hold" then
						Keybind:Press(true);
					end;
				end;
			end);

			Library:Connect(UserInputService.InputEnded, function(Input)
				if Input.KeyCode == Keybind.Key or Input.UserInputType == Keybind.Key then
					if Keybind.Mode == "Hold" then
						Keybind:Press(false);
					end;
				end;
			end);

			Library:Connect(KeyButton.Object.MouseButton2Click, function()
				Keybind.Open = not Keybind.Open;
	
				if Keybind.Open then
					ModesWindow.Object.Visible = true;

					ModesWindow.Object.ZIndex = 15;
					for Index, Value in ModesWindow.Object:GetChildren() do
						if Value:IsA("TextButton") then 
							Value.ZIndex = 15;
						end;
					end;

					local a = Tween:Create(ModesWindow.Object, nil, {Size = U2New(0, 50, 0, 1)});
					a.Tween.Completed:Wait();
					task.wait(0.05);
					Tween:Create(ModesWindow.Object, nil, {Size = U2New(0, 50, 0, 50)});
				else
					local a = Tween:Create(ModesWindow.Object, nil, {Size = U2New(0, 50, 0, 1)});
					a.Tween.Completed:Wait();
					Tween:Create(ModesWindow.Object, nil, {Size = U2New(0, 0, 0, 1)});
					task.wait(0.05);
					ModesWindow.Object.Visible = false;

					ModesWindow.Object.ZIndex = 1;
					for Index, Value in ModesWindow.Object:GetChildren() do
						if Value:IsA("TextButton") then 
							Value.ZIndex = 1;
						end;
					end;
				end;
			end);

			Library:Connect(ToggleMode.Object.MouseButton1Click, function()
				Keybind:Set("Toggle");
			end);

			Library:Connect(HoldMode.Object.MouseButton1Click, function()
				Keybind:Set("Hold");
			end);

			Library:Connect(AlwaysMode.Object.MouseButton1Click, function()
				Keybind:Set("Always");
			end);

			if Keybind.Default then
				Keybind:Set({Mode = Keybind.Mode, Key = Keybind.Default, Toggled = false});
			end;

			Library.SetFlags[Keybind.Flag] = function(Value)
				Keybind:Set(Value);
			end;

			return Keybind;
		end;

		function Library.Sections:Textbox(Data)
			Data = Data or {};

			local Textbox = {
				Window = self.Window,
				Tab = self.Tab,
				SubPage = self.SubTab,
				Section = self,

				Name = Data.Name or 'Textbox',
				Flag = Data.Flag or Library:NextFlag(),
				Default = Data.Default or '';
				Callback = Data.Callback or function() end;
				Placeholder = Data.Placeholder or '...';
				Value = "";
				Class = "Textbox";
			};

			local NewTextbox = Objects:New("Frame", {
				Parent = Textbox.Section.Elements.Content,
				BackgroundTransparency = 1,
				Name = "Textbox",
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(1, 0, 0, 15),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			});

			NewTextbox:Tooltip(Data.Tooltip);
			
			local Text = Objects:New("TextLabel", {
				Parent = NewTextbox.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				BorderColor3 = FromRGB(0, 0, 0),
				Text = Textbox.Name,
				Name = "Text",
				BackgroundTransparency = 1,
				Position = U2New(0, 0, 0, 0),
				Size = U2New(0, 50, 1, 0),
				BorderSizePixel = 0,
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255),
				TextXAlignment = Enum.TextXAlignment.Left
			});	Library:AddToTheme(Text.Object, {TextColor3 = "Text"});

			Text:TextBorder();
			
			local Realbox = Objects:New("TextBox", {
				Parent = NewTextbox.Object,
				FontFace = UIFont,
				TextColor3 = Library.Theme.Text,
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "",
				Name = "Realbox",
				Size = U2New(1, -55, 1, 0),
				AnchorPoint = V2New(1, 0),
				Position = U2New(1, 0, 0, 0),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Right,
				BorderSizePixel = 0,
				PlaceholderText = Textbox.Placeholder,
				PlaceholderColor3 = FromRGB(145, 145, 145),
				TextSize = 13,
				BackgroundColor3 = FromRGB(255, 255, 255),
				ClearTextOnFocus = false;
			}); Library:AddToTheme(Realbox.Object, {TextColor3 = "Text"});

			Realbox:TextBorder();
			
			local Liner = Objects:New("Frame", {
				Parent = Realbox.Object,
				AnchorPoint = V2New(1, 1),
				Name = "Liner",
				Position = U2New(1, 0, 1, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = U2New(0, 69, 0, 1),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme.Accent
			}); Library:AddToTheme(Liner.Object, {BackgroundColor3 = "Accent"});

			function Textbox:Set(Value)
				Textbox.Value = tostring(Value);
				Tween:Create(Liner.Object, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = U2New(0, Realbox.Object.TextBounds.X + 3, 0, 1);});
				Tween:Create(Realbox.Object, nil, {TextColor3 = Library.Theme.Text});
				Library:ChangeObjectTheme(Realbox.Object, {TextColor3 = "Text"});

				Library.Flags[Textbox.Flag] = Textbox.Value;

				if Textbox.Callback then 
					Textbox.Callback(Textbox.Value);
				end;
			end;

			function Textbox:Get()
				return Textbox.Value;
			end;

			function Textbox:SetVisiblity(Bool)
				NewTextbox.Object.Visible = Bool
			end;

			Library:Connect(Realbox.Object.Focused, function()
				Tween:Create(Realbox.Object, nil, {TextColor3 = Library.Theme.Accent});
				Library:ChangeObjectTheme(Realbox.Object, {TextColor3 = "Accent"});
			end);

			Library:Connect(Realbox.Object.FocusLost, function()
				Textbox:Set(Realbox.Object.Text);
			end);

			if Textbox.Default then
				Textbox:Set(Textbox.Default);
			end;

			Library.SetFlags[Textbox.Flag] = function(Value)
				Textbox:Set(Value);
			end;
			
			return Textbox;
		end;
	end;
end;











