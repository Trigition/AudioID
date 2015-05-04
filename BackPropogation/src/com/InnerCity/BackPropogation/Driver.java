package com.InnerCity.BackPropogation;

import java.io.File;
import java.io.IOException;
import java.util.Scanner;

import com.InnerCity.BackPropogation.IO.CSVParser;

import weka.classifiers.functions.MultilayerPerceptron;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.converters.CSVLoader;

/**
 * Runs the program.
 * But what do we want? What would be the input? That's a hard question.
 * I think the simplist answer is to just provide a dir with the test and a dir with the training dadta
 * and just parse it, gather up what it can, and then
 * simply construct the network and do what we do with it?
 * @author smanzana
 *
 */
public final class Driver {

	public static void main(String[] args) throws IOException {
		
		Instances trainInstances;
		Instance testInst;
		Scanner input = new Scanner(System.in);
		
		//trainInst = getTraining(args.length > 0 ? args[0] : null);
		
		
		
		File inFile;
		
		if (args.length == 0) {
			System.out.println("Welcome. How are you? Great? That's great!");
			System.out.println("Please enter the name of the file to load TRAINING vectors from.");
			System.out.println("This file should be a .csv and have a header row");
			System.out.print("Training Filename:  ");
			
			String inf = null;
			while (inf == null || inf.trim().isEmpty()) {
				inf = input.nextLine();
			}
			
			inFile = new File(inf);
			
		} else {
			inFile = new File(args[0]);
		}
		
		if (!inFile.exists() || inFile.isDirectory()) {
			System.out.println("Error locating file or invalid file type: " + inFile.getAbsolutePath());
			printUsage();
			return;
		}
		
		//CSVLoader load = new CSVLoader();

		
		System.out.print("Loading training vectors... ");
		try {
			trainInstances = CSVParser.getInstances(inFile);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return;
		}
		
		System.out.println(" complete!");
		
		
		//trian network
		MultilayerPerceptron n = new MultilayerPerceptron();
		
		System.out.print("Beginning training...");
		System.out.println(trainInstances.attribute(1));
		trainInstances.setClassIndex(1);
		try {
			n.buildClassifier(trainInstances);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		System.out.println("  complete!");
		
		
		
		
		
		
		while (true) {
			//testInst = getTest(null);
			
			//
			File testFile;
			
			
			System.out.println("Please enter the name of the file containing the jerk you would like to classify:");
			
			String inf = null;
			while (inf == null || inf.trim().isEmpty()) {
				if (input.hasNextLine()) {
					inf = input.nextLine();
				}
			}
				
			testFile = new File(inf);
			
			
			//light file error checking
			if (!testFile.exists() || testFile.isDirectory()) {
				System.out.println("Error reading file: " + testFile.getAbsolutePath());
				continue;
			}
			
					
			//go through and finally load up the dataset from the file
			//CSVLoader load = new CSVLoader();
			Instances testInstances;
			testInstances = CSVParser.getInstances(testFile);
			
			if (testInstances.numInstances() > 1) {
				System.out.println("Warning: Only the first jerk is taken from the passed file!");
				System.out.println("Ignored " + (testInstances.numInstances() - 1) + " instances!");
			} else if (testInstances.numInstances() == 0) {
				System.out.println("Unable to find valid jerk data inside the passed file!");
				continue;
			}
			
			testInst = testInstances.firstInstance();
			testInst.setClassMissing();
			
			try {
				System.out.println(n.classifyInstance(testInst));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		
	}
	
//	private static Instances getTraining(String fileName) {
//		
//		
//		Scanner scan = new Scanner(System.in);
//File inFile;
//		
//		if (fileName == null) {
//			System.out.println("Welcome. How are you? Great? That's great!");
//			System.out.println("Please enter the name of the file to load TESTING vectors from.");
//			System.out.println("This file should be a .csv and have a header row");
//			System.out.print("Training Filename:  ");
//			
//			String inf = null;
//			while (inf == null || inf.trim().isEmpty()) {
//				inf = scan.nextLine();
//			}
//			
//			scan.close();
//			inFile = new File(inf);
//			
//		} else {
//			inFile = new File(fileName);
//		}
//		
//		if (!inFile.exists() || inFile.isDirectory()) {
//			System.out.println("Error locating file or invalid file type: " + inFile.getAbsolutePath());
//			printUsage();
//			return null;
//		}
//		
//		CSVLoader input = new CSVLoader();
//
//		
//		System.out.print("Loading training vectors... ");
//		Instances trainInstances = null;
//		try {
//			input.setFile(inFile);
//			String[] u = {"-H"};
//			input.setOptions(u);
//			trainInstances = input.getDataSet();
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		
//		System.out.println(" complete!");
//				
//		return trainInstances;
//		
//	}
	
//	private static Instance getTest(String fileName) {
//		
//		Scanner input = new Scanner(System.in);
//		File testFile;
//		
//		
//		if (fileName == null) {
//			System.out.println("Please enter the name of the file containing the jerk you would like to classify:");
//			
//			String inf = null;
//			while (inf == null || inf.trim().isEmpty()) {
//				if (input.hasNextLine()) {
//					inf = input.nextLine();
//				}
//			}
//			
//			testFile = new File(inf);
//			input.close();
//			
//		} else {
//			testFile = new File(fileName);
//		}
//		
//		
//		//light file error checking
//		if (!testFile.exists() || testFile.isDirectory()) {
//			System.out.println("Error reading file: " + testFile.getAbsolutePath());
//			return null;
//		}
//		
//				
//		//go through and finally load up the dataset from the file
//		CSVLoader load = new CSVLoader();
//		Instances trainInst;
//		try {
//			load.setFile(testFile);
//			trainInst = load.getDataSet();
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			return null;
//		}
//		
//		if (trainInst.numInstances() > 1) {
//			System.out.println("Warning: Only the first jerk is taken from the passed file!");
//			System.out.println("Ignored " + (trainInst.numInstances() - 1) + " instances!");
//		} else if (trainInst.numInstances() == 0) {
//			System.out.println("Unable to find valid jerk data inside the passed file!");
//			return null;
//		}
//		
//		return trainInst.firstInstance();
//		
//	}
	
	public static void printUsage() {
		System.out.println("Usage: java -jar [jarname] [filename]");
	}
	
}



/*
package NeuralClass.WekaLab;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.util.Enumeration;

import weka.classifiers.Classifier;
import weka.classifiers.functions.MultilayerPerceptron;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;

public class FirstTry  {
	
	
	@SuppressWarnings("unchecked")
	public static void main(String[] argv){
		
		String input = "data.arff";
		MultilayerPerceptron net = new MultilayerPerceptron();
		
		try{

			InputStream read = new ObjectInputStream(new FileInputStream(input));
			Instances allData = DataSource.read(read);
			allData.setClassIndex(allData.numAttributes() -1);	
			
			Instances trainSet = new Instances(allData, 0);
			Instances testSet = new Instances(allData, 0);
			
			boolean UseInTrain = true;  // controls whether to add the Instance at the training set or at the testing set
			Enumeration<Instance> enumInstances = allData.enumerateInstances();
			
			while  (enumInstances.hasMoreElements()) {
				 Instance currInstance  = enumInstances.nextElement();
				 if (UseInTrain)
				    trainSet.add(currInstance);
				 else
				   testSet.add(currInstance);
				 UseInTrain = !UseInTrain;
				}
			
			net.buildClassifier(trainSet);

			net.
			
			int cnt = 0;
						
			Enumeration<Instance> enumTestInstances = testSet.enumerateInstances() ;
			int numTestingInstances = testSet.numInstances();
			double[] classLabels = new double[numTestingInstances];
			double[] predictedLabels  = new double[numTestingInstances];
			
			 double[] distForInstance;
			int	 classOfInstances;
			 
			 int classIdx = testSet.classIndex();
					 
			while (enumTestInstances.hasMoreElements()) {   // for all the elements of the testing set
				   Instance currInstance = enumTestInstances.nextElement();
				   distForInstance = net.distributionForInstance(currInstance);
				   classOfInstances =currInstance.index(classIdx);
				   classLabels[cnt] = classOfInstances;
				   predictedLabels[cnt] = distForInstance[0];
				   cnt += 1;
				   
			}
			
			read.close();
		} catch (IOException e) {
			e.printStackTrace();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}

	
}
*/
