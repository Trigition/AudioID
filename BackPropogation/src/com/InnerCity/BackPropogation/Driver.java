package com.InnerCity.BackPropogation;

import weka.classifiers.functions.MultilayerPerceptron;
import weka.core.Instances;

/**
 * Runs the program.
 * But what do we want? What would be the input? That's a hard question.
 * I think the simplist answer is to just provide a dir with the test and a dir with the training dadta
 * and just parse it, gather up what it can, and then
 * simply construct the network and do what we do with it?
 * @author smanzana
 *
 */
public class Driver {

	public static void main(String[] args) {
		
		
		
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
