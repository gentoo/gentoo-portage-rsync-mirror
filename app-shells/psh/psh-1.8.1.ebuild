# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/psh/psh-1.8.1.ebuild,v 1.8 2012/07/29 18:17:49 armin76 Exp $

inherit perl-module

DESCRIPTION="Combines the interactive nature of a Unix shell with the power of Perl"
HOMEPAGE="http://www.focusresearch.com/gregor/sw/psh/"
SRC_URI="http://www.focusresearch.com/gregor/download/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="readline"

DEPEND=">=dev-lang/perl-5"
RDEPEND="readline? (
	dev-perl/Term-ReadLine-Gnu
	dev-perl/TermReadKey )"

myinst="SITEPREFIX=${D}/usr"
