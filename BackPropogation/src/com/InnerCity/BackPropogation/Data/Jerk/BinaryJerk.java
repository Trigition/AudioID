package com.InnerCity.BackPropogation.Data.Jerk;

import weka.core.Attribute;
import weka.core.Instance;
import weka.core.SparseInstance;

/**
 * Stores jerk information in a binary format.
 * Values are either 0 or 1, and cannot hold intermediate values.
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
	
	public Instance asInstance() {
		if (rangeArray == null || size == 0) {
			return null;
		}
		
		Instance inst = new SparseInstance(size);
		
		for (int i = 0; i < size; i++) {
			Attribute att = new Attribute("bit_" + i);
			inst.setValue(att, rangeArray[i] ? 1.0 : 0.0);
		}
		
		
		return inst;
		
	}
	
	
}
