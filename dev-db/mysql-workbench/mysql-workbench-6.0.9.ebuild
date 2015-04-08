# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-workbench/mysql-workbench-6.0.9.ebuild,v 1.4 2015/03/21 21:38:10 nativemad Exp $

EAPI=5
GCONF_DEBUG="no"

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="sqlite"

CMAKE_MIN_VERSION="2.8.11.1"

inherit gnome2 eutils flag-o-matic python-single-r1 cmake-utils

MY_P="${PN}-community-${PV}-src"

DESCRIPTION="MySQL Workbench"
HOMEPAGE="http://dev.mysql.com/workbench/"
SRC_URI="mirror://mysql/Downloads/MySQLGUITools/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug doc gnome-keyring +iodbc"

# glibc: deprecated mutex functions, removed in 2.36.0
CDEPEND="${PYTHON_DEPS}
		dev-libs/glib:2
		dev-cpp/atkmm
		dev-cpp/pangomm
		>=dev-cpp/glibmm-2.14:2
		>=dev-cpp/gtkmm-2.14:2.4
		dev-libs/atk
		x11-libs/pango
		>=x11-libs/gtk+-2.6:2
		gnome-base/libglade:2.0
		>=x11-libs/cairo-1.5.12[glib,svg]
		dev-libs/libsigc++:2
		dev-libs/boost
		>=dev-cpp/ctemplate-0.95
		>=dev-libs/libxml2-2.6.2:2
		dev-libs/libzip
		>=virtual/mysql-5.1
		dev-libs/libpcre
		virtual/opengl
		>=dev-lang/lua-5.1[deprecated]
		|| ( sys-libs/e2fsprogs-libs dev-libs/ossp-uuid )
		dev-libs/tinyxml[stl]
		dev-db/mysql-connector-c++
		dev-db/vsqlite++
		!iodbc? ( dev-db/unixODBC ) iodbc? ( dev-db/libiodbc )
		gnome-keyring? ( gnome-base/libgnome-keyring )
			dev-python/pexpect
			>=dev-python/paramiko-1.7.4
	"

RDEPEND="${CDEPEND}
		app-admin/sudo
		>=sys-apps/net-tools-1.60_p20120127084908"

DEPEND="${CDEPEND}
		virtual/pkgconfig"

S="${WORKDIR}"/"${MY_P}"

src_prepare() {
	## Patch CMakeLists.txt
	epatch "${FILESDIR}/${PN}-6.0.8-CMakeLists.patch"

	## remove hardcoded CXXFLAGS
	sed -i -e 's/-O0 -g3//' ext/scintilla/gtk/CMakeLists.txt || die

	## package is very fragile...
	strip-flags

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_use gnome-keyring GNOME_KEYRING)
		$(cmake-utils_use_use iodbc IODBC)
		-DLIB_INSTALL_DIR="/usr/$(get_libdir)"
		-DPYTHON_INCLUDE_DIR="$(python_get_includedir)"
		-DPYTHON_LIBRARY="$(python_get_library_path)"
	)
	cmake-utils_src_configure
}
