# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-butterfly/telepathy-butterfly-0.5.15-r1.ebuild,v 1.6 2011/10/05 17:58:04 xarthisius Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.5"
RESTRICT_PYTHON_ABIS="2.4 3.*"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

inherit python multilib eutils

DESCRIPTION="An MSN connection manager for Telepathy"
HOMEPAGE="http://telepathy.freedesktop.org/releases/telepathy-butterfly/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND=">=dev-python/telepathy-python-0.15.17
	>=dev-python/papyon-0.5.1
	>=net-libs/libproxy-0.3.1[python]"

DOCS="AUTHORS NEWS"

src_prepare() {
	# Remove bad import from im module, bug #355499
	epatch "${FILESDIR}/${P}-fix-import.patch"

	# disable pyc compiling
	mv py-compile py-compile-disabled
	ln -s $(type -P true) py-compile

	# It doesn't really support python3 yet
	python_convert_shebangs -r 2 .

	python_src_prepare
}

pkg_postinst() {
	python_mod_optimize butterfly
}

pkg_postrm() {
	python_mod_cleanup butterfly
}
