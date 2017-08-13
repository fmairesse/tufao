!defined(BOOST_ROOT, var) {
    error("BOOST_ROOT must be defined. Add BOOST_ROOT=<path to boost directory> to qmake arguments.")
}

QT       = core network
TEMPLATE = lib
CONFIG += c++11
TARGET = tufao1

DEFINES += TUFAO_LIBRARY\
    QT_DEPRECATED_WARNINGS\
    BUFFER_SIZE=128

ROOT_DIR = $${PWD}
SRC_DIR = $${ROOT_DIR}/src
INSTALL_DIR = $${ROOT_DIR}/install

INCLUDEPATH += $${SRC_DIR} \
    $${ROOT_DIR}/3rd/boost.http/include\
    $${BOOST_ROOT}

SOURCES += \
    $${SRC_DIR}/abstractmessagesocket.cpp \
    $${SRC_DIR}/classhandler.cpp \
    $${SRC_DIR}/classhandlermanager.cpp \
    $${SRC_DIR}/headers.cpp \
    $${SRC_DIR}/httpfileserver.cpp \
    $${SRC_DIR}/httpserver.cpp \
    $${SRC_DIR}/httpserverrequest.cpp \
    $${SRC_DIR}/httpserverrequestrouter.cpp \
    $${SRC_DIR}/httpserverresponse.cpp \
    $${SRC_DIR}/httpsserver.cpp \
    $${SRC_DIR}/httpupgraderouter.cpp \
    $${SRC_DIR}/notfoundhandler.cpp \
    $${SRC_DIR}/urlrewriterhandler.cpp \
    $${SRC_DIR}/websocket.cpp \
    $${SRC_DIR}/priv/asctime.cpp \
    $${SRC_DIR}/priv/reasonphrase.cpp \
    $${SRC_DIR}/priv/rfc1036.cpp \
    $${SRC_DIR}/priv/rfc1123.cpp \
    $${SRC_DIR}/priv/tcpserverwrapper.cpp \

INCLUDES = \
    $${SRC_DIR}/abstracthttpserverrequesthandler.h \
    $${SRC_DIR}/abstracthttpupgradehandler.h \
    $${SRC_DIR}/abstractmessagesocket.h \
    $${SRC_DIR}/classhandler.h \
    $${SRC_DIR}/classhandlermanager.h \
    $${SRC_DIR}/headers.h \
    $${SRC_DIR}/httpfileserver.h \
    $${SRC_DIR}/httpserver.h \
    $${SRC_DIR}/httpserverplugin.h \
    $${SRC_DIR}/httpserverrequest.h \
    $${SRC_DIR}/httpserverrequestrouter.h \
    $${SRC_DIR}/httpserverresponse.h \
    $${SRC_DIR}/httpsserver.h \
    $${SRC_DIR}/httpupgraderouter.h \
    $${SRC_DIR}/ibytearray.h \
    $${SRC_DIR}/notfoundhandler.h \
    $${SRC_DIR}/urlrewriterhandler.h \
    $${SRC_DIR}/tufao_global.h \
    $${SRC_DIR}/websocket.h

HEADERS = $${INCLUDES} \
    $${SRC_DIR}/priv/asctime.h \
    $${SRC_DIR}/priv/classhandlermanager.h \
    $${SRC_DIR}/priv/cryptography.h \
    $${SRC_DIR}/priv/dependencytree.h \
    $${SRC_DIR}/priv/httpfileserver.h \
    $${SRC_DIR}/priv/httppluginserver.h \
    $${SRC_DIR}/priv/httpserver.h \
    $${SRC_DIR}/priv/httpserverrequest.h \
    $${SRC_DIR}/priv/httpserverrequestrouter.h \
    $${SRC_DIR}/priv/httpserverresponse.h \
    $${SRC_DIR}/priv/httpsserver.h \
    $${SRC_DIR}/priv/httpupgraderouter.h \
    $${SRC_DIR}/priv/reasonphrase.h \
    $${SRC_DIR}/priv/rfc1036.h \
    $${SRC_DIR}/priv/rfc1123.h \
    $${SRC_DIR}/priv/sessionstore.h \
    $${SRC_DIR}/priv/simplesessionstore.h \
    $${SRC_DIR}/priv/tcpserverwrapper.h \
    $${SRC_DIR}/priv/urlrewriterhandler.h \
    $${SRC_DIR}/priv/websocket.h

# Install

CONFIG(debug, debug|release) {
    BUILD_TYPE = debug
} else {
    BUILD_TYPE = release
}

# Quotes because of a qmake bug on windows: it emits the copy command without quoting a string containing + (g++)
TUFAO_LIB_INSTALLDIR = \"$$clean_path(Qt$${QT_VERSION}/$${basename(QMAKESPEC)}/$$basename(QMAKE_TARGET.arch)$$ANDROID_TARGET_ARCH/$$BUILD_TYPE)\"

include.path = $${INSTALL_DIR}/include/Tufao
include.files = $${INCLUDES} include/*
target.path = $${INSTALL_DIR}/lib/$${TUFAO_LIB_INSTALLDIR}
android {
    INSTALL_LIB_DIR = $${target.path}
    target.extra  = "rm -Rf $${INSTALL_LIB_DIR} ;"
    target.extra += "mkdir -p $${INSTALL_LIB_DIR} ;"
    target.extra += "cp `ls | grep lib` $${INSTALL_LIB_DIR}"
}
INSTALLS = include target
