package com.InnerCity.BackPropogation.Data.Jerk;

import weka.core.Attribute;
import weka.core.Instance;
import weka.core.SparseInstance;

/**
 * Stores jerk information in a binary fashion.<br />
 * 0 values indicate an unknown or gray area.<br />
 * Please note this implementation does not store continuous values. It only stores
 * a -1, 0, or 1. No intermediate values are considered.
 * @author smanzana
 *
 */
public class BipolarJerk implements Jerk {
	
	/**
	 * Store the values passed by the given vector that this jerk represents.
	 * We choose characters to represent out data here. Characters are the smallest
	 * representation we can have without only having two states (boolean) or taking up
	 * 4-8 bytes instead (int, double). Therefore we use chars even though we're only using
	 * 3 states out of 255
	 */
	private char[] rangeArray;
	
	private int size;
	
	public BipolarJerk(char[] dataArray) {
		
		this.rangeArray = dataArray.clone();
		this.size = rangeArray.length;
		
	}
	
	/**
	 * Casts the given double array to bipolar standards.<br />
	 * Specifics for determining which value to store are:
	 * <p><ul>
	 * <li>-1 : value < -.5 </li>
	 * <li>0 : -.5 <= value <= .5</li>
	 * <li>1 : .5 < value</li>
	 * </ul></p>
	 * @param dataArray
	 */
	public BipolarJerk(double[] dataArray) {
		this.size = rangeArray.length;
		
		this.rangeArray = new char[size];
		
		for (int i = 0; i < size; i ++) {
			if (dataArray[i] < -0.5) {
				rangeArray[i] = (char) -1;
			} else if (dataArray[i] <= 0.5) {
				rangeArray[i] = 0;
			} else {
				rangeArray[i] = 1;
			}
		}
	}
	
	public BipolarJerk(boolean[] dataArray) {
		this.size = dataArray.length;
		
		this.rangeArray = new char[size];
		
		for (int i = 0; i < size; i++) {
			rangeArray[i] = (char) (dataArray[i] ? 1 : -1);
		}
	}
	
	public Instance asInstance() {
		if (rangeArray == null || size == 0) {
			return null;
		}
		
		Instance inst = new SparseInstance(size);
		
		for (int i = 0; i < size; i++) {
			Attribute attr = new Attribute("bit_" + i);
			inst.setValue(attr, rangeArray[i]);
		}
		
		return inst;
	}

}
