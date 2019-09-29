DataDriver для FIBPlus.
----------------------

Компонент регистрит себя сам - нужно только добавить его в package.

В силу особенностей "устройства" FIBPlus (TpFIBQuery не является наследником
TDataSet - и вытаскивать данные проще через TpFIBDataSet, но выполнять execute
procedure надо именно через TpFIBQuery) Command'у с CommandType'ом, равным
cthStoredProc, имеет смысл использовать только для execute procedure.

Если же SP возвращает какой-либо курсор, то надо просто вызывать команду с
CommandType = cthSelectQuery с запросом следующего вида:

  select from our_sp1(param1).


Serguei S. Borisoff
jr_ross@mail.ru
