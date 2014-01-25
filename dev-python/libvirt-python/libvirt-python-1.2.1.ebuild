# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libvirt-python/libvirt-python-1.2.1.ebuild,v 1.3 2014/01/25 18:17:07 ago Exp $

EAPI=5

#BACKPORTS=062ad8b2

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

MY_P="${P/_rc/-rc}"

inherit distutils-r1

DESCRIPTION="libvirt Python bindings"
HOMEPAGE="http://www.libvirt.org"
SRC_URI="http://libvirt.org/sources/python/${MY_P}.tar.gz
	${BACKPORTS:+
		http://dev.gentoo.org/~cardoe/distfiles/${MY_P}-${BACKPORTS}.tar.xz}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND=">=app-emulation/libvirt-0.9.6:=[-python(-)]"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( dev-python/lxml )"

S="${WORKDIR}/${P%_rc*}"

src_prepare() {
	[[ -n ${BACKPORTS} ]] && \
		EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${S}/patches" \
			epatch

	distutils-r1_src_prepare
}

python_test() {
	esetup.py test
}
