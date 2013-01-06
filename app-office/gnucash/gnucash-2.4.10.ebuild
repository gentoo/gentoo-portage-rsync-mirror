# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnucash/gnucash-2.4.10.ebuild,v 1.7 2012/09/19 18:21:16 pacho Exp $

EAPI="4"
GNOME2_LA_PUNT="yes"
GCONF_DEBUG="no"
PYTHON_DEPEND="python? 2:2.5"

inherit gnome2 python eutils

DOC_VER="2.2.0"

DESCRIPTION="A personal finance manager"
HOMEPAGE="http://www.gnucash.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="chipcard cxx debug +doc hbci mysql ofx postgres python quotes sqlite webkit"

# FIXME: rdepend on dev-libs/qof when upstream fix their mess (see configure.ac)
RDEPEND=">=dev-libs/glib-2.13:2
	>=dev-libs/popt-1.5
	>=dev-libs/libxml2-2.5.10:2
	>=dev-scheme/guile-1.8.3:12[deprecated,regex]
	dev-scheme/guile-www
	>=dev-scheme/slib-3.1.4
	>=gnome-base/gconf-2:2
	>=gnome-base/libgnomeui-2.4
	>=gnome-base/libglade-2.4:2.0
	gnome-base/libgnome-keyring
	media-libs/libart_lgpl
	>=sys-libs/zlib-1.1.4
	>=x11-libs/gtk+-2.14:2
	x11-libs/goffice:0.8[gnome]
	x11-libs/pango
	cxx? ( dev-cpp/gtkmm:2.4 )
	ofx? ( >=dev-libs/libofx-0.9.1 )
	hbci? ( >=net-libs/aqbanking-5[gtk,ofx?]
		sys-libs/gwenhywfar[gtk]
		chipcard? ( sys-libs/libchipcard )
	)
	quotes? ( dev-perl/DateManip
		>=dev-perl/Finance-Quote-1.11
		dev-perl/HTML-TableExtract )
	webkit? ( net-libs/webkit-gtk:2 )
	!webkit? ( >=gnome-extra/gtkhtml-3.16:3.14 )
	sqlite? ( dev-db/libdbi dev-db/libdbi-drivers[sqlite] )
	postgres? ( dev-db/libdbi dev-db/libdbi-drivers[postgres] )
	mysql? ( dev-db/libdbi dev-db/libdbi-drivers[mysql] )
"
DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.3
	virtual/pkgconfig
	dev-util/intltool
	gnome-base/gnome-common
	sys-devel/libtool
"

PDEPEND="doc? ( >=app-doc/gnucash-docs-${DOC_VER} )"

pkg_setup() {
	DOCS="doc/README.OFX doc/README.HBCI"

	if use webkit ; then
		G2CONF+=" --with-html-engine=webkit"
	else
		G2CONF+=" --with-html-engine=gtkhtml"
	fi

	if use sqlite || use mysql || use postgres ; then
		G2CONF+=" --enable-dbi"
	else
		G2CONF+=" --disable-dbi"
	fi

	G2CONF+="
		$(use_enable cxx gtkmm)
		$(use_enable debug)
		$(use_enable ofx)
		$(use_enable hbci aqbanking)
		$(use_enable python python-bindings)
		--disable-doxygen
		--enable-locale-specific-tax
		--disable-error-on-warning"

	if use python ; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	: > "${S}"/py-compile

	use python && python_convert_shebangs -r 2 .

	# Disable python binding tests because of missing file
	sed 's/^\(SUBDIRS =.*\)tests\(.*\)$/\1\2/' \
		-i src/optional/python-bindings/Makefile.{am,in} \
		|| die "python tests sed failed"

	gnome2_src_prepare
}

src_configure() {
	# guile wrongly exports LDFLAGS as LIBS which breaks modules
	# Filter until a better ebuild is available, bug #202205
	local GUILE_LIBS=""
	local lib
	for lib in $(guile-config link); do
		if [ "${lib#-Wl}" = "$lib" ]; then
			GUILE_LIBS="$GUILE_LIBS $lib"
		fi
	done

	econf GUILE_LIBS="${GUILE_LIBS}" ${G2CONF}
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	GUILE_WARN_DEPRECATED=no \
	GNC_DOT_DIR="${T}"/.gnucash \
	emake check
}

src_install() {
	# Parallel installation fails from time to time, bug #359123
	MAKEOPTS="${MAKEOPTS} -j1" gnome2_src_install GNC_DOC_INSTALL_DIR=/usr/share/doc/${PF}

	rm -rf "${ED}"/usr/share/doc/${PF}/{examples/,COPYING,INSTALL,*win32-bin.txt,projects.html}
	mv "${ED}"/usr/share/doc/${PF} "${T}"/cantuseprepalldocs || die
	dodoc "${T}"/cantuseprepalldocs/*
}

pkg_postinst() {
	gnome2_pkg_postinst
	use python && python_mod_optimize gnucash
}

pkg_postrm() {
	gnome2_pkg_postrm
	use python && python_mod_cleanup gnucash
}
