	// TwitterAnalysis.cpp : Twitter Data Analysis
	#include "stdafx.h"
	#include <iostream>
	#include <sstream>
	#include <vector>
	#include <string>
	#include <fstream>
	#include "agm.h"
	#include "agmfit.h"
	using namespace std;
	using namespace TSnap;

	void PrintGStats(const char s[], PNGraph Graph) {
	printf("graph %s, nodes %d, edges %d, empty %s\n",
	s, Graph->GetNodes(), Graph->GetEdges(),
	Graph->Empty() ? "yes" : "no");
	}
		
	int main(int argc, char* argv[]) {

		string edge="";
		const char *edge1 ="";
		char * s1;
		char * s2;
		int from,to,a[2],j=0,RndFullDiam,SmallWorlFullDiam,PrefAttachFullDiam,i,t, FullDiam;
		int64 triad; 
		double RndclusteringCoeff,PrefAttachclusteringCoeff,SmallWorldclusteringCoeff,clusteringCoeff;
		double numStrongComp,RndEffDiam, RndAvgPL, SmallWorldEffDiam, SmallWorldAvgPL, PrefAttachEffDiam, PrefAttachAvgPL,EffDiam,AvgPL;  
		PNGraph Graph;
		PUNGraph RandomGraph, PrefAttach, SmallWorld;
		TIntPrV edges;
		TIntFltH PRank;
		TIntPrV Bridges;
		TFltV EigV;

		ofstream P1_measures,P2_measures,P3_measures,bridges;
		P1_measures.open("P1_measures.txt");
		P2_measures.open("P2_measures.txt");
		P3_measures.open("P3_measures.txt");
		bridges.open("Bridges.txt");
		
		cout<<"\n loading SNAP Graph";
		//Graph = TSnap::LoadEdgeList<PNGraph>("SnapGraph.txt",0,1);
		Graph = TNGraph::New();
		t = Graph->Empty();
		for (i = 1; i < 78697; i++) {
			cout<<"adding Node"<<i<<"\n";
		Graph->AddNode(i);
		}

		//Reading the Annonymized List and creating the SNAP graph
		ifstream gwfile;
		gwfile.open("annonymized_edge_List.csv");
		if(!gwfile) {
		cout << "FAILED: file could not be opened" << endl << "Press enter to close.";
		cin.get();
		return 0;
		}else
		cout << "SUCCESSFULLY opened file!\n";
		cout << "-------------------------\n\n\n";
	
		while(getline(gwfile, edge,'\n')){
			edge1=edge.c_str();
			s1 = strtok ((char *)edge1,",");
			s2 = strtok (NULL,",");
			from = atoi(s1);
			to = atoi(s2);
			Graph->AddEdge(from,to);
			cout<<"Adding Edge"<<from<<"->"<<to<<endl;
		}
		TSnap::SaveEdgeList(Graph, "SnapGraph.txt", "File saved as Tab separated");
		cout<<"\n graph loaded";
		PUNGraph UG = TSnap::ConvertGraph<PUNGraph>(Graph);
		
		//									P1 Measure
		// Bridges
		GetEdgeBridges(UG, Bridges);
		bridges << "\nNumber of Bridges : " << Bridges.Len() <<endl;
		for(int i = 0; i<Bridges.Len(); i++)
		{
			bridges << Bridges[i].Val1 << "->" << Bridges[i].Val2 <<endl; 
		}

		// Triads
		triad = TSnap::GetTriads(Graph);
		P1_measures << "\nNumber of triads : " << triad <<endl;

		
		
		//									P2 Measure
		// Global Clustering Coefficient
		clusteringCoeff= TSnap::GetClustCf(Graph);
		P2_measures << "\nGlobal Clustering Coefficient : " << clusteringCoeff<<"\n\n";
		
		// Top 3 PageRank Values
		GetPageRank(Graph,PRank);
		P2_measures << "\nTop 3 Page Rank : " << "\n1st : "<< PRank[0].Val << "\n2nd : "<< PRank[1].Val << "\n3rd : "<< PRank[2].Val <<endl;

		// Top 3 Eigenvector centrality Values
		TSnap::GetEigVec(UG, EigV);
		P2_measures << "\nTop 3 EigenVector Centralities: "<< "\n1st : "<< EigV[0].Val << "\n2nd : "<< EigV[1].Val << "\n3rd : "<< EigV[2].Val <<endl;

			
		//							P3 Models and Measures With 5000 Nodes and Average Degree 4 as that of Twitter Graph
		// Creating Random graph
		RandomGraph = TSnap::GenRndDegK(5000,4);
		PrintGStats("Random Graph" , TSnap::ConvertGraph<PNGraph>(RandomGraph));
		cout<<"\n Random graph created \n";
		TSnap::SaveEdgeList(RandomGraph, "RandomGraph.tsv", "File saved as Tab separated");
		TSnap::GetBfsEffDiam(RandomGraph, 5000, true, RndEffDiam, RndFullDiam, RndAvgPL);
		RndclusteringCoeff= TSnap::GetClustCf(RandomGraph);
		
		P3_measures << "\n\n\nRandom Graph with 5000 nodes and Average Degree 4: ";
		P3_measures << "\nAverage Path Length : "<< RndAvgPL;
		P3_measures << "\nClustering Coefficient : "<< RndclusteringCoeff;

		// Creating Small World Model Graph
		SmallWorld = TSnap::GenSmallWorld(5000,4,0.05);
		PrintGStats("Small World Graph" , TSnap::ConvertGraph<PNGraph>(SmallWorld));
		TSnap::SaveEdgeList(SmallWorld, "SmallWorld.tsv", "File saved as Tab separated");
		cout<<"\n SmallWorld graph created \n";
		TSnap::GetBfsEffDiam(SmallWorld, 5000, true, SmallWorldEffDiam, SmallWorlFullDiam, SmallWorldAvgPL);
		SmallWorldclusteringCoeff= TSnap::GetClustCf(SmallWorld);
		
		P3_measures << "\n\n\nSmall World Graph with 5000 nodes and Average Degree 4 and Beta .05: ";
		P3_measures << "\nAverage Path Length : "<< SmallWorldAvgPL;
		P3_measures << "\nClustering Coefficient : "<< SmallWorldclusteringCoeff;
		

		// Creating Prefrential Attachment Model Graph
		PrefAttach = TSnap::GenPrefAttach(5000,4);
		PrintGStats("Prefrential Graph" , TSnap::ConvertGraph<PNGraph>(PrefAttach));
		TSnap::SaveEdgeList(PrefAttach, "PrefrentialGraph.tsv", "File saved as Tab separated");
		cout<<"\n PrefAttach graph created \n";
		TSnap::GetBfsEffDiam(PrefAttach, 5000, true, PrefAttachEffDiam, PrefAttachFullDiam, PrefAttachAvgPL);
		PrefAttachclusteringCoeff= TSnap::GetClustCf(PrefAttach);
		cout<<"\n PrefAttach graph created";
		P3_measures << "\n\n\nPrefrential Graph with 5000 nodes and Average Degree 4 : ";
		P3_measures << "\nAverage Path Length : "<< PrefAttachAvgPL;
		P3_measures << "\nClustering Coefficient : "<< PrefAttachclusteringCoeff;*/

		// Diameter and Average Path Length
		TSnap::GetBfsEffDiam(Graph, 78696, true, EffDiam, FullDiam,AvgPL);
		P1_measures << "\nDiameter : " << FullDiam<<endl;
		P1_measures << "\nAverage Path Length : " << AvgPL<<endl;

		P1_measures.close();
		P2_measures.close();
		P3_measures.close();
		bridges.close();

	return 0;
	}
