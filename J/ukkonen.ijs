empty_tree=:'';_1

fp=:] NB. Follow path - 'suffix fp tree'

es=: 1 : 0 NB. Extend suffix - 'tree (extension es) suffix'
:
  n=.x fp y
    
)

NB. Examples
xabxa=:'';_1;('bxa$';2);('$$';5);('a';4;(<'bxa$';1));(<'xa';3;(<'bxa$';0))
implicit_xabxa=:'';_1;('bxa';2);('a';'bxa';1);(<'xa';'bxa';0)
