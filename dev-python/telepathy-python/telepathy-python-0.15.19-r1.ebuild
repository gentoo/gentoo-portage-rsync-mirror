# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/telepathy-python/telepathy-python-0.15.19-r1.ebuild,v 1.5 2014/02/22 21:24:33 pacho Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
AUTOTOOLS_AUTORECONF=true

inherit autotools-utils python-r1

DESCRIPTION="Telepathy Python base classes for use in connection managers, and proxy classes for use in clients."
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

DEPEND="dev-libs/libxslt"
RDEPEND=">=dev-python/dbus-python-0.80[${PYTHON_USEDEP}]"

PATCHES=(
	# Don't install _generated/errors.py twice, bug #348386
	"${FILESDIR}"/${P}-install-twice.patch
	# automake-1.12 compat, bug #423249, https://bugs.freedesktop.org/show_bug.cgi?id=51392
	"${FILESDIR}"/${P}-mkdir_p.patch
	)

src_prepare() {
	autotools-utils_src_prepare
	python_prepare() {
		mkdir -p "${BUILD_DIR}"
	}
	python_foreach_impl python_prepare
}

src_configure() {
	ECONF_SOURCE="${S}" python_foreach_impl autotools-utils_src_configure
}

src_compile() {
	python_foreach_impl autotools-utils_src_compile
}

src_install() {
	python_foreach_impl autotools-utils_src_install
}
