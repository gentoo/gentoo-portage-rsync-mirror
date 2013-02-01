# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-workbench/mysql-workbench-5.2.45.ebuild,v 1.5 2013/01/31 23:11:27 ago Exp $

EAPI=5
GCONF_DEBUG="no"
PYTHON_DEPEND=2

PYTHON_USE_WITH=sqlite
PYTHON_USE_WITH_OPT=doc

inherit gnome2 eutils flag-o-matic python autotools

MY_P="${PN}-gpl-${PV}-src"

DESCRIPTION="MySQL Workbench"
HOMEPAGE="http://dev.mysql.com/workbench/"
SRC_URI="mirror://mysql/Downloads/MySQLGUITools/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug doc gnome-keyring nls static-libs"

# Build system bundles an unreleased copy of dev-libs/antlr-c 3.4 so we
# can't depend on our own packaged version right now.

CDEPEND="dev-db/sqlite:3
	>=x11-libs/gtk+-2.6:2
	dev-libs/glib:2
	gnome-base/libglade:2.0
	dev-libs/libsigc++:2
	dev-libs/boost
	>=dev-cpp/ctemplate-0.95
	>=dev-libs/libxml2-2.6.2:2
	>=dev-cpp/glibmm-2.14:2
	>=dev-cpp/gtkmm-2.14:2.4
	dev-db/libiodbc
	dev-libs/libzip
	>=virtual/mysql-5.1
	dev-libs/libpcre
	virtual/opengl
	>=dev-lang/lua-5.1[deprecated]
	x11-libs/pango
	|| ( sys-libs/e2fsprogs-libs
		dev-libs/ossp-uuid )
	>=x11-libs/cairo-1.5.12[svg]
	dev-python/pexpect
	>=dev-python/paramiko-1.7.4
	gnome-keyring? ( gnome-base/libgnome-keyring )
	nls? ( sys-devel/gettext )"
RDEPEND="${CDEPEND}
	app-admin/sudo
	>=sys-apps/net-tools-1.60_p20120127084908"
DEPEND="${CDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}"/"${MY_P}"

pkg_setup() {
	# Make sure we use Python 2 since the code is not compatible with 3.
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# Remove hardcoded CXXFLAGS
	sed -i -e 's/debug_flags="-ggdb3 /debug_flags="/' configure || die
	sed -i -e 's/-O0 -g3//' ext/scintilla/gtk/Makefile.in ext/scintilla/gtk/Makefile.am || die

	# Remove bundled ctemplate version to make sure we use the system
	# version, but leave a directory to avoid confusing configure, bug
	# 357539.
	rm -rf ext/ctemplate || die
	mkdir -p ext/ctemplate/ctemplate-src || die

	epatch "${FILESDIR}"/${PN}-5.2.44-my_lib.patch

	# Regenerate autotools files to work around broken libtool for
	# antlr, bug 431756.
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable nls i18n) \
		$(use_enable debug) \
		$(use_enable static-libs static)
}

src_install() {
	emake install DESTDIR="${D}" || die
	find "${ED}" -name '*.la' -delete || die
}
