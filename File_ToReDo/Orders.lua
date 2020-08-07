function Orders(msg)
local text = msg.content_.text_
if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
------------------------------------------hso----------------------------------
if text == ("مسح قائمه العام") and Sudo_ToReDo(msg) then
redis:del(ToReDo..'GBan:User')
send(msg.chat_id_, msg.id_, '\n܁༯┆تم مسـح قائمةه العام 💞 ܰ')
return false
end

if text == ("قائمه العام") and Sudo_ToReDo(msg) then
local list = redis:smembers(ToReDo..'GBan:User')
t = "\n܁༯┆قائمة العام 💞💞 .\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = redis:get(ToReDo.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜*@"..username.."*◞  💞🦄 .\n"
else
end
end
if #list == 0 then
t = "٭ 𖤹┆لا يوجد احد محظور عام ☓◟"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("حظر عام") and msg.reply_to_message_id_ and Sudo_ToReDo(msg) then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك حظر المطور الاساسي 💞 ܰ\n")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(ToReDo) then  
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك حظر البوت  💞 ܰ\n")
return false 
end
redis:sadd(ToReDo..'GBan:User', result.sender_user_id_)
chat_kick(result.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم حظر العضو عام  💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^حظر عام @(.*)$")  and Sudo_ToReDo(msg) then
local username = text:match("^حظر عام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  💞 ܰ")   
return false 
end      
if tonumber(result.id_) == tonumber(ToReDo) then  
send(msg.chat_id_, msg.id_, "܁༯┆لا تستطيع حظر البوت 💞 ܰ")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك حظر المطور الاساسي 💞 ܰ\n")
return false 
end
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم حظر العضو عام  💞 ܰ'
texts = usertext..status
redis:sadd(ToReDo..'GBan:User', result.id_)
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  💞 ܰ\n'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^حظر عام (%d+)$") and Sudo_ToReDo(msg) then
local userid = text:match("^حظر عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك حظر المطور الاساسي 💞 ܰ\n")
return false 
end
if tonumber(userid) == tonumber(ToReDo) then  
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك حظر البوت  💞 ܰ")
return false 
end
redis:sadd(ToReDo..'GBan:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم حظر العضو عام  💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم حظر العضو عام  💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("كتم عام") and msg.reply_to_message_id_ and Sudo_ToReDo(msg) then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك كتم المطور الاساسي 💞 ܰ\n")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(ToReDo) then  
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك كتم البوت عام  💞 ܰ")
return false 
end
redis:sadd(ToReDo..'Gmute:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم كتم العضو عام من المجموعات  💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم عام @(.*)$")  and Sudo_ToReDo(msg) then
local username = text:match("^كتم عام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  💞 ܰ")   
return false 
end      
if tonumber(result.id_) == tonumber(ToReDo) then  
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك كتم البوت  💞 ܰ")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك كتم المطور الاساسي  💞 ܰ\n")
return false 
end
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم كتم العضو عام من المجموعات  💞 ܰ'
texts = usertext..status
redis:sadd(ToReDo..'Gmute:User', result.id_)
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  💞 ܰ\n'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^كتم عام (%d+)$") and Sudo_ToReDo(msg) then
local userid = text:match("^كتم عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك كتم المطور الاساسي 💞 ܰ\n")
return false 
end
if tonumber(userid) == tonumber(ToReDo) then  
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك كتم البوت  💞 ܰ")
return false 
end
redis:sadd(ToReDo..'Gmute:User', userid)

tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم كتم العضو عام من المجموعات  💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم كتم العضو عام من المجموعات  💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("الغاء العام") and msg.reply_to_message_id_ and Sudo_ToReDo(msg) then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم الغاء ܊ الحظر ٭ الكتم ܊ عام من المجموعات 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
redis:srem(ToReDo..'GBan:User', result.sender_user_id_)
redis:srem(ToReDo..'Gmute:User', result.sender_user_id_)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء العام @(.*)$") and Sudo_ToReDo(msg) then
local username = text:match("^الغاء العام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
if result.id_ then
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم الغاء ܊ الحظر ٭ الكتم ܊ عام من المجموعات 💞 ܰ'
texts = usertext..status
redis:srem(ToReDo..'GBan:User', result.id_)
redis:srem(ToReDo..'Gmute:User', result.id_)
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  💞 ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^الغاء العام (%d+)$") and Sudo_ToReDo(msg) then
local userid = text:match("^الغاء العام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
redis:srem(ToReDo..'GBan:User', userid)
redis:srem(ToReDo..'Gmute:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم الغاء ܊ الحظر ٭ الكتم ܊ عام من المجموعات 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم الغاء ܊ الحظر ٭ الكتم ܊ عام من المجموعات 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("مسح المطورين") and Sudo_ToReDo(msg) then
redis:del(ToReDo..'Sudo:User')
send(msg.chat_id_, msg.id_, "\n܁༯┆تم مسح المطورين 💞 ܰ ")
end
if text == ("المطورين") and Sudo_ToReDo(msg) then
local list = redis:smembers(ToReDo..'Sudo:User')
t = "\n܁༯┆قائمة المطورين 💞💞 .\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = redis:get(ToReDo.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜*@"..username.."*◞  💞🦄 .\n"
else
end
end
if #list == 0 then
t = "٭ 𖤹┆لا يوجد مطوريين ☓◟"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مطور") and msg.reply_to_message_id_ and Sudo_ToReDo(msg) then
function start_function(extra, result, success)
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
redis:sadd(ToReDo..'Sudo:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم رفع العضو ◃ مطور💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور @(.*)$") and Sudo_ToReDo(msg) then
local username = text:match("^رفع مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  💞 ܰ")   
return false 
end      
redis:sadd(ToReDo..'Sudo:User', result.id_)
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم رفع العضو ◃ مطور💞 ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  💞 ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور (%d+)$") and Sudo_ToReDo(msg) then
local userid = text:match("^رفع مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
redis:sadd(ToReDo..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم رفع العضو ◃ مطور💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم رفع العضو ◃ مطور💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("تنزيل مطور") and msg.reply_to_message_id_ and Sudo_ToReDo(msg) then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
redis:srem(ToReDo..'Sudo:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم تنزيل العضو ◃ مطور💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^تنزيل مطور @(.*)$") and Sudo_ToReDo(msg) then
local username = text:match("^تنزيل مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
if result.id_ then
redis:srem(ToReDo..'Sudo:User', result.id_)
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم تنزيل العضو ◃ مطور💞 ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  💞 ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مطور (%d+)$") and Sudo_ToReDo(msg) then
local userid = text:match("^تنزيل مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
redis:srem(ToReDo..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم تنزيل العضو ◃ مطور💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم تنزيل العضو ◃ مطور💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
------------------------------------------------------------------------
if text == ("مسح الاساسين") and Sudo(msg) then
redis:del(ToReDo..'Basic:Constructor'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n܁༯┆تم مسح الاساسين 💞 ܰ')
return false
end

if text == 'المنشئين الاساسين' and Sudo(msg) then
local list = redis:smembers(ToReDo..'Basic:Constructor'..msg.chat_id_)
t = "\n٭ 𖤓┆قائمة الاساسيين 💞💞◟\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = redis:get(ToReDo.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜[@"..username.."]◞ .\n"
else
end
end
if #list == 0 then
t = "܁༯┆لايوجد منشئين اساسيين 💞 ܰ"
end
send(msg.chat_id_, msg.id_, t)
return false
end

if text == ("رفع منشئ اساسي") and msg.reply_to_message_id_ and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
redis:sadd(ToReDo..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم رفع العضو منشى اساسي 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي @(.*)$") and Sudo(msg) then
local username = text:match("^رفع منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  💞 ܰ")   
return false 
end      
redis:sadd(ToReDo..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم رفع العضو منشى اساسي 💞 ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  💞 ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي (%d+)$") and Sudo(msg) then
local userid = text:match("^رفع منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
redis:sadd(ToReDo..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم رفع العضو منشى اساسي 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم رفع العضو منشى اساسي 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل منشئ اساسي") and msg.reply_to_message_id_ and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
redis:srem(ToReDo..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم تنزيل العضو ◃ منشى اساسي 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي @(.*)$") and Sudo(msg) then
local username = text:match("^تنزيل منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
if result.id_ then
redis:srem(ToReDo..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم تنزيل العضو ◃ منشى اساسي 💞 ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  💞 ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي (%d+)$") and Sudo(msg) then
local userid = text:match("^تنزيل منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
redis:srem(ToReDo..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم تنزيل العضو ◃ منشى اساسي 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم تنزيل العضو ◃ منشى اساسي 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end

------------------------------------------------------------------------
if text == 'مسح المنشئين' and BasicConstructor(msg) then
redis:del(ToReDo..'Constructor'..msg.chat_id_)
texts = '܁༯┆ تم مسح قائمة المنشئين 💞 ܰ'
send(msg.chat_id_, msg.id_, texts)
end

if text == ("المنشئين") and BasicConstructor(msg) then
local list = redis:smembers(ToReDo..'Constructor'..msg.chat_id_)
t = "\n٭ 𖤓┆قائمة المنشئين 💞💞◟\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = redis:get(ToReDo.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜[@"..username.."]◞ .\n"
else
end
end
if #list == 0 then
t = "܁༯┆لايوجد منشئين 💞 ܰ"
end
send(msg.chat_id_, msg.id_, t)
end
if text ==("المنشئ") then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_,"܁༯┆المنشئ محذوف 😹😔💞 ܰ")
return false  
end
local UserName = (b.username_ or "XXXC_X")
send(msg.chat_id_, msg.id_,"܁༯┆منشئ المجموعةه ◃ ["..b.first_name_.."](T.me/"..UserName..") 💞 ܰ ")  
end,nil)   
end
end
end,nil)   
end
if text == "رفع منشئ" and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
redis:sadd(ToReDo..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم رفع العضو منشى 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^رفع منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  💞 ܰ")   
return false 
end      
redis:sadd(ToReDo..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم رفع العضو منشى 💞 ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  💞 ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^رفع منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^رفع منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
redis:sadd(ToReDo..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم رفع العضو منشى 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم رفع العضو منشى 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
if text and text:match("^تنزيل منشئ$") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
redis:srem(ToReDo..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المنشئين 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^تنزيل منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
if result.id_ then
redis:srem(ToReDo..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المنشئين 💞 ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  💞 ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^تنزيل منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^تنزيل منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
redis:srem(ToReDo..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المنشئين 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المنشئين 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
------------------------------------------------------------------------
if text == 'مسح المدراء' and Constructor(msg) then
redis:del(ToReDo..'Owners'..msg.chat_id_)
texts = '܁༯┆ تم مسح قائمة المدراء 💞 ܰ '
send(msg.chat_id_, msg.id_, texts)
end
if text == ("المدراء") and Constructor(msg) then
local list = redis:smembers(ToReDo..'Owners'..msg.chat_id_)
t = "\n٭ 𖤓┆قائمة المدراء 💞💞◟\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = redis:get(ToReDo.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜[@"..username.."]◞ .\n"
else
end
end
if #list == 0 then
t = "܁༯┆لايوجد مدراء ?? ܰ"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
redis:sadd(ToReDo..'Owners'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري 💞 ܰ' 
status  = '\n܁༯┆تم رفع العضو مدير 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^رفع مدير @(.*)$") and Constructor(msg) then
local username = text:match("^رفع مدير @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  💞 ܰ")   
return false 
end      
redis:sadd(ToReDo..'Owners'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري 💞 ܰ' 
status  = '\n܁༯┆تم رفع العضو مدير 💞 ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  💞 ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end 

if text and text:match("^رفع مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^رفع مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
redis:sadd(ToReDo..'Owners'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري 💞 ܰ' 
status  = '\n܁༯┆تم رفع العضو مدير 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري 💞 ܰ' 
status  = '\n܁༯┆تم رفع العضو مدير 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
if text == ("تنزيل مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
redis:srem(ToReDo..'Owners'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المدراء 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل مدير @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت ??.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
if result.id_ then
redis:srem(ToReDo..'Owners'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المدراء 💞 ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  ?? ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^تنزيل مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
redis:srem(ToReDo..'Owners'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المدراء 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المدراء 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text ==("رفع الادمنيه") and Owners(msg) then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local num2 = 0
local admins = data.members_
for i=0 , #admins do
if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then
redis:sadd(ToReDo.."Mod:User"..msg.chat_id_, admins[i].user_id_)
num2 = num2 + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,b) 
if b.username_ == true then
end
if b.first_name_ == false then
redis:srem(ToReDo.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
redis:srem(ToReDo.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end
if num2 == 0 then
send(msg.chat_id_, msg.id_,"܁༯┆  لا توجد ادمنيةه ليتم رفعهم 💞 ܰ") 
else
send(msg.chat_id_, msg.id_,"܁༯┆ تمت ترقيةه ◃ "..num2.."  من ادمنية المجموعةه 💞 ܰ") 
end
end,nil)   
end
if text == 'مسح الادمنيه' and Owners(msg) then
redis:del(ToReDo..'Mod:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '܁༯┆ تم مسح قائمة الادمنية 💞 ܰ')
end
if text == ("الادمنيه") then
local list = redis:smembers(ToReDo..'Mod:User'..msg.chat_id_)
t = "\n٭ 𖤓┆قائمة الادمنيه 💞💞◟\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = redis:get(ToReDo.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜[@"..username.."]◞ .\n"
else
end
end
if #list == 0 then
t = "܁༯┆لايوجد ادمنيه 💞 ܰ"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع ادمن") and msg.reply_to_message_id_ and Owners(msg) then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
if redis:get(ToReDo..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆ تم تعطيل الرفع من قبل المنشئين 💞 ܰ') 
return false
end
redis:sadd(ToReDo..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم رفع العضو ادمن 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن @(.*)$") and Owners(msg) then
local username = text:match("^رفع ادمن @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆ تم تعطيل الرفع من قبل المنشئين 💞 ܰ') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  💞 ܰ")   
return false 
end      
redis:sadd(ToReDo..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم رفع العضو ادمن 💞 ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  💞 ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن (%d+)$") and Owners(msg) then
local userid = text:match("^رفع ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆ تم تعطيل الرفع من قبل المنشئين 💞 ܰ') 
return false
end
redis:sadd(ToReDo..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم رفع العضو ادمن 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم رفع العضو ادمن 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل ادمن") and msg.reply_to_message_id_ and Owners(msg) then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
redis:srem(ToReDo..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم تنزيل العضو من الادمنية 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن @(.*)$") and Owners(msg) then
local username = text:match("^تنزيل ادمن @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
if result.id_ then
redis:srem(ToReDo..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم تنزيل العضو من الادمنية 💞 ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  💞 ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن (%d+)$") and Owners(msg) then
local userid = text:match("^تنزيل ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت ??.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
redis:srem(ToReDo..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم تنزيل العضو من الادمنية ?? ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم تنزيل العضو من الادمنيةه 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
------------------------------------------------------------------------
if text == ("طرد") and msg.reply_to_message_id_ ~=0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆ تم تعطيل الطرد من قبل المنشئين 💞 ܰ') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(ToReDo) then  
send(msg.chat_id_, msg.id_, "܁༯┆ لا تستطيع طرد البوت💞 ܰ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n܁༯┆ عذرا لا استطيع طرد ◃ كتم ◃ تقييد ◃  ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'܁༯┆ليس لدي صلاحية الحظر يرجى تفعيلها 💞 ܰ') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆ البوت ليس ادمن يرجئ ترقيتي 💞 ܰ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆ههلو عمري 💞 ܰ '
statusk  = '\n܁༯┆تم طرد العضو بنجاح 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..statusk)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^طرد @(.*)$") and Mod(msg) then 
local username = text:match("^طرد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆ تم تعطيل الطرد من قبل المنشئين ?? ܰ') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(ToReDo) then  
send(msg.chat_id_, msg.id_, "܁༯┆ لاتستطيع طرد البوت💞 ܰ ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n܁༯┆ عذرا لا استطيع طرد ◃ كتم ◃ تقييد ◃  ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆ عذرا عزيزي هذا معرف قناة 💞 ܰ ")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'܁༯┆ليس لدي صلاحية الحظر يرجى تفعيلها 💞 ܰ') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆ البوت ليس ادمن يرجئ ترقيتي 💞 ܰ') 
return false  
end
usertext = '\n܁༯┆ههلو عمري 💞 ܰ '
statusk  = '\n܁༯┆تم طرد العضو بنجاح 💞 ܰ'
texts = usertext..statusk
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, '܁༯┆ لايوجد معرف بهذا الحساب 💞 ܰ ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  

if text and text:match("^طرد (%d+)$") and Mod(msg) then 
local userid = text:match("^طرد (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆ تم تعطيل الطرد من قبل المنشئين 💞 ܰ') 
return false
end
if tonumber(userid) == tonumber(ToReDo) then  
send(msg.chat_id_, msg.id_, "܁༯┆ لاتستطيع طرد البوت💞 ܰ ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n܁༯┆ عذرا لا استطيع طرد ◃ كتم ◃ تقييد ◃  ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'܁༯┆ليس لدي صلاحية الحظر يرجى تفعيلها 💞 ܰ') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆ البوت ليس ادمن يرجئ ترقيتي 💞 ܰ') 
return false  
end
chat_kick(msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆ههلو عمري 💞 ܰ '
statusk  = '\n܁༯┆تم طرد العضو بنجاح 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..statusk)
else
usertext = '\n܁༯┆ههلو عمري 💞 ܰ '
statusk  = '\n܁༯┆تم طرد العضو بنجاح 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..statusk)
end;end,nil)
end,nil)   
end
return false
end
------------------------------------------------------------------------
if text == 'مسح المميزين' and Mod(msg) then
redis:del(ToReDo..'Vips:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '܁༯┆ تم مسح قائمة الاعضاء المميزين 💞 ܰ')
end
if text == ("المميزين") and Mod(msg) then
local list = redis:smembers(ToReDo..'Vips:User'..msg.chat_id_)
t = "\n٭ 𖤓┆قائمة المميزين 💞💞◟\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = redis:get(ToReDo.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜[@"..username.."]◞ .\n"
else
end
end
if #list == 0 then
t = "܁༯┆لايوجد مميزين 💞 ܰ"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مميز") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆ تم تعطيل الرفع من قبل المنشئين 💞 ܰ') 
return false
end
function start_function(extra, result, success)
redis:sadd(ToReDo..'Vips:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
local  statuss  = '\n܁༯┆تم رفع العضو مميز 💞 ܰ '
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مميز @(.*)$") and Mod(msg) then
local username = text:match("^رفع مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆ تم تعطيل الرفع من قبل المنشئين 💞 ܰ') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  💞 ܰ")   
return false 
end      
redis:sadd(ToReDo..'Vips:User'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
local  statuss  = '\n܁༯┆تم رفع العضو مميز 💞 ܰ '
texts = usertext..statuss
else
texts = '܁༯┆لايوجد حساب بهذا المعرف 💞 ܰ' 
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^رفع مميز (%d+)$") and Mod(msg) then
local userid = text:match("^رفع مميز (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆ تم تعطيل الرفع من قبل المنشئين 💞 ܰ') 
return false
end
redis:sadd(ToReDo..'Vips:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
local  statuss  = '\n܁༯┆تم رفع العضو مميز 💞 ܰ '
send(msg.chat_id_, msg.id_, usertext..statuss)
else
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
local  statuss  = '\n܁༯┆تم رفع العضو مميز 💞 ܰ '
send(msg.chat_id_, msg.id_, usertext..statuss)
end;end,nil)
return false
end

if (text == ("تنزيل مميز")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
redis:srem(ToReDo..'Vips:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المميزين 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز @(.*)$") and Mod(msg) then
local username = text:match("^تنزيل مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
if result.id_ then
redis:srem(ToReDo..'Vips:User'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المميزين 💞 ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  💞 ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز (%d+)$") and Mod(msg) then
local userid = text:match("^تنزيل مميز (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
redis:srem(ToReDo..'Vips:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المميزين 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري 💞 ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المميزين 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
-------------------------------------LOKRAND - @bbbbl - @Y07BOT - @VVWVV3 - @k777a ---------------------------------------
if text == 'مسح المحظورين' and Mod(msg) then
redis:del(ToReDo..'Ban:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n܁༯┆تم مسح المحظورين 💞 ܰ')
end
if text == ("المحظورين") then
local list = redis:smembers(ToReDo..'Ban:User'..msg.chat_id_)
t = "\n٭ 𖤓┆قائمة المحظورين 💞💞◟\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = redis:get(ToReDo.."user:Name" .. v)
if username then
t = t.."?? "..k.." ◜[@"..username.."]◞ .\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "܁༯┆لايوجد محظورين 💞 ܰ"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("حظر") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆تم تعطيل الحظر من قبل المنشئين 💞 ܰ') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(ToReDo) then  
send(msg.chat_id_, msg.id_, "܁༯┆لا تسطيع حظر البوت 💞 ܰ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n܁༯┆عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'܁༯┆ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها 💞 ܰ') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆البوت ليس ادمن يرجى ترقيتي 💞 ܰ') 
return false  
end
redis:sadd(ToReDo..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆ههلو عمري 💞 ܰ'
status  = '\n܁༯┆تم حظر العضو بنجاح 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text and text:match("^حظر @(.*)$") and Mod(msg) then
local username = text:match("^حظر @(.*)$")
if redis:get(ToReDo..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆تم تعطيل الحظر من قبل المنشئين 💞 ܰ') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n܁༯┆عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'܁༯┆ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها 💞 ܰ') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
redis:sadd(ToReDo..'Ban:User'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆ههلو عمري 💞 ܰ'
status  = '\n܁༯┆تم حظر العضو بنجاح 💞 ܰ'
texts = usertext..status
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, '܁༯┆لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^حظر (%d+)$") and Mod(msg) then
local userid = text:match("^حظر (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆تم تعطيل الحظر من قبل المنشئين 💞 ܰ') 
return false
end
if tonumber(userid) == tonumber(ToReDo) then  
send(msg.chat_id_, msg.id_, "܁༯┆لا تسطيع حظر البوت 💞 ܰ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n܁༯┆عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'܁༯┆ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها 💞 ܰ') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
redis:sadd(ToReDo..'Ban:User'..msg.chat_id_, userid)
chat_kick(msg.chat_id_, userid)  
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆ههلو عمري 💞 ܰ'
status  = '\n܁༯┆تم حظر العضو بنجاح 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆ههلو عمري 💞 ܰ'
status  = '\n܁༯┆تم حظر العضو بنجاح 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end,nil)   
end
return false
end
if text == ("الغاء حظر") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(ToReDo) then
send(msg.chat_id_, msg.id_, '܁༯┆ انا لست محظورا \n') 
return false 
end
redis:srem(ToReDo..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆ههلو عمري 💞 ܰ'
status  = '\n܁༯┆تم الغاء حظر العضو 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
 
if text and text:match("^الغاء حظر @(.*)$") and Mod(msg) then
local username = text:match("^الغاء حظر @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(ToReDo) then
send(msg.chat_id_, msg.id_, '܁༯┆ انا لست محظورا \n') 
return false 
end
redis:srem(ToReDo..'Ban:User'..msg.chat_id_, result.id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
usertext = '\n܁༯┆ههلو عمري 💞 ܰ'
status  = '\n܁༯┆تم الغاء حظر العضو 💞 ܰ'
texts = usertext..status
else
texts = '܁༯┆ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء حظر (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء حظر (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if tonumber(userid) == tonumber(ToReDo) then
send(msg.chat_id_, msg.id_, '܁༯┆ انا لست محظورا \n') 
return false 
end
redis:srem(ToReDo..'Ban:User'..msg.chat_id_, userid)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆ههلو عمري 💞 ܰ'
status  = '\n܁༯┆تم الغاء حظر العضو 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆ههلو عمري 💞 ܰ'
status  = '\n܁༯┆تم الغاء حظر العضو 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end

------------------------------------------------------------------------
if text == 'مسح المكتومين' and Mod(msg) then
redis:del(ToReDo..'Muted:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '܁༯┆تم مسح المكتومين 💞 ܰ ')
end
if text == ("المكتومين") and Mod(msg) then
local list = redis:smembers(ToReDo..'Muted:User'..msg.chat_id_)
t = "\n٭ 𖤓┆قائمة المكتومين 😹😭💞◟\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = redis:get(ToReDo.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜[@"..username.."]◞ .\n"
else
end
end
if #list == 0 then
t = "܁༯┆لايوجد مكتومين 💞 ܰ"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("كتم") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(ToReDo) then  
send(msg.chat_id_, msg.id_, "܁༯┆ ليش شمسويلك حته تكتم البوت؟؟ + البوت مينكتم 😹😔💞 ܰ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n܁༯┆لا تستطيع طرد ܊ حظر ܊ كتم ܊ تقييد \n܁༯┆٭ ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆البوت ليس ادمن يرجى ترقيتي 💞 ܰ') 
return false  
end
redis:sadd(ToReDo..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆ههلو عمري 💞 ܰ'
status  = '\n܁༯┆العضو تم ◃ كتمةه ههناا  💞 ܰ' 
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم @(.*)$") and Mod(msg) then
local username = text:match("^كتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆البوت ليس ادمن يرجى ترقيتي 💞 ܰ') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(ToReDo) then  
send(msg.chat_id_, msg.id_, "܁༯┆لا تستطيع كتم البوت 💞 ܰ ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n܁༯┆لا تستطيع طرد ܊ حظر ܊ كتم ܊ تقييد \n܁༯┆٭ ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  💞 ܰ")   
return false 
end      
redis:sadd(ToReDo..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆ههلو عمري 💞 ܰ'
status  = '\n܁༯┆العضو تم ◃ كتمةه ههناا  💞 ܰ' 
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
end
else
send(msg.chat_id_, msg.id_, '܁༯┆لا يوجد حساب بهاذا المعرف ?? ܰ ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match('^كتم (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n܁༯┆لا تستطيع طرد ܊ حظر ܊ كتم ܊ تقييد \n܁༯┆٭ ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم كتم العضو ◃ '..TextEnd[2]..' '..TextEnd[3]..' 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if text and text:match('^كتم (%d+) (.*) @(.*)$') and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  💞 ܰ")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n܁༯┆لا تستطيع طرد ܊ حظر ܊ كتم ܊ تقييد \n܁༯┆٭ ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم كتم العضو ◃ '..TextEnd[2]..' '..TextEnd[3]..' 💞 ܰ'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
if text and text:match("^كتم (%d+)$") and Mod(msg) then
local userid = text:match("^كتم (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if tonumber(userid) == tonumber(ToReDo) then  
send(msg.chat_id_, msg.id_, "܁༯┆لا تستطيع كتم البوت 💞 ܰ ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n܁༯┆لا تستطيع طرد ܊ حظر ܊ كتم ܊ تقييد \n܁༯┆٭ ( '..Rutba(userid,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆البوت ليس ادمن يرجى ترقيتي 💞 ܰ') 
return false  
end
redis:sadd(ToReDo..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم كتم العضو هنا 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم كتم العضو هنا 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
if text == ("الغاء كتم") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
redis:srem(ToReDo..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم الغاء كتم العضو هنا 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء كتم @(.*)$") and Mod(msg) then
local username = text:match("^الغاء كتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
function start_function(extra, result, success)
if result.id_ then
redis:srem(ToReDo..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم الغاء كتم العضو هنا 💞 ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  💞 ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء كتم (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء كتم (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
redis:srem(ToReDo..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم الغاء كتم العضو هنا 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري 💞 ܰ'
status  = '\n܁༯┆تم الغاء كتم العضو هنا 💞 ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end

if text and text:match("^تغير رد المطور (.*)$") and Owners(msg) then
local Teext = text:match("^تغير رد المطور (.*)$") 
redis:set(ToReDo.."Sudo:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"܁༯┆تم تغير رد المطور الى ◃ "..Teext)
end
if text and text:match("^تغير رد منشئ الاساسي (.*)$") and Owners(msg) then
local Teext = text:match("^تغير رد منشئ الاساسي (.*)$") 
redis:set(ToReDo.."BasicConstructor:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"܁༯┆تم تغير رد المنشئ الاساسي الى ◃ 💞 ܰ"..Teext)
end
if text and text:match("^تغير رد المنشئ (.*)$") and Owners(msg) then
local Teext = text:match("^تغير رد المنشئ (.*)$") 
redis:set(ToReDo.."Constructor:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"܁༯┆تم تغير رد المنشئ الى ◃ "..Teext)
end
if text and text:match("^تغير رد المدير (.*)$") and Owners(msg) then
local Teext = text:match("^تغير رد المدير (.*)$") 
redis:set(ToReDo.."Owners:Rd"..msg.chat_id_,Teext) 
send(msg.chat_id_, msg.id_,"܁༯┆تم تغير رد المدير الى ◃ "..Teext)
end
if text and text:match("^تغير رد الادمن (.*)$") and Owners(msg) then
local Teext = text:match("^تغير رد الادمن (.*)$") 
redis:set(ToReDo.."Mod:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"܁༯┆تم تغير رد الادمن الى ◃ "..Teext)
end
if text and text:match("^تغير رد المميز (.*)$") and Owners(msg) then
local Teext = text:match("^تغير رد المميز (.*)$") 
redis:set(ToReDo.."Vips:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"܁༯┆تم تغير رد المميز الى ◃ "..Teext)
end
if text and text:match("^تغير رد العضو (.*)$") and Owners(msg) then
local Teext = text:match("^تغير رد العضو (.*)$") 
redis:set(ToReDo.."Memp:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"܁༯┆تم تغير رد العضو الى ◃ "..Teext)
end
if text == 'مسح رد العضو' and Mod(msg) then
redis:del(ToReDo..'Memp:Rd'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '܁༯┆تم مسح رد العضو 💞 ܰ ')
end
if text == 'مسح رد المميز' and Mod(msg) then
redis:del(ToReDo..'Vips:Rd'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '܁༯┆تم مسح رد المميز 💞 ܰ ')
end
if text == 'مسح رد الادمن' and Mod(msg) then
redis:del(ToReDo..'Mod:Rd'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '܁༯┆تم مسح رد الادمن 💞 ܰ ')
end
if text == 'مسح رد المدير' and Mod(msg) then
redis:del(ToReDo..'Owners:Rd'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '܁༯┆تم مسح رد المدير💞 ܰ ')
end
if text == 'مسح رد المنشئ' and Mod(msg) then
redis:del(ToReDo..'Constructor:Rd'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '܁༯┆تم مسح رد المنشئ 💞 ܰ ')
end
if text == 'مسح رد المنشئ الاساسي' and Mod(msg) then
redis:del(ToReDo..'BasicConstructor:Rd'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '܁༯┆تم مسح رد المنشئ الاساسي 💞 ܰ ')
end
if text == 'مسح رد المطور' and Mod(msg) then
redis:del(ToReDo..'Sudo:Rd'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '܁༯┆تم مسح رد المطور 💞 ܰ ')
end

if text and text:match("^(.*)$") then
if redis:get(ToReDo..'help'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮┆ تم حفظ الكليشه بنجاح')
redis:del(ToReDo..'help'..msg.sender_user_id_)
redis:set(ToReDo..'help_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if redis:get(ToReDo..'help1'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮┆ تم حفظ الكليشه بنجاح')
redis:del(ToReDo..'help1'..msg.sender_user_id_)
redis:set(ToReDo..'help1_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if redis:get(ToReDo..'help2'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮┆ تم حفظ الكليشه بنجاح')
redis:del(ToReDo..'help2'..msg.sender_user_id_)
redis:set(ToReDo..'help2_text',text)
return false
end
end

if text and text:match("^(.*)$") then
if redis:get(ToReDo..'help3'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮┆ تم حفظ الكليشه بنجاح')
redis:del(ToReDo..'help3'..msg.sender_user_id_)
redis:set(ToReDo..'help3_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if redis:get(ToReDo..'help4'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '??┆ تم حفظ الكليشه بنجاح')
redis:del(ToReDo..'help4'..msg.sender_user_id_)
redis:set(ToReDo..'help4_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if redis:get(ToReDo..'help5'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮┆ تم حفظ الكليشه بنجاح')
redis:del(ToReDo..'help5'..msg.sender_user_id_)
redis:set(ToReDo..'help5_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if redis:get(ToReDo..'help6'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮┆ تم حفظ الكليشه بنجاح')
redis:del(ToReDo..'help6'..msg.sender_user_id_)
redis:set(ToReDo..'help6_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if redis:get(ToReDo..'help7'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮┆ تم حفظ الكليشه بنجاح')
redis:del(ToReDo..'help7'..msg.sender_user_id_)
redis:set(ToReDo..'help7_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if redis:get(ToReDo..'help8'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '??┆ تم حفظ الكليشه بنجاح')
redis:del(ToReDo..'help8'..msg.sender_user_id_)
redis:set(ToReDo..'help8_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if redis:get(ToReDo..'help9'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮┆ تم حفظ الكليشه بنجاح')
redis:del(ToReDo..'help9'..msg.sender_user_id_)
redis:set(ToReDo..'help9_text',text)
return false
end
end

if text == 'استعاده الاوامر' and Sudo_ToReDo(msg) then
redis:del(ToReDo..'help_text')
redis:del(ToReDo..'help1_text')
redis:del(ToReDo..'help2_text')
redis:del(ToReDo..'help3_text')
redis:del(ToReDo..'help4_text')
redis:del(ToReDo..'help5_text')
redis:del(ToReDo..'help6_text')
redis:del(ToReDo..'help7_text')
redis:del(ToReDo..'help8_text')
redis:del(ToReDo..'help9_text')
send(msg.chat_id_, msg.id_, '🔘┆ تم استعادة الاوامر القديمه')
end
if text == 'تغير امر الاوامر' and Sudo_ToReDo(msg) then
send(msg.chat_id_, msg.id_, '܁༯┆ارسل كليشة الامر الان ◃ 💞 ܰ')
redis:set(ToReDo..'help'..msg.sender_user_id_,'true')
return false 
end
if text == 'تغير امر م1' and Sudo_ToReDo(msg) then
send(msg.chat_id_, msg.id_, '🔘┆ الان يمكنك ارسال الكليشه م1')
redis:set(ToReDo..'help1'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م2' and Sudo_ToReDo(msg) then
send(msg.chat_id_, msg.id_, '🔘┆ الان يمكنك ارسال الكليشه م2')
redis:set(ToReDo..'help2'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م3' and Sudo_ToReDo(msg) then
send(msg.chat_id_, msg.id_, '🔘┆ الان يمكنك ارسال الكليشه م3')
redis:set(ToReDo..'help3'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م4' and Sudo_ToReDo(msg) then
send(msg.chat_id_, msg.id_, '🔘┆ الان يمكنك ارسال الكليشه م4')
redis:set(ToReDo..'help4'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م5' and Sudo_ToReDo(msg) then
send(msg.chat_id_, msg.id_, '🔘┆ الان يمكنك ارسال الكليشه م5')
redis:set(ToReDo..'help5'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م6' and Sudo_ToReDo(msg) then
send(msg.chat_id_, msg.id_, '🔘┆ الان يمكنك ارسال الكليشه م6')
redis:set(ToReDo..'help6'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م7' and Sudo_ToReDo(msg) then
send(msg.chat_id_, msg.id_, '🔘┆ الان يمكنك ارسال الكليشه م7')
redis:set(ToReDo..'help7'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م8' and Sudo_ToReDo(msg) then
send(msg.chat_id_, msg.id_, '🔘┆ الان يمكنك ارسال الكليشه م8')
redis:set(ToReDo..'help8'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م9' and Sudo_ToReDo(msg) then
send(msg.chat_id_, msg.id_, '🔘┆ الان يمكنك ارسال الكليشه م9')
redis:set(ToReDo..'help9'..msg.sender_user_id_,'true')
return false 
end

--
if text == 'سمايلات' or text == 'سمايل' then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:Games'..msg.chat_id_) then
redis:del(ToReDo..'Set:Sma'..msg.chat_id_)
Random = {'🍏','🍎','🍐','🍊','🍋','🍉','🍇','🍓','🍈','🍒','🍑','🍍','🥥','🥝','🍅','🍆','🥑','🥦','🥒','🌶','🌽','🥕','🥔','??','🥐','🍞','🥨','🍟','🧀','🥚','??','🥓','🥩','🍗','🍖','🌭','🍔','🍠','🍕','🥪','🥙','☕️','🍵','🥤','🍶','🍺','🍻','🏀','⚽️','🏈','⚾️','🎾','🏐','🏉','🎱','🏓','🏸','🥅','🎰','🎮','🎳','🎯','🎲','🎻','🎸','🎺','🥁','🎹','🎼','🎧','🎤','🎬','🎨','🎭','🎪','🎟','🎫','🎗','🏵','🎖','🏆','🥌','🛷','🚗','🚌','🏎','🚓','🚑','🚚','🚛','🚜','🇮🇶','⚔','🛡','??','🌡','💣','📌','📍','??','📗','📂','📅','📪','☑','📬','📭','⏰','📺','??','☎️','📡'}
SM = Random[math.random(#Random)]
redis:set(ToReDo..'Random:Sm'..msg.chat_id_,SM)
send(msg.chat_id_, msg.id_,'܁༯┆اسرع واحد يدز لسمايل  ◃ ˼ `'..SM..'` ˹ 💞 ܰ')
return false
end
end
if text == ''..(redis:get(ToReDo..'Random:Sm'..msg.chat_id_) or '')..'' and not redis:get(ToReDo..'Set:Sma'..msg.chat_id_) then
if not redis:get(ToReDo..'Set:Sma'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'܁༯┆ويانا فائز ككلللوش 😂😭💞 ܰ')
redis:incrby(ToReDo..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(ToReDo..'Set:Sma'..msg.chat_id_,true)
return false
end 
if text == 'الاسرع' or text == 'ترتيب' then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:Games'..msg.chat_id_) then
redis:del(ToReDo..'Speed:Tr'..msg.chat_id_)
KlamSpeed = {'سحور','سياره','استقبال','قنفه','ايفون','بزونه','مطبخ','كرستيانو','دجاجه','مدرسه','الوان','غرفه','ثلاجه','كهوه','سفينه','العراق','محطه','طياره','رادار','منزل','مستشفى','كهرباء','تفاحه','اخطبوط','سلمون','فرنسا','برتقاله','تفاح','مطرقه','بتيته','لهانه','شباك','باص','سمكه','ذباب','تلفاز','حاسوب','انترنيت','ساحه','جسر'};
name = KlamSpeed[math.random(#KlamSpeed)]
redis:set(ToReDo..'Klam:Speed'..msg.chat_id_,name)
name = string.gsub(name,'سحور','س ر و ح')
name = string.gsub(name,'سياره','ه ر س ي ا')
name = string.gsub(name,'استقبال','ل ب ا ت ق س ا')
name = string.gsub(name,'قنفه','ه ق ن ف')
name = string.gsub(name,'ايفون','و ن ف ا')
name = string.gsub(name,'بزونه','ز و ه ن')
name = string.gsub(name,'مطبخ','خ ب ط م')
name = string.gsub(name,'كرستيانو','س ت ا ن و ك ر ي')
name = string.gsub(name,'دجاجه','ج ج ا د ه')
name = string.gsub(name,'مدرسه','ه م د ر س')
name = string.gsub(name,'الوان','ن ا و ا ل')
name = string.gsub(name,'غرفه','غ ه ر ف')
name = string.gsub(name,'ثلاجه','ج ه ت ل ا')
name = string.gsub(name,'كهوه','ه ك ه و')
name = string.gsub(name,'سفينه','ه ن ف ي س')
name = string.gsub(name,'العراق','ق ع ا ل ر ا')
name = string.gsub(name,'محطه','ه ط م ح')
name = string.gsub(name,'طياره','ر ا ط ي ه')
name = string.gsub(name,'رادار','ر ا ر ا د')
name = string.gsub(name,'منزل','ن ز م ل')
name = string.gsub(name,'مستشفى','ى ش س ف ت م')
name = string.gsub(name,'كهرباء','ر ب ك ه ا ء')
name = string.gsub(name,'تفاحه','ح ه ا ت ف')
name = string.gsub(name,'اخطبوط','ط ب و ا خ ط')
name = string.gsub(name,'سلمون','ن م و ل س')
name = string.gsub(name,'فرنسا','ن ف ر س ا')
name = string.gsub(name,'برتقاله','ر ت ق ب ا ه ل')
name = string.gsub(name,'تفاح','ح ف ا ت')
name = string.gsub(name,'مطرقه','ه ط م ر ق')
name = string.gsub(name,'بتيته','ب ت ت ي ه')
name = string.gsub(name,'لهانه','ه ن ل ه ل')
name = string.gsub(name,'شباك','ب ش ا ك')
name = string.gsub(name,'باص','ص ا ب')
name = string.gsub(name,'سمكه','ك س م ه')
name = string.gsub(name,'ذباب','ب ا ب ذ')
name = string.gsub(name,'تلفاز','ت ف ل ز ا')
name = string.gsub(name,'حاسوب','س ا ح و ب')
name = string.gsub(name,'انترنيت','ا ت ن ر ن ي ت')
name = string.gsub(name,'ساحه','ح ا ه س')
name = string.gsub(name,'جسر','ر ج س')
send(msg.chat_id_, msg.id_,'܁༯┆اسرع واحد يرتب ◃ ˼ '..name..' ˹ 💞 ܰ')
return false
end
end
------------------------------------------------------------------------
if text == ''..(redis:get(ToReDo..'Klam:Speed'..msg.chat_id_) or '')..'' and not redis:get(ToReDo..'Speed:Tr'..msg.chat_id_) then
if not redis:get(ToReDo..'Speed:Tr'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'܁༯┆ويانا فائز ككلللوش 😂😭💞 ܰ')
redis:incrby(ToReDo..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(ToReDo..'Speed:Tr'..msg.chat_id_,true)
end 

if text == 'حزوره' then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:Games'..msg.chat_id_) then
redis:del(ToReDo..'Set:Hzora'..msg.chat_id_)
Hzora = {'الجرس','عقرب الساعه','السمك','المطر','5','الكتاب','البسمار','7','الكعبه','بيت الشعر','لهانه','انا','امي','الابره','الساعه','22','خطأ','كم الساعه','البيتنجان','البيض','المرايه','الضوء','الهواء','الضل','العمر','القلم','المشط','الحفره','البحر','الثلج','الاسفنج','الصوت','بلم'};
name = Hzora[math.random(#Hzora)]
redis:set(ToReDo..'Klam:Hzor'..msg.chat_id_,name)
name = string.gsub(name,'الجرس','شيئ اذا لمسته صرخ ما هوه ؟')
name = string.gsub(name,'عقرب الساعه','اخوان لا يستطيعان تمضيه اكثر من دقيقه معا فما هما ؟')
name = string.gsub(name,'السمك','ما هو الحيوان الذي لم يصعد الى سفينة نوح عليه السلام ؟')
name = string.gsub(name,'المطر','شيئ يسقط على رأسك من الاعلى ولا يجرحك فما هو ؟')
name = string.gsub(name,'5','ما العدد الذي اذا ضربته بنفسه واضفت عليه 5 يصبح ثلاثين ')
name = string.gsub(name,'الكتاب','ما الشيئ الذي له اوراق وليس له جذور ؟')
name = string.gsub(name,'البسمار','ما هو الشيئ الذي لا يمشي الا بالضرب ؟')
name = string.gsub(name,'7','عائله مؤلفه من 6 بنات واخ لكل منهن .فكم عدد افراد العائله ')
name = string.gsub(name,'الكعبه','ما هو الشيئ الموجود وسط مكة ؟')
name = string.gsub(name,'بيت الشعر','ما هو البيت الذي ليس فيه ابواب ولا نوافذ ؟ ')
name = string.gsub(name,'لهانه','وحده حلوه ومغروره تلبس مية تنوره .من هيه ؟ ')
name = string.gsub(name,'انا','ابن امك وابن ابيك وليس باختك ولا باخيك فمن يكون ؟')
name = string.gsub(name,'امي','اخت خالك وليست خالتك من تكون ؟ ')
name = string.gsub(name,'الابره','ما هو الشيئ الذي كلما خطا خطوه فقد شيئا من ذيله ؟ ')
name = string.gsub(name,'الساعه','ما هو الشيئ الذي يقول الصدق ولكنه اذا جاع كذب ؟')
name = string.gsub(name,'22','كم مره ينطبق عقربا الساعه على بعضهما في اليوم الواحد ')
name = string.gsub(name,'خطأ','ما هي الكلمه الوحيده التي تلفض خطأ دائما ؟ ')
name = string.gsub(name,'كم الساعه','ما هو السؤال الذي تختلف اجابته دائما ؟')
name = string.gsub(name,'البيتنجان','جسم اسود وقلب ابيض وراس اخظر فما هو ؟')
name = string.gsub(name,'البيض','ماهو الشيئ الذي اسمه على لونه ؟')
name = string.gsub(name,'المرايه','ارى كل شيئ من دون عيون من اكون ؟ ')
name = string.gsub(name,'الضوء','ما هو الشيئ الذي يخترق الزجاج ولا يكسره ؟')
name = string.gsub(name,'الهواء','ما هو الشيئ الذي يسير امامك ولا تراه ؟')
name = string.gsub(name,'الضل','ما هو الشيئ الذي يلاحقك اينما تذهب ؟ ')
name = string.gsub(name,'العمر','ما هو الشيء الذي كلما طال قصر ؟ ')
name = string.gsub(name,'القلم','ما هو الشيئ الذي يكتب ولا يقرأ ؟')
name = string.gsub(name,'المشط','له أسنان ولا يعض ما هو ؟ ')
name = string.gsub(name,'الحفره','ما هو الشيئ اذا أخذنا منه ازداد وكبر ؟')
name = string.gsub(name,'البحر','ما هو الشيئ الذي يرفع اثقال ولا يقدر يرفع مسمار ؟')
name = string.gsub(name,'الثلج','انا ابن الماء فان تركوني في الماء مت فمن انا ؟')
name = string.gsub(name,'الاسفنج','كلي ثقوب ومع ذالك احفض الماء فمن اكون ؟')
name = string.gsub(name,'الصوت','اسير بلا رجلين ولا ادخل الا بالاذنين فمن انا ؟')
name = string.gsub(name,'بلم','حامل ومحمول نصف ناشف ونصف مبلول فمن اكون ؟ ')
send(msg.chat_id_, msg.id_,'܁༯┆اسرع واحد يحل الحزوره 💞 ܰ\n܁༯┆܊ '..name..' ܊')
return false
end
end
------------------------------------------------------------------------
if text == ''..(redis:get(ToReDo..'Klam:Hzor'..msg.chat_id_) or '')..'' and not redis:get(ToReDo..'Set:Hzora'..msg.chat_id_) then
if not redis:get(ToReDo..'Set:Hzora'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'܁༯┆ويانا فائز ككلللوش 😂😭💞 ܰ')
redis:incrby(ToReDo..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(ToReDo..'Set:Hzora'..msg.chat_id_,true)
end 

if text == 'معاني' then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:Games'..msg.chat_id_) then
redis:del(ToReDo..'Set:Maany'..msg.chat_id_)
Maany_Rand = {'قرد','دجاجه','بطريق','ضفدع','بومه','نحله','ديك','جمل','بقره','دولفين','تمساح','قرش','نمر','اخطبوط','سمكه','خفاش','اسد','فأر','ذئب','فراشه','عقرب','زرافه','قنفذ','تفاحه','باذنجان'}
name = Maany_Rand[math.random(#Maany_Rand)]
redis:set(ToReDo..'Maany'..msg.chat_id_,name)
name = string.gsub(name,'قرد','🐒')
name = string.gsub(name,'دجاجه','🐔')
name = string.gsub(name,'بطريق','🐧')
name = string.gsub(name,'ضفدع','🐸')
name = string.gsub(name,'بومه','🦉')
name = string.gsub(name,'نحله','🐝')
name = string.gsub(name,'ديك','🐓')
name = string.gsub(name,'جمل','🐫')
name = string.gsub(name,'بقره','🐄')
name = string.gsub(name,'دولفين','🐬')
name = string.gsub(name,'تمساح','🐊')
name = string.gsub(name,'قرش','🦈')
name = string.gsub(name,'نمر','??')
name = string.gsub(name,'اخطبوط','🐙')
name = string.gsub(name,'سمكه','🐟')
name = string.gsub(name,'خفاش','🦇')
name = string.gsub(name,'اسد','🦁')
name = string.gsub(name,'فأر','🐀')
name = string.gsub(name,'ذئب','🐺')
name = string.gsub(name,'فراشه','🦋')
name = string.gsub(name,'عقرب','🦂')
name = string.gsub(name,'زرافه','🦒')
name = string.gsub(name,'قنفذ','🦔')
name = string.gsub(name,'تفاحه','🍎')
name = string.gsub(name,'باذنجان','🍆')
send(msg.chat_id_, msg.id_,'܁༯┆اسرع واحد يدز معنى  ◃ ˼ '..name..' ˹ 💞 ܰ')
return false
end
end
------------------------------------------------------------------------
if text == ''..(redis:get(ToReDo..'Maany'..msg.chat_id_) or '')..'' and not redis:get(ToReDo..'Set:Maany'..msg.chat_id_) then
if not redis:get(ToReDo..'Set:Maany'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'܁༯┆ويانا فائز ككلللوش 😂😭💞 ܰ')
redis:incrby(ToReDo..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(ToReDo..'Set:Maany'..msg.chat_id_,true)
end 
if text == 'العكس' then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:Games'..msg.chat_id_) then
redis:del(ToReDo..'Set:Aks'..msg.chat_id_)
katu = {'باي','فهمت','موزين','اسمعك','احبك','موحلو','نضيف','حاره','ناصي','جوه','سريع','ونسه','طويل','سمين','ضعيف','شريف','شجاع','رحت','عدل','نشيط','شبعان','موعطشان','خوش ولد','اني','هادئ'}
name = katu[math.random(#katu)]
redis:set(ToReDo..'Set:Aks:Game'..msg.chat_id_,name)
name = string.gsub(name,'باي','هلو')
name = string.gsub(name,'فهمت','مافهمت')
name = string.gsub(name,'موزين','زين')
name = string.gsub(name,'اسمعك','ماسمعك')
name = string.gsub(name,'احبك','ماحبك')
name = string.gsub(name,'موحلو','حلو')
name = string.gsub(name,'نضيف','وصخ')
name = string.gsub(name,'حاره','بارده')
name = string.gsub(name,'ناصي','عالي')
name = string.gsub(name,'جوه','فوك')
name = string.gsub(name,'سريع','بطيء')
name = string.gsub(name,'ونسه','ضوجه')
name = string.gsub(name,'طويل','قزم')
name = string.gsub(name,'سمين','ضعيف')
name = string.gsub(name,'ضعيف','قوي')
name = string.gsub(name,'شريف','كواد')
name = string.gsub(name,'شجاع','جبان')
name = string.gsub(name,'رحت','اجيت')
name = string.gsub(name,'عدل','ميت')
name = string.gsub(name,'نشيط','كسول')
name = string.gsub(name,'شبعان','جوعان')
name = string.gsub(name,'موعطشان','عطشان')
name = string.gsub(name,'خوش ولد','موخوش ولد')
name = string.gsub(name,'اني','مطي')
name = string.gsub(name,'هادئ','عصبي')
send(msg.chat_id_, msg.id_,'܁༯┆ اسرع واحد يدز العكس ▸ {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(redis:get(ToReDo..'Set:Aks:Game'..msg.chat_id_) or '')..'' and not redis:get(ToReDo..'Set:Aks'..msg.chat_id_) then
if not redis:get(ToReDo..'Set:Aks'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'܁༯┆ويانا فائز ككلللوش 😂😭💞 ܰ')
redis:incrby(ToReDo..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(ToReDo..'Set:Aks'..msg.chat_id_,true)
end 

if redis:get(ToReDo.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 20 then
send(msg.chat_id_, msg.id_,"܁༯┆ عذرآ لا يمكنك تخمين عدد اكبر من ال { 20 } خمن رقم ما بين ال{ 1 و 20 }💞 ܰ\n")
return false  end 
local GETNUM = redis:get(ToReDo.."GAMES:NUM"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
redis:del(ToReDo..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_)
redis:del(ToReDo.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
redis:incrby(ToReDo..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,5)  
send(msg.chat_id_, msg.id_,'܁༯┆ مبروك فزت ويانه وخمنت الرقم الصحيح 💞 ܰ\n܁༯┆ تم اضافة { 5 } من النقاط 💞 ܰ\n')
elseif tonumber(NUM) ~= tonumber(GETNUM) then
redis:incrby(ToReDo..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_,1)
if tonumber(redis:get(ToReDo..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_)) >= 3 then
redis:del(ToReDo..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_)
redis:del(ToReDo.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,'܁༯┆اوبس لقد خسرت في اللعبه 💞 ܰ\n܁༯┆حظآ اوفر في المره القادمه 💞 ܰ\n܁༯┆كان الرقم الذي تم تخمينه { '..GETNUM..' }💞 ܰ')
else
send(msg.chat_id_, msg.id_,'܁༯┆اوبس تخمينك خطأ 💞 ܰ\n܁༯┆ ارسل رقم تخمنه مره اخرى 💞 ܰ')
end
end
end
end
if text == 'خمن' or text == 'تخمين' then   
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:Games'..msg.chat_id_) then
Num = math.random(1,20)
redis:set(ToReDo.."GAMES:NUM"..msg.chat_id_,Num) 
send(msg.chat_id_, msg.id_,'\n܁༯┆اهلاً بيك عمري في لعبة التخمين 💞 ܰ\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n܁༯┆#ملاحضة لديك 3 محاولات فقط\n܁༯┆سيتم تخمين عدد ما بين ܊ 20 - 1 ܊\n܁༯┆اذا تعتقد انك يمكنك الفوز جرب والعب الان')
redis:setex(ToReDo.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 100, true)  
return false  
end
end

if redis:get(ToReDo.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 6 then
send(msg.chat_id_, msg.id_,"܁༯┆عذرا لا يوجد سواء { 6 } اختيارات فقط ارسل اختيارك مره اخرى 💞 ܰ\n")
return false  end 
local GETNUM = redis:get(ToReDo.."Games:Bat"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
redis:del(ToReDo.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,'܁༯┆ويانا فائز ككلللوش 😂😭💞 ܰ')
redis:incrby(ToReDo..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,3)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
redis:del(ToReDo.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,'܁༯┆لقد خسرت 😭💞 ܰ \n܁༯┆المحبس في اليد رقم ˼ '..GETNUM..' ˹ 💞 ܰ')
end
end
end

if text == 'محيبس' or text == 'بات' then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:Games'..msg.chat_id_) then   
Num = math.random(1,6)
redis:set(ToReDo.."Games:Bat"..msg.chat_id_,Num) 
TEST = [[
܁༯┆في اي يد يقع المحبس 💞 ܰ
━━━ ━━━━━━━━━ ━━━━━
٭ 👊🏻6 ٭ 👊🏻5 ٭ 👊🏻4 ٭ 👊🏻3 ٭ 👊🏻2 ٭ 👊🏻1 ٭
━━━ ━━━━━━━━ ━━━━━━
܁༯┆اختار رقم لاستخراج المحبس  من اليد الذي تحمل المحبس
܁༯┆الفائز يحصل على  ◃ 5 ▹ نقاط
]]
send(msg.chat_id_, msg.id_,TEST)
redis:setex(ToReDo.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 100, true)  
return false  
end
end

------------------------------------------------------------------------
if text == 'المختلف' then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:Games'..msg.chat_id_) then
mktlf = {'😸','☠','🐼','🐇','🌑','🌚','⭐️','✨','⛈','🌥','⛄️','👨‍🔬','👨‍💻','👨‍??','👩‍🍳','🧚‍♀','🧜‍♂','🧝‍♂','🙍‍♂','🧖‍♂','👬','??‍👨‍👧','🕒','🕤','⌛️','📅',};
name = mktlf[math.random(#mktlf)]
redis:del(ToReDo..'Set:Moktlf:Bot'..msg.chat_id_)
redis:set(ToReDo..':Set:Moktlf'..msg.chat_id_,name)
name = string.gsub(name,'😸','😹😹😹😹😹😹😹😹😸😹😹😹😹')
name = string.gsub(name,'☠','💀💀💀💀💀💀💀☠💀💀💀💀💀')
name = string.gsub(name,'🐼','👻👻👻🐼👻👻👻👻👻👻👻')
name = string.gsub(name,'🐇','🕊🕊🕊🕊🕊🐇🕊🕊🕊🕊')
name = string.gsub(name,'🌑','🌚🌚🌚🌚🌚🌑🌚🌚🌚')
name = string.gsub(name,'🌚','🌑🌑🌑🌑🌑🌚🌑🌑🌑')
name = string.gsub(name,'⭐️','🌟🌟🌟🌟🌟🌟🌟🌟⭐️🌟🌟🌟')
name = string.gsub(name,'✨','💫💫💫💫💫✨💫💫💫💫')
name = string.gsub(name,'⛈','🌨🌨🌨🌨🌨⛈🌨🌨🌨🌨')
name = string.gsub(name,'🌥','⛅️⛅️⛅️⛅️⛅️⛅️🌥⛅️⛅️⛅️⛅️')
name = string.gsub(name,'⛄️','☃☃☃☃☃☃⛄️☃☃☃☃')
name = string.gsub(name,'👨‍🔬','👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👨‍🔬👩‍🔬👩‍🔬👩‍🔬')
name = string.gsub(name,'👨‍💻','👩‍💻👩‍💻👩‍‍💻👩‍‍💻👩‍💻👨‍💻👩‍💻👩‍💻👩‍💻')
name = string.gsub(name,'👨‍🔧','👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👨‍🔧👩‍🔧')
name = string.gsub(name,'😂','👨‍🍳👨‍🍳👨‍🍳👨‍🍳👨‍🍳👩‍🍳👨‍🍳👨‍🍳👨‍🍳')
name = string.gsub(name,'🧚‍♀','🧚‍♂🧚‍♂🧚‍♂🧚‍♂🧚‍♀🧚‍♂🧚‍♂')
name = string.gsub(name,'🧜‍♂','🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧚‍♂🧜‍♀🧜‍♀🧜‍♀')
name = string.gsub(name,'🧝‍♂','🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♂🧝‍♀🧝‍♀🧝‍♀')
name = string.gsub(name,'🙍‍♂️','🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️??‍♂️🙍‍♂️??‍♂️🙎‍♂️🙎‍♂️')
name = string.gsub(name,'🧖‍♂️','🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♂️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️')
name = string.gsub(name,'👬','👭👭👭👭👭👬👭👭👭')
name = string.gsub(name,'👨‍👨‍👧','👨‍👨‍👧 👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍??‍👦👨‍👨‍👧👨‍👨‍👦👨‍👨‍👦')
name = string.gsub(name,'🕒','🕒🕒🕒🕒🕒🕒🕓🕒🕒🕒')
name = string.gsub(name,'🕤','🕥🕥🕥🕥🕥🕤🕥🕥🕥')
name = string.gsub(name,'⌛️','⏳⏳⏳⏳⏳⏳⌛️⏳⏳')
name = string.gsub(name,'📅','📆??📆📆📆??📅📆📆')
send(msg.chat_id_, msg.id_,'܁༯┆اسرع واحد يدز  ◃ ˼ '..name..' ˹ 💞 ܰ')
return false
end
end
------------------------------------------------------------------------
if text == ''..(redis:get(ToReDo..':Set:Moktlf'..msg.chat_id_) or '')..'' then 
if not redis:get(ToReDo..'Set:Moktlf:Bot'..msg.chat_id_) then 
redis:del(ToReDo..':Set:Moktlf'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'܁༯┆ويانا فائز ككلللوش ??😭💞 ܰ')
redis:incrby(ToReDo..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(ToReDo..'Set:Moktlf:Bot'..msg.chat_id_,true)
end
------------------------------------------------------------------------
if text == 'رياضيات' then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:Games'..msg.chat_id_) then
Hussein = {'9','2','60','9','5','4','25','10','17','15','39','5','16',};
name = Hussein[math.random(#Hussein)]
redis:del(ToReDo..'Set:Ryadeat:Bot'..msg.chat_id_)
redis:set(ToReDo..':Set:Ryadeat'..msg.chat_id_,name)
name = string.gsub(name,'9','2+7=')
name = string.gsub(name,'2','5-3=')
name = string.gsub(name,'60','(30)² =')
name = string.gsub(name,'9','2+2+5=')
name = string.gsub(name,'5','8-3=?')
name = string.gsub(name,'4','40÷10=')
name = string.gsub(name,'25','30-5=')
name = string.gsub(name,'10','100÷10=')
name = string.gsub(name,'17','10+5+2=')
name = string.gsub(name,'15','25-10=')
name = string.gsub(name,'39','44-5=')
name = string.gsub(name,'5','12+1-8=')
name = string.gsub(name,'16','16+16-16=')
send(msg.chat_id_, msg.id_,'اجب عن التالي ~ {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(redis:get(ToReDo..':Set:Ryadeat'..msg.chat_id_) or '')..'' then 
if not redis:get(ToReDo..'Set:Ryadeat:Bot'..msg.chat_id_) then 
redis:del(ToReDo..':Set:Ryadeat'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'܁༯┆ويانا فائز ككلللوش 😂😭💞 ܰ')
redis:incrby(ToReDo..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(ToReDo..'Set:Ryadeat:Bot'..msg.chat_id_,true)
end
------------------------------------------------------------------------
if text == 'انكليزي' then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:Games'..msg.chat_id_) then
Hussein = {'معلومات','قنوات','مجموعات','كتاب','تفاحه','مختلف','سدني','نقود','اعلم','ذئب','تمساح','ذكي',};
name = Hussein[math.random(#Hussein)]
redis:del(ToReDo..'Set:English:Bot'..msg.chat_id_)
redis:set(ToReDo..':Set:English'..msg.chat_id_,name)
name = string.gsub(name,'ذئب','Wolf')
name = string.gsub(name,'معلومات','Information')
name = string.gsub(name,'قنوات','Channels')
name = string.gsub(name,'مجموعات','Groups')
name = string.gsub(name,'كتاب','Book')
name = string.gsub(name,'تفاحه','Apple')
name = string.gsub(name,'سدني','Sydney')
name = string.gsub(name,'نقود','money')
name = string.gsub(name,'اعلم','I know')
name = string.gsub(name,'تمساح','crocodile')
name = string.gsub(name,'مختلف','Different')
name = string.gsub(name,'ذكي','Intelligent')
send(msg.chat_id_, msg.id_,'܁༯┆اجب عن التالي  ◃ ˼ '..name..' ˹ 💞 ܰ')
return false
end
end
------------------------------------------------------------------------
if text == ''..(redis:get(ToReDo..':Set:English'..msg.chat_id_) or '')..'' then 
if not redis:get(ToReDo..'Set:English:Bot'..msg.chat_id_) then 
redis:del(ToReDo..':Set:English'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'܁༯┆ويانا فائز ككلللوش 😂😭💞 ܰ')
redis:incrby(ToReDo..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(ToReDo..'Set:English:Bot'..msg.chat_id_,true)
end
------------------------------------------------------------------------

if text == 'امثله' then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if redis:get(ToReDo..'Lock:Games'..msg.chat_id_) then
mthal = {'جوز','ضراطه','الحبل','الحافي','شقره','بيدك','سلايه','النخله','الخيل','حداد','المبلل','يركص','قرد','العنب','العمه','الخبز','بالحصاد','شهر','شكه','يكحله',};
name = mthal[math.random(#mthal)]
redis:set(ToReDo..'Set:Amth'..msg.chat_id_,name)
redis:del(ToReDo..'Set:Amth:Bot'..msg.chat_id_)
name = string.gsub(name,'جوز','ينطي____للماعده سنون')
name = string.gsub(name,'ضراطه','الي يسوق المطي يتحمل___')
name = string.gsub(name,'بيدك','اكل___محد يفيدك')
name = string.gsub(name,'الحافي','تجدي من___نعال')
name = string.gsub(name,'شقره','مع الخيل يا___')
name = string.gsub(name,'النخله','الطول طول___والعقل عقل الصخلة')
name = string.gsub(name,'سلايه','بالوجه امراية وبالظهر___')
name = string.gsub(name,'الخيل','من قلة___شدو على الچلاب سروج')
name = string.gsub(name,'حداد','موكل من صخم وجهه كال آني___')
name = string.gsub(name,'المبلل','___ما يخاف من المطر')
name = string.gsub(name,'الحبل','اللي تلدغة الحية يخاف من جرة___')
name = string.gsub(name,'يركص','المايعرف___يكول الكاع عوجه')
name = string.gsub(name,'العنب','المايلوح___يكول حامض')
name = string.gsub(name,'العمه','___إذا حبت الچنة ابليس يدخل الجنة')
name = string.gsub(name,'الخبز','انطي___للخباز حتى لو ياكل نصه')
name = string.gsub(name,'باحصاد','اسمة___ومنجله مكسور')
name = string.gsub(name,'شهر','امشي__ولا تعبر نهر')
name = string.gsub(name,'شكه','يامن تعب يامن__يا من على الحاضر لكة')
name = string.gsub(name,'القرد','__بعين امه غزال')
name = string.gsub(name,'يكحله','اجه___عماها')
send(msg.chat_id_, msg.id_,'܁༯┆اسرع واحد يكمل المثل 💞 ܰ \n܁༯┆ ˼ '..name..' ˹')
return false
end
end
------------------------------------------------------------------------
if text == ''..(redis:get(ToReDo..'Set:Amth'..msg.chat_id_) or '')..'' then 
if not redis:get(ToReDo..'Set:Amth:Bot'..msg.chat_id_) then 
redis:del(ToReDo..'Set:Amth'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'܁༯┆ويانا فائز ككلللوش 😂😭💞 ܰ')
redis:incrby(ToReDo..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(ToReDo..'Set:Amth:Bot'..msg.chat_id_,true)
end
if text == 'تعطيل الالعاب' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '\n܁༯┆ههلو عمري 💞 ܰ \n܁༯┆تم تعطيل الالعاب 💞 ܰ')
redis:del(ToReDo..'Lock:Games'..msg.chat_id_) 
end
if text == 'تفعيل الالعاب' and Owners(msg) then  
send(msg.chat_id_, msg.id_, '܁༯┆ههلو عمري 💞 ܰ \n܁༯┆تم تفعيل الالعاب 💞 ܰ')
redis:set(ToReDo..'Lock:Games'..msg.chat_id_,true) 
end

if text == 'الالعاب' or text == 'اللعبه' and redis:get(ToReDo..'Lock:Games'..msg.chat_id_) then
Text_Games = [[
٭ 𖤓┆قائمة الالعاب 💞◟
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
܁ 𖧇゠ لعبة المختلف ▹ ◃ ◞المختلف◜
܁ 𖧇゠ لعبة الاسرع ▹ ◃ ◞الاسرع◜
܁ 𖧇゠ لعبة العكس ▹ ◃ ◞العكس◜
܁ 𖧇゠ لعبة حزوره ▹ ◃ ◞حزوره◜
܁ 𖧇゠ لعبة سمايل ▹ ◃ ◞سمايل◜
܁ 𖧇゠ لعبة معاني ▹ ◃ ◞معاني◜
܁ 𖧇゠ لعبة امثله ▹ ◃ ◞امثله◜
܁ 𖧇゠ لعبة خمن ▹ ◃ ◞خمن◜
܁ 𖧇゠ لعبة بات ▹ ◃ ◞بات◜
܁ 𖧇゠ لعبة انكليزي ▹ ◃ ◞انكليزي◜
܁ 𖧇゠ لعبة رياضيات ▹ ◃ ◞رياضيات◜
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤓┆[𝚃𝚆𝙰𝚂𝙻 𝚂𝙾𝚄𝚁𝙲𝙴](t.me/y07bot) 
]]
send(msg.chat_id_, msg.id_,Text_Games) 
end
if text == 'نقاطي' or text == 'نقاطي' then 
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
local Num = redis:get(ToReDo..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0
if Num == 0 then 
Text = '܁༯┆ لم تلعب اي لعبهہ‌‏ للحصول على نقاط'
else
Text = '܁༯┆ عدد نقاط التي رحبتها هہ‌‏ي *▸ { '..Num..' } مجوهہ‌‏رهہ‌‏ *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match("^بيع نقاطي (%d+)$") or text and text:match("^بيع نقاطي (%d+)$") then
local NUMPY = text:match("^بيع نقاطي (%d+)$") or text:match("^بيع نقاطي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
if tonumber(NUMPY) == tonumber(0) then
send(msg.chat_id_,msg.id_,"\n*܁༯┆ لا يمكنني البيع اقل من 1 *") 
return false 
end
if tonumber(redis:get(ToReDo..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)) == tonumber(0) then
send(msg.chat_id_,msg.id_,'܁༯┆ ليس لديك نقاط من الالعاب \n📬┋ اذا كنت تريد ربح النقاط \n📌┋ ارسل الالعاب وابدأ اللعب ! ') 
else
local NUM_GAMES = redis:get(ToReDo..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)
if tonumber(NUMPY) > tonumber(NUM_GAMES) then
send(msg.chat_id_,msg.id_,'\n܁༯┆ليس لديك نقاط بهہ‌‏ذا العدد \n📬┋ لزيادة نقاطك في اللعبه \n📌┋ ارسل الالعاب وابدأ اللعب !') 
return false 
end
local NUMNKO = (NUMPY * 50)
redis:decrby(ToReDo..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,NUMPY)  
redis:incrby(ToReDo..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_,NUMNKO)  
send(msg.chat_id_,msg.id_,'܁༯┆ تم خصم *▸ { '..NUMPY..' }* من نقاطك \n📨┋ وتم اضافة* ▸ { '..(NUMPY * 50)..' } رسالهہ‌‏ الى رسالك *')
end 
return false 
end
--------
if text == 'الاوامر' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا الاوامر هذا لا تخصك 💞 ܰ') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
local help_text = redis:get(ToReDo..'help_text')
Text = [[
܁༯┆ اهلا بيك عمري 💞 . 
܁༯┆اوامر البوت ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ م1 ◂ لعرض قائمة الحماية 
┤ م2 ◂ لعرض التفعيل و التعطيل
┤ م3 ◂ لعرض اوامر الوضع ٫ اضف 
┤ م4 ◂ لعرض اوامر الحذف 
┤ م5 ◂ لعرض اوامر التنزيل و الرفع
┤ م6 ◂ لعرض اوامر المجموعة
┤ م7 ◂ لعرض اوامر المطور
┤ م8 ◂ لعرض اوامر المطور الاساسي
┤ م9 ◂ لعرض اوامر الاعضاء
┘ م10 ◂ لعرض اوامر التحشيش
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/xxxc_x) 𖥠 .
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
----------------------------------------------------------------------------
----------------------------------------------------------------------------
if text == 'م1' or text == 'م١' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا الاوامر هذا لا تخصك 💞 ܰ') 
return false
end
print(AddChannel(msg.sender_user_id_))
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
Text = [[
܁༯┆ اهلا بيك عمري 💞 . 
܁༯┆اوامر حماية المجموعة ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ ܁ NO.1
┤ قفل او فتح + الامر ▿
┤ بالكتم ◞بالتقييد ◞بالطرد 
┤╌╌╌╌╌╌╌╌╌╌܁ 
┤ الاضافه
┤ الدردشه
┤ الدخول
┤ البوتات
┤ الاشعارات
┤ التعديل
┤ تعديل الميديا
┤ الروابط
┤ المعرفات
┤التاك
┤ الشارحه
┤ الملصقات
┤ المتحركه
┤ الفيديو
┤ الصور
┤ الالعاب
┤ الاغاني
┤ الصوت
┤ الكيبورد
┤ التوجيه
┤ الملفات
┤ السيلفي
┤ الجهات
┤ الماركداون
┤ الكلايش
┤ التكرار
┤ الفارسيه
┤ الفشار
┤ الانكليزيه
┘ الانلاين
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/xxxc_x) 𖥠 .
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
if text == 'م2' or text == 'م٢' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا الاوامر هذا لا تخصك 💞 ܰ ') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
Text = [[
܁༯┆ اهلا بيك عمري 💞 . 
܁༯┆اوامر التفعيل + التعطيل ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ ܁ NO.1
┆تفعيل ܊ تعطيل + الامر ▿
┤ اطردني
┤ صيح
┤ ضافني
┤ الرابط 
┤ الحظر
┤ الرفع
┤ الرفع 
┤ الايدي
┤ الالعاب
┤ ردود المطور
┤ الترحيب
┤ ردود المدير
┤ الردود
┘ صورتي
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/xxxc_x) 𖥠 .
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
if text == 'م3' or text == 'م٣' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا الاوامر هذا لا تخصك 💞 ܰ ') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
Text = [[
܁༯┆ اهلا بيك عمري 💞 . 
܁༯┆اوامر الوضع ٫ اضف ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ ܁ NO.1
┆اضف + الامر ▿
┤ امر 
┤ رد
┤ صلاحيه 
┤╌╌╌╌╌╌╌╌╌╌܁ 
┤ ܁ NO.2
┆ضع + الامر ▿
┤ اسم 
┤ رابط 
┤ ترحيب 
┤ قوانين
┤ صوره
┤ وصف 
┘ تكرار + العدد
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/xxxc_x) 𖥠 .
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
if text == 'م4' or text == 'م٤' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا الاوامر هذا لا تخصك 💞 ܰ ') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
Text = [[
܁༯┆ اهلا بيك عمري 💞 . 
܁༯┆اوامر المسح ٫ الحذف ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ ܁ NO.1
┆مسح + الامر ▿
┤ الايدي 
┤ الادمنيه
┤ المميزين
┤ المنشئين
┤ المدراء
┤ ردود المدير 
┤ البوتات 
┤ الصلاحيه 
┤ المحذوفين 
┤ قائمه المنع
┤╌╌╌╌╌╌╌╌╌╌܁
┤ ܁ NO.2
┆حذف + الامر ▿
┤ امر
┘ الاوامر المضافه
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/xxxc_x) 𖥠 .
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end

----------------------------------------------------------------------------
if text == 'م5' or text == 'م٥' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا الاوامر هذا لا تخصك 💞 ܰ ') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
Text = [[
܁༯┆ اهلا بيك عمري 💞 . 
܁༯┆اوامر التنزيل + الرفع ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ ܁ NO.1
┆تنزيل + رفع ▿
┤ مدير
┤ ادمن
┤ مميز
┤ منشى
┤ منشى اساسي
┤ ادمن بالكروب
┤ ادمن بكل الصلاحيات
┤ القيود
┤ تنزيل جميع الرتب ٭ تنزيل الرتبه
┤╌╌╌╌╌╌╌╌╌╌܁
┤ ܁ NO.2
┆ اوامر التغير ▿
┤ تغير رد المطور + الاسم
┤ تغير رد منشئ اساسي + الاسم
┤ تغير رد منشئ + الاسم
┤ تغير رد المدير + الاسم 
┤ تغير رد الادمن + الاسم 
┤ تغير رد المميز + الاسم 
┤ تغير رد العضو + الاسم
┤ تغير امر الاوامر
┘ تغير امر م 1 الى حد م 10
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/xxxc_x) 𖥠 .
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
----------------------------------------------------------------------------
if text == 'م6' or text == 'م٦' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا الاوامر هذا لا تخصك 💞 ܰ ') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
Text = [[
܁༯┆ اهلا بيك عمري 💞 . 
܁༯┆اوامر المجموعة  ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ استعاده الاوامر 
┤ الادمنيه 
┤ تاك الادمنيه
┤ كشف القيود
┤ تعين الايدي
┤ تنظيف + العدد
┤ تنزيل الكل 
┤ منع + الرد ܊ صور ٭ متحركه ٭ ملصق ܊ 
┤ المميزين 
┤ حظر ܊ الغاء حظر 
┤ المحظورين 
┤ كتم ܊ الغاء كتم
┤ المكتومين 
┤ تقيد + المده + يوم
┤ تقيد + المده + ساعه
┤ تقيد + المده + دقيقه
┤ كتم + المده + يوم
┤ كتم + المده + ساعه
┤ كتم + المده + دقيقه
┤ تقيد ܊ الغاء تقيد
┤ طرد 
┤  تثبيت ܊ الغاء تثبيت
┤الترحيب 
┤ كشف البوتات 
┤ الصلاحيات 
┤ كشف برد ܊ بمعرف
┤ تاك للكل
┤ اعدادات المجموعه 
┤ عدد الكروب
┤ ردود المدير 
┤ اسم البوت + الرتبه
┤ الاوامر المضافه 
┘ قائمه المنع
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/xxxc_x) 𖥠 .
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
if text == 'م7' or text == 'م٧' then
if not Sudo(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا الاوامر هذا لا تخصك 💞 ܰ ') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
Text = [[
܁༯┆ اهلا بيك عمري 💞 . 
܁༯┆اوامر مطور البوت ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ تفعيل ܊ تعطيل
┤ المجموعات ܊ المشتركين
┤ رفع ܊ تنزيل ٭ منشى اساسي ٭
┤ مسح الاساسين
┤ مسح المنشئين الاساسين
┤ مسح المنشئين
┤ اسم البوت + غادر
┤ ردود المطور
┤ رفع ܊ تنزيل ٭ مميز عام ٭
┤ مسح المميزين عام
┤ مسح المميز عام
┘ اذاعه ܊ اذا كان المطور الاساسي مفعلها
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/xxxc_x) 𖥠 .
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
if text == 'م8' or text == 'م٨' then
if not Sudo_ToReDo(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا الاوامر هذا لا تخصك 💞 ܰ ') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
Text = [[
܁༯┆ اهلا بيك عمري 💞 . 
܁༯┆اوامر مطور الاساسي ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ ܁ NO.1 
┤ تفعيل ܊ تعطيل
┤ المجموعات ܊ المشتركين
┤ رفع ܊ تنزيل ٭ منشى اساسي ٭
┤ مسح الاساسين
┤ مسح المنشئين الاساسين
┤ مسح المنشئين
┤ مسح المطورين 
┤ المطورين 
┤ رفع ܊ تنزيل ٭ مطور ٭
┤╌╌╌╌╌╌╌╌╌╌܁
┤ ܁ NO.2
┤ اسم البوت + غادر 
┤ اسم البوت + الرتبه 
┤ تحديث السورس 
┤ حظر عام 
┤ كتم عام 
┤ الغاء العام 
┤ قائمه العام 
┤ جلب نسخة الاحتياطيه
┤ رفع نسخه الاحتياطيه
┤╌╌╌╌╌╌╌╌╌╌܁
┤ ܁ NO.3
┤ اذاعه 
┤ اذاعه خاص 
┤ اذاعه بالتوجيه 
┤ اذاعه بالتوجيه خاص 
┤ اذاعه بالتثبيت 
┤╌╌╌╌╌╌╌╌╌╌܁
┤ ܁ NO.4
┤ جلب نسخه البوت 
┤ رفع نسخه البوت 
┤ ضع عدد الاعضاء + العدد
┤ ضع كليشه مطور 
┤ تفعيل ܊ تعطيل الاذاعه 
┤ تفعيل ܊ تعطيل البوت الخدمي
┤ تفعيل ܊ تعطيل التواصل 
┤ تغير اسم البوت 
┤ اضف ܊ حذف رد للكل
┤ ردود المطور 
┤ مسح ردود المطور
┤╌╌╌╌╌╌╌╌╌╌܁
┤ ܁ NO.5
┤ الاشتراك الاجباري
┤ تعطيل الاشتراك الاجباري
┤ تفعيل الاشتراك الاجباري
┤ حذف رساله الاشتراك
┤ تغير رساله الاشتراك
┤ تغير الاشتراك
┤╌╌╌╌╌╌╌╌╌╌܁
┤ ܁ NO.6
┤ الاحصائيات 
┤ المشتركين
┤ المجموعات
┤ السيرفر ܊ Server
┤ تفعيل ܊ تعطيل المغادره 
┤ تنظيف المشتركين 
┘ تنظيف الكروبات
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/xxxc_x) 𖥠 .
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
if text == 'م9' or text == 'م٩' then
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
Text = [[
܁༯┆ اهلا بيك عمري 💞 . 
܁༯┆اوامر الاعضاء ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ ܁ NO.1
┆لعرض معلوماتك ▿
┤ ايديي 
┤ اسمي
┤ رسائلي
┤ مسح رسايلي 
┤ رتبتي 
┤ سحكاتي
┤ مسح سحكاتي 
┤الرتبه ܊ بالرد او بالمعرف ܊
┤ الحساب + ايدي الشخص
┤ ╌╌╌╌╌╌╌╌╌╌ ܁ 
┤ ܁ NO.2
┆لعرض اوامر المجموعه ▿
┤ الرابط 
┤ القوانين
┤ الترحيب 
┤ ايدي
┤ اطردني
┤ كشف ܊ بالرد او بالمعرف ܊ 
┤ اسمي 
┤ المطور
┤ كول + الكلمه
┤ ╌╌╌╌╌╌╌╌╌╌ ܁ 
┤ ܁ NO.3
┤ بوسه ܊ بالرد ܊ 
┤ مصه ܊ بالرد  ܊
┤ شنو رائيك بهذا ܊ بالرد ܊
┘ رزله ٭ هينه ܊ بالرد ܊
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/xxxc_x) 𖥠 .
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == 'م10' or text == 'م١٠' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا الاوامر هذا لا تخصك 💞 ܰ ') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
send(msg.chat_id_, msg.id_,'- هلو حب ، لايمكنك استخدام البوت 💕.\n- ﭑشترك اولاً 💕 • ['..redis:get(ToReDo..'add:ch:username')..'] .')
return false
end
Text = [[
܁༯┆ اهلا بيك عمري 💞 . 
܁༯┆اوامر التحشيش ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ ܁ NO.1
┆رفع ܊ تنزيل + الامر ▿
┤ اثول
┤ جلب
┤ مطي
┤ صخل
┤ زاحف
┤ الرفع
┤ بكلبي
┤ تاج
┤ نبي
┤ ܁ NO.2 ▿
┤ زواج
┘ طلاك
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/xxxc_x) 𖥠 .
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
end
end
return {ToReDoa = Orders}