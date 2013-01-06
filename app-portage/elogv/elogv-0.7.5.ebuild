# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/elogv/elogv-0.7.5.ebuild,v 1.3 2012/01/11 01:55:41 ottxor Exp $

EAPI="3"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="ncurses"

inherit distutils eutils prefix

DESCRIPTION="Curses based utility to parse the contents of elogs created by Portage"
HOMEPAGE="http://gechi-overlay.sourceforge.net/?page=elogv"
SRC_URI="mirror://sourceforge/gechi-overlay/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND=""
RDEPEND=""

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	distutils_src_prepare
}

src_install() {
	distutils_src_install
	dodoc README || die
}

pkg_postinst() {
	distutils_pkg_postinst

	elog
	elog "In order to use this software, you need to activate"
	elog "Portage's elog features.  Required is"
	elog "		 PORTAGE_ELOG_SYSTEM=\"save\" "
	elog "and at least one out of "
	elog "		 PORTAGE_ELOG_CLASSES=\"warn error info log qa\""
	elog "More information on the elog system can be found"
	elog "in ${EPREFIX}/etc/make.conf.example"
	elog
	elog "To operate properly this software needs the directory"
	elog "${PORT_LOGDIR:-${EPREFIX}/var/log/portage}/elog created, belonging to group portage."
	elog "To start the software as a user, add yourself to the portage"
	elog "group."
	elog
}
