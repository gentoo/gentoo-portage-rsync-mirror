# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IP-Country/IP-Country-2.23.ebuild,v 1.9 2012/03/25 15:08:52 armin76 Exp $

inherit perl-module

DESCRIPTION="fast lookup of country codes from IP addresses"
SRC_URI="mirror://cpan/authors/id/N/NW/NWETTERS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~nwetters/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 hppa ppc ppc64 x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Geography-Countries
	dev-lang/perl"
mydoc="TODO"
