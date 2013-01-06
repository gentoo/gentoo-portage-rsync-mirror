# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Grove/XML-Grove-0.46_alpha-r1.ebuild,v 1.15 2007/07/10 23:33:28 mr_bones_ Exp $

inherit perl-module

MY_P="${P/_/}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A Perl module providing a simple API to parsed XML instances"
HOMEPAGE="http://cpan.org/modules/by-module/XML/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/K/KM/KMACLEOD/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc alpha ia64"
IUSE=""

DEPEND=">=dev-perl/libxml-perl-0.07-r1
	dev-lang/perl"
RDEPEND="${DEPEND}"
