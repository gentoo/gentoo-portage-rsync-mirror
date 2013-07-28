# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/meld/meld-1.7.4.ebuild,v 1.1 2013/07/28 19:46:50 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
PYTHON_COMPAT=( python2_{6,7} )

inherit eutils python-single-r1 gnome2

DESCRIPTION="A graphical diff and merge tool"
HOMEPAGE="http://meldmerge.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="+highlight gnome"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# FIXME: switch gconf-python to python-r1
RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/pygtk-2.14:2[${PYTHON_USEDEP}]
	>=dev-python/pygobject-2.8:2[${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	highlight? ( >=dev-python/pygtksourceview-2.10[${PYTHON_USEDEP}] )
	gnome? ( >=dev-python/gconf-python-2.22:2 )
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	dev-util/intltool
	app-text/scrollkeeper
"

src_prepare() {
	# fix the prefix so its not in */local/*
	sed -e "s:/usr/local:${EPREFIX}/usr:" \
		-e "s:\$(prefix)/lib:\$(prefix)/$(get_libdir):" \
		-i INSTALL || die "sed 1 failed"

	# don't install anything to /usr/share/doc/meld
	sed -e "s:\$(docdir)/meld:\$(docdir)/${PF}:" \
		-i INSTALL || die "sed 2 failed"

	# don't run scrollkeeper (with the wrong path),
	# leave that to gnome2.eclass #145833
	sed -e '/scrollkeeper-update/s/\t/&#/' \
		-i help/*/Makefile || die "sed 4 failed"

	strip-linguas -i "${S}/po"
	local mylinguas=""
	for x in ${LINGUAS}; do
		mylinguas="${mylinguas} ${x}.po"
	done

	if [ -n "${mylinguas}" ]; then
		sed -e "s/PO:=.*/PO:=${mylinguas}/" \
			-i po/Makefile || die "sed 6 failed"
	fi

	gnome2_src_prepare
}

src_configure() {
	:
}

src_install() {
	gnome2_src_install
	python_fix_shebang "${ED}"/usr/bin
	doman meld.1
}
