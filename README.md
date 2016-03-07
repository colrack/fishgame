# Fishgame - A serious game based on Kobold2d and Cocos2d

### Breve storia
Questo gioco è stato sviluppato a cavallo tra il 2012 e il 2013 per il progetto di Reti Wireless all'università.
È un'implementazione nativa dello stesso gioco precedentemente sviluppato con tecnologie web da un altro studente; il gioco è ospitato su [math.unipd.it](http://giochiamo.math.unipd.it/index.html).
A fine 2012 ho comprato il libro [Learn cocos2d 2 Game Development for iOS](http://www.apress.com/9781430244165) di  Steffen Itterheim e Andreas Loew.

<img src="https://raw.githubusercontent.com/colrack/fishgame/master/docs/img/learn_cocos2d_2_amazon.png" width="200">

Ho letto fino al capitolo 8 ed è stato sufficiente per implementare questo gioco.
È stata il primo framework di gioco che ho utilizzato, quindi sicuramente non è stato sviluppato con molta cognizione di causa.
Oggi (marzo 2016) faccio un po' di pulizia, rispolvero il gioco e provo a farlo partire; Kobold2D non è più supportato dall'autore e Cocos2d ha avuto delle major release che rendono impossibile compilare il gioco così com'era (Xcode 7.2.1).
Per provare il progetto è necessario avere Mac OS X Mountain Lion 10.8 ed installare (Xcode 4.6.3). Si può installare una vecchia versione di Mac OS X su macchina virtuale.

### Come compilare e far partire il progetto
Installate [Xcode 4.6.3](http://adcdownload.apple.com/Developer_Tools/xcode_4.6.3/xcode4630916281a.dmg); potete scaricarlo da Apple Developer Center (dovete essere registrati come sviluppatori e loggati). Potete anche eventualmente scaricare i [Command Line Tools](http://adcdownload.apple.com/Developer_Tools/command_line_tools_os_x_mountain_lion_for_xcode__april_2013/xcode462_cltools_10_86938259a.dmg) di allora che includono tra l'altro git.
Ho incluso una copia di Kobold2D nella pagina della release (https://github.com/colrack/fishgame/releases). Installate il pacchetto [Kobold2D_v2.1.0.pkg](https://github.com/colrack/fishgame/releases/download/untagged-037fef668ad90cc19ea5/Kobold2D_v2.1.0.pkg). Successivamente clonate il progetto `git clone https://github.com/colrack/fishgame.git` in `/Users/username/Kobold2D/Kobold2D-2.1.0/` oppure scaricate e scompattate (fishgame-src-1.0.zip](https://github.com/colrack/fishgame/releases/download/untagged-037fef668ad90cc19ea5/fishgame-src-1.0.zip) nella cartella citata.
Aprite con Xcode `Kobold2D.xcworkspace` ed importate il progetto `FishGame.xcodeproj` nel workspace.

Passo 1

<img src="https://raw.githubusercontent.com/colrack/fishgame/master/docs/img/import_project_1.png">

Passo 2

<img src="https://raw.githubusercontent.com/colrack/fishgame/master/docs/img/import_project_2.png">

Potete compilare il progetto per Mac OS oppure per iOS; selezionate il target che desiderate.

<img src="https://raw.githubusercontent.com/colrack/fishgame/master/docs/img/xcode_select_target_ios.png">

<img src="https://raw.githubusercontent.com/colrack/fishgame/master/docs/img/xcode_select_target_mac.png">

Se avete un iPad con iOS 6 ed un certificato valido potete installare l'app direttamente sul dispositivo tramite Xcode 4.6.
A partire da Xcode 7 non serve più avere pagato la membership annuale al programma per poter testare un'app sul device. Potete ottenere un profilo di provisioning tramite Xcode 7, importarlo su Xcode 4 e poi creare un archivio ipa firmato tramite Xcode 4. Successivamente potete installare l'ipa tramite Xcode 7 sul dispositivo con iOS 9.

