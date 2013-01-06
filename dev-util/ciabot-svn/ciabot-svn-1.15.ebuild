# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ciabot-svn/ciabot-svn-1.15.ebuild,v 1.6 2012/05/06 15:50:39 pacho Exp $

EAPI="4"
PYTHON_DEPEND="2"

inherit eutils python

DESCRIPTION="CIA-bot script for Subversion repositories"
HOMEPAGE="http://cia.navi.cx/doc/clients"
SRC_URI="mirror://gentoo/${P}.py.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	python_convert_shebangs -r 2 .
	dodir /etc/${PN}
	insinto /etc/${PN}
	doins "${FILESDIR}"/config.py
	newbin ${P}.py ${PN}
}

pkg_postinst() {
	elog "This ciabot-svn script should be called from your repository's post-commit"
	elog "hook with the repository and revision as arguments. For example,"
	elog "you could copy this script into your repository's \"hooks\" directory"
	elog "and add something like the following to the \"post-commit\" script,"
	elog "also in the repository's \"hooks\" directory:"
	elog ""
	elog "  REPOS=\"\$1\""
	elog "  REV=\"\$2\""
	elog "  /usr/bin/ciabot-svn \"\$REPOS\" \"\$REV\" &"
	elog ""
	elog "Or, if you have multiple project hosted, you can add each"
	elog "project's name to the commandline in that project's post-commit"
	elog "hook:"
	elog ""
	elog "  /usr/bin/ciabot-svn \"\$REPOS\" \"\$REV\" \"ProjectName\" &"
}
