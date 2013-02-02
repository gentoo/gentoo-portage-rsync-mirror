# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/telepathy-python/telepathy-python-0.15.19.ebuild,v 1.9 2013/02/02 22:31:14 ago Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

inherit python eutils autotools

DESCRIPTION="Telepathy Python base classes for use in connection managers, and proxy classes for use in clients."
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ~ppc64 sparc x86"
IUSE=""

DEPEND="dev-libs/libxslt"
RDEPEND=">=dev-python/dbus-python-0.80"

src_prepare() {
	# Don't install _generated/errors.py twice, bug #348386
	epatch "${FILESDIR}/${P}-install-twice.patch"
	# automake-1.12 compat, bug #423249, https://bugs.freedesktop.org/show_bug.cgi?id=51392
	epatch "${FILESDIR}/${P}-mkdir_p.patch"
	eautoreconf

	python_src_prepare
}

src_install() {
	python_src_install
	dodoc AUTHORS NEWS || die
}

pkg_postinst() {
	python_mod_optimize telepathy
}

pkg_postrm() {
	python_mod_cleanup telepathy
}
