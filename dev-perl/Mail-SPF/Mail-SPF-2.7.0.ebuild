# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-SPF/Mail-SPF-2.7.0.ebuild,v 1.3 2011/12/20 12:03:31 naota Exp $

EAPI=4

MODULE_AUTHOR=JMEHNLE
MODULE_VERSION=v2.007
MODULE_SECTION=mail-spf
inherit perl-module

DESCRIPTION="Sender Permitted From - Object Oriented"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-perl/Error
	dev-perl/URI
	>=dev-perl/Net-DNS-0.65
	>=dev-perl/NetAddr-IP-4.026
	>=dev-perl/Net-DNS-Resolver-Programmable-0.003
	virtual/perl-version
	!!dev-perl/Mail-SPF-Query"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.33"

SRC_TEST="do"

src_prepare() {
	perl-module_src_prepare
	sed -i -e "s:spfquery:spfquery.pl:" Build.PL || die "sed failed"
	mv "${S}"/bin/spfquery "${S}"/bin/spfquery.pl || die "renaming spfquery failed"
}

pkg_postinst() {
	elog "The spfquery script was renamed to spfquery.pl because of file collisions."
}
