# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/cstools/cstools-3.42.ebuild,v 1.5 2005/11/28 12:08:12 mcummings Exp $

inherit perl-app

MY_P="Cstools-${PV}"
DESCRIPTION="A charset conversion tool cstocs and two convenience Perl modules for Czech language."
SRC_URI="http://www.fi.muni.cz/~adelton/perl/${MY_P}.tar.gz"
HOMEPAGE="http://www.fi.muni.cz/~adelton/perl/#cstools"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/MIME-tools"

S=${WORKDIR}/${MY_P}
