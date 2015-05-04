package com.InnerCity.BackPropogation.IO;

import weka.core.Attribute;
import weka.core.FastVector;

public final class JerkAttributes{
	
	
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
			genreVector.addElement("Rock");
			genreVector.addElement("Classical");
			genreVector.addElement("Dubstep");
			
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
