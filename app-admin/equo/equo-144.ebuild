# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/equo/equo-144.ebuild,v 1.1 2012/09/27 10:59:44 lxnay Exp $

EAPI=3
PYTHON_DEPEND="2"
inherit eutils python bash-completion-r1

DESCRIPTION="Entropy Package Manager text-based client"
HOMEPAGE="http://www.sabayon.org"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
SRC_URI="mirror://sabayon/sys-apps/entropy-${PV}.tar.bz2"

S="${WORKDIR}/entropy-${PV}"

DEPEND="~sys-apps/entropy-${PV}"
RDEPEND="${DEPEND} sys-apps/file[python]"

src_compile() {
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="usr/lib" equo-install || die "make install failed"
	newbashcomp "${S}/misc/equo-completion.bash" equo
}

pkg_postinst() {
	python_mod_optimize "/usr/lib/entropy/client"
	echo
	elog "If you would like to allow users in the 'entropy' group"
	elog "to update available package repositories, please consider"
	elog "to install sys-apps/rigo-daemon"
	echo
}

pkg_postrm() {
	python_mod_cleanup "/usr/lib/entropy/client"
}
