package com.InnerCity.BackPropogation.IO;

import weka.core.Attribute;
import weka.core.FastVector;

public final class JerkAttributes{
	
	public static enum Genre {
		Reggae(101),
		Classical(102),
		Dubstep(103);
		
		private int index;
		
		private Genre(int index) {
			this.index = index;
		}
		
		public int getIndex() {
			return index;
		}
		
		public static Genre fromIndex(int index) {
			switch (index) {
			case 1:
				return Genre.Reggae;
			case 2:
				return Genre.Classical;
			case 3:
			default:
				return Genre.Dubstep;
			}
		}
	}
	
	
	private static FastVector attributeVector;
	
	/**
	 * Returns the attribute list.<br />
	 * If this is the first time this function is called, the attribute list is generated.<br />
	 * To generate an accurately sized attribute list, this function requires that the length
	 * of the actual bit array length be passed.
	 * @param bitSize
	 * @return
	 */
	public static FastVector getAttributes(int bitSize) {
		if (attributeVector == null) {
			
			attributeVector = new FastVector();
			Attribute attr;
			
			//do some sneaky genre stuff
			FastVector genreVector = new FastVector();
			genreVector.addElement(Genre.Reggae.getIndex());
			genreVector.addElement(Genre.Classical.getIndex());
			genreVector.addElement(Genre.Dubstep.getIndex());
			
			attr = new Attribute("Genre", genreVector);
			attributeVector.addElement(attr);
			
			//cycle through and create an attribute for each bit type
			for (int i = 0; i < bitSize; i++) {
				attr = new Attribute("Bit_" + i);
				attributeVector.addElement(attr);
			}
			
			return attributeVector;
			
			
		} else {
			return attributeVector;
		}
	}
}
