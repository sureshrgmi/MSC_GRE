	#include <stdio.h>
	#include <math.h>
	#include <sys/time.h> // header for timeval structure
    #include <time.h> // header for declaring time structure
	#include <stdlib.h>

	int main(int argc, char *argv[])
	{
	int m; 
	int n;
	double tol;// = 0.0001;

	int i, j, iter;

	// start and stop timer variables
	struct timeval startTime, stopTime;
	// total time variable
    long totalTime;

	m = atoi(argv[1]);
	n = atoi(argv[2]);
	tol = atof(argv[3]);

	double t[m+2][n+2], tnew[m+1][n+1], diff, difmax;

	printf("Input Variables : %d %d %lf\n",m,n, tol);

	// Starting the timer (getting the current time and storing it in startTime variable)
    gettimeofday(&startTime, NULL);


	// initialise temperature array
	for (i=0; i <= m+1; i++) {
		for (j=0; j <= n+1; j++) {
			t[i][j] = 30.0;
		}
	}

	// fix boundary conditions
	for (i=1; i <= m; i++) {
		t[i][0] = 30.0; // left
		t[i][n+1] = 20.0; //right
	}
	for (j=1; j <= n; j++) {
		t[0][j] = 80.0; //top
		t[m+1][j] = 50.0; //bottom
	}

	// main loop
	iter = 0;
	difmax = 1000000.0;
	while (difmax > tol) {
		iter++;

		difmax = 0.0;
		// update temperature for next iteration
		for (i=1; i <= m; i++) {
			for (j=1; j <= n; j++) {
				tnew[i][j] = (t[i-1][j]+t[i+1][j]+t[i][j-1]+t[i][j+1])/4.0;
				
				// work out maximum difference between old and new temperatures
				diff = fabs(tnew[i][j]-t[i][j]);
				if (diff > difmax) {
					difmax = diff;
				}
				t[i][j]=tnew[i][j];
			}
		}


	}

    // Stopping the timer (getting the current time and storing it in stopTime variable)
    gettimeofday(&stopTime, NULL);

	// print results
	printf("iter = %d  difmax = %9.11lf", iter, difmax);
	for (i=0; i <= m+1; i++) {
		printf("\n");
		for (j=0; j <= n+1; j++) {
			printf("%3.5lf ", t[i][j]);
		}
	}
	printf("\n");
	
	// Calculating the total time in mircoseconds
    totalTime = (stopTime.tv_sec * 1000000 + stopTime.tv_usec) - (startTime.tv_sec * 1000000 + startTime.tv_usec);

//    printf("\n");
    // Print the totalTime as a long integer (%ld)
    printf("The total execution time for GaussSerial in mircorsconds is : %ld\n", totalTime);

    printf("\n");
	}