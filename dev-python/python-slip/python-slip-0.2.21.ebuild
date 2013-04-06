# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-slip/python-slip-0.2.21.ebuild,v 1.4 2013/04/06 13:12:26 swift Exp $

EAPI=4

# pygtk, pygobject:2 etc. don't support multiple python2 slots
PYTHON_COMPAT="python2_7"

inherit eutils python-distutils-ng

DESCRIPTION="Miscellaneous convenience, extension and workaround code for Python"
HOMEPAGE="https://fedorahosted.org/python-slip/"
SRC_URI="https://fedorahosted.org/released/${PN}/${P}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="dbus gtk selinux"

RDEPEND="
	dbus? (
		dev-python/dbus-python
		dev-python/pygobject:2
		sys-auth/polkit )
	gtk? ( dev-python/pygtk:2 )
"
DEPEND=""

python_prepare_all() {
	use selinux || epatch "${FILESDIR}/${PN}-0.2.20-no-selinux.patch"
	sed -e "s:@VERSION@:${PV}:" setup.py.in > setup.py || die "sed failed"

	if ! use dbus; then
		sed -e '/name="slip.dbus"/ s/\(.*\)/if 0:\n    \1/' \
			-i setup.py || die "sed 2 failed"
	fi
	if ! use gtk; then
		sed -e '/name="slip.gtk"/ s/\(.*\)/if 0:\n    \1/' \
			-i setup.py || die "sed 3 failed"
	fi
}
