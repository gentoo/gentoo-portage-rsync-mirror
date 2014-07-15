# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SNMP_Session/SNMP_Session-1.13-r2.ebuild,v 1.4 2014/07/15 15:53:04 nimiux Exp $

EAPI=5

inherit perl-module

DESCRIPTION="A SNMP Perl Module"
SRC_URI="http://snmp-session.googlecode.com/files/${P}.tar.gz"
HOMEPAGE="http://code.google.com/p/snmp-session/"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~sparc-solaris ~x86-solaris"

PATCHES=(
	"${FILESDIR}"/${P}-Socket6.patch
)

src_install() {
	perl-module_src_install
	dohtml index.html
}
