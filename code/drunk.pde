float radius;
float radius0 = 1000.0;
int W = 1000;
int H = 300;
int X = 0;
int Xdisp = W/2;
int xmax = 10;
int Y = H*5/6;
float r;
int nbin = 101;
float[] prob = new float[nbin];
float[] newprob = new float[nbin];
void setup(){
	size(W,H);
	strokeWeight(1);
	frameRate(30);
	randomSeed(millis());
	prob[(nbin-1)/2]=1;
}

void draw(){
	radius = max(5,radius0/xmax);
	background(230);
	stroke(255);
	fill(200,200,200);
	for(int k=0;k<nbin;k=k+1){
		rect((k-0.5)*W/(nbin-1),H*5/6-prob[k],W/(nbin-1),prob[k]);
		//line(k*W/(nbin-1),H*5/6,k*W/(nbin-1),H*5/6-prob[k]);
		//text(round(prob[k]),k*W/(nbin-1),H*5/6);
	}
	fill(0);
	text("O",W/2,H*5/6+15);
	text(xmax,W*39/40,H*5/6+15);
	text(-xmax,W/40,H*5/6+15);
	strokeWeight(3);
	stroke(255);
	fill(0,121,184,100);
	ellipse(Xdisp,Y,radius,radius);
	calc();
	//stroke(0);
	
	//line(X,Y,nX,nY);
	//text("Black hole",nX+10,nY+10)
}

void calc(){
	r = random(-1,1);
	if(r<0){
		X-=1;
	}
	else{
		X+=1;
	}

	if(abs(X)>xmax){
		int i, j;
		
		for(i=0;i<nbin;i=i+1){
			newprob[i]=0;
			float cutoffi = (i+1)*(xmax+1)/xmax+(1-nbin/2/xmax);
			for(j=0;j<min(nbin-1,cutoffi-1);j=j+1){
				
				if (j==ceil(cutoffi-2)){
					float temp = prob[j]*(cutoffi-j-1);
					newprob[i]+=temp;
					prob[j]-=temp;
				}
				else{
					newprob[i]+=prob[j];
					prob[j]=0;
				}
				}
		}
		
		for(i=0;i<nbin;i=i+1){
			prob[i]=newprob[i];
		}
		
		xmax = abs(X);
	}
	prob[round((X+xmax)/2/xmax*(nbin-1))]+=1;


	Xdisp = (X+xmax)/2/xmax*W;
}
