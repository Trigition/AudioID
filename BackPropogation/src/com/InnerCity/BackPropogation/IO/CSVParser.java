package com.InnerCity.BackPropogation.IO;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

import weka.core.Attribute;
import weka.core.FastVector;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.SparseInstance;

public final class CSVParser {
	
	/**
	 * Attempts to grab all instances from the passed CSV file and return them as instances.<br />
	 * Since this is a straight up implementation class, we use our own generated Attribibutes.
	 * @param file
	 * @return
	 */
	public static Instances getInstances(File file) {
		if (file == null || !file.exists() || file.isDirectory()) {
			System.out.println("Unable to collected instances from the passed file: " + file.getAbsolutePath());
			return null;
		}
		
		Scanner scanner;
		try {
			scanner = new Scanner(file);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		String line;
		int bitLength = -1;
		FastVector rows = new FastVector();
		
		while (scanner.hasNextLine()) {
			//grab line, process it
			line = scanner.nextLine();
			if (line.trim().isEmpty()) {
				//empty line, so ignore it
				continue;
			}
			
			String[] bits = line.split(",");
			
			//do some checking to make sure we have the same length of columns
			//or assign the length of columns if this is the first one
			if (bitLength == -1) {
				//first line we've got, so record the length
				bitLength = bits.length - 1;
				
				//TODO COUPLING OMG GET IT OUT OMG WHUT
				if (bitLength <= 0) {
					System.out.println("Invalid first line of passed file: bitlength is reported to be <= 0!");
					scanner.close();
					return null;
				}
			} else {
				//else this is not the first one, so we want to check and make sure it's the proper length
				if (bitLength != bits.length - 1) {
					System.out.println("Mismatched length of rows in input file!");
					scanner.close();
					return null;
				}
			}
			
			FastVector jerk = new FastVector();
			
			jerk.addElement(bits[0]);
			jerk.addElement(bits[1]);
			
			for (int i = 0; i < bitLength; i++) {
				jerk.addElement(bits[i + 1]);
			}
			
			rows.addElement(jerk);
			
		}
		
		//we have all of our rows put into our fast vector now
		//get attributes for our given bit length
		FastVector attributes = JerkAttributes.getAttributes(bitLength);
		
		Instances instances = new Instances("Jerks", attributes, rows.size());
		
		for (int i = 0; i < rows.size(); i++) {
			Instance inst = new SparseInstance(bitLength + 1);
			FastVector row = (FastVector) rows.elementAt(i);
			int startIndex = 0; //for keeping track of if the data starts at pos 0 or pos 1
			
			System.out.println("First Data: " + (String) row.elementAt(0));
			
			String firstKey = (String) row.elementAt(0);
			if (firstKey.contains("C") || firstKey.contains("R") || firstKey.contains("D")) {
				//it's the class!
				startIndex = 1;
				//set this to be our class value
				inst.setValue( (Attribute) attributes.elementAt(0), (String) row.elementAt(0));
			}
			
			for (int j = startIndex; j < row.size() - (startIndex); j++) {
				String o = (String) row.elementAt(j);
				
				System.out.println("Attribute: " + (Attribute) attributes.elementAt(j + (1 - startIndex)));
				System.out.println("data: " + o);
				
				inst.setValue((Attribute) attributes.elementAt(j + (1 - startIndex)), Double.parseDouble(o));
			}

			instances.add(inst);
			
			
			
		}
		
		scanner.close();
		
		instances.setClass((Attribute) attributes.elementAt(0));
		
		return instances;
	}
	
}
