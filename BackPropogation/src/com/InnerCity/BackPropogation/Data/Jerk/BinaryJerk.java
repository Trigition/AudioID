package com.InnerCity.BackPropogation.Data.Jerk;

import weka.core.Instance;

/**
 * Stores jerk information in a binary format
 * @author smanzana
 *
 */
public class BinaryJerk implements Jerk{
	
	/**
	 * Keep track of all the bits in the jerk
	 */
	boolean[] rangeArray;
	
	/**
	 * Holds the size of the array
	 */
	int size;
	
	
	/**
	 * Create a jerk using the given Instance as source data
	 * @param jerkSource
	 */
	public BinaryJerk(boolean[] jerkSource) {
		if (jerkSource == null) {
			size = 0;
		}
		
		//jerkSource.setV
		
		//fetch size of Jerk
		rangeArray = jerkSource.clone();
		size = rangeArray.length;
	}
	
	public int size() {
		return size;
	}
	
//	public Instance asInstance() {
//		//Instance inst = new Instance();
//		
//		
//	}
	
	
}
