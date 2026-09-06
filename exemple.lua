do 
	local Window = Library:Window({Name = "utopiahack"});

	local KeybindList = Library:KeybindList("AUSJDjsadjsak") -- first arg is the name

	do
		local Tabs = {
			Combat = Window:Page({Name = "Combat"}),
			Misc = Window:Page({Name = "Misc"}),
			Visuals = Window:Page({Name = "Visuals"}),
			Players = Window:Page({Name = "Players"}),
			Settings = Window:Page({Name = "Settings"});
		};	

		local SubTabs = {
			Aimbot = Tabs.Combat:SubPage({Name = "Aimbot"});
			Weapon = Tabs.Combat:SubPage({Name = "Weapon"});
			Visuals = Tabs.Combat:SubPage({Name = "Visuals"});

			Themes = Tabs.Settings:SubPage({Name = "Themes"});
			Configs = Tabs.Settings:SubPage({Name = "Configs"});
		};

		local Sections = {
			SilentAimbot = SubTabs.Aimbot:Section({Name = "Silent Aimbot", Side = "Left"});
			CameraAimbot = SubTabs.Aimbot:Section({Name = "Camera Aimbot", Side = "Left"});

			Themes = SubTabs.Themes:Section({Name = "Theme", Side = "Left"});

			Configs = SubTabs.Configs:Section({Name = "Config", Side = "Left"});
		};

		do
			local Toggle = Sections.SilentAimbot:Toggle({Name = "Enabled", Tooltip = "Nigger", Default = false, Flag = "New_Toggle", Callback = function(Value)
				--print(Value);
			end});

			do
				Toggle:Colorpicker({Name = "Colorpicker", Flag = "Colorpicker", Tooltip = "Nigger", Alpha = 0, Default = Color3.fromRGB(167, 130, 255), Callback = function(Value)
					--print(Value);
				end});
			end;

			local Toggle2 = Sections.SilentAimbot:Toggle({
				Name = "Enabled", 
				Tooltip = "Enable Silent Aim", 
				Default = false, 
				Flag = "New_Toggle", 
				Callback = function(Value)
					--print(Value);
				end
			})

			local Button = Sections.SilentAimbot:Button({Name = "Button", Callback = function()
				Library:Notification("this is a notification", 5, Library.Theme.Accent);
			end});
			local Button2 = Sections.SilentAimbot:Button({Name = "Button", Callback = function()
				print("Pressed");
			end}):CreateSub({Name = "Sub Button", Callback = function()
				print("Pressed");
			end});
			local Slider = Sections.SilentAimbot:Slider({Name = "Slider", Decimals = 0.1, Suffix = "%", Flag = "Slider", Min = 1, Max = 100, Compact = true, Callback = function(Value)
				--print(Value);
			end});
			local Slider2 = Sections.SilentAimbot:Slider({Name = "Slider 2", Decimals = 0.1, Suffix = "%", Flag = "Slider2", Min = 1, Max = 100, Compact = false, Callback = function(Value)
				--print(Value);
			end});
			local Dropdown = Sections.SilentAimbot:Dropdown({Name = "Dropdown", Multi = false, Flag = "Dropdown", Options = {"Option 1", "Option 2", "Option 3"}, Callback = function(Value)
				--print(Value);
			end});
			local DropdownMulti = Sections.SilentAimbot:Dropdown({Name = "Multi Dropdown", Multi = true, Flag = "DropdownMulti", Options = {"Option 1", "Option 2", "Option 3"}, Callback = function(Value)
				--print(Value);
			end});
			local Colorpicker = Sections.SilentAimbot:Colorpicker({Name = "Colorpicker", Flag = "Colorpicker", Default = Color3.fromRGB(167, 130, 255), Callback = function(Value)
				--print(Value);
			end});
			local Keybind = Sections.SilentAimbot:Keybind({Name = "Magic Bullet", Flag = "Keybind2", Default = Enum.KeyCode.Z, Mode = "Toggle", Callback = function(Value)
				print(Value);
			end});
			local Textbox = Sections.SilentAimbot:Textbox({Name = "Textbox", Flag = "Textbox", Callback = function(Value)
				--print(Value);
			end});
		end;

		do
			local ThemeColorpickers = {};

			for _, Value in Library.Theme do
				ThemeColorpickers[_] = Sections.Themes:Colorpicker({Name = _, Flag = _ .. "_theme", Default = Value, Callback = function(Val)
					Library:ChangeTheme(_, Val);
				end});
			end;
		end;

		do
			local ConfigName = "";
			local ConfigSelected;

			local ConfigDropdown = Sections.Configs:Dropdown({Name = "Configs", Flag = "Configs", Options = {}, Callback = function(Value)
				ConfigSelected = Value;
			end});

			Sections.Configs:Textbox({Name = "Config Name", Default = "", Flag = "ConfigName", Placeholder = "Name ...", Callback = function(Value)
				ConfigName = Value;
			end});

			Sections.Configs:Button({Name = "Load Config", Callback = function()
				if ConfigSelected then
					Library:LoadConfig(readfile(Library:GetConfigsDirectory() .. ConfigSelected .. ".json"));

					task.spawn(function()
						task.wait(0.5)

						for Index, Value in Library.Theme do 
							Library.Theme[Index] = Library.Flags[Index.."_theme"].Color;
							Library:ChangeTheme(Index, Library.Flags[Index.."_theme"].Color);
						end;
					end);
				end;
			end}):CreateSub({Name = "Save Config", Callback = function()
				if ConfigSelected then
					writefile(Library:GetConfigsDirectory() .. ConfigSelected .. ".json", Library:GetConfig());
					Library:Notification("Saved Config", 3, Color3.fromRGB(0, 255, 0));
				end;
			end});

			Sections.Configs:Button({Name = "Create Config", Callback = function()
				if ConfigName == "" then 
					Library:Notification("Config name can't be empty.", 3, Color3.fromRGB(255, 0, 0));
					return;
				end;

				if isfile(Library:GetConfigsDirectory() .. ConfigName .. ".json") then
					Library:Notification("Config already exists.", 3, Color3.fromRGB(255, 0, 0));
					return;
				end;

				writefile(Library:GetConfigsDirectory() .. ConfigName .. ".json", Library:GetConfig());
				Library:ListConfigs(ConfigDropdown);
			end}):CreateSub({Name = "Delete Config", Callback = function()
				if ConfigSelected then
					delfile(Library:GetConfigsDirectory() .. ConfigSelected .. ".json");
				end;
			end});

			Library:ListConfigs(ConfigDropdown);
		end;
	end;
end;

Library:Notification("this is a notification", 5, Library.Theme.Accent);
task.wait(2);
Library:Notification("that can be as much as characters\nor\nas much\nas lines\nas you\nwant", 5, Library.Theme.Accent);
Library:Notification("UI Loaded in: ".. string.format("%.4f", tick() - LoadingTick) .. " seconds.", 5, Library.Theme.Accent);

Library:Watermark("Utopiahack ~ Apocalypse rising 2 ~ ".. Library.Version);

getgenv().Library = Library;
return Library;
