# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Event-RPC/Event-RPC-0.90.ebuild,v 1.10 2006/10/09 14:27:03 mcummings Exp $

inherit perl-module

DESCRIPTION="Event based transparent Client/Server RPC framework"
SRC_URI="mirror://cpan/modules/by-module/Event/${P}.tar.gz"
HOMEPAGE="http://www.exit1.org/${PN}/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/glib-perl
	dev-perl/IO-Socket-SSL
		dev-perl/Net-SSLeay
		dev-perl/Event
	dev-lang/perl"
