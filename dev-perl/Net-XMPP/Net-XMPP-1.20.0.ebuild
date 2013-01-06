# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-XMPP/Net-XMPP-1.20.0.ebuild,v 1.9 2012/09/06 01:37:46 blueness Exp $

EAPI=4

MODULE_AUTHOR=HACKER
MODULE_VERSION=1.02
inherit perl-module

DESCRIPTION="XMPP Perl Library"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=dev-perl/XML-Stream-1.22
	dev-perl/Digest-SHA1"
DEPEND="virtual/perl-Module-Build
	${RDEPEND}"

SRC_TEST="do"
PATCHES=( "${FILESDIR}"/1.02-defined.patch )

src_prepare() {
	for i in 2_client_jabberd1.4.t 3_client_jabberd2.t ; do
		mv "${S}"/t/${i}{,.disable} || die
		sed -i -e "/${i}/d" "${S}"/MANIFEST || die
	done
	perl-module_src_prepare
}
