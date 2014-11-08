# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libvirt-python/libvirt-python-9999.ebuild,v 1.1 2014/11/08 17:46:15 tamiko Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

MY_P="${P/_rc/-rc}"

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://libvirt.org/libvirt-python.git"
	AUTOTOOLIZE=yes
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://libvirt.org/sources/python/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi
S="${WORKDIR}/${P%_rc*}"

DESCRIPTION="libvirt Python bindings"
HOMEPAGE="http://www.libvirt.org"
LICENSE="LGPL-2"
SLOT="0"
IUSE="test"

RDEPEND=">=app-emulation/libvirt-0.9.6:=[-python(-)]"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( dev-python/lxml )"

python_test() {
	esetup.py test
}
