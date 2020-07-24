#include <iostream>
#ifndef _LIBCPP_HAS_NO_THREADS
#include <omp.h>
#endif
#include "TestMatrix.h"

#ifdef BOOM1
TEST_THETIS(TestMatrix01) {
    std::cout << "TestMatrix0101" << std::endl << std::flush;
#ifndef _LIBCPP_HAS_NO_THREADS 
    throw std::logic_error("bad bad");
#else
    exit(1);
#endif
}

#endif

#ifdef BOOM2
TEST_THETIS(TestMatrix02) {
   
#ifndef _LIBCPP_HAS_NO_THREADS 
    spdlog::debug("test matrix 02 {}", 12345);
#endif
    CHECK(false);
}

TEST_THETIS(TestMatrix03) {

#ifndef _LIBCPP_HAS_NO_THREADS    
    spdlog::debug("test matrix 03 {}", 12345);
#endif
    ThetisAssert(1==2);
}
#endif 

TEST_THETIS(TestMatrix04) {

#ifndef _LIBCPP_HAS_NO_THREADS    
    spdlog::debug("test matrix 04 {}", 12345);
    spdlog::debug(" num threads = {}, max threads = {}", omp_get_num_threads(), omp_get_max_threads());
 #endif 


#ifndef _LIBCPP_HAS_NO_THREADS
#pragma omp parallel for
    for (int i=0; i<16; ++i) {
        auto thr = omp_get_thread_num();
        spdlog::debug("thread #{}", thr);
    }
#endif
}

#ifdef BOOM
TEST_THETIS(TestMatrix05) {

#ifndef _LIBCPP_HAS_NO_THREADS
    spdlog::debug("test matrix 05 {}", 12345);
#endif
    auto *data = new int[45];
    int acc = 0;
    for(int i=0; i<46; ++i) {
        acc += thetis_check_canary(data[i]); // caught by address sanitizer & thetis_alloc
    }
    std::cerr << acc << std::endl;
    delete[](data);
    //delete[](data); // caught/iso alloc
}

TEST_THETIS(TestMatrix06) {

#ifndef _LIBCPP_HAS_NO_THREADS    
    spdlog::debug("test matrix 05 {}", 12345);
#endif
    auto *data = new int[45];
    int acc = 0;
    for(int i=0; i<46; ++i) {
        data[i] = i+4;
    }
    std::cerr << acc << std::endl;
    delete[](data);
    //delete[](data); // caught/iso alloc
}
#endif

TEST_THETIS_PARALLEL(TestMatrix07) {

#ifndef _LIBCPP_HAS_NO_THREADS    
    std::this_thread::sleep_for(std::chrono::seconds(10));
    // ThetisAssert(1==2);
#endif
}

TEST_THETIS_PARALLEL(TestMatrix08) {

#ifndef _LIBCPP_HAS_NO_THREADS
    std::this_thread::sleep_for(std::chrono::seconds(10));
    ThetisAssert(1==1);
#endif
}
