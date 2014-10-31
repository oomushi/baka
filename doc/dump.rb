Avatar.create!([
  {user_id: 1, url: "/assets/admin.png", file: nil, content_type: nil},
  {user_id: 2, url: "/assets/guest.png", file: nil, content_type: nil},
  {user_id: 3, url: "/assets/guest.png", file: nil, content_type: nil},
  {user_id: 4, url: "/assets/guest.png", file: nil, content_type: nil}
])
Bbcode.create!([
  {label: "spoiler", output: "[spoiler]?[/spoiler]", tag: "spoiler", text: "<span class=\"spoiler\">\#{content}</span>", singular: false, match: ".+"},
  {label: "B)", output: "B)", tag: "", text: "", singular: true, match: ".+"},
  {label: ":(", output: ":(", tag: "", text: "", singular: true, match: ".+"},
  {label: ":/", output: ":/", tag: "", text: "", singular: true, match: ".+"},
  {label: ":)", output: ":)", tag: "", text: "", singular: true, match: ".+"},
  {label: ":^)", output: ":^)", tag: "", text: "", singular: true, match: ".+"},
  {label: ";)", output: ";)", tag: "", text: "", singular: false, match: ".+"},
  {label: ":'(", output: ":'(", tag: "", text: "", singular: true, match: ".+"},
  {label: "O_o", output: "O_o", tag: "", text: "", singular: true, match: ".+"},
  {label: "T_T", output: "T_T", tag: "", text: "", singular: true, match: ".+"},
  {label: "<3", output: "<3", tag: "", text: "", singular: true, match: ".+"},
  {label: ":X", output: ":X", tag: "", text: "", singular: true, match: ".+"},
  {label: ":O", output: ":O", tag: "", text: "", singular: true, match: ".+"},
  {label: ":D", output: ":D", tag: "", text: "", singular: true, match: ".+"},
  {label: ":P", output: ":P", tag: "", text: "", singular: true, match: ".+"},
  {label: "quote", output: "[quote=?]?[/quote]", tag: "quote", text: "<fieldset class=\"quote\"><legend>\#{meta}</legend><blockquote>\#{content}</blockquote></fieldset>", singular: false, match: ".+"}
])
Contact.create!([
  {user_id: 1, protocol: "email", value: "admin@baka.com"},
  {user_id: 2, protocol: "email", value: "guest@baka.com"},
  {user_id: 3, protocol: "email", value: "dice@inwind.it"},
  {user_id: 4, protocol: "email", value: "dice@inwind.it"}
])
Group.create!([
  {name: "admins", level: 1},
  {name: "logged users", level: 4},
  {name: "public", level: 64},
  {name: "mod1", level: 2},
  {name: "mod2", level: 2}
])
Message.create!([
  {text: "Hidden text", section: true, pinned: true, title: "Baka", message_id: 1, user_id: 1, nv: 0, dv: 1, snv: 1, sdv: 1, follow: false, writer_id: 1, reader_id: 4, moderator_id: 1},
  {text: "", section: true, pinned: false, title: "paa", message_id: 1, user_id: 1, nv: 1, dv: 2, snv: 2, sdv: 3, follow: false, writer_id: 1, reader_id: 4, moderator_id: 1},
  {text: "", section: true, pinned: false, title: "laa", message_id: 1, user_id: 1, nv: 2, dv: 3, snv: 3, sdv: 4, follow: false, writer_id: 1, reader_id: 3, moderator_id: 1},
  {text: "", section: true, pinned: false, title: "pl1", message_id: 1, user_id: 1, nv: 3, dv: 4, snv: 4, sdv: 5, follow: true, writer_id: 3, reader_id: 4, moderator_id: 2},
  {text: "", section: true, pinned: false, title: "pl2", message_id: 1, user_id: 1, nv: 4, dv: 5, snv: 5, sdv: 6, follow: true, writer_id: 3, reader_id: 4, moderator_id: 5},
  {text: "", section: true, pinned: false, title: "ll1", message_id: 1, user_id: 1, nv: 5, dv: 6, snv: 6, sdv: 7, follow: true, writer_id: 3, reader_id: 3, moderator_id: 2},
  {text: "", section: true, pinned: false, title: "ll2", message_id: 1, user_id: 1, nv: 6, dv: 7, snv: 7, sdv: 8, follow: true, writer_id: 3, reader_id: 3, moderator_id: 5},
  {text: "Perché tra i reader e i writer non ci sono i mod? :(\r\nQuesta sarebbe dovuta essere la sezione di avvisi per i mod1, quindi lettura e scrittura per mod1 e admin come mod.\r\n\r\nSarebbe poi stata da fare 1aa in qui c'erano solo gli annunti per i mod", section: true, pinned: false, title: "11a", message_id: 1, user_id: 1, nv: 7, dv: 8, snv: 8, sdv: 9, follow: true, writer_id: 3, reader_id: 3, moderator_id: 1},
  {text: "[list]\r\n[*] in index user il conteggio dei messaggi non dovrebbe comprendere le sezioni\r\n[*] creare bbcode per le liste => cambiare libreria per i bbcode => togliere gli smile personalizzati‽\r\n[*] il conteggio ultimo messaggio in index messaggi è errato\r\n[*] creare due utenze mod\r\n[*] flash a scomparsa\r\n[*] aspetto edit[list]\r\n[*] answer\r\n[*] attachment\r\n[*] avatar\r\n[*] bbcode\r\n[*] contact\r\n[*] group\r\n[*] like\r\n[*] messagge\r\n[*] poll\r\n[*] user\r\n[/list]\r\n[*] logica campi bbcode\r\n[*] in index bbcode gli smile non dovrebbero essere visibili nella prima colonna\r\n[*] visibilità messaggi tutta sbagliata\r\n[*] password guest generata random\r\n[*] le select permessi in messagi dovrebbero seguire la logica dei permessi di linux‽\r\n[*] text area di edit messaggio a tutto schermo\r\n[/list]", section: false, pinned: true, title: "[TODO]", message_id: 1, user_id: 1, nv: 8, dv: 9, snv: 9, sdv: 10, follow: false, writer_id: 1, reader_id: 1, moderator_id: 1}
])
User.create!([
  {username: "guest", password_hash: "$2a$10$Hci5PhzDTyNYnCqqDPHX2OQ6TPeFe0FsU/Qa29R2F0qE7D7rOoq1C", password_salt: "$2a$10$Hci5PhzDTyNYnCqqDPHX2O", confirm_code: "", sign: nil, birthday: nil, location: nil, guest: true},
  {username: "admin", password_hash: "$2a$10$4E6NW1vptj5Pv9IvUGba..fmg8CdZiH2bx8EQeeSgyQQwQSiRuALG", password_salt: "$2a$10$4E6NW1vptj5Pv9IvUGba..", confirm_code: nil, sign: nil, birthday: "1982-12-29", location: nil, guest: false},
  {username: "mod01", password_hash: "$2a$10$FRo.9R6xk9qJn63FcEnJeesMMs.eKATJLjiEBOCALx9i/EPYrLXY2", password_salt: "$2a$10$FRo.9R6xk9qJn63FcEnJee", confirm_code: "", sign: nil, birthday: nil, location: nil, guest: false},
  {username: "mod02", password_hash: "$2a$10$n5q.U7n9iUhPysdSoiBvN.ZXTRKw.0jKB0h9Z8H5gtVCvq9GHaBLu", password_salt: "$2a$10$n5q.U7n9iUhPysdSoiBvN.", confirm_code: "", sign: nil, birthday: nil, location: nil, guest: false}
])
