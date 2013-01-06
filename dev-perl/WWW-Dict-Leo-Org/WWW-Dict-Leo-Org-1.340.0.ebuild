# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Dict-Leo-Org/WWW-Dict-Leo-Org-1.340.0.ebuild,v 1.1 2011/08/28 09:09:09 tove Exp $

EAPI=4

MODULE_AUTHOR=TLINDEN
MODULE_VERSION=1.34
inherit perl-module

DESCRIPTION="Commandline interface to http://dict.leo.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-perl/HTML-TableParser
	virtual/perl-DB_File"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/1.34-umlaut.patch )

src_install() {
	perl-module_src_install
	mv "${D}"/usr/bin/{l,L}eo || die
}

pkg_postinst() {
	elog "We renamed leo to Leo"
	elog "due to conflicts with app-editors/leo"
}
