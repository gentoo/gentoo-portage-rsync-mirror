# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-selinux/python-selinux-2.16-r3.ebuild,v 1.1 2011/03/18 02:02:11 blueness Exp $

EAPI="2"

PYTHON_DEPEND="2"

inherit python eutils

DESCRIPTION="Extra python bindings for SELinux functions"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/selinux/"
LICENSE="GPL-2"
SLOT="0"
SRC_URI="mirror://gentoo/${P}-1.tar.bz2"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-libs/libselinux-1.28-r1"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/respect-LDFLAGS.patch"
}

src_compile() {
	emake PYVER="$(python_get_version)" || die
}

src_install() {
	python_need_rebuild
	make DESTDIR="${D}" PYVER="$(python_get_version)" install || die
}
