	#include <stdio.h>
	#include <math.h>
	#include <omp.h> // OpenMP header
	#include <sys/time.h> // header for timeval structure
    #include <time.h> // header for declaring time structure
	#include <stdlib.h>

	int main(int argc, char *argv[])
	{
	int m; 
	int n;
	double tol;// = 0.0001;

	int i, j, iter, nthreads; // Declaring Number of Threads

	// start and stop timer variables
	struct timeval startTime, stopTime;
	// total time variable
    long totalTime;

	m = atoi(argv[1]);
	n = atoi(argv[2]);
	tol = atof(argv[3]);
	nthreads = atof(argv[4]); // Getting the no of threads from arguments

	double t[m+2][n+2], tnew[m+1][n+1], diff, difmax, priv_difmax; // Declaring priv_difmax value

	// Setting OMP threads
	omp_set_num_threads(nthreads);
 
	printf("Input Variables : %d %d %lf %d\n",m,n, tol, nthreads);

	// Starting the timer (getting the current time and storing it in startTime variable)
    gettimeofday(&startTime, NULL);


	// initialise temperature array using parallel code
	// Parallel region for temperature array initialization
	#pragma omp parallel for schedule(static) \
	default(shared) private(i,j)

	for (i=0; i <= m+1; i++) {
		for (j=0; j <= n+1; j++) {
			t[i][j] = 30.0;
			tnew[i][j]=30;
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
	// specifying parallel region outside the while loop
	#pragma omp parallel default(shared) private(i, j, diff, priv_difmax)
	{
	while (difmax > tol) {
		#pragma omp single // single thread run
		iter++;

		#pragma omp single //single thread run
		difmax = 0.0;
		
		// tnew array initilization
		#pragma omp for schedule(static)
		for (i=1; i<=m; i++) {
			for(j=1; j<=n; j++){
				t[i][j]=tnew[i][j];
			}
		}

		// lets update the temperature for the next iter
		#pragma omp for schedule(static) nowait
		for (i=1; i <= m; i++) {
			for (j=1; j <= n; j++) {
				tnew[i][j] = (t[i-1][j]+t[i+1][j]+t[i][j-1]+t[i][j+1])/4.0;
			}
		}

		priv_difmax=0.0;
		#pragma omp for schedule(static)
		for (i=1; i<=m; i++){
			for (j=1; j<=n; j++){
				diff=fabs(tnew[i][j]-t[i][j]);
				if (diff >priv_difmax) {
					priv_difmax =diff;
				}
			}
		}
		#pragma omp critical
		if (priv_difmax > difmax){
			difmax = priv_difmax;
		}

		#pragma omp barrier
		}
	}

    // Stopping the timer (getting the current time and storing it in stopTime variable)
    gettimeofday(&stopTime, NULL);

	// // Commenting print results
	// printf("iter = %d  difmax = %9.11lf", iter, difmax);
	// for (i=0; i <= m+1; i++) {
	// 	printf("\n");
	// 	for (j=0; j <= n+1; j++) {
	// 		printf("%3.5lf ", t[i][j]);
	// 	}
	// }
	// printf("\n");
	
	// Calculating the total time in mircoseconds
    totalTime = (stopTime.tv_sec * 1000000 + stopTime.tv_usec) - (startTime.tv_sec * 1000000 + startTime.tv_usec);
   printf("\n");
    // Print the totalTime as a long integer (%ld)
    printf("The total execution time for Gauss-OpemMP in mircorsconds is : %ld\n", totalTime);

    printf("\n");
	}