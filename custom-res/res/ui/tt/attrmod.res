Haven Resource 1
 src   AttrMod.java /* Preprocessed source code */
package haven.res.ui.tt.attrmod;

import haven.*;
import static haven.PUtils.*;
import java.util.*;
import java.awt.image.BufferedImage;

/* >tt: AttrMod$Fac */
public class AttrMod extends ItemInfo.Tip {
    public final Collection<Mod> mods;

    public static class Mod {
	public final Resource attr;
	public final int mod;

	public Mod(Resource attr, int mod) {this.attr = attr; this.mod = mod;}
    }

    public AttrMod(Owner owner, Collection<Mod> mods) {
	super(owner);
	this.mods = mods;
    }

    public static class Fac implements InfoFactory {
	public ItemInfo build(Owner owner, Raw raw, Object... args) {
	    Resource.Resolver rr = owner.context(Resource.Resolver.class);
	    Collection<Mod> mods = new ArrayList<Mod>();
	    for(int a = 1; a < args.length; a += 2)
		mods.add(new Mod(rr.getres((Integer)args[a]).get(), (Integer)args[a + 1]));
	    return(new AttrMod(owner, mods));
	}

	public ItemInfo build(Owner owner, Object... args) {
	    return(null);
	}
    }

    private static String buff = "128,255,128", debuff = "255,128,128";
    public static BufferedImage modimg(Collection<Mod> mods) {
	Collection<BufferedImage> lines = new ArrayList<BufferedImage>(mods.size());
	for(Mod mod : mods) {
	    BufferedImage line = RichText.render(String.format("%s $col[%s]{%s%d}", mod.attr.layer(Resource.tooltip).t,
							       (mod.mod < 0)?debuff:buff, (mod.mod < 0)?'-':'+', Math.abs(mod.mod)),
						 0).img;
	    BufferedImage icon = convolvedown(mod.attr.layer(Resource.imgc).img,
					      new Coord(line.getHeight(), line.getHeight()),
					      CharWnd.iconfilter);
	    lines.add(catimgsh(0, icon, line));
	}
	return(catimgs(0, lines.toArray(new BufferedImage[0])));
    }

    public BufferedImage tipimg() {
	return(modimg(mods));
    }
}
code �  haven.res.ui.tt.attrmod.AttrMod$Mod ����   4 
  	  	     attr Lhaven/Resource; mod I <init> (Lhaven/Resource;I)V Code LineNumberTable 
SourceFile AttrMod.java 
     	  #haven/res/ui/tt/attrmod/AttrMod$Mod Mod InnerClasses java/lang/Object ()V haven/res/ui/tt/attrmod/AttrMod attrmod.cjava !             	     
      '     *� *+� *� �                     
     	code �  haven.res.ui.tt.attrmod.AttrMod$Fac ����   4 N
  $ %  ' (
  $ ) +
  ,  - . / 0
  1 2 3 4
  5 6 8 : <init> ()V Code LineNumberTable build < Owner InnerClasses = Raw O(Lhaven/ItemInfo$Owner;Lhaven/ItemInfo$Raw;[Ljava/lang/Object;)Lhaven/ItemInfo; StackMapTable % > ;(Lhaven/ItemInfo$Owner;[Ljava/lang/Object;)Lhaven/ItemInfo; 
SourceFile AttrMod.java   haven/Resource$Resolver Resolver ? @ java/util/ArrayList #haven/res/ui/tt/attrmod/AttrMod$Mod Mod java/lang/Integer A B C D E F G haven/Resource  H > I J haven/res/ui/tt/attrmod/AttrMod  K #haven/res/ui/tt/attrmod/AttrMod$Fac Fac java/lang/Object L haven/ItemInfo$InfoFactory InfoFactory haven/ItemInfo$Owner haven/ItemInfo$Raw java/util/Collection context %(Ljava/lang/Class;)Ljava/lang/Object; intValue ()I getres (I)Lhaven/Indir; haven/Indir get ()Ljava/lang/Object; (Lhaven/Resource;I)V add (Ljava/lang/Object;)Z /(Lhaven/ItemInfo$Owner;Ljava/util/Collection;)V haven/ItemInfo attrmod.cjava !                    *� �            �       �     e+�  � :� Y� :6-�� =� Y-2� � � 	 � 
 � -`2� � � �  W���» Y+� �        �    � @                T  Z  �  !          �           "  "    M    2   9 	  9  	   &	   * 	   7 	  9 ;	code +  haven.res.ui.tt.attrmod.AttrMod ����   4 �
 , O	 + P Q R S
  T R U V W V X Y Z [	 	 \	 ] ^
 ] _ `	  b	 	 c	 + d	 + e
 f g
 h i
 j k
 l m
 n o	 n p	 ] q r	  p t
 " u
  v	 w x
 y z {
 + | R } R ~ 
 + �
 + � � � � � � Fac InnerClasses Mod mods Ljava/util/Collection; 	Signature =Ljava/util/Collection<Lhaven/res/ui/tt/attrmod/AttrMod$Mod;>; buff Ljava/lang/String; debuff <init> � Owner /(Lhaven/ItemInfo$Owner;Ljava/util/Collection;)V Code LineNumberTable V(Lhaven/ItemInfo$Owner;Ljava/util/Collection<Lhaven/res/ui/tt/attrmod/AttrMod$Mod;>;)V modimg 6(Ljava/util/Collection;)Ljava/awt/image/BufferedImage; StackMapTable � � Y � � [ ](Ljava/util/Collection<Lhaven/res/ui/tt/attrmod/AttrMod$Mod;>;)Ljava/awt/image/BufferedImage; tipimg  ()Ljava/awt/image/BufferedImage; <clinit> ()V 
SourceFile AttrMod.java 8 � 1 2 java/util/ArrayList � � � 8 � � � � � � � � #haven/res/ui/tt/attrmod/AttrMod$Mod %s $col[%s]{%s%d} java/lang/Object � � � � � � � haven/Resource$Tooltip Tooltip � 6 � � 7 6 5 6 � � � � � � � � � � � � � � � � � � � haven/Resource$Image Image haven/Coord � � 8 � � � � � � � java/awt/image/BufferedImage � � � � � � [Ljava/awt/image/BufferedImage; � � ? @ 128,255,128 255,128,128 haven/res/ui/tt/attrmod/AttrMod � haven/ItemInfo$Tip Tip #haven/res/ui/tt/attrmod/AttrMod$Fac haven/ItemInfo$Owner java/util/Collection java/util/Iterator java/lang/String [Ljava/lang/Object; (Lhaven/ItemInfo$Owner;)V size ()I (I)V iterator ()Ljava/util/Iterator; hasNext ()Z next ()Ljava/lang/Object; attr Lhaven/Resource; haven/Resource tooltip Ljava/lang/Class; layer � Layer )(Ljava/lang/Class;)Lhaven/Resource$Layer; t mod I java/lang/Character valueOf (C)Ljava/lang/Character; java/lang/Math abs (I)I java/lang/Integer (I)Ljava/lang/Integer; format 9(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String; haven/RichText render 8(Ljava/lang/String;I[Ljava/lang/Object;)Lhaven/RichText; img Ljava/awt/image/BufferedImage; imgc 	getHeight (II)V haven/CharWnd 
iconfilter � Convolution Lhaven/PUtils$Convolution; haven/PUtils convolvedown e(Ljava/awt/image/BufferedImage;Lhaven/Coord;Lhaven/PUtils$Convolution;)Ljava/awt/image/BufferedImage; catimgsh @(I[Ljava/awt/image/BufferedImage;)Ljava/awt/image/BufferedImage; add (Ljava/lang/Object;)Z toArray (([Ljava/lang/Object;)[Ljava/lang/Object; catimgs haven/ItemInfo haven/Resource$Layer haven/PUtils$Convolution attrmod.cjava ! + ,     1 2  3    4 
 5 6   
 7 6     8 ;  <   +     *+� *,� �    =          
  3    > 	 ? @  <  �     ܻ Y*�  � L*�  M,�  � �,�  � 	N
� Y-� � � � � SY-� � 	� � � SY-� � -� +� SY-� � � S� � � � :-� � � � � � Y� � � �  � !:+� "YSYS� #� $ W��N+� "� % � &� '�    A   � �  B C� :  B B C D  E F F�   B B C D  E F F G�   B B C D  E F F�   B B C D  E F F� e =   .    (  ) ( * d + u * � - � . � - � 0 � 1 � 2 3    H  I J  <         *� � (�    =       6  K L  <   #      )� *� �    =       &  M    � /   B  - + . 	 	 + 0 	 9 � :	  ] a   ] s  , � �	 � ] � � y �	codeentry *   tt haven.res.ui.tt.attrmod.AttrMod$Fac   