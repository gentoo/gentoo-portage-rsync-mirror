# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-Mail/DateTime-Format-Mail-0.30.ebuild,v 1.15 2011/01/14 20:27:12 armin76 Exp $

inherit perl-module

DESCRIPTION="Convert between DateTime and RFC2822/822 formats"
HOMEPAGE="http://search.cpan.org/~drolsky/"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

RDEPEND=">=dev-perl/Params-Validate-0.67
		>=dev-perl/DateTime-0.17
		dev-lang/perl"
DEPEND="${RDEPEND}
		virtual/perl-Module-Build"
