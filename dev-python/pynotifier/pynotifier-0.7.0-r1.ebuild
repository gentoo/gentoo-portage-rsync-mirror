# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pynotifier/pynotifier-0.7.0-r1.ebuild,v 1.7 2013/08/03 09:45:37 mgorny Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="pyNotifier provides an implementation of a notifier/event scheduler."
HOMEPAGE="http://www.bitkipper.net/"
SRC_URI="http://www.bitkipper.net/bytes/debian/dists/unstable/source/${PN}_${PV}.orig.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="qt4 gtk"

DEPEND=""
RDEPEND="dev-python/twisted-core
	gtk? ( dev-python/pygobject:2 )
	qt4? ( dev-python/PyQt4[X] )"

PYTHON_MODNAME="notifier"

src_prepare() {
	distutils_src_prepare
	use gtk || rm notifier/nf_gtk.py
	use qt4 || rm notifier/nf_qt.py
}
