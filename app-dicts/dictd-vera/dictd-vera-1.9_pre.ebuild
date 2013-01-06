# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/dictd-vera/dictd-vera-1.9_pre.ebuild,v 1.7 2005/01/01 12:50:10 eradicator Exp $

MY_P=dict-vera-${PV/_/-}
DESCRIPTION="V.E.R.A. -- Virtual Entity of Relevant Acronyms for dict"
HOMEPAGE="http://www.dict.org/"
SRC_URI="ftp://ftp.dict.org/pub/dict/pre/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc amd64"
IUSE=""

RDEPEND=">=app-text/dictd-1.5.5"

S=${WORKDIR}

src_install() {
	insinto /usr/lib/dict
	doins vera.dict.dz vera.index || die
}
