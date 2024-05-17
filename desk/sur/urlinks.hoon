  ::  /sur/urlinks
::::
::
|%
+$  action
  $%  
    [%add-link label=@t url=@t]
    [%delete-link index=@ud]
    [%edit-link index=@ud label=@t url=@t]
    [%change-bio name=@t bio=@t image=@t]

  ==
+$  update
  $%  [%risen values=(list @)]
  ==

+$  link
  $:
    label=@t
    url=@t
  ==
--
