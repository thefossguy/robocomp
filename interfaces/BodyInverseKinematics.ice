//******************************************************************
// 
//  Generated by IDSL to IDL Translator
//  
//  File name: BodyInverseKinematics.idl
//  Source: BodyInverseKinematics.idsl
//  
//******************************************************************   
#ifndef ROBOCOMPBODYINVERSEKINEMATICS_ICE
#define ROBOCOMPBODYINVERSEKINEMATICS_ICE

module RoboCompBodyInverseKinematics
{
	exception BIKException { string text; };
	struct Pose6D
	{
		float x;
		float y;
		float z;
		float rx;
		float ry;
		float rz;
	};
	struct WeightVector //Multiplies the error vector as E(q) = e' W e;
	{
		float x;
		float y;
		float z;
		float rx;
		float ry;
		float rz;
	};
	struct Axis
	{
		float x;
		float y;
		float z;
	};
	
	
	interface BodyInverseKinematics
	{
		// Deprecated
		bool setTarget(string bodyPart, Pose6D target) throws BIKException;
		// Sets part tip position at 6dof target. Any of these 6 constraints can be relaxed by setting weights [x y z rx ry rz]to zero.
		// For example, if we don't care about final orientation, set weights to [1 1 1 0 0 0]
		//Values different to 0-1 can be used to ponderate the effect of each component of the error vector (i.e. radians vs meters). All ones is ok for most uses. 
		void setTargetPose6D(string bodyPart, Pose6D target, WeightVector weights) throws BIKException;
		
		// Directs the part ip towards de target. For the target, only the translation components are used.
		// "axis" is the tip's reference frame axis that will be aligned to the target. It can be either "x", "y" or "z"
		// "axisconstraint" can be set to True if the aligning axis is to be hodl with a certain value, given in "axisangleConstraint".
		// "For example, to point towards some point "with a gun" keeping it upwards. 
		void pointAxisTowardsTarget(string bodyPart, Pose6D target, string axis, bool axisConstraint, float axisAngleConstraint) throws BIKException;
		
		// Makes the part tip advance along "ax" direction defined in the part tip reference frame. It is a convenience form of "setTargetPose6D" using the available constraints
		// Useful in grasping operations
		void advanceAlongAxis(string bodyPart, Axis ax, float dist) throws BIKException;
		
		// Open/close gripper to a certain distance between them.
		void setFingers(float d) throws BIKException;
		
		void goHome(string part) throws BIKException;
	};
};
  
#endif