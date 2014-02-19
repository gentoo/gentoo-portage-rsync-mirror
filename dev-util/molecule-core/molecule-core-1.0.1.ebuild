# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/molecule-core/molecule-core-1.0.1.ebuild,v 1.3 2014/02/19 10:52:49 lxnay Exp $

EAPI="5"
PYTHON_DEPEND="*"

inherit python

DESCRIPTION="Sabayon distro-agnostic images build tool"
HOMEPAGE="http://www.sabayon.org"
SRC_URI="mirror://sabayon/${CATEGORY}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/intltool
	sys-devel/gettext"
RDEPEND="!<dev-util/molecule-1
	sys-process/lsof"

src_install() {
	emake DESTDIR="${D}" LIBDIR="/usr/lib" \
		PREFIX="/usr" SYSCONFDIR="/etc" install \
		|| die "emake install failed"
}

pkg_postinst() {
	python_mod_optimize "/usr/lib/molecule"
}

pkg_postrm() {
	python_mod_cleanup "/usr/lib/molecule"
}
