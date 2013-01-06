# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/telepathy-farstream/telepathy-farstream-0.2.3.ebuild,v 1.4 2012/12/08 01:25:54 tetromino Exp $

EAPI="4"
PYTHON_DEPEND="python? 2:2.5"
PYTHON_USE_WITH="xml"
PYTHON_USE_WITH_OPT="python"

inherit python

DESCRIPTION="Telepathy client library that uses Farstream to handle Call channels"
HOMEPAGE="http://telepathy.freedesktop.org"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="examples python"

RDEPEND=">=dev-libs/glib-2.30:2
	>=sys-apps/dbus-0.60
	>=dev-libs/dbus-glib-0.60
	>=net-libs/telepathy-glib-0.17.5
	>=net-libs/farstream-0.1.0:0.1
	python? (
		>=dev-python/pygobject-2.12.0:2
		>=dev-python/gst-python-0.10.10 )"
# python2 is needed at build time in all cases
DEPEND="${RDEPEND}
	!python? ( =dev-lang/python-2*[xml] )"

pkg_setup() {
	# Needed for xincludator.py at build time even if USE=-python
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	if use python; then
		python_convert_shebangs -r 2 .
	fi
}

src_configure() {
	econf $(use_enable python) --disable-static
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog NEWS README

	# Remove .la files since static libs are disabled
	find "${D}" -name '*.la' -exec rm -f {} + || die

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.c
		if use python; then
			insinto /usr/share/doc/${PF}/examples/python
			doins python/examples/*.py
		fi
	fi
}
