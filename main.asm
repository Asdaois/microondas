# i n c l u d e   " p 1 6 f 1 7 8 7 . i n c "  
 ;   C O N F I G 1  
 ;   U s e   l a   m i s m a   c o n f i g u r a c i � n   d e   l o s   a n e x o s   r e f e r e n t e s   a l   1 7 8 7   a n e x o   2 . 1  
 ;   V a r i a b l e s  
 D I S S _ L   e q u   0 x 2 0  
 D I S S _ H   e q u   0 x 2 1  
 D I S M _ L   e q u   0 x 2 2  
 D I S M _ H   e q u   0 x 2 3  
 C O N T 0   e q u   0 x 2 4  
 C O N T 1   e q u   0 x 2 5  
 S E G _ L   e q u   0 x 2 6  
 S E G _ H   e q u   0 x 2 7  
 M I N _ L   e q u   0 x 2 8  
 M I N _ H   e q u   0 x 2 9  
 C O N D   e q u   0 x 2 A  
 A U X   e q u   0 x 2 B  
 D E C   e q u   0 x 2 C  
 E S T A D O   e q u   0 x 2 D  
 W A U X   e q u   0 x 2 E  
 C O N D 2   e q u   0 x 2 F  
 D E C 2   e q u   0 x 3 0  
  
 g o t o   P R I N C I P A L  
 o r g   0 4  
 g o t o   I N T E R R U P C I O N  
 P R I N C I P A L :  
 b s f   S T A T U S , R P 0  
 m o v l w   0 x F 1  
 m o v w f   T R I S B  
 m o v l w   0 x 0 1  
 m o v w f   T R I S D  
 m o v l w   0 x 0 C  
 m o v w f   T R I S C  
 m o v l w   0 x 0 4  
 m o v w f   O P T I O N _ R E G  
 b c f   S T A T U S , R P 0  
 m o v l w   . 2 0 0  
 m o v w f   D E C  
 c l r f   D E C 2  
 c l r f   C O N D 2  
 c l r f   P O R T B  
 c l r f   C O N D  
 c l r f   S E G _ L  
 c l r f   S E G _ H  
 c l r f   M I N _ L  
 c l r f   M I N _ H  
 m o v l w   0 x 8 0  
 m o v w f   D I S S _ L  
 m o v w f   D I S S _ H  
 m o v w f   D I S M _ L  
 m o v w f   D I S M _ H  
 m o v l w   0 x 2 0  
 m o v w f   F S R  
 m o v l w   0 x 1 0  
 m o v w f   P O R T C  
 m o v l w   0 x A 0  
 m o v w f   I N T C O N  
 C I C L O 2  
 b t f s s   P O R T B , 4  
 g o t o   C I C L O 2  
 b t f s s   P O R T B , 5  
 g o t o   C I C L O 2  
 b t f s s   P O R T B , 6  
 g o t o   C I C L O 2  
 b t f s s   P O R T B , 7  
 g o t o   C I C L O 2  
 C I C L O  
 b t f s s   I N T C O N , 0  
 g o t o   C I C L O  
 c a l l   R E T A R D O  
 m o v l w   0 x F C   ;   1 1 1 1 1 1 0 0   c o l u m n a    
 m o v w f   P O R T B  
 b t f s c   P O R T B , 4   ;   u n o  
 g o t o   $ + 3  
 m o v l w   0 x 0 1  
 g o t o   C O N I N T  
 b t f s c   P O R T B , 5   ;   c u a t r o  
 g o t o   $ + 3  
 m o v l w   0 x 0 4  
 g o t o   C O N I N T  
 b t f s c   P O R T B , 6   ;   s i e t e  
 g o t o   $ + 3  
 m o v l w   0 x 0 7  
 g o t o   C O N I N T  
 b t f s s   P O R T B , 7   ;   *  
 g o t o   R E S E T  
 m o v l w   0 x F A   ; 1 1 1 1 0 1 0   s e g u n d a   c o l u m n a  
 m o v w f   P O R T B  
 b t f s c   P O R T B , 4   ;   d o s  
 g o t o   $ + 3  
 m o v l w   0 x 0 2  
 g o t o   C O N I N T  
 b t f s c   P O R T B , 5   ;   c i n c o  
 g o t o   $ + 3  
 m o v l w   0 x 0 5  
 g o t o   C O N I N T  
 b t f s c   P O R T B , 6   ;   o c h o  
 g o t o   $ + 3  
 m o v l w   0 x 0 8  
 g o t o   C O N I N T  
 b t f s c   P O R T B , 7   ;   c e r o  
 g o t o   $ + 3  
 m o v l w   0 x 0 0  
 g o t o   C O N I N T  
 m o v l w   0 x F 6   ;   1 1 1 1 0 1 1 0   t e r c e r a   c o l u m n a  
 m o v w f   P O R T B  
 b t f s c   P O R T B , 4   ; t r e s  
 g o t o   $ + 3  
 m o v l w   0 x 0 3  
 g o t o   C O N I N T  
 b t f s c   P O R T B , 5   ;   s e i s  
 g o t o   $ + 3  
 m o v l w   0 x 0 6  
 g o t o   C O N I N T  
 b t f s c   P O R T B , 6   ;   n u e v e  
 g o t o   $ + 3  
 m o v l w   0 x 0 9  
 g o t o   C O N I N T  
 b t f s c   P O R T B , 7   ;   #  
 g o t o   F I N  
 b c f   I N T C O N , 0  
 b s f   C O N D , 0  
 b s f   C O N D , 1  
 m o v f   S E G _ L , W  
 a d d w f   S E G _ H , W  
 a d d w f   M I N _ L , W  
 a d d w f   M I N _ H , W  
 b t f s c   S T A T U S , Z  
 g o t o   R E S E T  
 g o t o   S T P S  
 C O N I N T  
 m o v w f   A U X  
 m o v f   M I N _ L , W  
 m o v w f   M I N _ H  
 m o v f   S E G _ H , W  
 m o v w f   M I N _ L  
 m o v f   S E G _ L , W  
 m o v w f   S E G _ H  
 m o v f   A U X , W  
 m o v w f   S E G _ L  
 c a l l   A S I G N A R  
 F I N   c l r f   P O R T B  
 b c f   I N T C O N , 0  
 g o t o   C I C L O 2  
 B C D _ 7 S E G  
 a d d w f   P C L , F  
 r e t l w   0 x 8 0  
 r e t l w   0 x F 2  
 r e t l w   0 x 4 8  
 r e t l w   0 x 6 0  
 r e t l w   0 x 3 2  
 r e t l w   0 x 2 4  
 r e t l w   0 x 0 4  
 r e t l w   0 x F 0  
 r e t l w   0 x 0 0  
 r e t l w   0 x 3 0  
 I N T E R R U P C I O N :  
 m o v w f   W A U X  
 s w a p f   S T A T U S , W  
 m o v w f   E S T A D O  
 m o v l w   . 1 0 0  
 a d d w f   T M R 0 , F  
 b t f s s   C O N D 2 , 0  
 g o t o   S I G  
 d e c f s z   D E C 2 , F  
 g o t o   $ + 4  
 b c f   C O N D 2 , 0  
 b c f   P O R T C , 0  
 g o t o   S I G  
 m o v l w   . 2 0 0  
 x o r w f   D E C 2 , W  
 b t f s c   S T A T U S , Z  
 b c f   P O R T C , 0  
 m o v l w   . 1 5 0  
 x o r w f   D E C 2 , W  
 b t f s c   S T A T U S , Z  
 b s f   P O R T C , 0  
 m o v l w   . 1 0 0  
 x o r w f   D E C 2 , W  
 b t f s c   S T A T U S , Z  
 b c f   P O R T C , 0  
 m o v l w   . 5 0  
 x o r w f   D E C 2 , W  
 b t f s c   S T A T U S , Z  
 b s f   P O R T C , 0  
 S I G  
 b t f s s   C O N D , 1  
 g o t o   C O N T I N U A R 1  
 m o v f   S E G _ L , W  
 a d d w f   S E G _ H , W  
 a d d w f   M I N _ L , W  
 a d d w f   M I N _ H , W  
 b t f s c   S T A T U S , Z  
 g o t o   I R F I N  
 d e c f s z   D E C , F  
 g o t o   C O N T I N U A R 1  
 m o v l w   . 2 0 0  
 m o v w f   D E C  
 m o v l w   0  
 x o r w f   S E G _ L , W  
 b t f s c   S T A T U S , Z  
 g o t o   $ + 3  
 d e c f   S E G _ L , F  
 g o t o   C O N T I N U A R 2  
 m o v l w   . 9  
 m o v w f   S E G _ L  
 m o v l w   0  
 x o r w f   S E G _ H , W  
 b t f s c   S T A T U S , Z  
 g o t o   $ + 3  
 d e c f   S E G _ H , F  
 g o t o   C O N T I N U A R 2  
 m o v l w   . 5  
 m o v w f   S E G _ H  
 m o v l w   0  
 x o r w f   M I N _ L , W  
 b t f s c   S T A T U S , Z  
 g o t o   $ + 3  
 d e c f   M I N _ L , F  
 g o t o   C O N T I N U A R 2  
 m o v l w   . 9  
 m o v w f   M I N _ L  
 m o v l w   0  
 x o r w f   M I N _ H , W  
 b t f s c   S T A T U S , Z  
 g o t o   $ + 3  
 d e c f   M I N _ H , F  
 g o t o   C O N T I N U A R 2  
 I R F I N  
 b s f   P O R T C , 0  
 c l r f   P O R T B  
 b c f   I N T C O N , 0  
 c l r f   C O N D  
 b s f   C O N D 2 , 0  
 m o v l w   . 2 5 0  
 m o v w f   D E C 2  
 g o t o   C O N T I N U A R 1  
 C O N T I N U A R 2  
 c a l l   A S I G N A R  
 C O N T I N U A R 1  
 i n c f   F S R , F  
 m o v l w   0 x 2 4  
 x o r w f   F S R , W  
 b t f s s   S T A T U S , Z  
 g o t o   $ + 3  
 m o v l w   0 x 2 0  
 m o v w f   F S R  
 b t f s s   P O R T C , 4  
 g o t o   $ + 4  
 b c f   P O R T C , 4  
 b s f   P O R T C , 5  
 g o t o   C O N _ C O R  
 b t f s s   P O R T C , 5  
 g o t o   $ + 4  
 b c f   P O R T C , 5  
 b s f   P O R T C , 6  
 g o t o   C O N _ C O R  
 b t f s s   P O R T C , 6  
 g o t o   $ + 4  
 b c f   P O R T C , 6  
 b s f   P O R T C , 7  
 g o t o   C O N _ C O R  
 b c f   P O R T C , 7  
 b s f   P O R T C , 4  
 C O N _ C O R  
 m o v f   I N D F , W  
 m o v w f   P O R T D  
 b c f   I N T C O N , 2  
 s w a p f   E S T A D O , W  
 m o v w f   S T A T U S  
 s w a p f   W A U X , F  
 s w a p f   W A U X , W  
 r e t f i e  
 R E S E T  
 b c f   P O R T C , 1  
 c l r f   C O N D  
 c l r f   S E G _ L  
 c l r f   S E G _ H  
 c l r f   M I N _ L  
 c l r f   M I N _ H  
 m o v l w   . 2 0 0  
 m o v w f   D E C  
 m o v l w   0  
 g o t o   C O N I N T  
 S T P S  
 b s f   P O R T C , 1  
 c l r f   P O R T B  
 C O N D _ F I N A L  
 b t f s s   C O N D , 0  
 g o t o   F I N A L  
 b t f s s   P O R T B , 4  
 g o t o   C O N D _ F I N A L  
 b t f s s   P O R T B , 5  
 g o t o   C O N D _ F I N A L  
 b t f s s   P O R T B , 6  
 g o t o   C O N D _ F I N A L  
 b t f s s   P O R T B , 7  
 g o t o   C O N D _ F I N A L  
 b c f   I N T C O N , 0  
 b t f s s   C O N D , 0  
 g o t o   F I N A L  
 b t f s s   I N T C O N , 0  
 g o t o   $ - 3  
 c a l l   R E T A R D O  
 m o v l w   0 x F C  
 m o v w f   P O R T B  
 b t f s s   P O R T B , 7  
 g o t o   R E S E T  
 m o v l w   0 x F 6  
 m o v w f   P O R T B  
 b t f s c   P O R T B , 7  
 g o t o   S T P S  
 b c f   I N T C O N , 0  
 b c f   C O N D , 1  
 P A U S A  
 b c f   P O R T C , 1  
 c l r f   P O R T B  
 P A U S A _ 1  
 b t f s s   P O R T B , 4  
 g o t o   P A U S A _ 1  
 b t f s s   P O R T B , 5  
 g o t o   P A U S A _ 1  
 b t f s s   P O R T B , 6  
 g o t o   P A U S A _ 1  
 b t f s s   P O R T B , 7  
 g o t o   P A U S A _ 1  
 b c f   I N T C O N , 0  
 b t f s s   I N T C O N , 0  
 g o t o   $ - 1  
 c a l l   R E T A R D O  
 m o v l w   0 x F C  
 m o v w f   P O R T B  
 b t f s s   P O R T B , 7  
 g o t o   R E S E T  
 m o v l w   0 x F 6  
 m o v w f   P O R T B  
 b t f s c   P O R T B , 7  
 g o t o   P A U S A  
 b c f   I N T C O N , 0  
 b s f   C O N D , 1  
 g o t o   S T P S  
 F I N A L  
 b c f   P O R T C , 1  
 m o v l w   0 x 4 2  
 m o v w f   D I S S _ L  
 m o v l w   0 x 5 6  
 m o v w f   D I S S _ H  
 m o v l w   0 x 0 C  
 m o v w f   D I S M _ L  
 m o v l w   0 x F F  
 m o v w f   D I S M _ H  
 c l r f   P O R T B  
 F I N A L _ 1  
 b t f s s   P O R T B , 4  
 g o t o   F I N A L _ 1  
 b t f s s   P O R T B , 5  
 g o t o   F I N A L _ 1  
 b t f s s   P O R T B , 6  
 g o t o   F I N A L _ 1  
 b t f s s   P O R T B , 7  
 g o t o   F I N A L _ 1  
 b c f   I N T C O N , 0  
 b t f s s   I N T C O N , 0  
 g o t o   $ - 1  
 c a l l   R E T A R D O  
 m o v l w   0 x F C  
 m o v w f   P O R T B  
 b t f s c   P O R T B , 7  
 g o t o   F I N A L  
 b c f   I N T C O N , 0  
 g o t o   R E S E T  
 R E T A R D O  
 m o v l w   0 x 1 9  
 m o v w f   C O N T 0  
 m o v l w   0 x F F  
 m o v w f   C O N T 1  
 d e c f s z   C O N T 1 , F  
 g o t o   $ - 1  
 d e c f s z   C O N T 0 , F  
 g o t o   $ - 5  
 r e t u r n  
 A S I G N A R  
 m o v f   S E G _ L , W  
 c a l l   B C D _ 7 S E G  
 m o v w f   D I S S _ L  
 m o v f   S E G _ H , W  
 c a l l   B C D _ 7 S E G  
 m o v w f   D I S S _ H  
 m o v f   M I N _ L , W  
 c a l l   B C D _ 7 S E G  
 m o v w f   D I S M _ L  
 m o v f   M I N _ H , W  
 c a l l   B C D _ 7 S E G  
 m o v w f   D I S M _ H  
 r e t u r n  
 e n d 