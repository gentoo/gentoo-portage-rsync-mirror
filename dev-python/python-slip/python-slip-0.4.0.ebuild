# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-slip/python-slip-0.4.0.ebuild,v 1.1 2013/08/09 21:36:45 eva Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 eutils

DESCRIPTION="Miscellaneous convenience, extension and workaround code for Python"
HOMEPAGE="https://fedorahosted.org/python-slip/"
SRC_URI="https://fedorahosted.org/released/${PN}/${P}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus gtk selinux"

RDEPEND="
	dbus? (
		dev-python/dbus-python[${PYTHON_USEDEP}]
		|| (
			dev-python/pygobject:3[${PYTHON_USEDEP}]
			dev-python/pygobject:2[${PYTHON_USEDEP}] )
		sys-auth/polkit )
	gtk? ( dev-python/pygtk:2[${PYTHON_USEDEP}] )
"
DEPEND=""

python_prepare_all() {
	use selinux || epatch "${FILESDIR}/${PN}-0.4.0-no-selinux.patch"
	sed -e "s:@VERSION@:${PV}:" setup.py.in > setup.py || die "sed failed"

	if ! use dbus; then
		sed -e '/name="slip.dbus"/ s/\(.*\)/if 0:\n    \1/' \
			-i setup.py || die "sed 2 failed"
	fi
	if ! use gtk; then
		sed -e '/name="slip.gtk"/ s/\(.*\)/if 0:\n    \1/' \
			-i setup.py || die "sed 3 failed"
	fi

	distutils-r1_python_prepare_all
}
