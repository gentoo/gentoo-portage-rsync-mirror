# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/notify-python/notify-python-0.1.1-r2.ebuild,v 1.11 2012/08/13 06:50:04 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* 2.5-jython"

inherit eutils python

DESCRIPTION="Python bindings for libnotify"
HOMEPAGE="http://www.galago-project.org/"
SRC_URI="http://www.galago-project.org/files/releases/source/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 ~sh sparc x86 ~x86-fbsd"
IUSE="examples"

RDEPEND=">=dev-python/pygtk-2.24:2
	>=x11-libs/libnotify-0.7"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch

	# Disable byte-compilation.
	rm -f py-compile
	ln -s $(type -P true) py-compile

	# Remove the old pynotify.c to ensure it's properly regenerated #212128.
	rm -f src/pynotify.c

	python_src_prepare
}

src_install() {
	python_src_install
	python_clean_installation_image
	dodoc AUTHORS ChangeLog NEWS README

	# Requested from bug 351879.
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins tests/*.{png,py}
	fi
}

pkg_postinst() {
	python_mod_optimize gtk-2.0/pynotify
}

pkg_postrm() {
	python_mod_cleanup gtk-2.0/pynotify
}
