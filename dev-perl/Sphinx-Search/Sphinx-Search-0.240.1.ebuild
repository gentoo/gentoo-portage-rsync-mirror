# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sphinx-Search/Sphinx-Search-0.240.1.ebuild,v 1.1 2011/01/17 13:02:21 tove Exp $

EAPI=3

MODULE_AUTHOR=JJSCHUTZ
MODULE_VERSION=0.240.1
inherit perl-module

DESCRIPTION="Perl API client for Sphinx search engine"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="dev-perl/File-SearchPath
	dev-perl/Path-Class
	dev-perl/DBI"
DEPEND="${RDEPEND}"

pkg_postinst() {
	ewarn "You must connect to a Sphinx searchd of 0.9.8_rc1 or newer"
}
