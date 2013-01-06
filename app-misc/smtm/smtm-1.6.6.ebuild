# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/smtm/smtm-1.6.6.ebuild,v 1.7 2012/03/18 15:36:02 armin76 Exp $

inherit perl-app

DESCRIPTION="Stock ticker, profit/loss calculator and chart tool"
HOMEPAGE="http://eddelbuettel.com/dirk/code/smtm.html"
SRC_URI="http://eddelbuettel.com/dirk/code/smtm/smtm_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND=">=dev-lang/perl-5
	dev-perl/perl-tk
	dev-perl/DateManip
	dev-perl/HTML-Parser
	dev-perl/Finance-YahooQuote
	dev-perl/libwww-perl"

mydoc="BUGS THANKS TODO examples/*"
