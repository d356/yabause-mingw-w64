FROM d356/fedora-mxe-shared
COPY yabause yabause
RUN sed -i "/if (WIN32)/c\if (FALSE)" /yabause/yabause/src/qt/CMakeLists.txt

# libyabause needs to be static
RUN sed -i -e 's/add_library(yabause/add_library(yabause STATIC/g' /yabause/yabause/src/CMakeLists.txt

# build yabause-qt
RUN cd yabause/yabause ; \
    mkdir build ; \
    cd build ; \
    cmake -DCMAKE_C_FLAGS="-fno-inline-functions" -DYAB_PORTS=qt -DCMAKE_TOOLCHAIN_FILE=/mxe/usr/x86_64-w64-mingw32.shared/share/cmake/mxe-conf.cmake .. ; \
    make