--[[	---------------------------------------------------------------
        Call To Arms - Updated for Cata by Xcamr aka Rockyoysters
        English Localization Update and Testing by Sesub
        ---------------------------------------------------------------
        @Author: 		Larry Lewis
        @Author:		Sacha Beharry
        @Author:		Eike Hanus (R10E)
        @Author:		David Glassbrenner
        @DateCreated: 	26th May 2005
        @LastUpdate: 	21 February 2011
        @Release:		Cata
        @Interface:		40000
--]]

        CTA_RELEASEVERSION 	= "aieCTA 4.0.8.0";
        CTA_RELEASENOTE 	= "aieCTA 4.0.8.0";
        CTA_THIS_VERSION	= 408;

--[[
        E-Mail David Glassbrenner:	lioneljonson@gmail.com
        Project Name: 		Call To Arms, Grouping Tool for World of Warcraft
--]]


--[[
		---------------------------------------------------------------
		NOTES ABOUT BUGS:
		There is a problem with his addon and CensusPlus from warcraftrealms.com

		---------------------------------------------------------------
--]]

--[[	Variables
    ---------------------------------------------------------------
--]]

CTA_DEFAULT_RAID_CHANNEL		= "aieCTAChannel";
CTA_INVITE_MAGIC_WORD 			= "inviteme";
CTA_PLAYER						= "player";
CTA_MAX_RESULTS_ITEMS			= 20;
CTA_MAX_BLACKLIST_ITEMS			= 15;
CTA_ALLIANCE	    			= "Alliance";
CTA_HORDE						= "Horde";
CTA_DEFAULT_LFM_TRIGGER			= "lf%d?m";
CTA_DEFAULT_LFG_TRIGGER			= "lfg";

aieCTA_SavedVariables = {
    version						= 0,
    runCount					= 0,
    GreyList 					= {},
    MinimapArcOffset			= 223,
    MinimapRadiusOffset			= 75,
    MinimapMsgArcOffset			= 296,
    MinimapMsgRadiusOffset		= 95,
    MainFrameTransparency		= 0.85,
    MonitorLfg					= 1,
    FilterLfg					= 1,
    MuteLFG						= 1,
    ShowOnMinimap				= 1,
    lfgTrigger							= CTA_DEFAULT_LFG_TRIGGER,
    lfmTrigger							= CTA_DEFAULT_LFM_TRIGGER,
    messageList 				= {},
    FilterLevel					= 5,
    timeLastMsgAdded			= 0,
};

CTA_CommunicationChannel 		= "aieCTAChannel";
CTA_MyRaid 						= nil;
CTA_FilteredResultsList 		= {};
CTA_ResultsListOffset 			= 0;
CTA_BlackList 					= {};
CTA_PlayerListOffset 			= 0;
CTA_MyRaidIsOnline 				= nil;

CTA_IgnoreBlacklisted			= 1;

local CTA_RAID_TYPE_PVP 		= 1;
local CTA_RAID_TYPE_PVE 		= 0;
local CTA_RP_TYPE				= 1;
local CTA_GREYLISTED			= 0;
local CTA_BLACKLISTED			= 1;
local CTA_WHITELISTED			= 2;
local CTA_MESSAGE				= "M";
local CTA_GENERAL				= "I";
local CTA_GROUP_UPDATE			= "G";
local CTA_BLOCK					= "X";
local CTA_SEARCH				= "S";
CTA_NUM_CLASSES           		= 10


local CTA_MESSAGE_COLOURS = {
    M = { r = 1,   b = 1,   g = 0.5 },
    I = { r = 1,   b = 0.5, g = 1   },
    G = { r = 0.5, b = 0.5, g = 1   },
    X = { r = 1,   b = 0.5, g = 0.5 },
    S = { r = 0.5, b = 1,   g = 0.5 }
};

local CTA_MyRaidPassword 		= nil;
local CTA_UpdateTicker 			= 0.0;
local CTA_SearchTimer 			= 0;
local CTA_SelectedResultListItem = 0;
local CTA_ChannelSpam 			= {};
local CTA_SpamTimer 			= 0;
local CTA_PendingMembers		= {};
local CTA_GraceTimer			= 0;
local CTA_HostingRaidGroup		= nil;
      CTA_InvitationRequests	= {};
local CTA_OutstandingRequests	= 0;
local CTA_RequestTimer			= 0;
local CTA_myguild = nil;
local CTA_myname = nil;

CTA_PollBroadcast 				= nil;
CTA_PollApplyFilters 			= nil;
CTA_TimeSinceLastBroadcast		= 0;
CTA_TimeSinceLastFilter			= 0
CTA_RawGroupList				= {};
CTA_JoinedChannel				= nil;
CTA_AcidSummary					= nil;
CTA_AnnounceTimer				= 0;

CTA_WhoName						= nil;

-- Search
CTA_MessageList						= {};

-- R7 BEGIN

local lfxChatMessageList			= {};
CTA_AutoAnnounce					= nil;

CTA_ForwardThrottle                 = 10;		--250
CTA_ForwardTimer					= CTA_ForwardThrottle;

CTA_WhoFlag 						= nil;

CTA_AcidDetails						= nil;
CTA_PlayerIsAFK						= nil;

CTA_Classes							= {};

--R7 END

--R11
CTA_ClassColors 					= {};
CTA_ClassColors["Priest"]	 		= "ffffff";
CTA_ClassColors["Mage"] 			= "68ccef";
CTA_ClassColors["Warlock"] 			= "9382c9";
CTA_ClassColors["Druid"] 			= "ff7c0a";
CTA_ClassColors["Hunter"] 			= "aad372";
CTA_ClassColors["Rogue"] 			= "fff468";
CTA_ClassColors["Warrior"]	 		= "c69b6d";
CTA_ClassColors["Paladin"]	 		= "f48cba";
CTA_ClassColors["Shaman"] 			= "badb00";
CTA_ClassColors["Death Knight"] 	= "c41f3b";

CTA_ClassColors[CTA_PRIEST] 		= "ffffff"; --= { id=1, txMin=0.50, txMax=0.75, tyMin=0.25, tyMax=0.50 };
CTA_ClassColors[CTA_MAGE] 			= "68ccef"; --= { id=2, txMin=0.25, txMax=0.50, tyMin=0.00, tyMax=0.25 };
CTA_ClassColors[CTA_WARLOCK] 		= "9382c9"; --= { id=3, txMin=0.75, txMax=1.00, tyMin=0.25, tyMax=0.50 };
CTA_ClassColors[CTA_DRUID] 			= "ff7c0a"; --= { id=4, txMin=0.75, txMax=1.00, tyMin=0.00, tyMax=0.25 };
CTA_ClassColors[CTA_HUNTER] 		= "aad372"; --= { id=5, txMin=0.00, txMax=0.25, tyMin=0.25, tyMax=0.50 };
CTA_ClassColors[CTA_ROGUE] 			= "fff468"; --= { id=6, txMin=0.50, txMax=0.75, tyMin=0.00, tyMax=0.25 };
CTA_ClassColors[CTA_WARRIOR] 		= "c69b6d"; --= { id=7, txMin=0.00, txMax=0.25, tyMin=0.00, tyMax=0.25 };
CTA_ClassColors[CTA_PALADIN] 		= "f48cba"; --= { id=8, txMin=0.00, txMax=0.25, tyMin=0.50, tyMax=0.75 };
CTA_ClassColors[CTA_SHAMAN] 		= "badb00";	--= { id=9, txMin=0.25, txMax=0.50, tyMin=0.25, tyMax=0.50 };
CTA_ClassColors[CTA_DEATHKNIGHT] 	= "c41f3b";

CTA_IsAllianceFactionUser			= nil;
CTA_Reload 							= 1;
CTA_UI 								= {};

CTA_UI.getString = function( uiObj, defaultVal )
    local val = uiObj:GetText();
    if( not val or val == "" ) then
        return defaultVal;
    else
        return val;
    end
end

local CLR = {}
function CLR:VALUE(s)
    local v
    if type(s) == "nil" then
        v = "nil"
    else
        v = tostring(s)
    end

    return string.format("|cffffa0a0%s|r", v)
end

CTA_UI.getNumber = function( uiObj, defaultVal, minVal, maxVal )
    for val in string.gmatch( uiObj:GetText(), "(%d+)" ) do
        val = tonumber( val );
        if( val >= minVal and val <= maxVal ) then
            return val;
        end
    end
    return defaultVal;
end

--[[	---------------------------------------------------------------
        OnLoad and Slash Commands
        ---------------------------------------------------------------
--]]




--[[	---------------------------------------------------------------
        Register events and hook functions.
        ---------------------------------------------------------------
--]]

function CTA_OnLoad(self)

    --Register Slash Command
    SlashCmdList["CallToArmsCOMMAND"] = CTA_SlashHandler;
    SLASH_CallToArmsCOMMAND1 = "/cta";

    --Register Event Listeners
    self:RegisterEvent("CHAT_MSG_SYSTEM");
    self:RegisterEvent("PARTY_MEMBERS_CHANGED");
    self:RegisterEvent("PARTY_LEADER_CHANGED");
    self:RegisterEvent("CHAT_MSG_WHISPER");
    self:RegisterEvent("CHAT_MSG_CHANNEL");
    --self:RegisterEvent("CHAT_MSG_GUILD");
    self:RegisterEvent("RAID_ROSTER_UPDATE");
    --self:RegisterEvent("WHO_LIST_UPDATE");
    self:RegisterEvent("VARIABLES_LOADED");
    self:RegisterEvent("PLAYER_ENTERING_WORLD");

    --Announce AddOn to user
    CTA_Error("-[ CTA "..CTA_RELEASEVERSION.." ]-");

    CTA_Classes[1] = CTA_PRIEST;
    CTA_Classes[2] = CTA_MAGE;
    CTA_Classes[3] = CTA_WARLOCK;
    CTA_Classes[4] = CTA_DRUID;
    CTA_Classes[5] = CTA_HUNTER;
    CTA_Classes[6] = CTA_ROGUE;
    CTA_Classes[7] = CTA_WARRIOR;
    CTA_Classes[8] = CTA_PALADIN;
    CTA_Classes[9] = CTA_SHAMAN;
    CTA_Classes[10] = CTA_DEATHKNIGHT;

    CTA_Classes[CTA_PRIEST] 	= 1;
    CTA_Classes[CTA_MAGE] 		= 2;
    CTA_Classes[CTA_WARLOCK] 	= 3;
    CTA_Classes[CTA_DRUID] 		= 4;
    CTA_Classes[CTA_HUNTER] 	= 5;
    CTA_Classes[CTA_ROGUE] 		= 6;
    CTA_Classes[CTA_WARRIOR] 	= 7;
    CTA_Classes[CTA_PALADIN] 	= 8;
    CTA_Classes[CTA_SHAMAN] 	= 9;
    CTA_Classes[CTA_DEATHKNIGHT] 	= 10;

    CTA_myguild = "<"..(GetGuildInfo("player") or "_")..">";
    CTA_myname = UnitName("player")
    print(CTA_myguild, CTA_myname);
    
	local function myChatFilter(msg)
			--If chatFilter returns true, the message is discarded.
			--If chatFilter returns false the second parameter as non-false/nil, the current message text is replaced with your return

			if( aieCTA_SavedVariables.muteLFGChannel and ( arg9 or "?" ) == CTA_MONITOR_CHANNEL_NAME ) then
				print("--MUTE--")
				return;
			end

			--print("filtering ", this and this:GetName() or "nil", arg2 or "nil", aieCTA_SavedVariables.muteLFGChannel or "nil")
			--if (true) then
			--	return false, msg
			--end

			-- R5 : effectively makes blacklist an extended ignore list as well
			if( arg2 and CTA_IgnoreBlacklisted and CTA_FindInList( arg2, CTA_BlackList ) ) then
				--CTA_IconMsg( arg2, CTA_BLOCK ); -- left for testing, disabled for R7
				CTA_LogMsg( CTA_BLOCKED_MESSAGE..arg2, CTA_BLOCK ); -- R7
				return;
			end

			if( strsub(event, 1, 16) == "CHAT_MSG_WHISPER" ) then
				-- R11b7: back to hiding all auto-whispers until R12
				--[[
				if( msg and strsub(msg, 1, 5) == "[CTA]" ) then --R11b5: visible to cta recipients as well
					--CTA_IconMsg( arg2, CTA_MESSAGE );
					if( arg2 == nil or arg2 ~= UnitName("player") ) then
						CTA_LogMsg( ( arg2 or "nil" )..": "..msg, CTA_MESSAGE );
						return; --R3
					else
						CTA_LogMsg( "Message was shown in chat, arg2 = "..arg2, CTA_MESSAGE );
					end
				end
				--]]
				if( msg and strsub(msg, 2, 4) == "CTA" ) then
					if( strlen(event) > 16 or arg2 == nil or arg2 == UnitName("player") ) then
						CTA_LogMsg( ( arg2 or "nil" )..": "..msg, CTA_MESSAGE );
						return;
					end

					CTA_LogMsg( ( arg2 or "nil" )..": "..msg, CTA_MESSAGE );
				end
				--

			end


			if ( not msg or strsub(event, 1, 16) ~= "CHAT_MSG_WHISPER" or strsub(msg, 1, 5) ~= "/cta " ) then -- not msg: R3 bug fix
				if( not msg or not CTA_MainFrame:IsVisible() or not string.find( msg, CTA_AWAY_FROM_KEYBOARD) ) then -- not msg: R3 bug fix
					return false, msg
				end
			end
	end


--ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", myChatFilter)

    BasicScriptErrors:SetScript("OnShow", CTA_ScriptError );
end



function CTA_ScriptError()
    local message = BasicScriptErrorsText:GetText();
    if (not message or not string.find( message, "CallToArms" ) ) then
        --CTA_Println( "No CallToArms error found" );
        return;
    end


    local extMsg = "Error: "..message;
    extMsg = extMsg..", Addons: ";
    local numAddons = GetNumAddOns();
    for i = 1, numAddons do
        if( IsAddOnLoaded( i ) ) then
            local name = GetAddOnInfo( i );
            extMsg = extMsg..name..", ";
        end
    end
    extMsg = extMsg.." Client: "..GetLocale();

    CTA_ErrorReportingFrameEditBox:SetText( extMsg );
    CTA_ErrorReportingFrame:Show();
end


--[[	CTA_SlashHandler(com)
        ---------------------------------------------------------------
        For Slash Commands (surprise)
        @arg The command String
--]]

function CTA_SlashHandler(com)
    if( not com or  com=="" ) then
        CTA_Println( CTA_CALL_TO_ARMS.." "..CTA_RELEASEVERSION );
        CTA_Println( CTA_COMMANDS..": "..CTA_HELP.." | "..CTA_TOGGLE.." | "..CTA_ANNOUNCE_GROUP.." |  "..CTA_DISSOLVE_RAID);

        CTA_Println( CTA_COMMANDS..": "..CTA_TOGGLE_MINIMAP );

        --CTA_Println( "Beta commands:" );
        --CTA_Println( "/error: starts CTA error reporting function. Only works if an error has already occurred." );
        return;
    end

    if( com==CTA_HELP ) then
        CTA_Println( CTA_TOGGLE..": "..CTA_TOGGLE_HELP );
        CTA_Println( CTA_ANNOUNCE_GROUP..": "..CTA_ANNOUNCE_GROUP_HELP );
        CTA_Println( CTA_DISSOLVE_RAID..": "..CTA_DISSOLVE_RAID_HELP );
        return;
    end

    if( com==CTA_TOGGLE ) then
        if( CTA_MainFrame:IsVisible() ) then
            CTA_MainFrame:Hide();
        else
            CTA_MainFrame:Show();
        end
        return;
    end

    if( com==CTA_TOGGLE_MINIMAP ) then
        if( CTA_MinimapIcon:IsVisible() ) then
            CTA_MinimapIcon:Hide();
        else
            CTA_MinimapIcon:Show();
        end
        return;
    end

    if( com==CTA_DISSOLVE_RAID ) then
        if( IsRaidLeader() ) then
            CTA_DissolveRaid();
        else
            CTA_Println( CTA_MUST_BE_LEADER_TO_DISSOLVE_RAID );
        end
        return;
    end


    if( com==CTA_AUTO_ANNOUNCE_OFF ) then
        CTA_AutoAnnounce = nil;
        CTA_AnnounceToLFGButton:SetText( CTA_ANNOUNCE_LFG_BTN );
        CTA_AnnounceToLFGButton2:SetText( CTA_ANNOUNCE_LFG_BTN );
        -- CTA_AnnounceTimer = 0; -- R10E
        CTA_Println( CTA_AUTO_ANNOUNCE_TURNED_OFF );
        return;
    end

    if( com==CTA_ANNOUNCE_GROUP.." on" ) then
        CTA_AutoAnnounce = CTA_MONITOR_CHANNEL_NAME;
        if CTA_AnnounceTimer == 0 then CTA_AnnounceTimer = 5 end; -- R10E
        CTA_Println( CTA_AUTO_ANNOUNCE_TURNED_ON..CTA_AnnounceTimer..CTA_SECONDS );
        CTA_AnnounceToLFGButton:SetText( CTA_ANNOUNCE_LFG_BTN_OFF );
        CTA_AnnounceToLFGButton2:SetText( CTA_ANNOUNCE_LFG_BTN_OFF );
    end


    --[ [
    if( com=="error" ) then
        CTA_ScriptError();
        return;
    end
    --]]

    if( com == "clear_lfx" ) then
        aieCTA_SavedVariables.messageList = {};
        aieCTA_SavedVariables.messageList[GetRealmName()] = aieCTA_SavedVariables.messageList[GetRealmName()] or {};
        aieCTA_SavedVariables.messageList[GetRealmName()][1] = aieCTA_SavedVariables.messageList[GetRealmName()][1] or {};
        aieCTA_SavedVariables.messageList[GetRealmName()][2] = aieCTA_SavedVariables.messageList[GetRealmName()][2] or {};
        table.wipe(CTA_MessageList);
        if( (UnitFactionGroup("player")) == "Alliance" ) then
            CTA_IsAllianceFactionUser = 1;

            for k,v in pairs(aieCTA_SavedVariables.messageList[GetRealmName()][1]) do
            	CTA_MessageList[k] = v
            end

            CTA_Util.chatPrintln( "Showing Alliance Messages" );
        else

            for k,v in pairs(aieCTA_SavedVariables.messageList[GetRealmName()][2]) do
            	CTA_MessageList[k] = v
            end

            CTA_Util.chatPrintln( "Showing Horde Messages" );
        end
        CTA_UpdateResults();
    end


    if( com == "faction" ) then
        if( CTA_IsAllianceFactionUser ) then
            CTA_Util.chatPrintln( "Alliance Character" );
        else
            CTA_Util.chatPrintln( "Horde Character" );
        end

    end

    if( com == "channels" ) then
        local channelList = {EnumerateServerChannels()};
        for i=1, #channelList do
            CTA_Util.chatPrintln( channelList[i] );
        end
    end


end



--[[	---------------------------------------------------------------
        OnUpdate and OnEvent
        ---------------------------------------------------------------
--]]



--[[	CTA_OnUpdate()
        ---------------------------------------------------------------
        Keep the <var>CTA_UpdateTicker</var> running.
        @arg The time elapsed since the last call to this function
--]]

function CTA_OnUpdate(self, elapsed ) -- Called by XML on Update

    CTA_UpdateTicker = CTA_UpdateTicker + elapsed;
    CTAWM.onUpdate( self, elapsed );
    if ( CTA_UpdateTicker < 1 ) then
        return
    end


    if( CTA_AnnounceTimer > 0 ) then
        CTA_AnnounceTimer = CTA_AnnounceTimer - 1;

        -- r7
        if( CTA_AnnounceTimer == 0 and CTA_AutoAnnounce ) then
            if( CTA_PlayerIsAFK ) then
                CTA_SlashHandler(CTA_AUTO_ANNOUNCE_OFF)
                CTA_Println( CTA_AFK_ANNOUNCE_OFF );
            elseif ( CTA_GetNumGroupMembers() > 1 and not CTA_MyRaid ) then
                autoannouce = nil;
                CTA_Println( CTA_JOIN_ANNOUNCE_OFF );
            elseif( CTA_MyRaidIsOnline and CTA_MyRaid ) then
                CTA_MyRaidInstantUpdate();
                CTA_SendChatMessage( CTA_AcidSummary, "CHANNEL", CTA_MONITOR_CHANNEL_NAME );
                CTA_LogMsg( "Sent to lfg channel: ".. CTA_AcidSummary );
                CTA_AnnounceTimer = 300;
                PlaySound("TellMessage");
                CTA_IconMsg( CTA_ANNOUNCED_LFM );
                CTA_Println( CTA_ANNOUNCED_LFM_EXT );
            elseif( CTA_LGMPrefixLabel:GetText() and CTA_LFGDescriptionEditBox:GetText() ~= "" ) then
                CTA_SendChatMessage( CTA_LGMPrefixLabel:GetText()..CTA_LFGDescriptionEditBox:GetText(), "CHANNEL", CTA_MONITOR_CHANNEL_NAME ); --CTA_AutoAnnounce );
                CTA_LogMsg( "Sent to lfg channel: "..  CTA_LGMPrefixLabel:GetText()..CTA_LFGDescriptionEditBox:GetText() );
                CTA_AnnounceTimer = 300;
                PlaySound("TellMessage");
                CTA_IconMsg( CTA_ANNOUNCED_LFG );
                CTA_Println( CTA_ANNOUNCED_LFG_EXT );
            else
                CTA_SlashHandler(CTA_AUTO_ANNOUNCE_OFF);
                CTA_Println( CTA_NOTHING_TO_ANNOUNCE );
            end
        end
        -- /r7
    end

    CTA_TimeSinceLastBroadcast = CTA_TimeSinceLastBroadcast + 1;
    if( CTA_TimeSinceLastBroadcast > 30 ) then
        CTA_TimeSinceLastBroadcast = 0;

        if( CTA_MyRaidIsOnline and CTA_MyRaid ) then
            CTA_PollBroadcast = 1;
        elseif( CTA_LFGCheckButton:GetChecked() and CTA_LGMPrefixLabel:GetText() and CTA_LFGDescriptionEditBox:GetText() ~= "" ) then
            if( CTA_GetNumGroupMembers() > 1 ) then
                CTA_LFGCheckButton:SetChecked( 0 );
                CTA_Println( CTA_JOIN_STOP_LFG );
            else
                CTA_PollBroadcast = 3;
            end
        end

        --/r7
    end

    CTA_TimeSinceLastFilter = CTA_TimeSinceLastFilter + 1;
    if( CTA_TimeSinceLastFilter > 10 ) then
        CTA_TimeSinceLastFilter = 0;
        CTA_PollApplyFilters = 1;
    end

    CTA_SpamTimer = CTA_SpamTimer + CTA_UpdateTicker;
    if( CTA_SpamTimer > 7 ) then
        CTA_ChannelSpam = {};
        CTA_SpamTimer = 0;

          CTA_UpdateMinimapTexture()

        -- Ok, piggybacking 10s SpamTimer to implement
        -- Polled Broadcasting and
        -- Auto Search Updates.

        if( CTA_PollApplyFilters ) then
            CTA_TimeSinceLastFilter = 0;
            CTA_ApplyFiltersToGroupList();
        end


        if( CTA_PollBroadcast and (not CTA_PlayerIsAFK) ) then
            CTA_TimeSinceLastBroadcast = 0;

            if( CTA_PollBroadcast == 3 ) then --r7
                if( CTA_LFGCheckButton:GetChecked() and CTA_LGMPrefixLabel:GetText() and CTA_LFGDescriptionEditBox:GetText() ~= "" ) then

                    local tim = CTA_GetGameTime();


                    local lfgT = CTA_LFGDescriptionEditBox:GetText();

                    --
                    if string.find( lfgT, ":") then lfgT = string.gsub(lfgT, ":", "."); end;


                    CTA_SendChatMessage( "/cta B<"..tim..":"..lfgT..":"..CTA_RELEASEVERSION..">", "CHANNEL", GetChannelName( CTA_CommunicationChannel ) );
                    CTA_LogMsg( "CTA Broadcast: "..tim..":"..lfgT..":"..CTA_RELEASEVERSION..">");
                end
                CTA_PollBroadcast = nil;
            elseif( CTA_PollBroadcast == 2 ) then
                CTA_SendChatMessage("/cta A<>", "CHANNEL", GetChannelName( CTA_CommunicationChannel ) );
                CTA_PollBroadcast = nil;
            elseif( CTA_MyRaidIsOnline and CTA_MyRaid ) then
                CTA_BroadcastRaidInfo();
            end
        end
    end

    if( CTA_GraceTimer > 0  ) then
        CTA_GraceTimer = CTA_GraceTimer - CTA_UpdateTicker;
        --CTA_IconMsg( floor(CTA_GraceTimer) );
        if( CTA_GraceTimer <= 0 ) then
            if( CTA_MyRaid and not CTA_PlayerCanHostGroup() ) then
                CTA_MyRaid = nil;
                CTA_MyRaidIsOnline = nil;
                CTA_HostingRaidGroup = nil;
                CTA_SearchFrame:Show();
                CTA_MyRaidFrame:Hide();
                CTA_StartRaidFrame:Hide();
            else
                CTA_MyRaidInstantUpdate();
            end
        end
    end

    -- using new who system in r11b2 for results
    CTA_RequestTimer = CTA_RequestTimer + CTA_UpdateTicker;
    if( CTA_RequestTimer > 2 ) then
        for i = 1, #CTA_MessageList do
            if( not CTA_MessageList[i].who ) then
                local name = CTA_MessageList[i].op or CTA_MessageList[i].author;
                CTA_MessageList[i].whoAttempts = CTA_MessageList[i].whoAttempts or 0;

                CTA_MessageList[i].who = CTAWM.toOldFormat(name);
                if( CTA_MessageList[i].who ) then
                    --CTA_Util.logPrintln( "Got who info for ".. CLR:VALUE(name).." after ".. CLR:VALUE(CTA_MessageList[i].whoAttempts) .." attempts");
                    CTA_MessageList[i].whoAttempts = 0;
                else
                    if( CTA_MessageList[i].whoAttempts < 5 ) then
                        if( CTAWM.getPositionInQueue( name ) == 0 ) then
                            CTA_MessageList[i].whoAttempts = CTA_MessageList[i].whoAttempts + 1;
                            --CTA_Util.logPrintln( "Asking for who info for ".. CLR:VALUE(name) ..", attempt ".. CLR:VALUE(CTA_MessageList[i].whoAttempts) );
                            CTAWM.addNameToWhoQueue( name );
                        end
                    else
                        CTA_Util.logPrintln( "Could not get who info for "..CLR:VALUE(name) .." after 5 attempts; setting who info as blank" );
                        local entry = {};
                        entry.level = 0;
                        CTA_MessageList[i].who = entry;
                    end
                end
            end
        end

        -- R11B4: updating automatic invitations to use WhoManager
        if( CTA_OutstandingRequests > 0 ) then
            CTA_LogMsg( CTA_OutstandingRequests..CTA_INVITATION_REQUEST_OUTSTANDING );
            for name, data in pairs(CTA_InvitationRequests) do
                if( data.status == 1 ) then
                    local pdata = CTAWM.getInformation( name );
                    if( pdata ) then
                        CTA_LogMsg( CTA_VALIDATING_REQUEST_FROM..name );
                        --Data format: { time, level, race, class, guild }
                        local level, class, guild = pdata[2], pdata[4], pdata[5];
                        CTA_OutstandingRequests = CTA_OutstandingRequests - 1;
                        if( CTA_MyRaid and level >= CTA_MyRaid.minLevel and string.find( CTA_GetClassString(CTA_MyRaid.classes),class) ) then

							local v1,v2,v3,v4 = strsplit(" ", guild);
							local validMainGuild = nil;

							if(v1 == 'alea' and v2 == 'iacta' and v3 == 'est') then
								validMainGuild = 1;
							end

							local subguild = v4;

							local validSubGuild = nil;
							for k,v in pairs(CTA_SUBGUILDS) do
								if( v == subguild ) then
									validSubGuild = 1;
								end
							end

							if(subguild and validSubGuild == 1 and validMainGuild == 1) then
								CTA_LogMsg( CLR:VALUE(name).."\'s request processed: Valid player - Invitation sent" );
								InviteUnit( name );

								CTA_InvitationRequests[name].status = 2;
								CTA_InvitationRequests[name].class = class;
								CTA_InvitationRequests[name].level = level;

								CTA_IconMsg( CTA_INVITATION_SENT_TO.." "..name, CTA_GROUP_UPDATE );
    	                        CTA_SendAutoMsg( CTA_INVITATION_SENT_MESSAGE, name );
    	                        CTA_MyRaidInstantUpdate();
							else
	                            CTA_InvitationRequests[name] = nil;
	                            CTA_LogMsg( CLR:VALUE(name).."\'s request processed: Invalid player - request removed" );

								CTA_SendAutoMsg( CTA_WRONG_GUILD, name);
							end
                        else
                            CTA_InvitationRequests[name] = nil;
                            CTA_LogMsg( CLR:VALUE(name).."\'s request processed: Invalid player - request removed" );

                            CTA_SendAutoMsg( CTA_WRONG_LEVEL_OR_CLASS, name );
                        end

                    else
                        data.whoAttempts = data.whoAttempts or 0;
                        if( data.whoAttempts < 5 ) then
                            if( CTAWM.getPositionInQueue( name ) == 0 ) then
                                data.whoAttempts = data.whoAttempts + 1;
                                --CTA_Util.logPrintln( "Asking for who info for ".. CLR:VALUE(name)..", attempt ".. data.whoAttempts ); -- R11B5: fixed bug
                                CTAWM.addNameToWhoQueue( name );
                            else
                                CTA_Util.logPrintln( "Who request for ".. CLR:VALUE(name).." is queued in position ".. CTAWM.getPositionInQueue( name ) );
                            end
                        else
                            CTA_Util.logPrintln( "Could not get who info for "..CLR:VALUE(name) .." after 5 attempts; removing request" );
                            --CTA_InvitationRequests[name] = nil;
                            CTA_LogMsg( "Player "..name.." could not be found. Removing from requests list." );
                            CTA_RemoveRequest(name); -- R11B5: fixed bug - was (CTA_WhoName)
                        end
                    end
                end
            end
        end

        CTA_RequestTimer = 0;
    end
    --[[
    CTA_RequestTimer = CTA_RequestTimer + CTA_UpdateTicker;
    if( CTA_RequestTimer > 5 ) then
        if( CTA_OutstandingRequests > 0 ) then
            CTA_LogMsg( CTA_OutstandingRequests..CTA_INVITATION_REQUEST_OUTSTANDING );
            for name, data in CTA_InvitationRequests do
                if( data.status == 1 ) then
                    SetWhoToUI(1);
                    CTA_WhoName = name;
                    SendWho("n-"..name);
                    SendWho(name);
                    CTA_LogMsg( CTA_VALIDATING_REQUEST_FROM..name );
                    break;
                end
            end
        end
        CTA_RequestTimer = 0;
    end
    --]]
    CTA_ForwardTimer = CTA_ForwardTimer - 1;
    if( CTA_ForwardTimer == 0 ) then
        if( lfxChatMessageList[#lfxChatMessageList] ) then
            CTA_Util.sendChatMessage( lfxChatMessageList[#lfxChatMessageList].message, "CHANNEL", GetChannelName( CTA_CommunicationChannel ) );
            --CTA_Util.chatPrintln( ">>"..lfxChatMessageList[#lfxChatMessageList].message );
            local name = lfxChatMessageList[#lfxChatMessageList].author;
            table.remove( lfxChatMessageList, #lfxChatMessageList );
            CTA_Util.logPrintln( "Forwarded msg from <"..CLR:VALUE(name)..">, pending relay count: "..#lfxChatMessageList );
        end
        CTA_ForwardTimer = CTA_ForwardThrottle;

    end

    CTA_UpdateTicker = 0;
end



function CTA_ForwardMessage(msg)
   table.insert(lfxChatMessageList, 1, msg)
    CTA_ForwardTimer = CTA_ForwardThrottle;
end


function CTA_MinimapIconOnClick(button)
    if button == "RightButton" then
        -- no op
    else
        CTA_ToggleMainFrame()
    end
end


function CTA_UpdateMinimapTexture()
    --[[
    local _, _, _, _, _, _, _, _, _, _, lfgStatus, lfmStatus = GetLookingForGroup();

    if lfgStatus or lfmStatus then
         SetDesaturation(CTA_MinimapIconBgTexture, false)
    else
         SetDesaturation(CTA_MinimapIconBgTexture, true)
    end
    --]]
    SetDesaturation(CTA_MinimapIconBgTexture, false)
end

--[[	CTA_OnEvent()
        ---------------------------------------------------------------
        Event handler.
        @arg The event to be handled
--]]

function CTA_OnEvent(self, event,... ) -- Called by XML on Event
	local arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9 = ...;

    if(event == "PLAYER_ENTERING_WORLD" and CTA_Reload ) then --"VARIABLES_LOADED") then
        CTA_InitWorld(self,event,...)
    end

    -- for R2 to see if we can tell when a player does not accept your invitation to join the group
    if ( event == "CHAT_MSG_SYSTEM" ) then
        if ( string.find( arg1, CTA_DECLINES_YOUR_INVITATION ) or string.find( arg1, CTA_IS_ALREADY_IN_A_GROUP ) ) then
            local name = string.gsub( arg1, "%s*([^%s]+).*", "%1" );
            CTA_RemoveRequest( name );
            CTA_LogMsg( name..CTA_HAS_DECLINED_INVITATION );
            CTA_MyRaidInstantUpdate();
        end

        if ( string.find( arg1, CTA_NOW_AFK ) ) then
            --CTA_Println( "AFK" );
            CTA_PlayerIsAFK = 1;
        end

        if ( string.find( arg1, CTA_NO_LONGER_AFK ) ) then
            --CTA_Println( "NOT AFK" );
            CTA_PlayerIsAFK = nil;
        end
    end

    -- Listen for Invitation requests
	if ( event == "CHAT_MSG_WHISPER" ) then
        -- CTA_Util.logPrintln( "Received Whisper: <"..arg1.."> from <"..arg2..">" );

        -- If the identity mod is on (and a lot of people in AIE use it),
        -- strip out the added on text before processing arg1
        local the_arg1 = arg1
        for msg in string.gmatch( the_arg1, "%(.*%): (.*)" ) do
            the_arg1 = msg
        end
        -- CTA_Util.logPrintln( "New the_arg1: "..the_arg1.."" );

        if( CTA_MyRaidIsOnline and string.lower( strsub(the_arg1, 1, 8) ) == CTA_INVITE_MAGIC_WORD) then
            if( not CTA_FindInList( arg2, CTA_BlackList ) ) then -- R2
                if( CTA_ChannelSpam[arg2] == nil ) then
                    CTA_ChannelSpam[arg2] = 0;
                end
                CTA_ChannelSpam[arg2] = CTA_ChannelSpam[arg2] + 1;
                if( CTA_ChannelSpam[arg2] > 12 ) then --r7 4 -> 12
                    CTA_RemoveRequest( arg2 );
                    CTA_SendAutoMsg(arg2.." "..CTA_WAS_BLACKLISTED, arg2);
                    CTA_IconMsg( arg2.." "..CTA_WAS_BLACKLISTED, CTA_BLOCK );
                    CTA_AddPlayer( arg2, CTA_BLACKLISTED_NOTE, CTA_DEFAULT_STATUS, CTA_DEFAULT_RATING, CTA_BlackList )
                else
                    CTA_ReceiveRaidInvitationRequest( the_arg1, arg2 );
                end
            end
        end

        if( CTA_MyRaidIsOnline and CTA_AcidDetails and string.lower( strsub(the_arg1, 1, 7) ) == "details" ) then
            CTA_SendAutoMsg( CTA_AcidDetails, arg2 )
        end

        if( string.lower( strsub(the_arg1, 1, 4) ) == "cta?" ) then
            CTA_SendAutoMsg( CTA_ABOUT_CTA_MESSAGE, arg2 )
        end

    end

    -- Listen for LFG Channel messages

	if ( event == "CHAT_MSG_CHANNEL" ) then
        --arg1 = message, arg2 = sender, arg3 = language, arg4 = channelString
        --arg6  = flags, arg8 = channel#, arg9 = channelName

        --print("chat msg from: "..arg2)
        if( not CTA_JoinedChannel ) then
                CTA_Util.joinChannel( CTA_MONITOR_CHANNEL_NAME );
                -- Use channel event to delay joining of aieCTAChannel
                CTA_Util.joinChannel( CTA_CommunicationChannel );
                CTA_JoinedChannel = 1;
        end


        -- CTA channel relay msgs
        if( arg9 == CTA_CommunicationChannel ) then
            local entry = {};
            -- CTA_Util.logPrintln( "CTA-RELAY: <"..arg1.."> from <"..arg2..">" );

            --R7 > Trusted CTA Channel Messages

            if( arg1 == "/cta A<>" ) then
                for i = 1, #CTA_MessageList do
                    local name = CTA_MessageList[i].author or "?";
                    if( name == arg2 and not CTA_MessageList[i].op ) then
                        table.remove( CTA_MessageList , i );
                        break;
                    end
                end
                CTA_PollApplyFilters = 1;
                return;
            end

            for code, com, opt in string.gmatch( arg1, "/cta A<(%d+):(.+):(.+)>" ) do
                local tim = string.sub( code,  1,  6 );
                local cla = tonumber( string.sub( code,  7,  10 ) );
                local siz = tonumber( string.sub( code,  11,  12 ) );
                local max = tonumber( string.sub( code, 13, 14 ) );
                local min = tonumber( string.sub( code, 15, 16 ) );
                local pro = 0;
                local typ = CTA_RAID_TYPE_PVE;

                if( siz > 40 ) then
                    typ = CTA_RAID_TYPE_PVP;
                    siz = siz - 40;
                end

                if( max > 40 ) then
                    pro = 1;
                    max = max - 40;
                end

                local whoData = nil;

                -- R11B4
                local shownInChatAndOrMinimap = nil;
                --

                for i = 1, #CTA_MessageList do
                    local name = CTA_MessageList[i].author or "?";
                    if( name == arg2 and not CTA_MessageList[i].op ) then
                        whoData = CTA_MessageList[i].who;
                        shownInChatAndOrMinimap = CTA_MessageList[i].shownInChatAndOrMinimap;
                        table.remove( CTA_MessageList , i );
                        break;
                    end
                end

                entry.ctaType = "A";
                entry.author = arg2 or nil;
                entry.message = com or nil;
                entry.time = tim or nil;
                entry.options = opt or nil;
                entry.who = whoData or nil;
                entry.op = nil;

                entry.pvtype = tonumber(typ) or nil;
                entry.size = tonumber(siz) or nil;
                entry.maxSize = tonumber(max) or nil;
                entry.minLevel = tonumber(min) or nil;
                entry.classes = tonumber(cla) or nil;
                entry.passwordProtected = tonumber(pro) or nil;
                entry.shownInChatAndOrMinimap = shownInChatAndOrMinimap or nil;

                table.insert( CTA_MessageList, 1, entry );
                CTA_PollApplyFilters = 1;
                return;
			end

			for code, com, opt in string.gmatch( arg1, "/cta B<(%d+):(.+):(.+)>" ) do
                -- Remove author from LFX list upon receiving new transmission
                local whoData = nil;

                -- R11B4
                local shownInChatAndOrMinimap = nil;
                --

                for i = 1, #CTA_MessageList do
                    local name = CTA_MessageList[i].author or "?";
                    if( name == arg2 and not CTA_MessageList[i].op ) then
                        whoData = CTA_MessageList[i].who;
                        shownInChatAndOrMinimap = CTA_MessageList[i].shownInChatAndOrMinimap;
                        table.remove( CTA_MessageList , i );
                        break;
                    end
                end

                entry.ctaType = "B";
                entry.author = arg2 or nil;
                entry.message = com or nil;
                entry.time = code or nil;
                entry.options = opt or nil;
                entry.who = whoData or nil;
				entry.op = nil;

                entry.pvtype = nil;
                entry.size = nil;
                entry.maxSize = nil;
                entry.minLevel = nil;
                entry.classes = nil;
                entry.passwordProtected = nil;
                entry.shownInChatAndOrMinimap = shownInChatAndOrMinimap or nil;

                table.insert( CTA_MessageList, 1, entry );
                CTA_PollApplyFilters = 1;
                return;
            end


            for code, opname, com, opt in string.gmatch( arg1, "/cta C<(%d+):(.+):(.+):(.+)>" ) do
            --[[ Removed for beta 4 tests
                if( CTA_Util.search( com, aieCTA_SavedVariables.lfmTrigger ) > 0 ) then
            --]]

				-- remove this msg from our forward list
				for i = 1, #lfxChatMessageList do
					local name = lfxChatMessageList[i].author or "?";
					if( name == opname ) then
						table.remove( lfxChatMessageList, i );
						CTA_Util.logPrintln( "Rx cta forward msg re: <"..CLR:VALUE(opname).."> from <"..CLR:VALUE(arg2).."> - Removed monitor entry" );
						break;
					end
				end

				local whoData = nil;

				-- Ignore broadcast from myself
				if (CTA_myname == arg2) then
					return;
				end

				-- Does this guy already have an entry in our message list?  If so remove.
				for i = 1, #CTA_MessageList do
					local name = CTA_MessageList[i].op or "?";
					if( name == opname ) then
						whoData = CTA_MessageList[i].who;
						table.remove( CTA_MessageList , i );
						break;
					end
				end

	--			CTA_Util.logPrintln( "MSG-C <"..com.."> from <"..arg2.."> op <"..opname..">" );

				entry.ctaType = "C";
				entry.author = arg2 or nil;
				entry.message = com or nil;
				entry.time = code or nil;
				entry.options = opt or nil;
				entry.who = whoData or nil;
				entry.op = opname or nil;

                entry.pvtype = nil;
                entry.size = nil;
                entry.maxSize = nil;
                entry.minLevel = nil;
                entry.classes = nil;
                entry.passwordProtected = nil;
				entry.shownInChatAndOrMinimap = nil;

				table.insert( CTA_MessageList, 1, entry );
				CTA_PollApplyFilters = 1;
				--]]
            --[[ Removed for beta 4 tests
                end
            --]]
                return;
            end

            for code, opname, com, opt in string.gmatch( arg1, "/cta D<(%d+):(.+):(.+):(.+)>" ) do

            --[[ Removed for beta 4 tests
                --if( CTA_Util.search( com, aieCTA_SavedVariables.lfgTrigger ) > 0 ) then
            --]]

                    for i = 1, #lfxChatMessageList do
                        local name = lfxChatMessageList[i].author or "?";
                        if( name == opname ) then
                            table.remove( lfxChatMessageList, i );
                            CTA_Util.logPrintln( "Rx cta forward msg re: "..CLR:VALUE(opname).." from "..CLR:VALUE(arg2).." - Removed monitor entry" );
                            break;
                        end
                    end

                    local whoData = nil;

                        -- Ignore broadcast from myself
                    if (CTA_myname == arg2) then
                        return;
                    end

                    -- Does this guy already have an entry in our message list?  If so remove.
                    for i = 1, #CTA_MessageList do
                        local name = CTA_MessageList[i].op or "?";
                        if( name == opname ) then
                            whoData = CTA_MessageList[i].who;
                            table.remove( CTA_MessageList , i );
                            CTA_Util.logPrintln( "Removed entry: "..CLR:VALUE(opname).." from "..CLR:VALUE(arg2) );
                            break;
                        end
                    end

                    entry.ctaType = "D";
                    entry.author = arg2 or nil;
                    entry.message = com or nil;
                    entry.time = code or nil;
                    entry.options = opt or nil;
                    entry.who = whoData or nil;
                    entry.op = opname or nil;

					entry.pvtype = nil;
					entry.size = nil;
					entry.maxSize = nil;
					entry.minLevel = nil;
					entry.classes = nil;
					entry.passwordProtected = nil;
					entry.shownInChatAndOrMinimap = nil;

                    --print("--rcvd msg from "..opname)
                    --ignore messages from myself!
                    if (CTA_myname ~= arg2) then
                        table.insert( CTA_MessageList, 1, entry );
                        CTA_PollApplyFilters = 1;
                    end
            --[[ Removed for beta 4 tests
                --end
            --]]
                return;
            end

        elseif (string.lower( arg9 ) == string.lower( CTA_MONITOR_CHANNEL_NAME )) then -- or (type(arg7) == "number" and arg7 > 0) then  -- Server Channel

      		local global_chan = string.lower( arg9 ) == string.lower( CTA_MONITOR_CHANNEL_NAME )	--LookingForGroup channel
            local channel = arg8 or "?";
            local author = arg2 or " ";

			local entry = {};
            local msg = arg1 or "?";
            local type = "C"

            -- INSERT SCORING ALGORITHM HERE! ----->

            local spamscore, score, mtype = CTA_Util.rateResults( msg, aieCTA_SavedVariables.FilterLevel );

            -- <----- INSERT SCORING ALGORITHM HERE!

            --CTA_Util.logPrintln("score="..score.."  mtype="..mtype)
            local mCol = "ffff3333";
            if( mtype == "U" ) then
                mCol = "ffcccccc";
            elseif( mtype == "D" ) then
                mCol = "ffccffcc";
            elseif( mtype == "C" ) then
                mCol = "ffccccff";

            end

            if spamscore > 0 or score > 0 then
                CTA_Util.logPrintln( "[|cffffffff|Hplayer:"..author.."|h"..author.. "|h|r]: ".. score .." : |c"..mCol..msg.. "|r" );
            end

            if ( score == 0 ) then
                --if( not aieCTA_SavedVariables.muteLFGChannel) then
                --	DEFAULT_CHAT_FRAME:AddMessage( "*["..author.."]: "..msg, 1, 0.8, 0 );
                --end
                return;
            end

            -- is a spam by another cta user
            for i = 1, #CTA_MessageList do
                local name = CTA_MessageList[i].author or "?";
                if( name == author and not CTA_MessageList[i].op ) then
                    return;
                end
            end

            -- Generate HHMMSS timestamp
            local tim = CTA_GetGameTime();
            --local tim, minute = GetGameTime();
            --if( tim < 10 ) then tim = "0"..tim; end
            --if( minute < 10 ) then tim = tim.."0"; end
            --tim = tim..minute;



            -- if LookingForGroup channel-------------------------------------
			if global_chan then
            -- got this message in the LFG channel
            -- add this message to the list
                local whoData = nil;

                for i = 1, #CTA_MessageList do
                    local name = CTA_MessageList[i].op or "?";
                    if( name == author ) then
                        whoData = CTA_MessageList[i].who;
                        table.remove( CTA_MessageList , i );
                        break;
                    end
                end

                entry.ctaType = mtype or nil;
                entry.author = "";
                entry.message = msg or nil;
                entry.time = tim or nil;
                entry.options = "x";
                entry.who = whoData or nil;
                entry.op = author or nil;

				entry.pvtype = nil;
				entry.size = nil;
				entry.maxSize = nil;
				entry.minLevel = nil;
				entry.classes = nil;
				entry.passwordProtected = nil;
				entry.shownInChatAndOrMinimap = nil;

                table.insert( CTA_MessageList, 1, entry );
                aieCTA_SavedVariables.timeLastMsgAdded = time();
                CTA_PollApplyFilters = 1;
            else
				-- Forward this message across CTA channel

				-- Only forward msgs with no spam and score >= 3
				-- otherwise we forwarding too many messages and getting D/C'd
				--print("scores: ",spamscore, score)

				CTA_Util.logPrintln( "Picked up lfx msg in <"..CLR:VALUE(arg9).."> from <"..CLR:VALUE(author)..">");

				if (spamscore > 0) or (score < 3) then
					return;
				end

				--CTA_Util.logPrintln("msg added")
				-- Add to our message list right now
				-- begin add msg
				for i = 1, #CTA_MessageList do
					local name = CTA_MessageList[i].op or "?";
					if( name == author ) then
						whoData = CTA_MessageList[i].who;
						table.remove( CTA_MessageList , i );
						break;
					end
				end

                entry.ctaType = mtype or nil;
                entry.author = "";
                entry.message = msg or nil;
                entry.time = tim or nil;
                entry.options = "x";
                entry.who = whoData or nil;
                entry.op = author or nil;

				entry.pvtype = nil;
				entry.size = nil;
				entry.maxSize = nil;
				entry.minLevel = nil;
				entry.classes = nil;
				entry.passwordProtected = nil;
				entry.shownInChatAndOrMinimap = nil;

                table.insert( CTA_MessageList, 1, entry );
                aieCTA_SavedVariables.timeLastMsgAdded = time();
                CTA_PollApplyFilters = 1;

                -- end add msg

                -- Forward to other CTA users
                for i = 1, #lfxChatMessageList do
                    local name = lfxChatMessageList[i].author or "?";
                    if( name == author ) then
                        table.remove( lfxChatMessageList, i );
                        break;
                    end
                end

                if string.find( msg, ":") then msg = string.gsub(msg, ":", "."); end;

                entry.author = author or nil;
                entry.message = "/cta "..mtype.."<"..tim..":"..author..":"..msg..":x>";

                entry.ctaType = nil;
                entry.time = nil;
                entry.options = nil;
                entry.who = nil;
                entry.op = nil;

				entry.pvtype = nil;
				entry.size = nil;
				entry.maxSize = nil;
				entry.minLevel = nil;
				entry.classes = nil;
				entry.passwordProtected = nil;
				entry.shownInChatAndOrMinimap = nil;

                CTA_ForwardMessage( entry );

                --CTA_Util.logPrintln( "Relaying msg, count: "..#lfxChatMessageList );
        	end	-- end if global_chan


			return

		end
	end

    -- Listen for Who information -- NEEDS WORK
    if ( event == "WHO_LIST_UPDATE" ) then
        CTAWM.onEventWhoListUpdated(self,event,...);
    end

    -- Group update
    if ( event == "RAID_ROSTER_UPDATE" or event == "PARTY_LEADER_CHANGED" or event == "PARTY_MEMBERS_CHANGED" ) then
        CTA_GraceTimer = 2;
    end

end


function CTA_InitWorld(self,event,...)
    CTA_MinimapArcSlider:SetValue( aieCTA_SavedVariables.MinimapArcOffset );
        CTA_MinimapRadiusSlider:SetValue( aieCTA_SavedVariables.MinimapRadiusOffset );
        CTA_MinimapMsgArcSlider:SetValue( aieCTA_SavedVariables.MinimapMsgArcOffset );
        CTA_MinimapMsgRadiusSlider:SetValue( aieCTA_SavedVariables.MinimapMsgRadiusOffset );
        CTA_UpdateMinimapIcon();
        CTA_AddGreyToBlack();
        CTA_ImportIgnoreListToGreyList();
        if( not aieCTA_SavedVariables.runCount or aieCTA_SavedVariables.runCount == 0 ) then
            aieCTA_SavedVariables.runCount = 0;
            CTA_MainFrame:Show();
            CTA_SearchFrame:Hide();
            CTA_MoreFeaturesFrame:Show();
            --CTA_MyRaidFrame:Hide();
            --CTA_StartRaidFrame:Hide();
            CTA_SettingsFrame:Show();
            --CTA_GreyListFrame:Hide();
            --CTA_LogFrame:Hide();
        end
        aieCTA_SavedVariables.runCount = aieCTA_SavedVariables.runCount + 1;

        CTA_FrameTransparencySlider:SetValue( ( aieCTA_SavedVariables.MainFrameTransparency or 0.85 ) );
        CTA_MainFrame:SetAlpha( CTA_FrameTransparencySlider:GetValue() );

        CTA_MuteLFGChannelCheckButton:SetChecked( aieCTA_SavedVariables.muteLFGChannel );
        CTA_ShowOnMinimapCheckButton:SetChecked( aieCTA_SavedVariables.showOnMinimap );
        CTA_ShowFilteredMessagesInChatCheckButton:SetChecked( aieCTA_SavedVariables.showFilteredChat );
        CTA_PlaySoundOnNewResultCheckButton:SetChecked( aieCTA_SavedVariables.playSoundForNewResults );

        aieCTA_SavedVariables.FilterLevel = aieCTA_SavedVariables.FilterLevel or 4;
        if( not aieCTA_SavedVariables.version or aieCTA_SavedVariables.version < CTA_THIS_VERSION ) then
            CTA_MinimapMessageFrame2:AddMessage( CTA_RESETTING_LFX, 1, 1, 1 );
            CTA_LogMsg( CTA_RESETTING_LFX );
            aieCTA_SavedVariables.version = CTA_THIS_VERSION;
            aieCTA_SavedVariables.FilterLevel = 4;
            aieCTA_SavedVariables.messageList = {};
            --if( GetLocale() == "frFR" ) then
            --	aieCTA_SavedVariables.FilterLevel = 1;
            --end
        else
            aieCTA_SavedVariables.messageList = aieCTA_SavedVariables.messageList or {};
        end

        --aieCTA_SavedVariables.userChannelName = aieCTA_SavedVariables.userChannelName or CTA_MONITOR_CHANNEL_NAME;

        aieCTA_SavedVariables.messageList[GetRealmName()] = aieCTA_SavedVariables.messageList[GetRealmName()] or {};
        aieCTA_SavedVariables.messageList[GetRealmName()][1] = aieCTA_SavedVariables.messageList[GetRealmName()][1] or {};
        aieCTA_SavedVariables.messageList[GetRealmName()][2] = aieCTA_SavedVariables.messageList[GetRealmName()][2] or {};

		table.wipe(CTA_MessageList);

        if( (UnitFactionGroup("player")) == "Alliance" ) then
            CTA_IsAllianceFactionUser = 1;

			for k,v in pairs(aieCTA_SavedVariables.messageList[GetRealmName()][1]) do
				CTA_MessageList[k] = v
			end

            CTA_LogMsg( CTA_SHOWING_ALLIANCE_LFX );
        else
			for k,v in pairs(aieCTA_SavedVariables.messageList[GetRealmName()][2]) do
				CTA_MessageList[k] = v
			end

            CTA_LogMsg( CTA_SHOWING_HORDE_LFX );
        end

        aieCTA_SavedVariables.timeLastMsgAdded = aieCTA_SavedVariables.timeLastMsgAdded or 0;
        if( time() - aieCTA_SavedVariables.timeLastMsgAdded > 900 ) then
            CTA_MinimapMessageFrame2:AddMessage( CTA_CLEAR_OLD_MSGS, 1, 1, 1 );
            CTA_LogMsg( CTA_CLEAR_OLD_MSGS );
            table.wipe(CTA_MessageList);
        end

        CTA_FilterLevelSlider:SetValue( aieCTA_SavedVariables.FilterLevel );
        CTA_FilterLevelSliderNote:SetText( 	CTA_FilterLevelNotes[ aieCTA_SavedVariables.FilterLevel ] );

        aieCTA_SavedVariables.chatFrameNum = aieCTA_SavedVariables.chatFrameNum or 1;
        CTA_ChatFrameNumberEditBox:SetText( aieCTA_SavedVariables.chatFrameNum );

        CTAWM.onEventVariablesLoaded(event);


        CTA_UpdateGreyListItems();
        CTA_UpdateResults();
        CTA_Reload = nil;

        CTA_MinimapMessageFrame:AddMessage( CTA_CALL_TO_ARMS, 1, 0.85, 0 );
        CTA_LogMsg( CTA_CALL_TO_ARMS );
        --CTA_MinimapMessageFrame2:AddMessage( CTA_CALL_TO_ARMS_LOADED, 1, 1, 1 );
        --CTA_Println( CTA_CALL_TO_ARMS_LOADED );

end  -- end function CTA_InitWorld(self,event,...)


--[[	---------------------------------------------------------------
        Communication - System
        ---------------------------------------------------------------
--]]




--[[	CTA_JoinChannel()
        ---------------------------------------------------------------
        Attempts to join the <var>CTA_CommunicationChannel</var>
        channel.
--]]

function CTA_JoinChannel() -- NOT IN USE
    CTA_Util.joinChannel( CTA_CommunicationChannel );
end




--[[	CTA_ConnectedToChannel()
        ---------------------------------------------------------------
        Determines whether the client has joined the specified channel.
        @arg The name of the channel
        @return nil, 1 if already connected to the channel
--]]
--[[
function CTA_ConnectedToChannel( channel )  -- NOT IN USE
    local DefaultChannels = { GetChatWindowChannels(DEFAULT_CHAT_FRAME:GetID()) };
    local connected = nil;
    if( DefaultChannels ) then
        for item = 1, #DefaultChannels do
            CTA_LogMsg( DefaultChannels[item] );
            if( DefaultChannels[item] == channel ) then
                connected = 1;
                break;
            end
        end
    end
    return connected;
end
--]]




--[[	CTA_SendAutoMsg()
        ---------------------------------------------------------------
        Sends a chat message, by whisper, to the specified player.
        @arg The message to be sent
        @arg The recipient of the message
--]]

function CTA_SendAutoMsg( message, player )
    -- R11 B3
    --SendChatMessage( "* "..message, "WHISPER", nil, player );
    SendChatMessage( "[CTA] "..message, "WHISPER", nil, player );
end




--[[	CTA_SendChatMessage()
        ---------------------------------------------------------------
        Sends a chat message to the specified player or channel.
        @arg The message to be sent
        @arg The type of transmission eg. whisper, channel etc
        @arg The recipient player/channel of the message
--]]

function CTA_SendChatMessage( message, messageType, channel )
    local language = CTA_COMMON;
    if( UnitFactionGroup(CTA_PLAYER) ~= CTA_ALLIANCE ) then
        language = CTA_ORCISH;
    end
    --[ [
    if messageType == "CHANNEL" and type(channel)=="string" then
        local index = GetChannelName(channel)
        if (index~=0) then channel = index end
    end
    --	CTA_Util.chatPrintln( "Sent: "..message .. " to " .. channel);

    --]]
    --SendChatMessage( string.gsub( message, "|c(%w+)|H(%w+):(.+)|h(.+)|h|r", "%4" ), messageType, language, channel );
    ChatThrottleLib:SendChatMessage("NORMAL","CTA", string.gsub( message, "|c(%w+)|H(%w+):(.+)|h(.+)|h|r", "%4" ), messageType, language, channel );
end







--[[	---------------------------------------------------------------
        Invitations
        ---------------------------------------------------------------
--]]

--[[	CTA_SendPasswordRaidInvitationRequest()
        ---------------------------------------------------------------
        Sends a request with a pasword for an invitation
--]]

function CTA_SendPasswordRaidInvitationRequest()
    local raid = CTA_FilteredResultsList[ CTA_SelectedResultListItem ];
    local password = CTA_SafeSet( CTA_JoinRaidWindowEditBox:GetText(), "" );
    if( password ~= "" and raid.leader) then
        CTA_SendChatMessage( CTA_INVITE_MAGIC_WORD.." "..password, "WHISPER", raid.leader );
    else
    	DEFAULT_CHAT_FRAME:AddMessage(CTA_CANT_JOIN_SELF, 1.0, 0.0, 0.0);
    end
    CTA_JoinRaidWindow:Hide();
end




--[[	CTA_SendRaidInvitationRequest()
        ---------------------------------------------------------------
        Sends a request for an invitation
--]]

function CTA_SendRaidInvitationRequest() -- Called by XML
    local raid = CTA_FilteredResultsList[ CTA_SelectedResultListItem ];
    CTA_JoinRaidWindow:Hide();
    CTA_RequestInviteButton:Disable();

    if( raid.passwordProtected == 1 ) then
        CTA_JoinRaidWindow:Show();
    else
    	if( raid ) then
        	CTA_SendChatMessage( CTA_INVITE_MAGIC_WORD, "WHISPER", raid.author );
        end
    end
end




--[[	CTA_ReceiveRaidInvitationRequest()
        ---------------------------------------------------------------
        Handles incoming invitation requests.
        @arg The invitation request with optional password
        @arg The name pf the player requesting the invitation
--]]

function CTA_ReceiveRaidInvitationRequest( msg, author )
    if( CTA_InvitationRequests[author] ) then return; end -- cheap short-circuit hack
    CTA_LogMsg( CTA_RECEIVED_INVITATION_REQUEST..author );
    if( CTA_MyRaid.size + #CTA_InvitationRequests < CTA_MyRaid.maxSize ) then
        if( CTA_MyRaid.passwordProtected==1 ) then
            local password = string.gsub( string.sub( msg, 9 ), "%s*([^%s]+).*", "%1" );

            if( password and password==CTA_MyRaidPassword ) then
                CTA_AddRequest( author );
            else
                CTA_SendAutoMsg( CTA_INCORRECT_PASSWORD_MESSAGE, author);
            end
        else
           	CTA_AddRequest( author );
        end
    else
        CTA_SendAutoMsg( CTA_NO_SPACE_MESSAGE, author);
    end
end




--[[	CTA_AddRequest()
        ---------------------------------------------------------------
        Adds a player's request for an invitation to join the group.
        @arg The name of the player requesting an invitaion
--]]

function CTA_AddRequest( name )
    CTA_InvitationRequests[name] = {};
    CTA_InvitationRequests[name].status = 1;
    CTA_OutstandingRequests = CTA_OutstandingRequests + 1;
end




--[[	CTA_RemoveRequest()
        ---------------------------------------------------------------
        Removes a player's request for an invitation to join the group.
        @arg The name of the player requesting an invitaion
--]]

function CTA_RemoveRequest( name )
    if( CTA_InvitationRequests[name] ) then
        if( CTA_InvitationRequests[name].status == 1 ) then
            CTA_OutstandingRequests = CTA_OutstandingRequests - 1;
        end
        CTA_InvitationRequests[name] = nil;
    end
end



--[[	---------------------------------------------------------------
        Inter-AddOn Group Information Communication
        ---------------------------------------------------------------
--]]




--[[	CTA_BroadcastRaidInfo()
        ---------------------------------------------------------------
        Sends this group info to the CTA Channel.
--]]

function CTA_BroadcastRaidInfo()
    CTA_PollBroadcast = nil;

    if( CTA_MyRaidIsOnline == nil ) then return; end -- short circuit hack for push changeover in R5

    local myName = UnitName( CTA_PLAYER );
    local myRaid = CTA_MyRaid;
    --local com = CTA_GetGroupType()..": [CTA R3 Pre-release Test Group] "..myRaid.comment;
    local com = myRaid.comment.." ("..CTA_GetGroupType()..")";
    local typ = myRaid.pvtype;
    local siz = myRaid.size;
    local max = myRaid.maxSize;
    local min = myRaid.minLevel;
    local cla = myRaid.classes;
    local pro = myRaid.passwordProtected;
    local opt = myRaid.options;
    --local tim = myRaid.creationTime; ListChannelByName
    --local hour, minute = GetGameTime();
    --local tim = hour;
    --if( hour < 10 ) then tim = "0"..tim; end
    --if( minute < 10 ) then tim = tim.."0"; end
    --tim = tim..minute;
    local tim = CTA_GetGameTime();

    if( typ == CTA_RAID_TYPE_PVP ) then
        siz = siz + 40;
    end

    if( pro == 1 ) then
        max = max + 40;
    end

    while( string.len( cla ) < 4 ) do
        cla = "0"..cla;
    end

    while( string.len( siz ) < 2 ) do
        siz = "0"..siz;
    end
    while( string.len( max ) < 2 ) do
        max = "0"..max;
    end
    while( string.len( min ) < 2 ) do
        min = "0"..min;
    end

    local code = ""..tim..cla..siz..max..min;
    --
    if string.find( com, ":") then com = string.gsub(com, ":", "."); end;

    CTA_SendChatMessage("/cta A<"..code..":"..com..":"..opt..">", "CHANNEL", GetChannelName( CTA_CommunicationChannel ) ); -- MARKER
    --CTA_LogMsg( "CTA Raid Broadcast: /cta A<"..code..":"..com..":"..opt..">");
    --CTA_IconMsg( "Broadcast Sent" );
end






--[[	---------------------------------------------------------------
        Functions Related To The Search Frame And The Group List
        ---------------------------------------------------------------
--]]




--[[	CTA_ApplyFiltersToGroupList()
        ---------------------------------------------------------------
        Applies filter settings to the group list and
        updates the score for each one. This score will be used by the
        <func>CTA_UpdateList()</func> function to refresh the results
        list with those groups with a score of at least 1.
        Called by CTA_SearchButton, will be renamed to ApplyFilters()
        or something to that effect.
--]]


function CTA_ApplyFiltersToGroupList()

    local keywords = CTA_UI.getString( CTA_SearchFrameDescriptionEditBox, "*" );
    local playerClass = CTA_UI.getString( CTA_PlayerClassDropDownText, CTA_ANY_CLASS );
    local playerMinLevel = CTA_UI.getNumber( CTA_PlayerMinLevelEditBox,  0, 1, 85 );
    local playerMaxLevel = CTA_UI.getNumber( CTA_PlayerMaxLevelEditBox, 85, 1, 85 );


    CTA_RequestInviteButton:Disable();
    CTA_ResultsListOffset = 0;
    CTA_SelectedResultListItem = 0;

    local oldListSize = 0;
    if( CTA_FilteredResultsList ) then
        oldListSize = #CTA_FilteredResultsList;
    end


    CTA_FilteredResultsList = {};

    local chr, cmn = GetGameTime();
    cmn = cmn + 1;
    local pruneCount = 0;
    local newResult = nil;
    --local dmn = time() - aieCTA_SavedVariables.messageList[i].time;

    -- R11B4
    local entryToShowInChatAndOrMinimap = nil;
    --
    --CTA_Util.logPrintln( "#msglist = "..#CTA_MessageList );
    for i=1, #CTA_MessageList  do
        local data = CTA_MessageList[i];
        if( data ) then

            local ok = 1;
            local dhr = chr - tonumber( string.sub( data.time,  1,  2 ) ) or 0; -- added: beta 4 hack re: beta 3 reported error
            local dmn = cmn - tonumber( string.sub( data.time,  3,  4 ) ) or 0; -- added: beta 4 hack re: beta 3 reported error

            if( dhr ~= 0 ) then
                dmn = dmn + 60;
            end
            -- R11 B7: small hack to fix negative time bug
            if( dmn < 0 ) then
                dmn = 999;
            end

            --[[
            playerClass = CTA_PlayerClassDropDownText:GetText() or CTA_ANY_CLASS;
            if( strlen(CTA_PlayerMinLevelEditBox:GetText()) == 0 ) then
                playerMinLevel = 1;
            else
                playerMinLevel = tonumber( CTA_PlayerMinLevelEditBox:GetText() );
            end
            if( strlen(CTA_PlayerMaxLevelEditBox:GetText()) == 0 ) then
                playerMaxLevel = 80;
            else
                playerMaxLevel = tonumber( CTA_PlayerMaxLevelEditBox:GetText() );
            end
            --]]

            if( data.ctaType == "A" ) then

                if( dmn > 2 ) then
                    table.remove( CTA_MessageList , i );
                    pruneCount = pruneCount + 1;
                    ok = nil;
                    i = i - 1;
                end

                --if( ok and showClasses > 0 and CTA_CheckClasses( data.classes, showClasses ) == 0 ) then ok = nil; end
                --if( ok and showEmpty == 0 and data.size <= 1 ) then ok = nil; end
                --if( ok and showFull == 0 and data.size == data.maxSize ) then ok = nil; end
                --if( ok and showPVP == 0 and data.pvtype == CTA_RAID_TYPE_PVP ) then ok = nil; end
                --if( ok and showPVE == 0 and data.pvtype == CTA_RAID_TYPE_PVE ) then ok = nil; end
                --if( ok and showProtected == 0 and CTA_MyRaidPassword ) then ok = nil; end
                --if( ok and showMinLevel < data.minLevel ) then ok = nil; end
                if ( CTA_SearchDropDownText:GetText() == CTA_SHOW_PLAYERS_ONLY ) then ok = nil; end

            elseif( data.ctaType == "B" ) then

                if( dmn > 2 ) then
                    table.remove( CTA_MessageList , i );
                    pruneCount = pruneCount + 1;
                    ok = nil;
                    i = i - 1;
                end
                if ( CTA_SearchDropDownText:GetText() == CTA_SHOW_GROUPS_ONLY ) then ok = nil; end

                if ( data.who and data.who.level ~= 0 ) then
                    if( playerClass ~= CTA_ANY_CLASS and data.who.class ~= playerClass ) then ok = nil; end
                    if( data.who.level < playerMinLevel or data.who.level > playerMaxLevel ) then ok = nil; end
                elseif( playerClass ~= CTA_ANY_CLASS or playerMinLevel > 0 or playerMaxLevel < 85 ) then
                    ok = nil;
                end

            elseif( data.ctaType == "C" ) then

                if( dmn > 16 ) then
                    table.remove( CTA_MessageList , i );
                    pruneCount = pruneCount + 1;
                    ok = nil;
                    i = i - 1;
                end
                if ( CTA_SearchDropDownText:GetText() == CTA_SHOW_PLAYERS_ONLY ) then ok = nil; end
                if ( data.who and data.who.level ~= 0 ) then
                    if( playerClass ~= CTA_ANY_CLASS and data.who.class ~= playerClass ) then ok = nil; end
                    if( data.who.level < playerMinLevel or data.who.level > playerMaxLevel ) then ok = nil; end
                elseif( playerClass ~= CTA_ANY_CLASS or playerMinLevel > 0 or playerMaxLevel < 85 ) then
                    ok = nil;
                end

            elseif( data.ctaType == "D" ) then

                if( dmn > 16 ) then
                    table.remove( CTA_MessageList , i );
                    pruneCount = pruneCount + 1;
                    ok = nil;
                    i = i - 1;
                end
                if ( CTA_SearchDropDownText:GetText() == CTA_SHOW_GROUPS_ONLY ) then ok = nil; end
                if ( data.who and data.who.level ~= 0 ) then
                    if( playerClass ~= CTA_ANY_CLASS and data.who.class ~= playerClass ) then ok = nil; end
                    if( data.who.level < playerMinLevel or data.who.level > playerMaxLevel ) then ok = nil; end
                elseif( playerClass ~= CTA_ANY_CLASS or playerMinLevel > 0 or playerMaxLevel < 85 ) then
                    ok = nil;
                end

            end

            if( ok ) then
                local score = 1;
                if( keywords and keywords~="*" ) then
                    score = CTA_Util.search( data.message, keywords ); --SachaSearch( data.author.." "..data.message, keywords );
                end
                if( score > 0 ) then
                    data.elapsed = dmn;
                    table.insert( CTA_FilteredResultsList, data );

                    -- R11B4
                    if( data.who and data.who.level ~= 0 ) then
                        if( data.shownInChatAndOrMinimap == nil ) then
                            entryToShowInChatAndOrMinimap = data;
                        end
                    end
                    --
                end
            end

        end
    end

    --if( pruneCount > 0 ) then
        --CTA_LogMsg( CTA_REMOVED_OLD_RESULT_ITEMS[1]..pruneCount..CTA_REMOVED_OLD_RESULT_ITEMS[2] );	-- "Removed n old result items" message
    --end

    if ( oldListSize < #CTA_FilteredResultsList and aieCTA_SavedVariables.playSoundForNewResults ) then
        PlaySoundFile( "Sound\\Interface\\PickUp\\PutDownRing.wav" );
    end

    -- R11B4
    if( entryToShowInChatAndOrMinimap ) then
        local entry = entryToShowInChatAndOrMinimap;
        local author = entry.op or entry.author;
        local msghex = "bbffbb";
        if( entry.ctaType == "C" ) then
            msghex = "bbbbff";
        end

        if( aieCTA_SavedVariables.showFilteredChat ) then
            entry.shownInChatAndOrMinimap = 1;
            local fnum = 1;
            if( ( CTA_ChatFrameNumberEditBox:GetText() or "" ) ~= "" ) then
                fnum = tonumber( CTA_ChatFrameNumberEditBox:GetText() );
            end
            local frame = getglobal( "ChatFrame"..fnum );
            if( frame ) then
                aieCTA_SavedVariables.chatFrameNum = fnum;
                frame:AddMessage( "[|cff".. ( CTA_ClassColors[entry.who.class] or "ffffff" ).."|Hplayer:"..author.."|h"..author.. ", "..entry.who.level.." " .. entry.who.class .. "|h|r]: |cff"..msghex..entry.message.. "|r", 1, 0.8, 0 );
            else
                DEFAULT_CHAT_FRAME:AddMessage( "[|cff".. ( CTA_ClassColors[entry.who.class] or "ffffff" ).."|Hplayer:"..author.."|h"..author.. ", "..entry.who.level.." " .. entry.who.class .. "|h|r]: |cff"..msghex..entry.message.. "|r", 1, 0.8, 0 );
            end
        end

        if( aieCTA_SavedVariables.showOnMinimap ) then
            entry.shownInChatAndOrMinimap = 2;
            CTA_MinimapMessageFrame:AddMessage( "|cff".. ( CTA_ClassColors[entry.who.class] or "ffffff" ).."|Hplayer:"..author.."|h "..author.. ", "..entry.who.level.." " .. entry.who.class .. "|h|r", 1, 0.8, 0 );
            CTA_MinimapMessageFrame2:AddMessage( "|cff"..msghex..entry.message.. "|r", 1, 0.8, 0 );
        end
    end
    --

    CTA_PollApplyFilters = nil;
    CTA_UpdateResults();
end




--[[	CTA_UpdateResults()								UPDATE FUNCTION
        ---------------------------------------------------------------
        Updates the groups results list to show only those
        groups with a score of at least 1.
        Also updates the selected group as necessary.
--]]


function CTA_UpdateResults()
    local index = 1;
    local groupListLength = #CTA_FilteredResultsList;


    if( groupListLength ~= 0 ) then
        CTA_MinimapIconTextLabel:SetText( groupListLength );
        CTA_MinimapIconTextLabel:Show();
    else
        CTA_MinimapIconTextLabel:Hide();
    end

    if( groupListLength ~= 1 ) then
        CTA_ResultsLabel:SetText( CTA_RESULTS_FOUND.." "..groupListLength.." / "..#CTA_MessageList );
    else
        CTA_ResultsLabel:SetText( CTA_RESULTS_FOUND.." "..groupListLength );
    end


    CTA_PageLabel:Show();

    local cpage = floor( CTA_ResultsListOffset / CTA_MAX_RESULTS_ITEMS );
    local tpage = floor( groupListLength / CTA_MAX_RESULTS_ITEMS );
    if( cpage == 0 or cpage <= CTA_ResultsListOffset / CTA_MAX_RESULTS_ITEMS ) then cpage = cpage + 1; end
    if( tpage == 0 or tpage < groupListLength / CTA_MAX_RESULTS_ITEMS ) then tpage = tpage + 1; end
    CTA_PageLabel:SetText( CTA_PAGE.." "..cpage.." / "..tpage );


    while( index < CTA_MAX_RESULTS_ITEMS + 1 ) do
        local c = "CTA_NewItem"..index;
        local isguildie = false;
        if( _G[c] ) then
            if( index+CTA_ResultsListOffset <= groupListLength ) then
                local entry = CTA_FilteredResultsList[index+CTA_ResultsListOffset];

                -- The text colour
                if( entry.ctaType== "A" or entry.ctaType== "C" ) then
                    _G[c.."NameLabel"]:SetTextColor( 0.75, 0.75, 1, 1 );
                    --getglobal( c.."TextureGold"):Show();
                    --getglobal( c.."TextureSilver"):Hide();
                else
                    _G[c.."NameLabel"]:SetTextColor( 0.75, 1, 0.75, 1 );
                    --getglobal( c.."TextureGold"):Hide();
                    --getglobal( c.."TextureSilver"):Show();
                end

                -- get elapsed time
                local timeText = "";
                if( entry.elapsed ) then
                    timeText = entry.elapsed.." min";
                    if( entry.elapsed > 1 ) then timeText = timeText.."s"; end
                else
                    timeText = entry.time;
                end

                local mainText = "";
                local moreText = "";
                local rightText = timeText..CTA_TIME_AGO;

                if( entry.ctaType== "A" ) then

                    local typeText = CTA_PVP;
                    local passwordText = CTA_NO;
                    if( entry.pvtype == CTA_RAID_TYPE_PVE ) then typeText = CTA_PVE; end
                    if( entry.passwordProtected == 1 ) then passwordText = CTA_YES; end
                    local myClass = UnitClass( CTA_PLAYER );
                    local comment = entry.message;
                    if( entry.minLevel > UnitLevel(CTA_PLAYER) or not string.find(CTA_GetClassString(entry.classes),myClass)  ) then
                        comment = "|cffff0000"..comment.."|r";
                    elseif( entry.passwordProtected == 1 ) then
                        comment = "|cffffff00"..comment.."|r";
                    else
                        comment = "|cff00ff00"..comment.."|r";
                    end
                    mainText = entry.author..": "..comment;
                    moreText = CTA_MORE_TEXT[1]..typeText..CTA_MORE_TEXT[2]..entry.size.."/"..entry.maxSize..CTA_MORE_TEXT[3]..entry.minLevel..CTA_MORE_TEXT[4]..passwordText;
                    rightText = CTA_GROUP_LAST_UPDATE.. rightText;
                elseif( entry.ctaType== "B" ) then

                    mainText = entry.author..": "..entry.message;
                    if (entry.who == nil) then
                        mainText = "|cffffffff"..entry.author.."|r: "..entry.message;
                    else
                        mainText = "|cff".. ( CTA_ClassColors[entry.who.class] or "ffffff" ) ..entry.author.."|r: "..entry.message;
                    end
                    if( entry.who and entry.who.level ~= 0 ) then
                        if( entry.who.guild == "<>" ) then
                            moreText = "Level "..entry.who.level.." "..entry.who.class;
                        else
                            if (entry.who.guild == CTA_myguild) then
                                isguildie = true;
                                mainText = "|cff".. ( CTA_ClassColors[entry.who.class] or "ffffff" ) ..entry.author.."|r: |cff33ff33"..entry.message.."|r";
                            end
                            moreText = "Level "..entry.who.level.." "..entry.who.class..", "..entry.who.guild;
                        end
                        --[[
                        if( entry.grouped == "yes" ) then
                            moreText = moreText.." - In a group at time of message ";
                        else
                            moreText = moreText.." (not in a group)";
                        end
                        ]]
                    end
--			rightText = "forwarded by "..entry.author.." "..rightText;
                rightText = CTA_PLAYER_LAST_UPDATE.. rightText;

                elseif( entry.ctaType== "C" ) then

                    mainText = entry.op..": "..entry.message;
                    if( entry.who and entry.who.level ~= 0 ) then
                        if( entry.who.guild == "<>" ) then
                            moreText = "Level "..entry.who.level.." "..entry.who.class;
                        else
                            moreText = "Level "..entry.who.level.." "..entry.who.class..", "..entry.who.guild;
                            if (entry.who.guild == CTA_myguild) then
                                isguildie = true
                            end
                        end
                        if (isguildie) then
                            mainText = "|cff".. ( CTA_ClassColors[entry.who.class] or "ffffff" ) ..entry.op.."|r: |cff33ff33"..entry.message.."|r";
                        else
                            mainText = "|cff".. ( CTA_ClassColors[entry.who.class] or "ffffff" ) ..entry.op.."|r: "..entry.message;
                        end
                    end
                    if entry.author == UnitName("player") or strlen(entry.author) <= 1 then
                    rightText = CTA_TIME_LEFT..rightText;
          else
                rightText = "Forwarded by "..entry.author.." "..rightText;
          end

                elseif( entry.ctaType== "D" or entry.ctaType== "U"  ) then
                    mainText = entry.op..": "..entry.message;
                    if( entry.who and entry.who.level ~= 0 ) then
                        if( entry.who.guild == "<>" ) then
                            moreText = "Level "..entry.who.level.." "..entry.who.class;
                        else
                            moreText = "Level "..entry.who.level.." "..entry.who.class..", "..entry.who.guild;
                            if (entry.who.guild == CTA_myguild) then
                                isguildie = true
                            end
                        end
                        if (isguildie) then
                            mainText = "|cff".. ( CTA_ClassColors[entry.who.class] or "ffffff" )..entry.op.."|r: |cff33ff33"..entry.message.."|r";
                        else
                            mainText = "|cff".. ( CTA_ClassColors[entry.who.class] or "ffffff" )..entry.op.."|r: "..entry.message;
                        end
                    end

                    if entry.author == UnitName("player") or strlen(entry.author) <= 1 then
                    rightText = CTA_TIME_LEFT..rightText;
          else
            rightText = "Forwarded by "..entry.author.." "..rightText;
          end
                end



                -- Set the texts
                _G[ c.."NameLabel"]:SetText( mainText );
                _G[ c.."MoreLabel"]:SetText( moreText );
                _G[ c.."MoreRightLabel"]:SetText( rightText );

                if( CTA_SelectedResultListItem == index + CTA_ResultsListOffset ) then
                    _G[c.."TextureSelected"]:Show();
                else
                    _G[c.."TextureSelected"]:Hide();
                end

                _G[c]:Show();
            else
                _G[c]:Hide();
            end
        end
        index = index + 1;
    end
end



--[[	CTA_ListItem_OnMouseUp()
        ---------------------------------------------------------------
        Sets the caller item as the selected group and updates the
        <ui>CTA_RequestInviteButton</ui> button as necessary, then
        calls the <func>CTA_UpdateResults()</func> afterwards.
--]]

function CTA_ListItem_OnMouseUp(self, button) -- Called by XML
    local value = string.gsub( self:GetName(), "CTA_NewItem(%d+)", "%1" );
    if( CTA_SelectedResultListItem == CTA_ResultsListOffset + value ) then
        CTA_SelectedResultListItem = 0;
        CTA_RequestInviteButton:Disable();
    else
        CTA_SelectedResultListItem = CTA_ResultsListOffset + value;

        local raid = CTA_FilteredResultsList[ CTA_ResultsListOffset + value ];

        -- R7
        if (button == "RightButton") then
            local name = raid.op or raid.author;
            --FriendsFrame_ShowDropdown(name, 1);

            HideDropDownMenu(1);
            if ( name ~= UnitName("player") ) then
                FriendsDropDown.initialize = FriendsFrameDropDown_Initialize;
                FriendsDropDown.displayMode = "MENU";
                FriendsDropDown.name = name;
                ToggleDropDownMenu(1, nil, FriendsDropDown, self:GetName());
            end

            return;
        end
        -- /R7

        if( raid.ctaType == "A" ) then -- for R7 goodness

            local myClass = UnitClass( CTA_PLAYER );
            if( raid.minLevel > UnitLevel (CTA_PLAYER ) or not string.find( CTA_GetClassString( raid.classes ),myClass ) ) then
                CTA_RequestInviteButton:Disable();
            else
                CTA_RequestInviteButton:Enable();
            end
        end
    end
    CTA_UpdateResults();
end




--[[	CTA_ListItem_ShowTooltip()
        ---------------------------------------------------------------
        Set up and show the tooltip for the calling group list item.
--]]

function CTA_ListItemAuxLeft_ShowTooltip(self) -- Called by XML
    GameTooltip:ClearLines();
    local parent = self:GetParent();
    local value = CTA_ResultsListOffset + string.gsub( parent:GetName(), "CTA_NewItem(%d+)", "%1" );

    local entry = CTA_FilteredResultsList[value];
    GameTooltip:SetOwner( self, "ANCHOR_BOTTOMLEFT" );
    GameTooltip:ClearAllPoints();
    GameTooltip:SetPoint("BOTTOMLEFT", parent:GetName(), "TOPLEFT", 0, 8);

    if( entry == nil ) then return; end

    GameTooltip:AddLine( ( entry.op or entry.author ) );
    GameTooltip:AddLine( entry.message, 0.9, 0.9, 1.0, 1, 1 );
    --GameTooltip:AddLine( entry.elapsed or "0", 1, 0.85, 0, 1, 1 );
    GameTooltip:AddLine( entry.ctaType or "-", 1, 0.85, 0, 1, 1 );
    GameTooltip:Show();
end


function CTA_ListItemAuxRight_ShowTooltip(self)

    local parent = self:GetParent();

    GameTooltip:ClearLines();
    local value = CTA_ResultsListOffset + string.gsub( parent:GetName(), "CTA_NewItem(%d+)", "%1" );

    local raid = CTA_FilteredResultsList[value];
    GameTooltip:SetOwner( self, "ANCHOR_BOTTOMRIGHT" );
    GameTooltip:ClearAllPoints();
    GameTooltip:SetPoint("BOTTOMRIGHT", parent:GetName(), "TOPRIGHT", 0, 8);

    if( raid == nil ) then return; end

    if( raid.ctaType == "A" ) then -- R7 condition

        local classes = { };
        classes[1] = CTA_PRIEST;
        classes[2] = CTA_MAGE;
        classes[3] = CTA_WARLOCK;
        classes[4] = CTA_DRUID;
        classes[5] = CTA_HUNTER;
        classes[6] = CTA_ROGUE;
        classes[7] = CTA_WARRIOR;
        classes[8] = CTA_PALADIN;
        classes[9] = CTA_SHAMAN;
        classes[10] = CTA_DEATHKNIGHT;

        local groupClasses, ctaVersion, ctaExtra = CTA_DecodeGroupClasses( raid.options );
        if( groupClasses and ctaVersion ) then
            GameTooltip:AddLine( CTA_CTA_GROUP, 0.1, 0.9, 0.1, 1, 1 );
            GameTooltip:AddLine( CTA_CURRENT_GROUP_CLASSES..":", 0.1, 0.9, 0.1, 1, 1 );
            local classList = CTA_GetClassString(raid.classes);
            for i = 1, CTA_NUM_CLASSES do
                if( string.find(classList, classes[i]) ) then
                    -- Class from table classes is a valid class to choose from
                    GameTooltip:AddDoubleLine( classes[i], groupClasses[i], 0.9, 0.9, 0.1, 0.1, 0.9, 0.1 );
                else
                	-- Class from table classes is an invalid class to choose from. BUGGED
                    GameTooltip:AddDoubleLine( classes[i], groupClasses[i], 0.9, 0.9, 0.1, 0.9, 0.1, 0.1 );
                end
            end
            if ctaExtra[1] and string.len(ctaExtra[1]) == 1 and string.find(ctaExtra[1], "[1234]") then
                local RPLevel = ctaExtra[1] + 0
                GameTooltip:AddDoubleLine( CTA_ROLEPLAY, CTA_RPLEVEL[RPLevel], 0.9, 0.9, 0.9, 0.1, 0.9, 0.1 );
            end
            GameTooltip:AddDoubleLine( CTA_VERSION, ctaVersion, 0.9, 0.9, 0.9, 0.1, 0.9, 0.1 );
        else
            if( raid.classes == (2^CTA_NUM_CLASSES - 1) ) then
                GameTooltip:AddLine( CTA_LFM_ANY_CLASS, 0.1, 0.9, 0.1 );
            else
                local myClass = UnitClass( CTA_PLAYER );
                local classList = CTA_GetClassString(raid.classes);

                if( string.find(classList, myClass) ) then
                    GameTooltip:AddLine( CTA_LFM_CLASSLIST..classList, 0.1, 0.9, 0.1 );
                else
                    if( not classList or classList == "" ) then
                        GameTooltip:AddLine( CTA_NO_MORE_PLAYERS_NEEDED, 0.9, 0.1, 0.1 );
                    else
                        GameTooltip:AddLine( CTA_LFM_CLASSLIST..classList, 0.9, 0.1, 0.1 );
                    end
                end
            end
            GameTooltip:AddLine( CTA_PRE_R7_USER, 0.3, 0.3, 0.3, 1, 1 );
        end

    elseif( raid.ctaType == "B" ) then -- R7 condition

        GameTooltip:AddLine( CTA_CTA_PLAYER, 0.1, 0.9, 0.1, 1, 1 );
        GameTooltip:AddDoubleLine( CTA_VERSION, raid.options, 0.9, 0.9, 0.9, 0.1, 0.9, 0.1 );

    elseif( raid.ctaType == "C" ) then -- R7 condition

        -- GameTooltip:AddLine( CTA_NON_CTA_GROUP_MESSAGE, 0.3, 0.3, 0.3, 1, 1 ); -- R10E
        GameTooltip:AddDoubleLine( raid.op, CTA_NON_CTA_GROUP_MESSAGE, 0.9, 0.9, 0.9, 0.9, 0.9, 0.0 )
        GameTooltip:AddLine( CTA_FULL_MESSAGE, 0.9, 0.9, 0.9, 1, 1 )
        GameTooltip:AddLine( raid.message, 0.3, 0.9, 0.3, 1, 1 )

    elseif( raid.ctaType == "D" ) then -- R7 condition

        -- GameTooltip:AddLine( CTA_NON_CTA_PLAYER_MESSAGE, 0.3, 0.3, 0.3, 1, 1 ); -- R10E
        GameTooltip:AddDoubleLine( raid.op, CTA_NON_CTA_PLAYER_MESSAGE, 0.9, 0.9, 0.9, 0.9, 0.9, 0.0 )
        GameTooltip:AddLine( CTA_FULL_MESSAGE, 0.9, 0.9, 0.9, 1, 1 )
        GameTooltip:AddLine( raid.message, 0.3, 0.9, 0.3, 1, 1 )

    end

    GameTooltip:Show();
end

function CTA_ResultItem_Hover_On(parent) -- Called by XML
    local value = CTA_ResultsListOffset + string.gsub( parent:GetName(), "CTA_NewItem(%d+)", "%1" );
    local entry = CTA_FilteredResultsList[value];
    if( entry == nil ) then return; end

    parent:SetHeight( 32 );
    _G[parent:GetName().."MoreLabel"]:Show();
    _G[parent:GetName().."MoreRightLabel"]:Show();
    if( entry.ctaType== "A" or entry.ctaType== "B" ) then
        _G[parent:GetName().."TexturePurple"]:Show();
        _G[parent:GetName().."TextureBlue"]:Hide();
    else
        _G[parent:GetName().."TexturePurple"]:Hide();
        _G[parent:GetName().."TextureBlue"]:Show();
    end

    if( entry.ctaType== "A" ) then
        _G[parent:GetName().."TextureSelectedIcon"]:SetTexture( "Interface\\Icons\\Spell_Holy_SealOfFury" );
    elseif( entry.ctaType== "B" ) then
        _G[parent:GetName().."TextureSelectedIcon"]:SetTexture( "Interface\\Icons\\Spell_Holy_RetributionAura" );
    elseif( entry.ctaType== "C" ) then
        _G[parent:GetName().."TextureSelectedIcon"]:SetTexture( "Interface\\Icons\\Spell_Holy_SealOfProtection" );
    elseif( entry.ctaType== "D" ) then
        _G[parent:GetName().."TextureSelectedIcon"]:SetTexture( "Interface\\Icons\\Spell_Holy_RighteousnessAura" );
    end

    _G[parent:GetName().."NameLabel"]:SetPoint( "TOPLEFT", parent:GetName(), "TOPLEFT", 37, 0 );
    _G[parent:GetName().."MoreLabel"]:SetPoint( "LEFT", parent:GetName(), "LEFT", 37, -6 );

    _G[parent:GetName().."TextureSelectedBg"]:Show();
    _G[parent:GetName().."TextureSelectedIcon"]:Show();

end

function CTA_ResultItem_Hover_Off(parent) -- Called by XML
    parent:SetHeight( 18 );
    _G[parent:GetName().."MoreLabel"]:Hide();
    _G[parent:GetName().."MoreRightLabel"]:Hide();
    _G[parent:GetName().."TexturePurple"]:Hide();
    _G[parent:GetName().."TextureBlue"]:Hide();

    _G[parent:GetName().."NameLabel"]:SetPoint( "TOPLEFT", parent:GetName(), "TOPLEFT", 5, 0 );
    _G[parent:GetName().."MoreLabel"]:SetPoint( "LEFT", parent:GetName(), "LEFT", 5, -6 );

    _G[parent:GetName().."TextureSelectedBg"]:Hide();
    _G[parent:GetName().."TextureSelectedIcon"]:Hide();

end






--[[	---------------------------------------------------------------
        Functions Related To Hosting A Group And The Acid Items
        ---------------------------------------------------------------
--]]




--[[	CTA_MyRaidInstantUpdate()						UPDATE FUNCTION
        ---------------------------------------------------------------
        Called by CTA_MyRaidFrame Components.
        This is the longest, most elaborate and buggy function and has
        been hacked and updated far too many times.
        Todo: A complete rewrite of the function.
--]]

function CTA_MyRaidInstantUpdate()
    if( CTA_MyRaid == nil ) then return; end

    local myName = UnitName( CTA_PLAYER );

    local myComment = CTA_SafeSet( CTA_MyRaidFrameDescriptionEditBox:GetText(), CTA_NO_DESCRIPTION ); -- MARKER UPDATE NOT COMING OFTEN ENOUGH

    local myRaidType = CTA_RAID_TYPE_PVE;
    if( CTA_MyRaidFramePVPCheckButton:GetChecked() ) then
        myRaidType = CTA_RAID_TYPE_PVP;
    end

        -- Advanced Class Integration and Distribution
        -- ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID
        -- ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID

--[[	------------------------------------
        [Setup Acid Items]

        If the acid item has no class list
        then it is hidden.
        ------------------------------------
--			]]
    if( not CTA_Acid0.val ) then
        local classes = { };
        classes[1] = CTA_PRIEST;
        classes[2] = CTA_MAGE;
        classes[3] = CTA_WARLOCK;
        classes[4] = CTA_DRUID;
        classes[5] = CTA_HUNTER;
        classes[6] = CTA_ROGUE;
        classes[7] = CTA_WARRIOR;
        classes[8] = CTA_PALADIN;
        classes[9] = CTA_SHAMAN;
        classes[10] = CTA_DEATHKNIGHT;

        local num = 0;
        while( num <= CTA_NUM_CLASSES) do

            local item = _G["CTA_Acid"..num];
            local class = _G["CTA_Acid"..num.."ClassNameLabel"];

            if( num > 0 ) then
                item.val = 0;
                item.cur = 0;
            else
                class:SetText( CTA_ANY_CLASS );
                item.val = CTA_MyRaid.maxSize;
                _G["CTA_Acid"..num.."LessButton"]:Hide();
                _G["CTA_Acid"..num.."MoreButton"]:Hide();
                --_G["CTA_Acid"..num.."EditButton"]:Hide();
                _G["CTA_Acid"..num.."DeleteButton"]:Hide();
            end

            num = num + 1;
        end
    end


--[[	------------------------------------
        [Update the Max Size]

        If the and sets up certain features
        for raid / party
        ------------------------------------
--]]

    local myOldMax = CTA_MyRaid.maxSize;
    if( not myOldMax ) then myOldMax = 40; end

    if ( IsRaidLeader() and GetNumRaidMembers() > 1 ) then CTA_HostingRaidGroup = 1; end
    local minSizeLimit = 2
    local maxSizeLimit = 5;	           					-- R2
    CTA_ConvertToRaidButton:Hide();
    CTA_MaxSizeHelpLabel:SetText( CTA_MAXIMUM_PLAYERS_HELP2 );
    if( IsPartyLeader() and GetNumRaidMembers() == 0  ) then
        CTA_ConvertToRaidButton:Show();
    else
        CTA_ConvertToRaidButton:Hide();
    end
    if( CTA_HostingRaidGroup ) then
        maxSizeLimit = 40;
        minSizeLimit = 6
        CTA_MaxSizeHelpLabel:SetText( CTA_MAXIMUM_PLAYERS_HELP );
    end
    if( IsRaidLeader() and GetNumRaidMembers() > 0 and GetNumRaidMembers() < 6 ) then
        CTA_ConvertToPartyButton:Show();
    else
        CTA_ConvertToPartyButton:Hide();
    end

    if( CTA_MyRaid.maxSize > maxSizeLimit ) then
        CTA_MyRaid.maxSize = maxSizeLimit;
    end

    local myMaxSize = CTA_SafeSetNumber( CTA_MyRaidFrameMaxSizeEditBox:GetText(), minSizeLimit, maxSizeLimit );
    if( not myMaxSize ) then
        myMaxSize = CTA_MyRaid.maxSize;
    else
        CTA_MyRaid.maxSize = tonumber(myMaxSize);
    end
    CTA_MyRaidFrameMaxSizeEditBox:SetText(""..myMaxSize);


--[[	------------------------------------
        [Update ACID Scale]

        According to the max size
        ------------------------------------
--]]

    --if( myMaxSize ~= myOldMax ) then
        local num = 0;
        local cval = 0;
        while( num <= CTA_NUM_CLASSES ) do
            local item = _G["CTA_Acid"..num];
            local ratio = item.val/myOldMax;
            item.val = floor(myMaxSize*ratio);
            cval = cval+item.val;
            num = num + 1;
        end
        if( cval < myMaxSize ) then
            CTA_Acid0.val = CTA_Acid0.val + (myMaxSize-cval);
        end
        num = 0;
        while( num <= CTA_NUM_CLASSES and cval > myMaxSize ) do
            local item = _G["CTA_Acid"..num];
            if( item.val > 0 ) then
                item.val = item.val - 1;
                cval = cval - 1;
            else
                num = num + 1;
            end
        end
    --end
    --CTA_LogMsg( "Adjusted ACID Size ("..cval..")", CTA_GENERAL );


--[[	------------------------------------
        [Reset Acid item current size]

        Set the current players in each rule
        to 0
        ------------------------------------
--]]


    local num = 0;
    while( num <= CTA_NUM_CLASSES ) do
        local item = _G["CTA_Acid"..num];
        item.cur = 0;
        num = num + 1;
    end


--[[	------------------------------------
        [Update ACID items current size]

        Big change here now
        ------------------------------------
--]]


    local name, level, class;
    local over = 0;
    num = 1;
    while ( num <= 40 ) do
        name, level, class = CTA_GetGroupMemberInfo( num );
        if( name == nil ) then break; end
        local index = CTA_GetClassCode(class);

        local bestItem = nil;
        for i = 1, CTA_NUM_CLASSES do
            local item = _G["CTA_Acid"..i];
            if( item.classes and item.classes[class] ) then
                if( not bestItem or #bestItem.classes > #item.classes ) then
                    if( item.cur < item.val ) then
                        bestItem = item;
                    end
                end
            end
        end

        if( not bestItem ) then
            over = over + 1;
        else
            bestItem.cur = bestItem.cur + 1;
        end
        --if( item.cur > item.val ) then over = over + 1; end

        if( CTA_InvitationRequests[name] ) then
            CTA_RemoveRequest( name ); -- R2: Remove pending member if in raid
            CTA_LogMsg( name..CTA_JOINED_GROUP_REQUEST_REMOVED );
            CTA_SendAutoMsg( CTA_PROMO..CTA_ANNOUNCE_JOIN_PROMPT, name );
        end

        num = num+1;
    end


--[[	------------------------------------
        [Update the Group Size]

        Take pendings into account etc
        ------------------------------------
--]]


    local pendingSize = 0;
    for name, data in pairs(CTA_InvitationRequests) do
        if( name and data.status == 2 ) then 	-- R2: pending members
            --CTA_Println( name..": "..class );
            local index = CTA_GetClassCode( data.class);
            local item = _G["CTA_Acid"..index];
            item.cur = item.cur + 1;
            pendingSize = pendingSize + 1;
            if( item.cur > item.val ) then over = over + 1; end
        end
    end

    CTA_Acid0.cur = over;

    --[[
    local oldSize = CTA_MyRaid.size;
    CTA_MyRaid.size = CTA_GetNumGroupMembers() + pendingSize;
    local mySize = CTA_MyRaid.size;

    if ( ( IsRaidLeader() and GetNumRaidMembers() > 0 ) ) then
        CTA_RaidSizeLabel:SetText( CTA_SIZE..": "..CTA_MyRaid.size.." ("..CTA_RAID..") ("..CTA_CURRENT..": "..CTA_GetNumGroupMembers().." "..CTA_PENDING..": "..pendingSize..")" );

    elseif( IsPartyLeader() and GetNumRaidMembers() == 0 ) then
        CTA_RaidSizeLabel:SetText( CTA_SIZE..": "..CTA_MyRaid.size.." ("..CTA_PARTY..") ("..CTA_CURRENT..": "..CTA_GetNumGroupMembers().." "..CTA_PENDING..": "..pendingSize..")" );

    end]]

    local oldSize = CTA_MyRaid.size;
    CTA_MyRaid.size = CTA_GetNumGroupMembers();
    local mySize = CTA_MyRaid.size;
    --CTA_Println( "Size = "..mySize );
    CTA_RaidSizeLabel:SetText( CTA_SIZE..": "..CTA_MyRaid.size.." ("..CTA_CURRENT..": "..CTA_GetNumGroupMembers().." "..CTA_PENDING..": "..#CTA_InvitationRequests..")" );


    if( CTA_MyRaid.size > oldSize ) then
        PlaySound("TellMessage");
    end
    CTA_IconMsg( CTA_GROUP_MEMBERS..CTA_MyRaid.size, CTA_GROUP_UPDATE);

    -- R7 announce auto off

    if( CTA_AutoAnnounce and  CTA_GetNumGroupMembers() >= CTA_MyRaid.maxSize ) then
        CTA_SlashHandler(CTA_AUTO_ANNOUNCE_OFF) -- R10E
        -- CTA_AnnounceTimer = 0; -- R10E
        CTA_Println( CTA_MAX_PLAYERS_REACHED );
    end


--[[	------------------------------------
        [Update the Acid Items]

        Accordingly
        ------------------------------------
--]]


    num = 0;


    -- CTA_AcidSummary = CTA_LFM..": "..CTA_MyRaid.comment.." ("..CTA_MyRaid.size.."/"..CTA_MyRaid.maxSize..")"..CTA_ANNOUNCE_SUMMARY_PROMPT; -- R10E Add RP-Flag
    -- CTA_AcidDetails = CTA_LFM..": "..CTA_MyRaid.comment.." ("..CTA_MyRaid.size.."/"..CTA_MyRaid.maxSize..") - "; -- R10E Compressed details
    CTA_AcidSummary = CTA_LFM
    if CTA_MyRaid.minLevel and CTA_MyRaid.minLevel > 1 then -- MARKER
        CTA_AcidSummary = CTA_AcidSummary.."("..CTA_MyRaid.minLevel.."+)"
    end
    CTA_AcidSummary = CTA_AcidSummary..": "..CTA_MyRaid.comment.." ("..CTA_MyRaid.size.."/"..CTA_MyRaid.maxSize..")"
    if CTA_RP_TYPE > 1  then
        local RPlevel = string.lower(string.sub(CTA_RPLEVEL[CTA_RP_TYPE],1,1))..string.sub(CTA_RPLEVEL[CTA_RP_TYPE],2)
        CTA_AcidSummary = CTA_AcidSummary..CTA_EXPECTING..RPlevel
    end
    CTA_AcidSummary = CTA_AcidSummary..CTA_ANNOUNCE_SUMMARY_PROMPT;
    if CTA_MyRaid.size >= CTA_MyRaid.maxSize then -- R10E Compressed details
        CTA_AcidDetails = "("..CTA_MyRaid.size.."/"..CTA_MyRaid.maxSize..") - "..CTA_NO_MORE_PLAYERS_NEEDED;
    else
        CTA_AcidDetails = "("..CTA_MyRaid.size.."/"..CTA_MyRaid.maxSize..") - "..CTA_STILL_LOOKING_FOR;
    end

    while( num <= CTA_NUM_CLASSES ) do
        local item = _G["CTA_Acid"..num];

        if( item.classes or item:GetName()=="CTA_Acid0" ) then

            local nam = _G["CTA_Acid"..num.."ClassNameLabel"];

            if( item:GetName()~="CTA_Acid0" ) then
                _G["CTA_Acid"..num.."ClassNameLabel"]:Show();
                --_G["CTA_Acid"..num.."ClassPercentLabel"]:Show();
                _G["CTA_Acid"..num.."ClassAbsoluteLabel"]:Show();
                _G["CTA_Acid"..num.."ClassCurrentLabel"]:Show();

                _G["CTA_Acid"..num.."LessButton"]:Show();
                _G["CTA_Acid"..num.."MoreButton"]:Show();
                --_G["CTA_Acid"..num.."EditButton"]:Show();
                _G["CTA_Acid"..num.."DeleteButton"]:SetText( CTA_ACID_EDIT );

                nam:SetText( "" );
                for key, val in pairs(item.classes) do
                    if( nam:GetText() ) then
                        if ( GetLocale() == "deDE" ) and (key == CTA_WARLOCK) then -- R10E German Warlock fix
                            nam:SetText( nam:GetText().."Hexer".."\n" );
                        else
                            nam:SetText( nam:GetText()..key.."\n" );
                        end
                    else
                        if ( GetLocale() == "deDE" ) and (key == CTA_WARLOCK) then -- R10E German Warlock fix
                            nam:SetText( "Hexer".."\n" );
                        else
                            nam:SetText( key.."\n" );
                        end
                    end
                end
            end

            local percent = _G["CTA_Acid"..num.."ClassPercentLabel"];
            local current = _G["CTA_Acid"..num.."ClassAbsoluteLabel"];
            local absolute = _G["CTA_Acid"..num.."ClassCurrentLabel"];
            local percentTex = _G["CTA_Acid"..num.."PercentTexture"];
            local currentTex = _G["CTA_Acid"..num.."CurrentTexture"];

            local pval = floor(50*item.val/CTA_MyRaid.maxSize); --80 changed to 50 R5
            if( pval > 50 ) then pval = 50; end -- cheapo fix
            local percentage = floor(100*item.val/CTA_MyRaid.maxSize);

            percent:SetText( percentage.."%" );
            absolute:SetText( "/"..item.val );

            if( item.val == 0)  then
                percentTex:Hide();
                absolute:SetTextColor( 0.5, 0.5, 0.5 );
            else
                percentTex:SetHeight( pval );
                absolute:SetTextColor( 1.0, 0.82, 0.0 );
                percentTex:Show();
            end

            local cval = item.cur;
            local cpval = floor(50*cval/CTA_MyRaid.maxSize); --80 -> 50 R5
            if( cpval > 50 ) then cpval = 50; end -- cheapo fix
            current:SetText( cval );

            if( cval == 0)  then
                currentTex:Hide();
                current:SetTextColor( 0.5, 0.5, 0.5 );
            else
                current:SetTextColor( 1.0, 0.82, 0.0 );
                currentTex:SetHeight( cpval );
                currentTex:Show();
            end
            if( cval > item.val and CTA_Acid0.cur > CTA_Acid0.val ) then
                current:SetTextColor( 1.0, 0.0, 0.0 );
            end

            local lfm = item.val-item.cur;
            if( lfm > 0 ) then
                if( num == 0 ) then
                    CTA_AcidDetails = CTA_AcidDetails..(lfm).." "..CTA_ANY_CLASS..", ";
                else
                    CTA_AcidDetails = CTA_AcidDetails..(lfm).." ";
                    local f = nil;
                    for k,v in pairs(item.classes) do
                        if( f ) then
                            CTA_AcidDetails = CTA_AcidDetails.."/";
                        else
                            f = 1;
                        end
                        CTA_AcidDetails = CTA_AcidDetails..k;

                    end
                    CTA_AcidDetails = CTA_AcidDetails..", ";
                end
            end
        else

            _G["CTA_Acid"..num.."ClassNameLabel"]:Hide();

            --_G["CTA_Acid"..num.."ClassPercentLabel"]:Hide();
            _G["CTA_Acid"..num.."ClassAbsoluteLabel"]:Hide();
            _G["CTA_Acid"..num.."ClassCurrentLabel"]:Hide();

            _G["CTA_Acid"..num.."PercentTexture"]:Hide();
            _G["CTA_Acid"..num.."CurrentTexture"]:Hide();

            _G["CTA_Acid"..num.."LessButton"]:Hide();
            _G["CTA_Acid"..num.."MoreButton"]:Hide();
            --_G["CTA_Acid"..num.."EditButton"]:Hide();
            _G["CTA_Acid"..num.."DeleteButton"]:SetText( CTA_ACID_ADD );


            --item:Hide();
        end

        num = num + 1;
    end

    if CTA_MyRaid.size < CTA_MyRaid.maxSize then
        CTA_AcidDetails = CTA_AcidDetails..CTA_ANNOUNCE_DETAILS_PROMPT; -- R10E
    end

    CTA_AcidNote:SetText( CTA_AcidSummary );

    if( CTA_HostingRaidGroup and IsPartyLeader() and GetNumRaidMembers() == 0 ) then
        --CTA_ConvertToRaid();
    end

    -- ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID
    -- ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID
    -- ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID ACID

    local myMinLevel = CTA_SafeSetNumber( CTA_MyRaidFrameMinLevelEditBox:GetText(), 1, 85 );
    if( not myMinLevel ) then
        CTA_MyRaidFrameMinLevelEditBox:SetText( CTA_MyRaid.minLevel );
        myMinLevel = CTA_MyRaid.minLevel;
    end

    local myClasses = 0;
    if( CTA_Acid0.cur < CTA_Acid0.val ) then
		myClasses = 1023;
    else
        local num = 1;
        local b = 1;
        local combinedClasses = {};
        for i = 1, CTA_NUM_CLASSES do
            local item = _G["CTA_Acid"..i];
            if( item.classes and item.cur < item.val ) then
                for k, v in pairs(item.classes) do
                    combinedClasses[ k ] = 1;
                end
            end
        end

        for k,v in pairs(combinedClasses) do
            local index = CTA_GetClassCode( k );
            myClasses = myClasses + (2^(index - 1 ));
        end
        --[[
        while( num <= CTA_NUM_CLASSES ) do
            local item = _G["CTA_Acid"..num];
            if( item.cur < item.val ) then
                myClasses = myClasses + b;
            end
            b = b * 2;
            num = num + 1;
        end	]]
    end
    
    local myUsePassword = 1;
    local oldPassword = CTA_MyRaidPassword;
    CTA_MyRaidPassword = CTA_MyRaidFramePasswordEditBox:GetText();
    for space in string.gmatch( CTA_MyRaidPassword, "(%s)" ) do
        CTA_MyRaidPassword = oldPassword;
    end
    if( not CTA_MyRaidPassword or CTA_MyRaidPassword== "" ) then
        myUsePassword = 0;
        CTA_MyRaidPassword = nil;
        CTA_MyRaidFramePasswordEditBox:SetText( "" );

    else
        CTA_MyRaidFramePasswordEditBox:SetText( CTA_MyRaidPassword );
    end

    local myName = UnitName(CTA_PLAYER);
    local myTime = CTA_MyRaid.creationTime;
    local ExtraOptions = CTA_RP_TYPE -- Further options need to be separated with ";"
    local myOptions = CTA_GetGroupClassesCode()..CTA_RELEASEVERSION..","..ExtraOptions;

    CTA_SetRaidInfo( CTA_MyRaid, myName, 100, myComment, myRaidType, mySize, myMaxSize, myMinLevel, myClasses, myUsePassword, myTime, myOptions );
    CTA_PollBroadcast = 1;
    --CTA_IconMsg( "Broadcast Polled" );

end



function CTA_AcidItemButton_OnClick(self, button, down) -- Called by XML
    local item = _G[self:GetParent():GetName()];

    if( string.find( self:GetName(), "Delete" ) ) then
        CTA_StartEditAcidItem( item );
        --[[
        if( item.classes == nil ) then
            CTA_AddAcidItem( item );
        else
            CTA_StartEditAcidItem(item);
        end]]
    elseif( string.find( self:GetName(), "Less" ) ) then
        if( item.val > 0 ) then
            item.val = item.val - 1;
            CTA_Acid0.val = CTA_Acid0.val + 1;
        end
        CTA_MyRaidInstantUpdate();
    else
        if( CTA_Acid0.val > 0 ) then
            item.val = item.val + 1;
            CTA_Acid0.val = CTA_Acid0.val - 1;
        end
        CTA_MyRaidInstantUpdate();
    end
end




--[[	CTA_StartEditAcidItem()
        ---------------------------------------------------------------
        Called by CTA_Acid(0-8) AddButton Components.
        All this function really does is set up the check buttons
        in the <ui>CTA_AcidEditDialog</ui> Frame before showing it
        to the user.
--]]

function CTA_StartEditAcidItem( item )
    for i = 1, CTA_NUM_CLASSES do
        _G["CTA_AcidClassCheckButton"..i]:SetChecked( 0 );
    end

--	CTA_AcidClassCheckButton8TextLabel:SetText( CTA_PALADIN.."/"..CTA_SHAMAN  );

    if( item.classes ) then
        for key, val in pairs(item.classes) do

            for i = 1, CTA_NUM_CLASSES do
                if ( _G["CTA_AcidClassCheckButton"..i.."TextLabel"]:GetText() == key ) then
                    _G["CTA_AcidClassCheckButton"..i]:SetChecked( 1 );
                end
            end
        end
    else
        item.classes = {};
    end

    CTA_AcidEditDialogHeadingLabel:SetText( CTA_EDIT_ACID_CLASSES );

    CTA_AcidEditDialog.target = item:GetName();
    CTA_AcidEditDialog:Show();
end




--[[	CTA_EditAcidItem()
        ---------------------------------------------------------------
        Called by the <ui>CTA_AcidEditDialog</ui>'s OKButton Component.
        Sets the Acid item's class list to what classes were checked
        by the user in the edit dialog.
--]]

function CTA_EditAcidItem()
    local acidItem = _G[CTA_AcidEditDialog.target];
    local checkCount = 0;
    acidItem.classes = {};
    for i = 1, CTA_NUM_CLASSES do
        local checked =  _G["CTA_AcidClassCheckButton"..i]:GetChecked();
        if( checked ) then
            acidItem.classes[ _G["CTA_AcidClassCheckButton"..i.."TextLabel"]:GetText() ] = 0;
            checkCount = checkCount + 1;
        end
    end

    if( checkCount == 0 or checkCount == 8 ) then
        acidItem.classes = nil;
        if( acidItem.val ) then
            CTA_Acid0.val = CTA_Acid0.val + acidItem.val;
        end
        acidItem.val = 0;
    end

    CTA_AcidEditDialog:Hide();
    CTA_MyRaidInstantUpdate();

end

--[[	CTA_StartAParty()
        ---------------------------------------------------------------
        Starts a party group.
        Called by StartARaidFrame's StartAPartyButton
--]]

function CTA_StartAParty() -- Called by XML
    CTA_HostingRaidGroup = nil;
    CTA_MyRaid = {};
    CTA_SetRaidInfo( CTA_MyRaid,  UnitName( CTA_PLAYER ), 100, "", CTA_RAID_TYPE_PVE, GetNumPartyMembers()+1, 5, 1, 255, 0, CTA_GetTime(), 0 );
    CTA_MyRaidIsOnline = 1;
    CTA_ShowStartRaidFrame();
end




--[[	CTA_StartARaid
        ---------------------------------------------------------------
        Starts a raid group.
        Called by StartARaidFrame's StartARaidButton
--]]

function CTA_StartARaid() -- Called by XML
    CTA_HostingRaidGroup = 1;
    CTA_MyRaid = {};
    CTA_SetRaidInfo( CTA_MyRaid,  UnitName( CTA_PLAYER ), 100, "", CTA_RAID_TYPE_PVE, GetNumRaidMembers(), 10, 1, 255, 0, CTA_GetTime(), 0 );
    CTA_MyRaidIsOnline = 1;
    CTA_ShowStartRaidFrame();
end




--[[	CTA_StopHosting()
        ---------------------------------------------------------------
        Stops hosting a group with CTA.
--]]

function CTA_StopHosting() -- Called by XML
    CTA_HostingRaidGroup = nil;
    CTA_MyRaid = nil;
    CTA_MyRaidIsOnline = nil;
    CTA_SlashHandler(CTA_AUTO_ANNOUNCE_OFF);
    CTA_PollBroadcast = 2;

    CTA_SearchFrame:Hide();
    CTA_MyRaidFrame:Hide();
    CTA_SettingsFrame:Hide();
    CTA_GreyListFrame:Hide();
    CTA_LogFrame:Hide();

    CTA_ShowStartRaidFrame();
end




--[[	CTA_ShowStartRaidFrame()
        ---------------------------------------------------------------
        Prompts the user to start hosting a group with CTA or
        tells the user that s/he cannot currently host a group or
        shows the group information frame if user is already using
        CTA to host a group.
--]]

function CTA_ShowStartRaidFrame()
    CTA_StartRaidFrame:Show();

    if( CTA_MyRaid ) then
        CTA_StartRaidFrame:Hide();

        if( CTA_ToggleViewableButton:GetText() ==  CTA_GO_OFFLINE ) then
            CTA_MyRaidIsOnline = 1;
        end

        CTA_MyRaidFrameDescriptionEditBox:SetText(""..CTA_MyRaid.comment);

        local myRaidType = CTA_MyRaid.pvtype;
        if( myRaidType == CTA_RAID_TYPE_PVP ) then
            CTA_MyRaidFramePVPCheckButton:SetChecked(1)
            CTA_MyRaidFramePVECheckButton:SetChecked(0)
        else
            CTA_MyRaidFramePVPCheckButton:SetChecked(0)
            CTA_MyRaidFramePVECheckButton:SetChecked(1)
        end

        CTA_MyRaidFrameMaxSizeEditBox:SetText(""..CTA_MyRaid.maxSize);
        CTA_MyRaidFrameMinLevelEditBox:SetText(""..CTA_MyRaid.minLevel);

        if( CTA_MyRaidPassword ) then
            CTA_MyRaidFramePasswordEditBox:SetText(CTA_MyRaidPassword);
        else
            CTA_MyRaidFramePasswordEditBox:SetText("");
        end

        CTA_MyRaidInstantUpdate();
        CTA_MyRaidFrame:Show();
    end

    CTA_StartARaidButton:Hide();
    CTA_StartAPartyButton:Hide();

    if ( CTA_PlayerCanHostGroup() ) then
        CTA_StartRaidLabel:SetText( CTA_PLAYER_CAN_START_A_GROUP );

        if( not CTA_MyRaid and IsRaidLeader() and GetNumRaidMembers() > 0 ) then
            CTA_StartARaidButton:Show();
        elseif( not CTA_MyRaid and IsPartyLeader() and GetNumRaidMembers() == 0 ) then
            CTA_StartAPartyButton:Show();
            CTA_StartARaidButton:Show();
        else
            CTA_StartAPartyButton:Show();
            CTA_StartARaidButton:Show();
        end
    else
        CTA_StartRaidLabel:SetText( CTA_PLAYER_IS_RAID_MEMBER_NOT_LEADER );
    end
end




--[[	CTA_AcidItem_ShowTooltip()
        ---------------------------------------------------------------
        Shows tooltip for acid items.
--]]

function CTA_AcidItem_ShowTooltip(self) -- Called by XML
    GameTooltip:SetOwner( self, "ANCHOR_TOP" );
    GameTooltip:ClearLines();
    GameTooltip:ClearAllPoints();
    GameTooltip:SetPoint("TOPLEFT", self:GetName(), "BOTTOMLEFT", 0, -8);

    local acidItem = self;
    if( not acidItem.classes and acidItem:GetName() ~= "CTA_Acid0" ) then
        GameTooltip:AddLine( CTA_NO_CLASSES_TOOLTIP );
        GameTooltip:AddLine( CTA_NO_CLASSES_TOOLTIP2, 1, 1, 1, 1, 1 );
        return;
    end

    local needed = acidItem.val - acidItem.cur;
    if( needed < 0 ) then needed = 0; end

    if( self:GetName() == "CTA_Acid0" ) then
        GameTooltip:AddDoubleLine( CTA_MAXIMUM_PLAYERS_ALLOWED..":", ""..self.val );
        GameTooltip:AddDoubleLine( CTA_PLAYERS_IN_RAID..":", ""..self.cur );
        GameTooltip:AddDoubleLine( CTA_NUMBER_OF_PLAYERS_NEEDED..":", ""..needed );
        GameTooltip:AddLine( CTA_ANY_CLASS_TOOLTIP, 1, 1, 1, 1, 1 );
    else
        GameTooltip:AddDoubleLine( CTA_MINIMUM_PLAYERS_WANTED..":", ""..self.val );
        GameTooltip:AddDoubleLine( CTA_PLAYERS_IN_RAID..":", ""..self.cur );
        GameTooltip:AddDoubleLine( CTA_NUMBER_OF_PLAYERS_NEEDED..":", ""..needed );
        GameTooltip:AddLine( CTA_CLASS_TOOLTIP, 1, 1, 1, 1, 1 );
    end

    GameTooltip:Show();
end




--[[	CTA_GetGroupMemberInfo()
        ---------------------------------------------------------------
        Returns information about a group member.
        @arg the index of the group member
        @return the name, level, class of the player.
--]]

function CTA_GetGroupMemberInfo( index )
    local name, rank, subgroup, level, class, fileName, zone, online, isDead;
    if ( IsRaidLeader() and GetNumRaidMembers() > 0 ) then
        name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(index);
    elseif ( IsPartyLeader() and GetNumPartyMembers() > 0 ) then
        local target = CTA_PLAYER;
        if( index > 1 and index < 6 ) then
            target = "PARTY"..(index-1);
        end
        name = UnitName(target);
        level = UnitLevel(target);
        class = UnitClass(target);
    elseif( GetNumRaidMembers() == 0  and GetNumPartyMembers() == 0 and index == 1 ) then
        local target = CTA_PLAYER;
        name = UnitName(target);
        level = UnitLevel(target);
        class = UnitClass(target);
    end
    return name, level, class;
end




--[[	CTA_GetNumGroupMembers()
        ---------------------------------------------------------------
        Returns information about a group member.
        @arg the index of the group member
        @return the name, level, class of the player.
--]]

function CTA_GetNumGroupMembers()
    if( GetNumRaidMembers() > 0 ) then
        return GetNumRaidMembers();
    elseif( GetNumPartyMembers() > 0 ) then
        return GetNumPartyMembers() + 1;
    else
        return 1;
    end
end




--[[	CTA_DissolveRaid()
        ---------------------------------------------------------------
        Dissolves the group by removing each member.
--]]

function CTA_DissolveRaid()
    CTA_IconMsg( CTA_DISSOLVING_RAID, CTA_GROUP_UPDATE );
    num = 1;
    local numRaidMembers = GetNumRaidMembers();
    local name, rank, subgroup, level, class, fileName, zone, online, isDead;
    local over = 0;
    while ( num <= numRaidMembers ) do
        name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(num);
        if( name ~= UnitName(CTA_PLAYER) ) then
            UninviteByName( name );
            CTA_SendAutoMsg( CTA_DISSOLVING_THE_RAID_CHAT_MESSAGE, name);
        end
        num = num+1;
    end
    CTA_IconMsg( CTA_RAID_DISSOLVED, CTA_GROUP_UPDATE );
end




--[[	CTA_ConvertToParty()
        ---------------------------------------------------------------
        convert your raid to a party.
--]]

function CTA_ConvertToParty() --R2 (suggested by Sadris) -- Called by XML
    CTA_IconMsg( CTA_CONVERTING_TO_PARTY, CTA_GROUP_UPDATE );
    num = 1;
    local numRaidMembers = GetNumRaidMembers();
    if( numRaidMembers > 5 ) then
        CTA_Println( CTA_CANNOT_CONVERT_TO_PARTY );
        return;
    end

    if( IsPartyLeader() ) then
        CTA_HostingRaidGroup = nil;
        ConvertToParty();
    end

--    local memberList = {};
--    local name, rank, subgroup, level, class, fileName, zone, online, isDead;
--    local over = 0;
--    while ( num <= numRaidMembers ) do
--        name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(num);
--        if( name ~= UnitName(CTA_PLAYER) ) then
--            memberList[num] = name;
--            UninviteUnit( name );
--            CTA_MyRaidInstantUpdate();
--
--            CTA_SendAutoMsg( CTA_CONVERTING_TO_PARTY_MESSAGE, name);
--        end
--        num = num+1;
--    end
--    for i = 1, numRaidMembers - 1 do
--        InviteUnit( memberList[i] );
--    end
    CTA_IconMsg( CTA_CONVERTING_TO_PARTY_DONE, CTA_GROUP_UPDATE );
--    CTA_HostingRaidGroup = nil;
end




--[[	CTA_GetGroupType()
        ---------------------------------------------------------------
        Returns a String representation of the type of group
        currently being hosted.
        @return CTA_GROUP or CTA_PARTY
--]]

function CTA_GetGroupType()
    if ( CTA_HostingRaidGroup ) then
        return CTA_RAID;
    end
    return CTA_PARTY;
end





--[[	CTA_ConvertToParty()
        ---------------------------------------------------------------
        Converts the raid to a party
        ]]

function CTA_ConvertToRaid()
    if( IsPartyLeader() ) then
        CTA_HostingRaidGroup = 1;
        ConvertToRaid();
    end
end




--[[	CTA_PlayerCanHostGroup()
        ---------------------------------------------------------------
        Indicates whether a player can start hosting a group according
        to CTA logic.
        returns 1 if can host, nil if not
--]]

function CTA_PlayerCanHostGroup()
    if ( ( IsRaidLeader() and GetNumRaidMembers() > 0 ) or
         ( IsPartyLeader() and GetNumRaidMembers() == 0 ) or
         ( GetNumPartyMembers() == 0 and GetNumRaidMembers() == 0 ) ) then
        return 1;
    else
        return nil;
    end
end


--[[	CTA_SetRaidInfo()
        ---------------------------------------------------------------
        Set group information for the specified group.
--]]

function CTA_SetRaidInfo( raid, name, score, comment, groupType, size, maxSize, minLevel, classes, passwordProtected, creationTime, options )
    raid.leader = name;
    raid.score = tonumber(score);
    raid.comment = comment;
    raid.pvtype = tonumber(groupType);
    raid.size = tonumber(size);
    raid.maxSize = tonumber(maxSize);
    raid.minLevel = tonumber(minLevel);
    raid.classes = tonumber(classes);
    raid.passwordProtected = tonumber(passwordProtected);
    raid.creationTime = creationTime;
    raid.options = options;
end









--[[	---------------------------------------------------------------
        Functions Related To The Blacklist
        ---------------------------------------------------------------
--]]




--[[	CTA_UpdateGreyListItems()     			UPDATE FUNCTION
        ---------------------------------------------------------------
        Updates the list of blacklisted players.
--]]

function CTA_UpdateGreyListItems()
    CTA_GreyListItem0NameLabel:SetText( CTA_NAME );
    CTA_GreyListItem0NoteLabel:SetText( CTA_PLAYER_NOTE );
    CTA_GreyListItem0StatusLabel:SetText( "" );
    CTA_GreyListItem0:Show();

    local gls = #CTA_BlackList;
    if( not gls ) then
        gls = 0;
    end
    CTA_GreyListFramePageLabel:Show();
    local cpage = floor( CTA_PlayerListOffset / CTA_MAX_BLACKLIST_ITEMS );
    local tpage = floor( gls / CTA_MAX_BLACKLIST_ITEMS );
    if( cpage == 0 or cpage <= CTA_PlayerListOffset / CTA_MAX_BLACKLIST_ITEMS ) then cpage = cpage + 1; end
    if( tpage == 0 or tpage < gls / CTA_MAX_BLACKLIST_ITEMS ) then tpage = tpage + 1; end
    CTA_GreyListFramePageLabel:SetText( CTA_PAGE.." "..cpage.." / "..tpage );


    for index = 1, CTA_MAX_BLACKLIST_ITEMS do
        local item = _G["CTA_GreyListItem"..index];
        if( index + CTA_PlayerListOffset <= gls  ) then
            local data = CTA_BlackList[ index + CTA_PlayerListOffset ];
            _G["CTA_GreyListItem"..index.."NameLabel"]:SetText( data.name );
            local i = CTA_FindInList( data.name, aieCTA_SavedVariables.GreyList );
            if( i ) then
                _G["CTA_GreyListItem"..index.."NoteLabel"]:SetTextColor( 1, 1, 1 );
            else
                _G["CTA_GreyListItem"..index.."NoteLabel"]:SetTextColor( 1, 0, 0 );
            end
            _G["CTA_GreyListItem"..index.."NoteLabel"]:SetText( data.note );
            _G["CTA_GreyListItem"..index.."RatingLabel"]:SetText( data.rating );
            _G["CTA_GreyListItem"..index]:Show();
        else
            item:Hide();
        end
    end
end




--[[	CTA_ShowGreyListFrame()
        ---------------------------------------------------------------
        Show the Greylist frame
--]]

function CTA_ShowGreyListFrame()
    --CTA_SearchFrame:Hide();
    --CTA_MyRaidFrame:Hide();
    --CTA_StartRaidFrame:Hide();
    CTA_SettingsFrame:Hide();
    CTA_LogFrame:Hide();
    CTA_GreyListFrame:Show();
    CTA_UpdateGreyListItems();
end




--[[	CTA_EditGreyListItem()
        ---------------------------------------------------------------
        Shows the Edit frame for the selected Greylist item
--]]

function CTA_EditGreyListItem(self)
    local listItem = _G[self:GetName()];
    CTA_GreyListItemEditFrame.name = ( _G[listItem:GetName().."NameLabel"]:GetText() or "?" );
    if( not CTA_FindInList( CTA_GreyListItemEditFrame.name, aieCTA_SavedVariables.GreyList ) ) then
        CTA_AddPlayer( CTA_GreyListItemEditFrame.name, CTA_DEFAULT_PLAYER_NOTE, CTA_DEFAULT_STATUS, CTA_DEFAULT_RATING, aieCTA_SavedVariables.GreyList );
    end
    CTA_GreyListItemEditFrameEditBox:SetText( aieCTA_SavedVariables.GreyList[ CTA_FindInList( CTA_GreyListItemEditFrame.name, aieCTA_SavedVariables.GreyList ) ].note );
    CTA_GreyListItemEditFrameTitleLabel:SetText( CTA_EDIT_PLAYER..": "..CTA_GreyListItemEditFrame.name );
    CTA_GreyListItemEditFrame:Show();
end




--[[	CTA_GreyListItemSaveChanges()
        ---------------------------------------------------------------
        Commits changes made to the selected Greylist item
--]]

function CTA_GreyListItemSaveChanges() -- Called by XML
    aieCTA_SavedVariables.GreyList[CTA_FindInList( CTA_GreyListItemEditFrame.name, aieCTA_SavedVariables.GreyList )].note = CTA_GreyListItemEditFrameEditBox:GetText();
    CTA_BlackList[CTA_FindInList( CTA_GreyListItemEditFrame.name, CTA_BlackList )].note = CTA_GreyListItemEditFrameEditBox:GetText();

    CTA_GreyListItemEditFrame:Hide();
    CTA_ShowGreyListFrame();
end




--[[	CTA_DeletePlayer()
        ---------------------------------------------------------------
        Removes the player from the Greylist
--]]

function CTA_DeletePlayer() -- Called by XML
    table.remove( CTA_BlackList , CTA_FindInList( CTA_GreyListItemEditFrame.name, CTA_BlackList ) );
    table.remove( aieCTA_SavedVariables.GreyList , CTA_FindInList( CTA_GreyListItemEditFrame.name, aieCTA_SavedVariables.GreyList ) );
    CTA_GreyListItemEditFrame:Hide();
    CTA_ShowGreyListFrame();
end




--[[
function CTA_ImportFriendsToGreyList()
    numFriends = GetNumFriends();
    for i=1,numFriends do
        local name, level, class, area, connected = GetFriendInfo(i);
        if( not aieCTA_SavedVariables.GreyList[name] ) then
            CTA_AddPlayer( name, CTA_DEFAULT_PLAYER_NOTE, CTA_DEFAULT_STATUS, CTA_DEFAULT_RATING, aieCTA_SavedVariables.GreyList );
        end
    end
end
--]]




--[[	CTA_ImportIgnoreListToGreyList()
        ---------------------------------------------------------------
        Adds players from the ignore list to the Greylist
--]]

function CTA_ImportIgnoreListToGreyList()
    local numIgnores = GetNumIgnores();
    for i = 1, numIgnores do
        local name = GetIgnoreName(i);
        CTA_AddPlayer( name, CTA_DEFAULT_IMPORTED_IGNORED_PLAYER_NOTE, CTA_DEFAULT_STATUS, CTA_DEFAULT_RATING, aieCTA_SavedVariables.GreyList );
        CTA_AddPlayer( name, CTA_DEFAULT_IMPORTED_IGNORED_PLAYER_NOTE, CTA_DEFAULT_STATUS, CTA_DEFAULT_RATING, CTA_BlackList );
    end
end





--[[	CTA_AddGreyToBlack()
        ---------------------------------------------------------------
        Updates the Blacklist by adding Greylist entries to it.
--]]

function CTA_AddGreyToBlack()
    for i = 1, #aieCTA_SavedVariables.GreyList do
        CTA_AddToList( aieCTA_SavedVariables.GreyList[i], CTA_BlackList );
    end
end





--[[	CTA_AddPlayer()
        ---------------------------------------------------------------
        Adds a new player to the Greylist.
        @arg the name of the player
        @arg the note to be added
        @arg the status of the player
        @arg the rating of the player
        @arg the list in which to enter the data
--]]

function CTA_AddPlayer( name, note, status, rating, list )
    local data = { name=name, note=note, status=status, rating=rating };
    CTA_AddToList( data, list );
    CTA_UpdateGreyListItems();
end


--[[	CTA_AddToList()
        ---------------------------------------------------------------
        Add data to list only if the name is not already in the List
        @arg the data to be added
        @arg the list in which to enter the data
--]]

function CTA_AddToList( data, list )
    if( not CTA_FindInList( data.name, list ) ) then
        table.insert( list, data );
    end
end




--[[	CTA_FindInList()
        ---------------------------------------------------------------
        Returns the index of the data which has a name field that
        matches the name provided
        @arg the name to search for
        @arg the list in which to search for the data
        @return index if found, nil if not found
--]]

function CTA_FindInList( name, list )
    for i = 1, #list do
        if( list[i].name == name ) then
            return i;
        end
    end
    return nil;
end




--[[	---------------------------------------------------------------
        Generic Functions Driven Directly By User Interface Events
        ---------------------------------------------------------------
--]]




--[[	CTA_ToggleMainFrame()
        ---------------------------------------------------------------
        Show/hide the Main Frame. If the search frame is visible
        and the main frame is opened the results list is automatically
        refreshed.
        Called by the minimap icon and the main frame's close button.
--]]

function CTA_ToggleMainFrame() -- Called by XML
    PlaySound("igCharacterInfoTab");
    if( CTA_MainFrame:IsVisible() ) then
        CTA_MainFrame:Hide();
    else
        CTA_MainFrame:Show();
        --[[
        if( CTA_SearchFrame:IsVisible() ) then
            CTA_ApplyFiltersToGroupList();
        end
        --]]
    end
end




--[[	CTA_Tab_OnCLick()
        ---------------------------------------------------------------
        Switches visibility of the frames in the main frame.
        Called by all tab buttons under the main frame.
--]]

function CTA_Tab_OnClick(self, button, down) -- Called by XML
    PlaySound("igCharacterInfoTab");
    CTA_SearchFrame:Hide();
    CTA_StartRaidFrame:Hide();
    CTA_MyRaidFrame:Hide();
    --CTA_SettingsFrame:Hide();
    --CTA_GreyListFrame:Hide();
    --CTA_LogFrame:Hide();
    CTA_MoreFeaturesFrame:Hide();
    CTA_CannotLFGFrame:Hide();

    CTA_LFGFrame:Hide(); -- r7


    CTA_ShowSearchButton:SetFrameLevel(CTA_MainFrame:GetFrameLevel() - 1);
    CTA_ShowMyRaidButton:SetFrameLevel(CTA_MainFrame:GetFrameLevel() - 1);
    --CTA_ShowPlayerListButton:SetFrameLevel(CTA_MainFrame:GetFrameLevel() - 1);
    --CTA_ShowSettingsButton:SetFrameLevel(CTA_MainFrame:GetFrameLevel() - 1);
    --CTA_ShowLogButton:SetFrameLevel(CTA_MainFrame:GetFrameLevel() - 1);

    CTA_ShowLFGButton:SetFrameLevel(CTA_MainFrame:GetFrameLevel() - 1);	-- r7
    CTA_ShowMFFButton:SetFrameLevel(CTA_MainFrame:GetFrameLevel() - 1);

    self:SetFrameLevel(CTA_MainFrame:GetFrameLevel() + 1);

    if( self:GetName() == "CTA_ShowSearchButton" ) then
        CTA_SearchFrame:Show();
        --[[CTA_ApplyFiltersToGroupList();]]
    elseif( self:GetName() == "CTA_ShowMyRaidButton" ) then
        CTA_ShowStartRaidFrame();
    elseif( self:GetName() == "CTA_ShowPlayerListButton" ) then
        CTA_ShowGreyListFrame();
    elseif( self:GetName() == "CTA_ShowSettingsButton" ) then
        CTA_SettingsFrame:Show();
    elseif( self:GetName() == "CTA_ShowLogButton" ) then
        CTA_LogFrame:Show();
    elseif( self:GetName() == "CTA_ShowLFGButton" ) then
        CTA_ShowLFGFrame();
    elseif( self:GetName() == "CTA_ShowMFFButton" ) then
        CTA_MoreFeaturesFrame:Show();
    end
end




--[[	CTA_DialogOKButton_OnCLick()
        ---------------------------------------------------------------
        Handles all 'Ok button' events generated by dialogs.
--]]

function CTA_DialogOKButton_OnClick(self, button, down) -- Called by XML
    local item = self:GetParent();
    if( item:GetName() == "CTA_AddPlayerFrame" ) then
        local name = CTA_AddPlayerFrameEditBox:GetText();
        if( name and name ~= "" ) then
            CTA_AddPlayer( name, CTA_DEFAULT_PLAYER_NOTE, CTA_DEFAULT_STATUS, CTA_DEFAULT_RATING, aieCTA_SavedVariables.GreyList );
            CTA_AddPlayer( name, CTA_DEFAULT_PLAYER_NOTE, CTA_DEFAULT_STATUS, CTA_DEFAULT_RATING, CTA_BlackList );
        end
        CTA_AddPlayerFrame:Hide();
    end

    if( item:GetName() == "CTA_JoinRaidWindow" ) then
        CTA_SendPasswordRaidInvitationRequest();
    end

    if( item:GetName() == "CTA_AcidEditDialog" ) then
        CTA_EditAcidItem();
    end

end




--[[	CTA_UpdateMinimapIcon()
        ---------------------------------------------------------------
        Adjusts the minimap icon position.
--]]

function CTA_UpdateMinimapIcon()
    CTA_MinimapIcon:SetPoint( "TOPLEFT", "Minimap", "TOPLEFT",
        55 - ( ( aieCTA_SavedVariables.MinimapRadiusOffset ) * cos( aieCTA_SavedVariables.MinimapArcOffset ) ),
        ( ( aieCTA_SavedVariables.MinimapRadiusOffset ) * sin( aieCTA_SavedVariables.MinimapArcOffset ) ) - 55
    );
    CTA_MinimapMessageFrame:SetPoint( "TOPRIGHT", "Minimap", "TOPRIGHT",
        ( 0 - ( ( aieCTA_SavedVariables.MinimapMsgRadiusOffset ) * cos( aieCTA_SavedVariables.MinimapMsgArcOffset ) ) ) - 55,
        ( ( aieCTA_SavedVariables.MinimapMsgRadiusOffset ) * sin (aieCTA_SavedVariables.MinimapMsgArcOffset ) ) - 55
    );

end




--[[	---------------------------------------------------------------
        Utility Functions
        ---------------------------------------------------------------
--]]


-- 	Other Functions

--	Searches a specified String (source) for a keyword String (search)
--	String patterns are not allowed - simple search keywords are used
--	Returns a number representing the degree to which the search string
--	was found in the specified string using my own scoring system.
--	Number ( 0 - 100 )
--
function CTA_SearchScore( source, search, show ) -- NOT IN USE
    local ad = string.lower( source );
    local query = string.lower( search );

    if( string.find( ad, query ) ) then
        return 100, "|cff33ff33"..source.."|r";
    else
        local sourceWords = {};
        for word in string.gmatch( ad, "%w+" ) do
            sourceWords[word] = word;
        end

        local highlighted = source;

        local score = 0;
        local total = 0;
        for word in string.gmatch(query, "%w+") do
            total = total + 1;
            if( sourceWords[word] ) then
                score = score + 1;

                if( show ) then
                    local s, e = string.find( string.lower( highlighted ), word );
                    highlighted = string.sub( highlighted, 1, s-1 ).."|cff99ff33"..string.sub( highlighted, s, e ).."|r"..string.sub( highlighted, e+1 );
                end
            elseif( string.find( ad, word ) ) then
                score = score + 0.9;

                if( show ) then
                    local s, e = string.find( string.lower( highlighted ), word );
                    highlighted = string.sub( highlighted, 1, s-1 ).."|cffccff33"..string.sub( highlighted, s, e ).."|r"..string.sub( highlighted, e+1 );
                end
            end
        end

        if( score > 0 ) then
            score = floor(99*score/total);
        end

        return score, highlighted;
    end
end


-- 	Returns a String representation of the current time
--	String ( eg. "14:40" )
function CTA_GetTime()
    -- returns HH:MM:SS
    local hour, minute = GetGameTime();
    local t = hour;
    if( hour < 10 ) then t = "0"..t; end
    t = t..":";
    if( minute < 10 ) then t = t.."0"; end
    t = t..minute;
    -- add second to the time
    t = t..":";
    local second = floor(GetTime() % 60)
    if (second < 10) then t = t.."0"; end
    t = t..second
    return t;
end

function CTA_GetGameTime()
    -- returns HHMMSS
    local hour, minute = GetGameTime();
    local t = hour;
    if( hour < 10 ) then t = "0"..t; end
    if( minute < 10 ) then t = t.."0"; end
    t = t..minute;
    -- add second to the time
    local second = floor(GetTime() % 60)
    if (second < 10) then t = t.."0"; end
    t = t..second
    return t;
end

--	Returns a String from the specified textfield (uiVal)
--	If the String is Nil, then (defaultVal) is returned
--	String / defaultVal
--
function CTA_SafeSet( uiVal, defaultVal )
    if( not uiVal or uiVal=="" ) then
        return defaultVal;
    else
        return uiVal;
    end
end


--	Returns the number entered into the textfield (uiValue),
--	if the number is valid, is no less than (min) and is no more then (max)
-- 	Number / Nil
--
function CTA_SafeSetNumber( uiValue, min, max )
    for value in string.gmatch( uiValue, "(%d+)" ) do
        if( value and value ~= "" and tonumber(value) >=min and tonumber(value) <= max ) then
            return tonumber(value);
        end
    end
    return nil;
end


--	Shows an error dialog with a title, text and close button
--
function CTA_ShowError( title, text ) -- NOT IN USE
    CTA_InformationDialogHeadingLabel:SetText( title );
    CTA_InformationDialogContentLabel:SetText( text );
    CTA_InformationDialog:Show();
end


--	Returns the class code for this player.
--	Number ( 1 - 8 )
--
function CTA_MyClassCode()
    local myClass = UnitClass(CTA_PLAYER);
    return CTA_GetClassCode(myClass);
end


--	Returns a String representaion of a class code
--	String ( eg. "Priest" )
--
function CTA_GetClassCode( name )
    local classes = { };
    classes[CTA_PRIEST] = 1;
    classes[CTA_MAGE] = 2;
    classes[CTA_WARLOCK] = 3;
    classes[CTA_DRUID] = 4;
    classes[CTA_HUNTER] = 5;
    classes[CTA_ROGUE] = 6;
    classes[CTA_WARRIOR] = 7;
    classes[CTA_PALADIN] = 8;
    classes[CTA_SHAMAN] = 9;
    classes[CTA_DEATHKNIGHT] = 10;

    return classes[name];
end


--	Returns whether the class code (value) is in a class set (classSet)
--	Number ( 1 / 0 )
--
function CTA_CheckClasses( classSet, value )
    local b = "";
    local c = classSet;

    while( c > 0 ) do
        local d = mod(c, 2);
        b = d..b;
        c = floor(c/2);
    end
    while(string.len(b) < CTA_NUM_CLASSES ) do
        b = "0"..b;
    end

    return tonumber( string.sub(b, (CTA_NUM_CLASSES+1)-value, (CTA_NUM_CLASSES+1)-value ) );
end


--	Returns a String with all the class names represented by the class set
--	String ( eg. "Priest Druid Warlock" )
--
function CTA_GetClassString( classSet )
    local b = "";
    local c = classSet;

    local classes = { };
    classes[1] = CTA_PRIEST;
    classes[2] = CTA_MAGE;
    classes[3] = CTA_WARLOCK;
    classes[4] = CTA_DRUID;
    classes[5] = CTA_HUNTER;
    classes[6] = CTA_ROGUE;
    classes[7] = CTA_WARRIOR;
    classes[8] = CTA_PALADIN;
    classes[9] = CTA_SHAMAN;
    classes[10] = CTA_DEATHKNIGHT;

    while( c > 0 ) do
        local d = mod(c, 2);
        b = d..b;
        c = floor(c/2);
    end
    while(string.len(b) < CTA_NUM_CLASSES ) do
        b = "0"..b;
    end

    local pos = CTA_NUM_CLASSES;
    local t = "";
    while( pos > 0 ) do
        if( string.sub(b, pos, pos) == "1" ) then
            t = t..classes[(1+CTA_NUM_CLASSES)-pos].." ";
        end
        pos = pos - 1;
    end
    return t;
end


--	Generic Tooltip Function
--
function CTA_ShowTooltip(self) -- Called by XML
    if( CTA_GenTooltips[self:GetName()] ) then
        GameTooltip:SetOwner( _G[self:GetName()], "ANCHOR_TOP" );
        GameTooltip:ClearLines();
        GameTooltip:ClearAllPoints();
        GameTooltip:SetPoint("TOPLEFT", self:GetName(), "BOTTOMLEFT", 0, -2);
        GameTooltip:AddLine( CTA_GenTooltips[self:GetName()].tooltip1 );
        GameTooltip:AddLine( CTA_GenTooltips[self:GetName()].tooltip2, 1, 1, 1, 1, 1 );
        GameTooltip:Show();
    end
end




--[[	---------------------------------------------------------------
        DEBUG / PROVING GROUNDS
        ---------------------------------------------------------------
--]]

function CTA_Error( s )
    UIErrorsFrame:AddMessage(s, 0.75, 0.75, 1.0, 1.0, UIERRORS_HOLD_TIME);
end

function CTA_Println( s )
    local m = s;
    if( not m ) then
        m = "nil";
    end

    if( DEFAULT_CHAT_FRAME ) then
        DEFAULT_CHAT_FRAME:AddMessage( "CTA: "..m, 1, 1, 0.5);
    end
end

function CTA_IconMsg( s, t )
    local m = s;
    if( not m ) then
        m = "nil";
    end

    if( not t ) then
        CTA_MinimapMessageFrame:AddMessage(m, 1.0, 1.0, 0.5, 1.0, UIERRORS_HOLD_TIME);
    else
        local r = CTA_MESSAGE_COLOURS[t].r;
        local g = CTA_MESSAGE_COLOURS[t].g;
        local b = CTA_MESSAGE_COLOURS[t].b;

        CTA_MinimapMessageFrame:AddMessage(m, r, g, b, 1.0, UIERRORS_HOLD_TIME);
    end
end

function CTA_LogMsg( s, t )
    local m = s;
    if( not m ) then
        m = "nil";
    end
    m = "["..CTA_GetTime().."] "..m;


    if( not t ) then
        CTA_Log:AddMessage( m, 1.0, 1.0, 0.5 );
    else
        local r = CTA_MESSAGE_COLOURS[t].r;
        local g = CTA_MESSAGE_COLOURS[t].g;
        local b = CTA_MESSAGE_COLOURS[t].b;

        CTA_Log:AddMessage( m, r, g, b );
    end
end







-- R7




function SachaSearch( source, search )
    if( not ( source and search ) ) then
        return nil;
    end

    local s = trim( search );
    local operator, op1, op2 = getOps( s );

    if( operator ) then
        local op1Res = SachaSearch( source, op1 );
        if( not op1Res ) then
            return 0;
        elseif( op1Res > 0 and operator == "/" ) then
            return 1;
        elseif( op1Res == 0 and operator == "+" ) then
            return 0;
        end

        local op2Res = SachaSearch( source, op2, verbose );
        if( not op2Res ) then
            return 0;
        elseif( op2Res > 0 and ( op1Res > 0 or operator == "/" ) ) then
            return 1;
        end
        return 0;
    else
        local literal;
        if( string.sub( s, 1, 1 ) == "-" ) then
            return( 1 - SachaSearch( source, trim( string.sub( s, 2 ) ) ) );
        elseif( string.sub( s, 1, 1 ) == "(" and string.sub( s, string.len( s ) ) == ")" ) then
            return SachaSearch( source, trim( string.sub( s, 2, string.len( s ) - 1 ) ) );
        elseif( string.sub( s, 1, 1 ) == "\"" and string.sub( s, string.len( s ) ) == "\"" ) then
            s = trim( string.sub( s, 2, string.len( s ) - 1 ) );
            literal = 1;
        end

        if( literal ) then
            if( string.find( source, s ) ) then
                return 1;
            else
                return 0;
            end
        else
            if( SachaScoredSearch( source, s ) > 0 ) then
                return 1;
            else
                return 0;
            end
        end
    end
end

function trim(s)
    if( not s ) then return nil; end
    return( string.gsub(s, "^%s*(.-)%s*$", "%1") or s );
end

function getOps( source )
    local operatorFound = nil;
    local bracketCount = 0;
    local inQuote = 0;
    local pos = 0;

    local currentChar;
    while( pos < string.len( source ) ) do
        currentChar = string.sub( source, pos, pos );
        if( ( currentChar == "+" or currentChar == "/" ) and bracketCount == 0 and inQuote == 0 ) then
            operatorFound = 1;
            break;
        elseif( currentChar == "(" ) then
            bracketCount = bracketCount + 1;
        elseif( currentChar == ")" ) then
            bracketCount = bracketCount - 1;
        elseif( currentChar == "\"" ) then
            inQuote = 1 - inQuote;
        end
        pos = pos + 1;
    end

    if( operatorFound ) then
        return currentChar, string.sub( source, 1, pos - 1 ), string.sub( source, pos + 1 );
    end
end


function SachaScoredSearch( source, search )
    local ad = string.lower( source );
    local query = string.lower( search );

    if( string.find( ad, query ) ) then
        return 100;
    else
        local score = 0;
        local total = 0;
        for word in string.gmatch(query, "%w+") do
            total = total + 1;
            if( string.find( ad, "%s+"..word.."%s+" ) ) then
                score = score + 1;
            elseif( string.find( ad, word ) ) then
                score = score + 0.9;
            end
        end

        if( score > 0 and total > 0 ) then
            score = floor(99*score/total);
        end

        return score;
    end
end



function CTA_GetGroupClassesCode()
    local groupClasses = {};
    groupClasses[1] = 0;
    groupClasses[2] = 0;
    groupClasses[3] = 0;
    groupClasses[4] = 0;
    groupClasses[5] = 0;
    groupClasses[6] = 0;
    groupClasses[7] = 0;
    groupClasses[8] = 0;
    groupClasses[9] = 0;
    groupClasses[10] = 0;

    local name, level, class;
    for num = 1, 40 do
        name, level, class = CTA_GetGroupMemberInfo( num );
        if( name == nil ) then break; end
        groupClasses[ CTA_GetClassCode(class) ] = groupClasses[ CTA_GetClassCode(class) ] + 1;
    end

    local retVal = "";
    for num = 1, CTA_NUM_CLASSES do
        retVal = retVal..groupClasses[ num ]..",";
    end
    return retVal;
end

function CTA_DecodeGroupClasses( code )
    if( not code or code == 0 ) then
        return;
    end

    local classes = {};
    classes[1] = CTA_PRIEST;
    classes[2] = CTA_MAGE;
    classes[3] = CTA_WARLOCK;
    classes[4] = CTA_DRUID;
    classes[5] = CTA_HUNTER;
    classes[6] = CTA_ROGUE;
    classes[7] = CTA_WARRIOR;
    classes[8] = CTA_PALADIN;
    classes[9] = CTA_SHAMAN;
    classes[10] = CTA_DEATHKNIGHT;

    --local retVal;
    local retVal2;
    local extra2 = {};

    for priest, mage, warlock, druid, hunter, rogue, warrior, paladin, shaman, deathknight, version, extra in string.gmatch( code, "(%d+),(%d+),(%d+),(%d+),(%d+),(%d+),(%d+),(%d+),(%d+),(%d+),([^,]+),([^,]+)" ) do
        --[[
            extra is now coding for strings which are separated by ";" note that the strings may NOT contain any ":" or ","
            it generates a table of strings which is returned
            NB: I might need it to implement the max level req for groups.

        --]]

        classes[1] = priest;
        classes[2] = mage;
        classes[3] = warlock;
        classes[4] = druid;
        classes[5] = hunter;
        classes[6] = rogue;
        classes[7] = warrior;
        classes[8] = paladin;
        classes[9] = shaman;
        classes[10] = deathknight;

        retVal2 = version;
        if extra then
            for i in string.gmatch( extra, "[^;]+" ) do
                table.insert(extra2, i)
            end
        end

    end

    return classes, retVal2, extra2;
end



function CTA_RoleplayDropDown_OnClick(self)
    UIDropDownMenu_SetSelectedID(CTA_RoleplayDropDown, self:GetID());
    CTA_RP_TYPE = self:GetID()
    CTA_MyRaidInstantUpdate();
end

function CTA_RoleplayDropDown_Init()
    local info = {};
    info.text = CTA_RPLEVEL[1];
    info.func = CTA_RoleplayDropDown_OnClick;
    UIDropDownMenu_AddButton(info);

    info = {};
    info.text = CTA_RPLEVEL[2];
    info.func = CTA_RoleplayDropDown_OnClick;
    UIDropDownMenu_AddButton(info);

    info = {};
    info.text = CTA_RPLEVEL[3];
    info.func = CTA_RoleplayDropDown_OnClick;
    UIDropDownMenu_AddButton(info);

    info = {};
    info.text = CTA_RPLEVEL[4];
    info.func = CTA_RoleplayDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
end



function CTA_SearchDropDown_OnClick(self)
    UIDropDownMenu_SetSelectedID(CTA_SearchDropDown, self:GetID());
end

function CTA_SearchDropDown_Init()
    local info = {};
    info.text = CTA_SHOW_PLAYERS_AND_GROUPS;
    info.func = CTA_SearchDropDown_OnClick;
    UIDropDownMenu_AddButton(info);

    info.text = CTA_SHOW_GROUPS_ONLY;
    info.func = CTA_SearchDropDown_OnClick;
    UIDropDownMenu_AddButton(info);

    info.text = CTA_SHOW_PLAYERS_ONLY;
    info.func = CTA_SearchDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
end


function CTA_ShowLFGFrame()
    if ( CTA_GetNumGroupMembers() > 1  ) then
        CTA_CannotLFGFrame:Show();
        CTA_LFGFrame:Hide();
    else
        CTA_CannotLFGFrame:Hide();
        CTA_LGMPrefixLabel:SetText( "Level "..UnitLevel( CTA_PLAYER ).." "..UnitClass( CTA_PLAYER ).." "..CTA_LFG.." " );
        CTA_LFGFrame:Show();
    end
end


function CTA_InitClassTable()
    CTA_Classes[1] = CTA_PRIEST;
    CTA_Classes[2] = CTA_MAGE;
    CTA_Classes[3] = CTA_WARLOCK;
    CTA_Classes[4] = CTA_DRUID;
    CTA_Classes[5] = CTA_HUNTER;
    CTA_Classes[6] = CTA_ROGUE;
    CTA_Classes[7] = CTA_WARRIOR;
    CTA_Classes[8] = CTA_PALADIN;
    CTA_Classes[9] = CTA_SHAMAN;
    CTA_Classes[10] = CTA_DEATHKNIGHT;

    CTA_Classes[CTA_PRIEST] 	= 1;
    CTA_Classes[CTA_MAGE] 		= 2;
    CTA_Classes[CTA_WARLOCK] 	= 3;
    CTA_Classes[CTA_DRUID] 		= 4;
    CTA_Classes[CTA_HUNTER] 	= 5;
    CTA_Classes[CTA_ROGUE] 		= 6;
    CTA_Classes[CTA_WARRIOR] 	= 7;
    CTA_Classes[CTA_PALADIN] 	= 8;
    CTA_Classes[CTA_SHAMAN] 	= 9;
    CTA_Classes[CTA_DEATHKNIGHT] 	= 10;
end


function CTA_PlayerClassDropDown_Init()
    if( not CTA_Classes[i] ) then
        CTA_InitClassTable();
    end

    local info = {};
    info.text = CTA_ANY_CLASS;
    info.func = CTA_PlayerClassDropDown_OnClick;
    UIDropDownMenu_AddButton(info);

    for i=1, CTA_NUM_CLASSES do
        info.text = CTA_Classes[i];
        info.func = CTA_PlayerClassDropDown_OnClick;
        UIDropDownMenu_AddButton(info);
    end
end


function CTA_PlayerClassDropDown_OnClick(self)
    UIDropDownMenu_SetSelectedID(CTA_PlayerClassDropDown, self:GetID());
end
