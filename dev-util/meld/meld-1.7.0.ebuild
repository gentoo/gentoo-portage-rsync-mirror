# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/meld/meld-1.7.0.ebuild,v 1.5 2013/03/27 09:49:31 ago Exp $

EAPI="4"
GCONF_DEBUG="no"
PYTHON_DEPEND="2:2.5"

inherit eutils python gnome2 multilib

DESCRIPTION="A graphical diff and merge tool"
HOMEPAGE="http://meldmerge.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="+highlight gnome"

RDEPEND=">=dev-python/pygtk-2.14:2
	>=dev-python/pygobject-2.8:2
	dev-python/dbus-python
	dev-python/pycairo
	highlight? ( >=dev-python/pygtksourceview-2.10 )
	gnome? ( >=dev-python/gconf-python-2.22:2 )
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	dev-util/intltool
	app-text/scrollkeeper
"

pkg_setup() {
	# Needed for optimizing python modules against proper interpreter
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	DOCS="NEWS"

	# fix the prefix so its not in */local/*
	sed -e "s:/usr/local:${EPREFIX}/usr:" \
		-e "s:\$(prefix)/lib:\$(prefix)/$(get_libdir):" \
		-i INSTALL || die "sed 1 failed"

	# don't install anything to /usr/share/doc/meld
	sed -e "s:\$(docdir)/meld:\$(docdir)/${PF}:" \
		-i INSTALL || die "sed 2 failed"

	# let the python eclass handle python objects
	sed -e '/$(PYTHON) .* .import compileall;/s/\t/&#/g' \
		-i Makefile || die "sed 3 failed"

	# don't run scrollkeeper (with the wrong path),
	# leave that to gnome2.eclass #145833
	sed -e '/scrollkeeper-update/s/\t/&#/' \
		-i help/*/Makefile || die "sed 4 failed"

	# replace all calls to python by specific major version
	sed -e "s/\(PYTHON ?= \).*/\1$(PYTHON -2)/" \
		-i INSTALL || die "sed 6 failed"
	python_convert_shebangs 2 "${S}"/tools/*

	strip-linguas -i "${S}/po"
	local mylinguas=""
	for x in ${LINGUAS}; do
		mylinguas="${mylinguas} ${x}.po"
	done

	if [ -n "${mylinguas}" ]; then
		sed -e "s/PO:=.*/PO:=${mylinguas}/" \
			-i po/Makefile || die "sed 5 failed"
	fi

	# Fix .desktop entry, upstream bug #686978
	sed -i -e '/Encoding/d' data/meld.desktop.in || die

	gnome2_src_prepare
}

src_configure() {
	:
}

src_install() {
	gnome2_src_install
	doman meld.1
	python_convert_shebangs 2 "${ED}"usr/bin/meld
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize /usr/$(get_libdir)/meld
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup /usr/$(get_libdir)/meld
}
