FasdUAS 1.101.10   ��   ��    k             l     ��  ��    S M-----------------------------------------------------------------------------     � 	 	 � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -   
  
 l     ��  ��    %  Auteur: boissonnfive@gmail.com     �   >   A u t e u r :   b o i s s o n n f i v e @ g m a i l . c o m      l     ��  ��      Date:  03/11/2008     �   $   D a t e :     0 3 / 1 1 / 2 0 0 8      l     ��  ��    I C Description: Exporte TOUS les contacts contenus dans l'application     �   �   D e s c r i p t i o n :   E x p o r t e   T O U S   l e s   c o n t a c t s   c o n t e n u s   d a n s   l ' a p p l i c a t i o n      l     ��  ��    7 1              "Carnet d'adresse" dans un fichier.     �   b                             " C a r n e t   d ' a d r e s s e "   d a n s   u n   f i c h i e r .      l     ��   !��     2 , Usage: osascript ExportAddressBookToVcf.scp    ! � " " X   U s a g e :   o s a s c r i p t   E x p o r t A d d r e s s B o o k T o V c f . s c p   # $ # l     �� % &��   % L F Remarque: Il faut modifier le nom du fichier o� vont �tre �crites les    & � ' ' �   R e m a r q u e :   I l   f a u t   m o d i f i e r   l e   n o m   d u   f i c h i e r   o �   v o n t   � t r e   � c r i t e s   l e s $  ( ) ( l     �� * +��   * S M           donn�es (fileName). Il faut aussi modifier le chemin de ce fichier    + � , , �                       d o n n � e s   ( f i l e N a m e ) .   I l   f a u t   a u s s i   m o d i f i e r   l e   c h e m i n   d e   c e   f i c h i e r )  - . - l     �� / 0��   /             (PathName).    0 � 1 1 ,                       ( P a t h N a m e ) . .  2 3 2 l     �� 4 5��   4 R L----------------------------------------------------------------------------    5 � 6 6 � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 3  7 8 7 l     ��������  ��  ��   8  9 : 9 l     �� ; <��   ; 4 . Dossier dans lequel on va faire l'exportation    < � = = \   D o s s i e r   d a n s   l e q u e l   o n   v a   f a i r e   l ' e x p o r t a t i o n :  > ? > l     @ A B @ r      C D C m      E E � F F l M a c i n t o s h   H D : U s e r s : b r u n o b o i s s o n n e t : D o c u m e n t s : C o n t a c t s : D o      ���� 0 pathname PathName A #  insert your folder path here    B � G G :   i n s e r t   y o u r   f o l d e r   p a t h   h e r e ?  H I H l     �� J K��   J ; 5 Nom du fichier qui va contenir les donn�es export�es    K � L L j   N o m   d u   f i c h i e r   q u i   v a   c o n t e n i r   l e s   d o n n � e s   e x p o r t � e s I  M N M l    O���� O r     P Q P m     R R � S S  A d d r e s s B o o k . v c f Q o      ���� 0 filename fileName��  ��   N  T U T l     ��������  ��  ��   U  V W V l     ��������  ��  ��   W  X Y X l     �� Z [��   Z 1 + Suppresion de l'ancien fichier s'il existe    [ � \ \ V   S u p p r e s i o n   d e   l ' a n c i e n   f i c h i e r   s ' i l   e x i s t e Y  ] ^ ] l   + _���� _ O    + ` a ` k    * b b  c d c r     e f e b     g h g o    ���� 0 pathname PathName h o    ���� 0 filename fileName f o      ���� 0 thefile theFile d  i�� i Q    * j k�� j k    ! l l  m n m l   �� o p��   o : 4delete theFile -- Delete previous export, if present    p � q q h d e l e t e   t h e F i l e   - -   D e l e t e   p r e v i o u s   e x p o r t ,   i f   p r e s e n t n  r�� r I   !�� s��
�� .sysoexecTEXT���     TEXT s l    t���� t b     u v u m     w w � x x  r m   v n     y z y 1    ��
�� 
psxp z 4    �� {
�� 
file { o    ���� 0 thefile theFile��  ��  ��  ��   k R      ������
�� .ascrerr ****      � ****��  ��  ��  ��   a m    	 | |�                                                                                  MACS   alis    r  Macintosh HD               �9H+     �
Finder.app                                                       s��0�4        ����  	                CoreServices    �*�      �0�       �   Q   P  3Macintosh HD:System:Library:CoreServices:Finder.app    
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��  ��  ��   ^  } ~ } l     ��������  ��  ��   ~   �  l     �� � ���   � 1 + Exporte les donn�es du "Carnet d'adresses"    � � � � V   E x p o r t e   l e s   d o n n � e s   d u   " C a r n e t   d ' a d r e s s e s " �  � � � l  , � ����� � O   , � � � � k   0 � � �  � � � r   0 9 � � � I  0 7�� ���
�� .corecnte****       **** � 2  0 3��
�� 
azf4��   � o      ���� 0 npersons   �  � � � Y   : � ��� � ��� � k   D � � �  � � � r   D T � � � c   D P � � � l  D L ����� � n   D L � � � 1   H L��
�� 
az49 � 4   D H�� �
�� 
azf4 � o   F G���� 0 i  ��  ��   � m   L O��
�� 
ctxt � o      ���� 0 	vcardinfo   �  � � � r   U e � � � c   U a � � � l  U ] ����� � n   U ] � � � 1   Y ]��
�� 
pnam � 4   U Y�� �
�� 
azf4 � o   W X���� 0 i  ��  ��   � m   ] `��
�� 
ctxt � o      ���� 0 
personname 
personName �  � � � l  f f�� � ���   � > 8 set target_file to PathName & "AddressBook.vcf" as text    � � � � p   s e t   t a r g e t _ f i l e   t o   P a t h N a m e   &   " A d d r e s s B o o k . v c f "   a s   t e x t �  � � � r   f q � � � c   f m � � � b   f i � � � o   f g���� 0 pathname PathName � o   g h���� 0 filename fileName � m   i l��
�� 
ctxt � o      ���� 0 target_file   �  ��� � Q   r � � � � � k   u � � �  � � � r   u � � � � I  u ��� � �
�� .rdwropenshor       file � 4   u {�� �
�� 
file � o   w z���� 0 target_file   � �� ���
�� 
perm � m   ~ ��
�� boovtrue��   � l      ����� � o      ���� 0 open_target_file  ��  ��   �  � � � I  � ��� � �
�� .rdwrwritnull���     **** � o   � ����� 0 	vcardinfo   � �� � �
�� 
refn � l  � � ����� � o   � ����� 0 open_target_file  ��  ��   � �� ���
�� 
wrat � m   � ���
�� rdwreof ��   �  ��� � I  � ��� ���
�� .rdwrclosnull���     **** � l  � � ����� � o   � ����� 0 open_target_file  ��  ��  ��  ��   � R      �� � �
�� .ascrerr ****      � **** � o      ���� 0 	theerrmsg 	theErrMsg � �� ���
�� 
errn � o      ���� 0 theerrnumber theErrNumber��   � L   � � � � o   � ����� 0 theerrnumber theErrNumber��  �� 0 i   � m   = >����  � o   > ?���� 0 npersons  ��   �  ��� � I  � �������
�� .aevtquitnull��� ��� null��  ��  ��   � m   , - � ��                                                                                  adrb   alis    d  Macintosh HD               �9H+     �Address Book.app                                                *�,��        ����  	                Applications    �*�      �,��       �  *Macintosh HD:Applications:Address Book.app  "  A d d r e s s   B o o k . a p p    M a c i n t o s h   H D  Applications/Address Book.app   / ��  ��  ��   �  ��� � l     ��������  ��  ��  ��       �� � � E R ��� � � �������������������   � ��~�}�|�{�z�y�x�w�v�u�t�s�r�q�p
� .aevtoappnull  �   � ****�~ 0 pathname PathName�} 0 filename fileName�| 0 thefile theFile�{ 0 npersons  �z 0 	vcardinfo  �y 0 
personname 
personName�x 0 target_file  �w 0 open_target_file  �v  �u  �t  �s  �r  �q  �p   � �o ��n�m � ��l
�o .aevtoappnull  �   � **** � k     � � �  > � �  M � �  ] � �  ��k�k  �n  �m   � �j�i�h�j 0 i  �i 0 	theerrmsg 	theErrMsg�h 0 theerrnumber theErrNumber � " E�g R�f |�e w�d�c�b�a�` ��_�^�]�\�[�Z�Y�X�W�V�U�T�S�R�Q�P�O�N�M ��L�g 0 pathname PathName�f 0 filename fileName�e 0 thefile theFile
�d 
file
�c 
psxp
�b .sysoexecTEXT���     TEXT�a  �`  
�_ 
azf4
�^ .corecnte****       ****�] 0 npersons  
�\ 
az49
�[ 
ctxt�Z 0 	vcardinfo  
�Y 
pnam�X 0 
personname 
personName�W 0 target_file  
�V 
perm
�U .rdwropenshor       file�T 0 open_target_file  
�S 
refn
�R 
wrat
�Q rdwreof �P 
�O .rdwrwritnull���     ****
�N .rdwrclosnull���     ****�M 0 	theerrmsg 	theErrMsg � �K�J�I
�K 
errn�J 0 theerrnumber theErrNumber�I  
�L .aevtquitnull��� ��� null�l ��E�O�E�O�  ��%E�O �*��/�,%j 	W X 
 hUO� �*�-j E�O yk�kh  *��/a ,a &E` O*��/a ,a &E` O��%a &E` O 5*�_ /a el E` O_ a _ a a a  O_ j W 	X   �[OY��O*j !U � � � � � M a c i n t o s h   H D : U s e r s : b r u n o b o i s s o n n e t : D o c u m e n t s : C o n t a c t s : A d d r e s s B o o k . v c f�� z � � � �z B E G I N : V C A R D  
 V E R S I O N : 3 . 0  
 N : V e l e z ; M a r c ; ; ;  
 F N : M a r c   V e l e z  
 E M A I L ; t y p e = I N T E R N E T ; t y p e = H O M E ; t y p e = p r e f : v e l e z . m a r c @ n e u f . f r  
 T E L ; t y p e = C E L L ; t y p e = p r e f : + 3 3   6   7 2   2 2   9 7   9 6  
 i t e m 1 . A D R ; t y p e = H O M E ; t y p e = p r e f : ; ; 4 2 0   R o u t e   D ' a r r a u n t z ; U s t a r i t z ; ; 6 4 4 8 0 ;  
 i t e m 1 . X - A B A D R : f r  
 X - A B U I D : 7 8 8 B 0 2 8 9 - F A 2 8 - 4 D D D - 9 2 6 8 - F 8 9 C 6 A 5 6 9 B F 7 \ : A B P e r s o n  
 E N D : V C A R D  
 � � � �  M a r c   V e l e z � � � � � M a c i n t o s h   H D : U s e r s : b r u n o b o i s s o n n e t : D o c u m e n t s : C o n t a c t s : A d d r e s s B o o k . v c f�� ���  ��  ��  ��  ��  ��  ��   ascr  ��ޭ